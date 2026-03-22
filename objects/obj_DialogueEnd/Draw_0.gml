// --- DRAW EVENT: obj_DialogueEnd ---

// 1. INPUT & LOGIC
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    current_line++;
    if (current_line >= array_length(dialogue)) {
        room_goto(rm_Level1Story);
        exit;
    }
}

// Logic: Hide Horatio after his lines are done
show_horatio = (current_line <= 1);

// 2. DRAW WORLD SPRITES (The characters standing)
draw_sprite_ext(pl_ad, 0, addeline_x, addeline_y, 1, 1, 0, c_white, 1);
draw_sprite_ext(pl_fairy, 0, fairy_x, fairy_y, 1, 1, 0, c_white, 1);
if (show_horatio) {
    draw_sprite_ext(pl_enemy, 0, horatio_x, horatio_y, 1, 1, 0, c_white, 1);
}

// 3. DRAW DIALOGUE BOX
var box_h = 200;
var box_y = room_height - box_h;
draw_set_alpha(0.8); draw_set_color(c_black);
draw_rectangle(0, box_y, room_width, room_height, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_line_width(0, box_y, room_width, box_y, 2);

// 4. DRAW PORTRAIT (The Face)
var data = dialogue[current_line];
var port_x = 100; 
var port_y = 575;

// Determine which frame of the Addeline Portrait to use
var face_frame = 0; 
if (data.s == "Addeline") {
    if (player_hp > 99) face_frame = 0;
    else if (player_hp > 40) face_frame = 1;
    else face_frame = 2;
}

// Draw the portrait sprite (data.port)
if (sprite_exists(data.port)) {
    draw_sprite_ext(data.port, face_frame, port_x, port_y, 0.6, 0.6, 0, c_white, 1);
}

// 5. DRAW TEXT
var text_x = 240;
draw_set_halign(fa_left);

// Name
draw_set_color(c_yellow);
draw_text_transformed(text_x, box_y + 30, data.s + ":", 1.2, 1.2, 0);

// Speech
draw_set_color(c_white);
draw_text_ext(text_x, box_y + 70, data.t, 32, room_width - text_x - 50);

// Prompt
draw_set_halign(fa_right);
draw_text(room_width - 20, room_height - 30, "Press ENTER >");