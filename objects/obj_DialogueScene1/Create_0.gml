// 1. Dialogue Script
// We are using spr_Addeline_Portraits for everyone until the other art is ready!
dialogue[0] = { t: "Excuse me! Are you one of the residents of this town?", s: "Fairy", spr: Bria, port: spr_Addeline_Portraits };
dialogue[1] = { t: "Yes, but well… you can see what’s happened here.", s: "Addeline", spr: pl_ad, port: spr_Addeline_Portraits };
dialogue[2] = { t: "Yes! I’m here to find those with mathemagical abilities!", s: "Fairy", spr: Bria, port: spr_Addeline_Portraits };
dialogue[3] = { t: "Dear citizen, are you OK? This.. creature needs to go back!", s: "Horatio", spr: pl_enemy, port: spr_Addeline_Portraits }; 
dialogue[4] = { t: "Don’t listen to him Addeline! Just give it a try with me!", s: "Fairy", spr: Bria, port: spr_Addeline_Portraits };
dialogue[5] = { t: "If you don’t have a reason for needing Fairy then they stay with me!", s: "Addeline", spr: pl_ad, port: spr_Addeline_Portraits };
dialogue[6] = { t: "Then I suppose this means a battle!", s: "Horatio", spr: pl_enemy, port: spr_Addeline_Portraits };

// Position for Environment Placeholders
addeline_x = 200; addeline_y = room_height - 500;
fairy_x = 450;    fairy_y = room_height - 450;
horatio_x = room_width - 250; horatio_y = room_height - 500;



current_line = 0;
show_horatio = false;

player_hp = 100; // Gives the dialogue scene a starting HP value so it doesn't crash