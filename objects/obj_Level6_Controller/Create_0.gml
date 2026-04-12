dialogue = [];

dialogue[0] = { t: "Just through here is King Phi\u002E\u002E\u002E Are you all ready?", s: "Bria", port: BriaDialogue };
dialogue[1] = { t: "Yeah!", s: "Everyone", port: AddelineDialogue }; 
dialogue[2] = { t: "*They enter the throne room. Horatio and King Phi stand on the other side of the room.*", s: "", port: -1 };
dialogue[3] = { t: "Well well well\u002E\u002E\u002E The troublemakers have arrived, just as you\u0027ve said Horatio. You have served well.", s: "King Phi", port: -1 }; // Changed to -1 temporarily
dialogue[4] = { t: "Thank you King Phi. Yes, I have tried time and again to get them to stop their useless pursuit, but they just can\u0027t seem to understand why your excellence is necessary.", s: "Horatio", port: HoratioDialogue}; // Changed to -1 temporarily
dialogue[5] = { t: "Maybe it\u0027s because all that Phi\u0027s excellence is doing is destroying people\u0027s homes, their lives, their families! He\u0027s done nothing but bring destruction upon everyone!", s: "Addeline", port: AddelineDialogue };
dialogue[6] = { t: "Yea! We wouldn\u0027t have had to deal with any of this if Bria had still been in power.", s: "Milly", port: MillyDialogue };
dialogue[7] = { t: "I have a duty and the kingdom to ensure that everyone is protected. And you have failed to do this.", s: "Erin", port: ErinDialogue };
dialogue[8] = { t: "Do you hear that King Phi? Everyone is sick of you! It would be better if you were out of power.", s: "Bria", port: BriaDialogue };
dialogue[9] = { t: "It seems that you will not back down. Nevertheless, I have collected enough power at this point, just a little more should be enough to ensure this is an easy fight. Horatio. Come to me.", s: "King Phi", port: -1 }; // Changed to -1 temporarily
dialogue[10] = { t: "*Horatio walks to King Phi.*", s: "", port: -1 };
dialogue[11] = { t: "Yes, my king?", s: "Horatio", port: HoratioDialogue}; // Changed to -1 temporarily
dialogue[12] = { t: "Your last act of service to me shall be giving me your power.", s: "King Phi", port: -1 }; // Changed to -1 temporarily
dialogue[13] = { t: "*King Phi grabs Horatio and drains the power from him, leaving Horatio abandoned by the throne.*", s: "", port: -1 };
dialogue[14] = { t: "Now, to deal with you pesky vermin.", s: "King Phi", port: -1 }; // Changed to -1 temporarily


// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;
player_flash_alpha = 0;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0;
text_speed = 0.5;