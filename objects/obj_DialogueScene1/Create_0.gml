// 1. Dialogue Script
dialogue[0] = { t: "Excuse me! Are you one of the residents of this town?", s: "Fairy", spr: pl_fairy, side: 1 };
dialogue[1] = { t: "Yes, but well… you can see what’s happened here.", s: "Addeline", spr: pl_ad, side: 0 };
dialogue[2] = { t: "Yes! I’m here to find those with mathemagical abilities!", s: "Fairy", spr: pl_fairy, side: 1 };
dialogue[3] = { t: "Dear citizen, are you OK? This.. creature needs to go back!", s: "Horatio", spr: pl_enemy, side: 2 }; // Villain enters here
dialogue[4] = { t: "Don’t listen to him Addeline! Just give it a try with me!", s: "Fairy", spr: pl_fairy, side: 1 };
dialogue[5] = { t: "If you don’t have a reason for needing Fairy then they stay with me!", s: "Addeline", spr: pl_ad, side: 0 };
dialogue[6] = { t: "Then I suppose this means a battle!", s: "Horatio", spr: pl_enemy, side: 2 };

// 2. CUSTOMIZE POSITIONS HERE
// X is left/right, Y is height
addeline_x = 200;
addeline_y = room_height - 500;

fairy_x = 450;
fairy_y = room_height - 450;

horatio_x = room_width - 250;
horatio_y = room_height - 500;

// 3. Logic Variables
current_line = 0;
show_horatio = false; // He starts hidden

