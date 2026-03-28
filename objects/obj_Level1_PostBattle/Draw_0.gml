// 1. Draw Character Model
draw_sprite_ext(pl_ad, 0, addeline_x, addeline_y, 1, 1, 0, c_white, 1);

// 2. Draw Dialogue Box Background
var box_h = 200;
var box_y = room_height - box_h;
draw_set_alpha(0.8); draw_set_color(c_black);
draw_rectangle(0, box_y, room_width, room_height, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_line_width(0, box_y, room_width, box_y, 2);

// 3. Setup Current Data for Portraits & Text
var data = dialogue[current_line];
var face_frame = (data.s == "Addeline") ? 0 : 0; // Adjust this if Addeline and Bria use different portrait indexes

// 4. Draw Portrait
draw_sprite_ext(data.port, face_frame, 110, room_height - 100, 0.6, 0.6, 0, c_white, 1);

// 5. Draw Typewriter Text
var text_to_draw = string_copy(data.t, 1, floor(text_progress));
var text_x = 240;

draw_set_halign(fa_left);
draw_set_color(c_yellow);
draw_text_transformed(text_x, box_y + 30, data.s + ":", 1.2, 1.2, 0);

draw_set_color(c_white);
// Text limit adjusted slightly to make sure long lines like Bria's fit nicely
draw_text_ext(text_x, box_y + 70, text_to_draw, 32, room_width - text_x - 50);

// 6. "Next" Prompt (only show if line is finished typing)
if (text_progress >= string_length(data.t)) {
    draw_set_halign(fa_right);
    draw_text(room_width - 20, room_height - 30, "Press ENTER >");
}