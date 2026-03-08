// If we reach line 3, Horatio appears
if (current_line >= 3) {
    show_horatio = true;
}

if (keyboard_check_pressed(vk_enter)) {
    current_line++;
    if (current_line >= array_length(dialogue)) {
        room_goto(rm_tutorial);
    }
}

if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_tutorial);
}

