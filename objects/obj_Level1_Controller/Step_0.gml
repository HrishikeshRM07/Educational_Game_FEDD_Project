// --- STEP EVENT ---
var data = dialogue[current_line];

// Typewriter logic: increase progress until it reaches full length of text
if (text_progress < string_length(data.t)) {
    text_progress += text_speed;
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    // If text is still typing, skip to the end of the line
    if (text_progress < string_length(data.t)) {
        text_progress = string_length(data.t);
    } 
    // Otherwise, move to the next line
    else {
        current_line++;
        text_progress = 0;
        
        // When dialogue ends, go to the actual battle room
        if (current_line >= array_length(dialogue)) {
            room_goto(rm_Level1_Battle); 
        }
    }
}