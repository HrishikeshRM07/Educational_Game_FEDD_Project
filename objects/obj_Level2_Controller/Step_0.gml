// Get current data
var _data = dialogue[current_line];

// Typewriter logic
if (text_progress < string_length(_data.t)) {
    text_progress += text_speed;
}

// Input logic
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    if (text_progress < string_length(_data.t)) {
        text_progress = string_length(_data.t); // Skip to end
    } else {
        if (current_line < array_length(dialogue) - 1) {
            current_line++;
            text_progress = 0;
        } else {
            // Transition to Level 2 Battle!
            room_goto(rm_Level2_Battle); 
        }
    }
}