// --- 1. TYPEWRITER MATH ---
if (current_line < array_length(dialogue)) {
    var _full_text = dialogue[current_line].t;
    if (text_progress < string_length(_full_text)) {
        text_progress += text_speed;
    }
}

// --- 2. PLAYER INPUT (ENTER / SPACE) ---
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    if (current_line < array_length(dialogue)) {
        var _full_text = dialogue[current_line].t;
        
        if (text_progress < string_length(_full_text)) {
            text_progress = string_length(_full_text); // Skip typing
        } 
        else {
            current_line++;
            text_progress = 0; // Reset typing for next line
        }
    }
    
    if (current_line >= array_length(dialogue)) {
        room_goto(rm_Level1Story);
    }
}

// --- 3. PLAYER INPUT (ESCAPE) ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_Level1Story);
}