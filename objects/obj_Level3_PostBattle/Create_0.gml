// --- 1. DIALOGUE SCRIPT ---
// --- 1. DIALOGUE SCRIPT ---
// After the fight
dialogue[0] = { t: "Haha! This will only help to grow King Phi\u0027s powers.\nGood luck, bold adventurers, and thank you for doing the dirty work.", s: "Horatio", port: HoratioDialogue, f: 1 };
dialogue[1] = { t: "That\u002E\u002E\u002E was a lot", s: "Milly", port: MillyDialogue, f: 4 };

// Bria\u0027s reassurance, split for pacing
dialogue[2] = { t: "And worst of all Horatio got away\u002E\u002E\u002E", s: "Addeline", port: AddelineDialogue, f: 0 };
dialogue[3] = { t: "It\u0027s OK Addeline! ", s: "Bria", port: BriaDialogue, f: 3 };

// Milly\u0027s support, split for pacing
dialogue[4] = { t: "We\u0027ll be approaching King Phi’s castle soon, and we\u0027ll be able to put an end to all of this.\nWe\u0027ll be approaching the castle soon\u002E\u002E\u002E So its best to keep moving", s: "Milly", port: BriaDialogue, f: 1 };
dialogue[5] = { t: "It\u0027ll be OK Addeline…\nI know we haven\u0027t known each other long, but we\u0027ll get through this together.", s: "Milly", port: MillyDialogue, f: 1 };

// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100; // For Addeline\u0027s dynamic face frame

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0; 
text_speed = 0.5;