// --- 1. DIALOGUE SCRIPT ---
dialogue = [];

// Addeline starts, grateful & curious
dialogue[0] = { t: "This is getting easier each time! Thank you, Bria.", s: "Addeline", spr: pl_ad, port: AddelineDialogue, f: 5 };
dialogue[1] = { t: "Although I do have to ask… do you know why so much destruction has happened because of King Phi?", s: "Addeline", spr: pl_ad, port: AddelineDialogue, f: 0 };

// Bria explains in small chunks for pacing
dialogue[2] = { t: "King Phi has wanted power for a long time, and he’s willing to go to any length to get it.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 2 };
dialogue[3] = { t: "At first, the problems could be solved with quick fixes, like replanting some trees.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 1 };
dialogue[4] = { t: "But over time, the issues multiplied.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 2 };
dialogue[5] = { t: "It escalated to the point where I was kidnapped, and the Summation Scorpion attacked your town.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 3 };
dialogue[6] = { t: "King Phi’s actions created effects that spread across the entire kingdom.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 3 };

// Addeline reacts
dialogue[7] = { t: "That… makes a lot of sense! Thank you, Bria.", s: "Addeline", spr: pl_ad, port: AddelineDialogue, f: 1 };

// Bria pushes the story forward
dialogue[8] = { t: "Not a problem, Addeline!", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 1 };
dialogue[9] = { t: "Now, let’s keep moving. I can’t shake the feeling that we’re being followed…", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 3 };
dialogue[10] = { t: "...and the sooner we find Horatio, the closer we’ll be to defeating King Phi.", s: "Bria", spr: pl_fairy, port: BriaDialogue, f: 3 };

// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;

// --- 2. ENVIRONMENT VARIABLES ---
addeline_x = 280; addeline_y = room_height - 700;
fairy_x = 630;    fairy_y = room_height - 630;
horatio_x = room_width - 350; horatio_y = room_height - 700;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0; 
text_speed = 0.5;