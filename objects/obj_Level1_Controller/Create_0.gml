// --- CREATE EVENT ---
// 1. Dialogue Script
dialogue[0] = { t: "Alright! We’re ready to set out. Just so you know it’s only going to get more dangerous from here though.", s: "Bria", spr: pl_fairy, port: spr_Addeline_Portraits };
dialogue[1] = { t: "King Phi has been putting together his forces for a long time, so let’s start it out nice and easy. Look! Here are some enemies to fight now!", s: "Bria", spr: pl_fairy, port: spr_Addeline_Portraits };
dialogue[2] = { t: "Bring it on!", s: "Addeline", spr: pl_ad, port: spr_Addeline_Portraits };

current_line = 0;
text_progress = 0; // For typewriter effect
text_speed = 0.5;  // Speed of letters appearing

// Positions
addeline_x = 200;
addeline_y = room_height - 500;
bria_x = 450;
bria_y = room_height - 450;