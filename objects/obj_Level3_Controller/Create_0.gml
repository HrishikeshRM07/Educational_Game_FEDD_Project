// --- 1. DIALOGUE SCRIPT ---
// Intro
dialogue[0] = { t: "HORATIO! What do you think you\u0027re doing?", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[1] = { t: "Why, gathering more power for King Phi, of course.", s: "Horatio", port: HoratioDialogue, f: 2 };
dialogue[2] = { t: "What else would I need this pesky scorpion for?", s: "Horatio", port: HoratioDialogue, f: 1 };

// { The Summation Scorpion shifts, looking as though it is in pain... }
dialogue[3] = { t: "That’s enough, Horatio! Don’t you see you\u0027re hurting the Scorpion?", s: "Addeline", port: AddelineDialogue, f :2 };

// { Horatio moves away from the Scorpion, carrying a vial... }
dialogue[4] = { t: "That\u0027s not my problem!", s: "Horatio", port: HoratioDialogue, f: 3 };
dialogue[5] = { t: "I guess you\u0027ll just have to deal with the scorpion if you\u0027re wanting to stop me.", s: "Horatio", port: HoratioDialogue, f: 1 };

// The beast attacks!
dialogue[6] = { t: "Uhm, guys\u002E\u002E\u002E I think it\u0027s about to attack us!", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[7] = { t: "Horatio\u002E\u002E\u002E how could he\u002E\u002E\u002E", s: "Addeline", port: AddelineDialogue };
dialogue[8] = { t: "No time for that Addeline! The scorpion\u0027s about to attack! Brace yourself!", s: "Bria", port: BriaDialogue, f: 3 };

// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100; // For Addeline's dynamic face frame

// Scene Action Triggers
scorpion_shifts = false; // Triggered at line 3
horatio_escapes = false; // Triggered at line 4

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0; 
text_speed = 0.5;