// --- 1. DIALOGUE SCRIPT ---
// --- 1. DIALOGUE SCRIPT ---
dialogue = [];

dialogue[0] = { t: "Thank you guys for the help!", s: "Milly", port: MillyDialogue, f: 1 };
dialogue[1] = { t: "That definitely would’ve been the end for me if I was alone.", s: "Milly", port: MillyDialogue, f: 4 };

dialogue[2] = { t: "Not a problem!", s: "Addeline", port: AddelineDialogue, f: 1 };
dialogue[3] = { t: "You were really helpful in that fight too.", s: "Addeline", port: AddelineDialogue, f: 1 };

dialogue[4] = { t: "Honestly… I wouldn’t mind if you stuck around with us.", s: "Addeline", port: AddelineDialogue, f: 5 };

dialogue[5] = { t: "The more people on our side, the better.", s: "Bria", port: BriaDialogue, f: 2 };
dialogue[6] = { t: "King Phi definitely won’t go down without a fight.", s: "Bria", port: BriaDialogue, f: 3 };

dialogue[7] = { t: "Oh! Thank you!", s: "Milly", port: MillyDialogue, f: 1 };
dialogue[8] = { t: "I’d be happy to join.", s: "Milly", port: MillyDialogue, f: 1 };

dialogue[9] = { t: "This is a perfect chance to document everything going on.", s: "Milly", port: MillyDialogue, f: 1};

dialogue[10] = { t: "We were heading to find the Summation Scorpion, right?", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[11] = { t: "It should be in a cave up ahead.", s: "Milly", port: MillyDialogue, f: 2 };

// Horatio moment (off-screen awareness)
dialogue[12] = { t: "Wait… I think I see something.", s: "Addeline", port: AddelineDialogue, f: 1 };
dialogue[13] = { t: "Horatio just went into that cave over there.", s: "Addeline", port: AddelineDialogue, f: 1 };

dialogue[14] = { t: "Perfect.", s: "Bria", port: BriaDialogue, f: 2 };
dialogue[15] = { t: "Make sure you’re all ready.", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[16] = { t: "This next fight is going to be a big one.", s: "Bria", port: BriaDialogue, f: 3 };

// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
horatio_enters_cave = false; // Triggered at line 7
player_hp = 100; // For Addeline's dynamic face frame

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0; 
text_speed = 0.5;