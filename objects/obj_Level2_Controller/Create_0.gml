// --- 1. DIALOGUE SCRIPT ---
dialogue = [];

// Approaching the Summation Scorpion's lair
dialogue[0] = { t: "Looks like Horatio is just up ahead. We must be getting close to the Summation Scorpion\u0027s lair at this point.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 1 };
dialogue[1] = { t: "How are you feeling Addeline?", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 0};

// Addeline responds, worried but composed
dialogue[2] = { t: "I\u0027m doing OK! King Phi has a lot of forces, which is worrying me a bit.", s: "Addeline", spr: pl_ad, port: AddelineDialogue, f: 0 };
dialogue[3] = { t: "If this is how he is before reaching full power I feel like it\u0027ll be near impossible to defeat him by the time we get there.", s: "Addeline", spr: pl_ad, port: AddelineDialogue, f: 0 };

// Bria senses tension
dialogue[4] = { t: "Yeah, it\u0027s definitely getting worse, not to mention how deserted it feels. Like somebody is always watching us.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 3 };

// Addeline notices danger
dialogue[5] = { t: "I don\u0027t think we’re alone after all Bria. Get ready for another fight!", s: "Addeline", spr: pl_ad, port: AddelineDialogue, f: 2 };

// Milly appears, frantic
dialogue[6] = { t: "Wait wait wait! I promise I\u0027m not with King Phi, I\u0027m just a librarian who wanted to see what was happening!", s: "Milly", spr: pl_ob, port: MillyDialogue, f: 2 };
dialogue[7] = { t: "I\u0027ve been keeping track of everything that\u0027s happened recently to create a book for the library.", s: "Milly", spr: pl_ob, port: MillyDialogue, f: 1 };

// Bria reacts skeptically
dialogue[8] = { t: "And you decided the way to go about that was following us around without a word?", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 2 };

// Addeline distrustful
dialogue[9] = { t: "Not to mention the fact that we have no reason to trust you.", s: "Addeline", spr: pl_ad, port: AddelineDialogue, f: 2 };
dialogue[10] = { t: "Nevermind, obviously there are enemies coming, and we don\u0027t have time for arguing. Can you fight?", s: "Addeline", spr: pl_ad, port: AddelineDialogue, f: 0 };

// Milly tries to help
dialogue[11] = { t: "I\u0027m not the best at fighting, but I\u0027ll do my best to support you!", s: "Milly", spr: pl_ob, port: MillyDialogue, f: 2 };

// Bria encouraging
dialogue[12] = { t: "Alright newbie! Let’s see what you can do.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 1 };

// --- 2. ENVIRONMENT VARIABLES ---
addeline_x = 200; addeline_y = room_height - 500;
milly_x = 600;    milly_y = room_height - 500;

// --- 3. SCENE STATE VARIABLES ---
current_line = 0;
show_milly = false; // Starts false until line 6!
player_hp = 100;    // For Addeline's dynamic face frame


// --- 4. TYPEWRITER VARIABLES ---
text_progress = 0; 
text_speed = 0.5;