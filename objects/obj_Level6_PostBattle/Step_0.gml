// --- 1. FADE TO BLACK LOGIC ---
// Updated to line 21 to match the new dialogue array!
if (current_line >= 21) {
    // Lowered from 0.015 to 0.005 for a much slower, dramatic fade
    fade_alpha = min(fade_alpha + 0.005, 1.0); 
}

// --- 2. TYPEWRITER MATH ---
if (current_line < array_length(dialogue)) {
    var _full_text = dialogue[current_line].t;
    if (text_progress < string_length(_full_text)) {
        text_progress += text_speed;
    }
}

// --- 3. PLAYER INPUT (ENTER) ---
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
    
    // Transition to the credits!
    if (current_line >= array_length(dialogue)) {
        room_goto(rm_title); 
    }
}

// --- 4. PLAYER INPUT (ESCAPE) ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_title); 
}