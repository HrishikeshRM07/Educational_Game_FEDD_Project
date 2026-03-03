

// Align text so bottom-right corner matches the coordinates
draw_set_halign(fa_right); // Right-align
draw_set_valign(fa_bottom); // Bottom-align

// Draw the text
draw_text(play_button_x, play_button_y, "PRESS ENTER TO BEGIN");

// Reset font and alignment (good practice)
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
