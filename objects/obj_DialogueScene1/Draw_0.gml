// --- 1. DRAW ENVIRONMENT PLACEHOLDERS (Stick Figures in the world) ---
draw_sprite_ext(pl_ad, 0, addeline_x, addeline_y, 1, 1, 0, c_white, 1);
draw_sprite_ext(pl_fairy, 0, fairy_x, fairy_y, 1, 1, 0, c_white, 1);

// Only show Horatio if he has arrived (Line 3 or later)
if (current_line >= 3) {
    draw_sprite_ext(pl_enemy, 0, horatio_x, horatio_y, 1, 1, 0, c_white, 1);
}

// --- 2. DRAW THE DIALOGUE BOX ---
var box_h = 200;
var box_y = room_height - box_h;

draw_set_alpha(0.8);
draw_set_color(c_black);
draw_rectangle(0, box_y, room_width, room_height, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_line_width(0, box_y, room_width, box_y, 2); // White top border

// --- 3. DRAW THE PORTRAIT (Inside Box on the Left) ---
var data = dialogue[current_line];
var port_x = 100; 
var port_y = 575;

// Logic: Use Addeline's faces for everyone as placeholders
var face_frame = 0; 
if (data.s == "Addeline") {
    if (player_hp > 99) face_frame = 0;
    else if (player_hp > 40) face_frame = 1;
    else if (player_hp > 0) face_frame = 2;
    else face_frame = 3;
} else {
    face_frame = 0; // Fairy and Horatio stay on the first frame
}

// Draw the Portrait (scaled to 0.6)
if (sprite_exists(data.port)) {
    draw_sprite_ext(data.port, face_frame, port_x, port_y, 0.6, 0.6, 0, c_white, 1);
}

// --- 4. DRAW THE TEXT (Nudged to the Right) ---
var text_x = 220; // Enough space so text doesn't touch the portrait face

draw_set_halign(fa_left);
draw_set_color(c_yellow);
draw_text_transformed(text_x, box_y + 30, data.s + ":", 1.2, 1.2, 0);

draw_set_color(c_white);
// Wrap the text so it stays on the screen
draw_text_ext(text_x, box_y + 70, data.t, 32, room_width - text_x - 50);

// Instruction at the bottom right
draw_set_halign(fa_right);
draw_text(room_width - 20, room_height - 30, "Press ENTER >");