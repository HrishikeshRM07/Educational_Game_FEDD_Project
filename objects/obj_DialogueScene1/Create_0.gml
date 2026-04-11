// --- 1. DIALOGUE SCRIPT ---
dialogue = [];

dialogue[0] = { t: "Excuse me! Are you one of the residents of this town?", s: "Fairy", port: BriaDialogue, f: 1 };

dialogue[1] = { t: "Yes, but well\u002E\u002E\u002E you can see what\u0027s happened here. Is there something you need help with? I may not be able to due to the damage, but I\u0027m ready to try!", s: "Addeline", port: AddelineDialogue, f: 0 };

dialogue[2] = { t: "Yes! I\u0027m here to find those with mathemagical abilities in order to save the city! King Phi\u0027s actions are causing chaos everywhere, and I think you may have the ability to help.", s: "Fairy", port: BriaDialogue, f: 1 };

dialogue[3] = { t: "Dear citizen, are you OK?", s: "Horatio", port: HoratioDialogue, f: 0 };
dialogue[4] = { t: "This creature\u002E\u002E\u002E needs to be taken back to the castle immediately. I hope it did not cause you any trouble.", s: "Horatio", port: HoratioDialogue, f: 0 };

dialogue[5] = { t: "Don\u0027t listen to him Addeline! Just give it a try with me!", s: "Fairy", port: BriaDialogue, f: 2 };

dialogue[6] = { t: "If you don\u0027t have a reason for needing Fairy\u002E\u002E\u002E", s: "Addeline", port: AddelineDialogue, f: 0 };
dialogue[7] = { t: "Then they can stay with me!", s: "Addeline", port: AddelineDialogue, f: 2 };

dialogue[8] = { t: "Then I suppose this means a battle!", s: "Horatio", port: HoratioDialogue, f: 3 };

// --- 2. ENVIRONMENT VARIABLES ---
addeline_x = 280; addeline_y = room_height - 700;
fairy_x = 630;    fairy_y = room_height - 630;
horatio_x = room_width - 350; horatio_y = room_height - 700;

// --- 3. SCENE STATE VARIABLES ---
current_line = 0;
show_horatio = false;
player_hp = 100; // Gives the dialogue scene a starting HP value

// --- 4. TYPEWRITER VARIABLES ---
text_progress = 0; // Starts at 0 letters
text_speed = 0.5;  // How fast the text types (higher is faster)