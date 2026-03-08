// 1. Set global transparency for this object
draw_set_alpha(text_alpha);

// 2. Get current coordinates
var sx = story_spr_x[current_line];
var sy = story_spr_y[current_line];

// 3. Draw the Sprite (pl_fairy)
// We use draw_sprite_ext so we can control the alpha properly
draw_sprite_ext(pl_fairy, 0, sx, sy, 1, 1, 0, c_white, text_alpha);

// 4. Draw the Text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white); // White text for black background

// Draw text centered at the bottom of the screen
// (room_height - 100) keeps the text at the bottom while the sprite moves around
draw_text_ext(room_width / 2, room_height - 100, story_text[current_line], 35, 800);

// 5. Clean up alpha for other objects
draw_set_alpha(1);
