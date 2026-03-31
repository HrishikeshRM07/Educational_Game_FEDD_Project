// --- 1. DIALOGUE SCRIPT ---
// --- 1. DIALOGUE SCRIPT ---
// After the fight
dialogue[0] = { t: "That… was a lot.", s: "Milly", port: MillyDialogue, f: 4 };
dialogue[1] = { t: "And worst of all Horatio got away…", s: "Addeline", port: AddelineDialogue, f: 0 };

// Bria's reassurance, split for pacing
dialogue[2] = { t: "It’s OK Addeline! We’ll be approaching King Phi’s castle soon, and we’ll be able to put an end to all of this.", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[3] = { t: "We’ll be approaching the castle soon… So it’s best to keep moving.", s: "Bria", port: BriaDialogue, f: 1 };

// Milly's support, split for pacing
dialogue[4] = { t: "It’ll be OK Addeline…", s: "Milly", port: MillyDialogue, f: 0 };
dialogue[5] = { t: "I know we haven’t known each other long, but we’ll get through this together.", s: "Milly", port: MillyDialogue, f: 1 };

// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100; // For Addeline's dynamic face frame

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0; 
text_speed = 0.5;