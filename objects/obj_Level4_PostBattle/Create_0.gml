// --- 1. DIALOGUE SCRIPT ---

dialogue = [];

dialogue[0] = { t: "It’s been some time since I’ve been in a fight that was as intense as that one!", s: "Erin", port: ErinDialogue };
dialogue[1] = { t: "I can certainly see why m’lady Bria believes you can defeat King Phi.", s: "Erin", port: ErinDialogue };

dialogue[2] = { t: "Thank you!", s: "Milly", port: MillyDialogue };

dialogue[3] = { t: "We’ve had time to train… which definitely helps.", s: "Addeline", port: AddelineDialogue };

dialogue[4] = { t: "Regardless, we’re almost at King Phi now!", s: "Bria", port: BriaDialogue };
dialogue[5] = { t: "I have faith in all of you — as a team.", s: "Bria", port: BriaDialogue };


// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0;
text_speed = 0.5;