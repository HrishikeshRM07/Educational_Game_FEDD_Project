// Handle the fading states
if (state == 0) {
    alpha += fade_speed;
    if (alpha >= 1) state = 1;
} 
else if (state == 1) {
    timer--;
    if (timer <= 0) state = 2;
} 
else if (state == 2) {
    alpha -= fade_speed;
    if (alpha <= 0) room_goto(rm_title);
}

// OPTIONAL: Skip the splash screen if a key is pressed
if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left)) {
    room_goto(rm_title);
}

