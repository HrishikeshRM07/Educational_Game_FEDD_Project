// 1. Draw the Hero (Addeline) - Always there
draw_sprite_ext(pl_ad, 0, addeline_x, addeline_y, 1, 1, 0, c_white, 1);

// 2. Draw the Fairy - Always there
draw_sprite_ext(pl_fairy, 0, fairy_x, fairy_y, 1, 1, 0, c_white, 1);

// 3. Draw the Villain (Horatio) - Only if he has "arrived"
if (show_horatio == true) {
    draw_sprite_ext(pl_enemy, 0, horatio_x, horatio_y, 1, 1, 0, c_white, 1);
}

// 4. DRAW THE TEXT BOX
var box_h = 180;
draw_set_color(c_black);
draw_set_alpha(0.8); // Make box slightly see-through
draw_rectangle(0, room_height - box_h, room_width, room_height, false);
draw_set_alpha(1);

// 5. DRAW THE TEXT
var data = dialogue[current_line];
draw_set_color(c_white);
draw_set_halign(fa_left);

// Draw Speaker Name
draw_text_transformed(50, room_height - box_h + 20, data.s + ":", 1.5, 1.5, 0);

// Draw Speech
draw_text_ext(50, room_height - box_h + 60, data.t, 30, room_width - 100);

// Instruction
draw_set_halign(fa_right);
draw_text(room_width - 20, room_height - 30, "Press ENTER >");