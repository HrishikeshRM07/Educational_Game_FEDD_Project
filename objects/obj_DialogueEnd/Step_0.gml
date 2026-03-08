// Make Horatio disappear after his lines (0 and 1)
if (current_line > 1) {
    show_horatio = false;
}

if (keyboard_check_pressed(vk_enter)) {
    current_line++;
    if (current_line >= array_length(dialogue)) {
        room_goto(rm_Level1Story);
    }
}

if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_Level1Story);
}

