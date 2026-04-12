// --- 1. DIALOGUE SCRIPT ---
dialogue = [];

dialogue[0] = { t: "Alright! We\u0027re ready to set out. Just so you know it\u0027s only going to get more dangerous from here though.", s: "Bria", port: BriaDialogue, f: 1 };

dialogue[1] = { t: "King Phi has been putting together his forces for a long time, so let\u0027s start it out nice and easy. \nLook! Here are some enemies to fight now.", s: "Bria", port: BriaDialogue, f: 2 };

dialogue[2] = { t: "Bring it on!", s: "Addeline", port: AddelineDialogue, f: 1};

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