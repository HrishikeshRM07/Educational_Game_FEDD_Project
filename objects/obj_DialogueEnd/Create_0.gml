// --- CREATE EVENT: obj_DialogueEnd ---
player_hp = 100; // Default value so the portrait logic doesn't crash

// Your Script
dialogue[0] = { t: "Fascinating… You may have bested me this time, but you will not best me again!", s: "Horatio", spr: pl_enemy, port: spr_Addeline_Portraits };
dialogue[1] = { t: "However, for now you are safe. Farewell.", s: "Horatio", spr: pl_enemy, port: spr_Addeline_Portraits };
dialogue[2] = { t: "Addeline that was amazing! You really are a skilled warrior.", s: "Fairy", spr: pl_fairy, port: spr_Addeline_Portraits };
dialogue[3] = { t: "King Phi has been trying to gain more mathemagical powers, but it’s had some pretty damaging results.", s: "Fairy", spr: pl_fairy, port: spr_Addeline_Portraits };
dialogue[4] = { t: "My sibling and I tried to stop him but he captured both of us! So what do you say, will you help us?", s: "Fairy", spr: pl_fairy, port: spr_Addeline_Portraits };
dialogue[5] = { t: "Of course! I don’t want to see my home destroyed so I’d be happy to!", s: "Addeline", spr: pl_ad, port: spr_Addeline_Portraits };

current_line = 0;
show_horatio = true;

// Positions
addeline_x = 200;
addeline_y = room_height - 500;
fairy_x = 450;
fairy_y = room_height - 450;
horatio_x = room_width - 250;
horatio_y = room_height - 500;

