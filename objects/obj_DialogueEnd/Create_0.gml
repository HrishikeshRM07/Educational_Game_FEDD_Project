// --- 1. DIALOGUE SCRIPT ---
dialogue = [];

dialogue[0] = { t: "Fascinating… You may have bested me this time…", s: "Horatio", port: HoratioDialogue, f: 0 };
dialogue[1] = { t: "But you will not best me again!", s: "Horatio", port: HoratioDialogue, f: 3 };

dialogue[2] = { t: "For now… you are safe. Farewell.", s: "Horatio", port: HoratioDialogue, f: 0 };

dialogue[3] = { t: "Addeline, that was amazing!", s: "Fairy", port: BriaDialogue, f: 1 };
dialogue[4] = { t: "You really are a skilled warrior.", s: "Fairy", port: BriaDialogue, f: 1 };

dialogue[5] = { t: "King Phi has been trying to gain more mathemagical powers…", s: "Fairy", port: BriaDialogue, f: 2 };
dialogue[6] = { t: "But it’s had some pretty damaging results.", s: "Fairy", port: BriaDialogue, f: 4 };

dialogue[7] = { t: "My sibling and I tried to stop him…", s: "Fairy", port: BriaDialogue, f: 4 };
dialogue[8] = { t: "But he captured both of us.", s: "Fairy", port: BriaDialogue, f: 4 };

dialogue[9] = { t: "So what do you say… will you help us?", s: "Fairy", port: BriaDialogue, f: 2 };

dialogue[10] = { t: "Of course!", s: "Addeline", port: AddelineDialogue, f: 5 };
dialogue[11] = { t: "I won’t let my home be destroyed.", s: "Addeline", port: AddelineDialogue, f: 2 };
dialogue[12] = { t: "I’ll help you.", s: "Addeline", port: AddelineDialogue, f: 5 };

// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0; 
text_speed = 0.5;

