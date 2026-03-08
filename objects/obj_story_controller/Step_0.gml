// Handle Fading Logic
if (fade_state == "in") {
    text_alpha += fade_speed;
    if (text_alpha >= 1) fade_state = "wait";
} 
else if (fade_state == "wait") {
    timer--;
    if (timer <= 0) fade_state = "out";
} 
else if (fade_state == "out") {
    text_alpha -= fade_speed;
    if (text_alpha <= 0) {
        current_line++;
        
        // Check if the story is finished
        if (current_line >= array_length(story_text)) {
            room_goto(rm_story1);
        } else {
            // Reset for the next line
            fade_state = "in";
            timer = 150; 
        }
    }
}

// Skip Line with Space
if (keyboard_check_pressed(vk_space)) {
    fade_state = "out";
}

// Skip Story with Escape
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_story1);
}