// This draws your logo in the exact center of the screen
draw_sprite_ext(Sprite49, 0, room_width/2 + 40, room_height/2, 0.75, 0.75, 0, c_white, alpha);

// This draws the "Loading" text below it
draw_set_halign(fa_center);
draw_set_alpha(alpha);
draw_set_color(c_black); // Black text for a white background
draw_text(1280, 720, "LOADING...");
draw_set_alpha(1); // Reset alpha