// --- 1. TYPEWRITER MATH ---
if (current_line < array_length(dialogue)) {
    var _full_text = dialogue[current_line].t;
    if (text_progress < string_length(_full_text)) {
        text_progress += text_speed;
    }
}

// --- 2. PLAYER INPUT (ENTER) ---
if (keyboard_check_pressed(vk_enter)) {
    if (current_line < array_length(dialogue)) {
        var _full_text = dialogue[current_line].t;
        
        // If it is still typing, finish the sentence instantly
        if (text_progress < string_length(_full_text)) {
            text_progress = string_length(_full_text);
        } 
        else {
            // If the sentence is fully typed, move to the NEXT line
            current_line++;
            text_progress = 0; 
        }
    }
    
    // If we just clicked past the final line, transition to the next level/overworld!
    if (current_line >= array_length(dialogue)) {
        room_goto(rm_Level4_Story); // Make sure to change this to the name of your next room!
    }
}

// --- 3. PLAYER INPUT (ESCAPE) ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_Level4_Story); // Make sure to change this to the name of your next room!
}