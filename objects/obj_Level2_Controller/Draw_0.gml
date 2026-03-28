// 1. Draw Addeline
draw_sprite_ext(pl_ad, 0, addeline_x, addeline_y, 1, 1, 0, c_white, 1);

// 2. Draw Milly ONLY IF she has revealed herself (Line 4 and onward)
if (current_line >= 4) {
    draw_sprite_ext(pl_ob, 0, milly_x, milly_y, 1, 1, 0, c_white, 1);
}

// 3. Draw Dialogue Box
var box_h = 200;
var box_y = room_height - box_h;
draw_set_alpha(0.8); draw_set_color(c_black);
draw_rectangle(0, box_y, room_width, room_height, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_line_width(0, box_y, room_width, box_y, 2);

// 4. Setup Current Data for Portraits
var data = dialogue[current_line];
var face_frame = 0; // You can expand this later if characters have multiple expressions

// 5. Draw Portrait
draw_sprite_ext(data.port, face_frame, 110, room_height - 100, 0.6, 0.6, 0, c_white, 1);

// 6. Draw Typewriter Text
var text_to_draw = string_copy(data.t, 1, floor(text_progress));
var text_x = 240;

draw_set_halign(fa_left);
draw_set_color(c_yellow);
draw_text_transformed(text_x, box_y + 30, data.s + ":", 1.2, 1.2, 0);

draw_set_color(c_white);
draw_text_ext(text_x, box_y + 70, text_to_draw, 32, room_width - text_x - 50);

// 7. "Next" Prompt (only show if line is finished typing)
if (text_progress >= string_length(data.t)) {
    draw_set_halign(fa_right);
    draw_text(room_width - 20, room_height - 30, "Press ENTER >");
}