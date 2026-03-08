// This makes the text "breathe"
title_alpha += (fade_speed * fade_dir);

if (title_alpha <= 0.3) fade_dir = 1;  // Start brightening
if (title_alpha >= 1)   fade_dir = -1; // Start dimming