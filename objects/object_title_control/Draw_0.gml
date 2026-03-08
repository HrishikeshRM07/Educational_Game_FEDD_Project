



// 2. Draw the Pulsing "Press Enter" text
draw_set_alpha(title_alpha); // Apply the pulsing transparency
draw_set_color(c_white);
draw_set_halign(fa_right); 
draw_set_valign(fa_bottom); 

draw_text(play_button_x, play_button_y, "PRESS [ENTER] TO BEGIN");

// 3. Reset everything
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
