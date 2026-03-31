// --- 1. DIALOGUE SCRIPT ---
dialogue = [];

dialogue[0] = { t: "Alright! We’re ready to set out...", s: "Bria", port: BriaDialogue, f: 1 };

dialogue[1] = { t: "King Phi has been putting together something dangerous...", s: "Bria", port: BriaDialogue, f: 2 };

dialogue[2] = { t: "Bring it on!", s: "Addeline", port: AddelineDialogue, f: 1};

// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0; 
text_speed = 0.5;