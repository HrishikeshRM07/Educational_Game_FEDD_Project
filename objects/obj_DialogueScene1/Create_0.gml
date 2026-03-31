// --- 1. DIALOGUE SCRIPT ---
dialogue = [];

dialogue[0] = { t: "Excuse me! Are you one of the residents of this town?", s: "Fairy", port: BriaDialogue, f: 1 };

dialogue[1] = { t: "Yes, but well… you can see what’s happened here.", s: "Addeline", port: AddelineDialogue, f: 0 };

dialogue[2] = { t: "I’m here to find those with mathemagical abilities!", s: "Fairy", port: BriaDialogue, f: 1 };

dialogue[3] = { t: "Dear citizen, are you OK?", s: "Horatio", port: HoratioDialogue, f: 0 };
dialogue[4] = { t: "This creature needs to go back!", s: "Horatio", port: HoratioDialogue, f: 0 };

dialogue[5] = { t: "Don’t listen to him Addeline! Just give it a try with me!", s: "Fairy", port: BriaDialogue, f: 2 };

dialogue[6] = { t: "If you don’t have a reason for needing Fairy…", s: "Addeline", port: AddelineDialogue, f: 0 };
dialogue[7] = { t: "Then they stay with me!", s: "Addeline", port: AddelineDialogue, f: 2 };

dialogue[8] = { t: "Then I suppose this means a battle!", s: "Horatio", port: HoratioDialogue, f: 3 };

// --- 2. ENVIRONMENT VARIABLES ---
addeline_x = 200; addeline_y = room_height - 500;
fairy_x = 450;    fairy_y = room_height - 450;
horatio_x = room_width - 250; horatio_y = room_height - 500;

// --- 3. SCENE STATE VARIABLES ---
current_line = 0;
show_horatio = false;
player_hp = 100; // Gives the dialogue scene a starting HP value

// --- 4. TYPEWRITER VARIABLES ---
text_progress = 0; // Starts at 0 letters
text_speed = 0.5;  // How fast the text types (higher is faster)