dialogue = [];

dialogue[0] = { t: "Great work everyone! Just past here is the throne room.", s: "Bria", port: BriaDialogue };
dialogue[1] = { t: "We finally made it… I swear, King Phi will pay for what he’s done.", s: "Addeline", port: AddelineDialogue };
dialogue[2] = { t: "This will go down in the history books as a battle for the ages!", s: "Milly", port: MillyDialogue };
dialogue[3] = { t: "It’s time to reclaim this castle.", s: "Erin", port: ErinDialogue };


// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0;
text_speed = 0.5;