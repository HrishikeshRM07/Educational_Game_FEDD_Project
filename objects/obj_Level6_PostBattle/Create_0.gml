// --- 1. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;
fade_alpha = 0; // Controls the black screen fade
player_flash_alpha = 0;

// --- 2. TYPEWRITER VARIABLES ---
text_progress = 0;
text_speed = 0.5;

// --- 3. DIALOGUE SETUP ---
dialogue = [];

dialogue[0]  = { t: "How\u002E\u002E\u002E I" + chr(39) + "d collected so much power\u002E\u002E\u002E how could you have defeated me?", s: "King Phi", port: -1 };
dialogue[1]  = { t: "While you may have had power, you never took the time to learn how to use it.", s: "Erin", port: ErinDialogue }; 
dialogue[2]  = { t: "You took and took until it was all that you knew.", s: "Erin", port: ErinDialogue }; 
dialogue[3]  = { t: "Without training your skills you" + chr(39) + "d never be able to use what you’d learned.", s: "Milly", port: MillyDialogue };
dialogue[4]  = { t: "We didn\u0027t hoard a power all for ourselves. We worked together, and trained in order to get here.", s: "Addeline", port: AddelineDialogue };
dialogue[5]  = { t: "And I\u0027m so proud of you all! For now, King Phi shall be sent to the dungeon,", s: "Bria", port: BriaDialogue };
dialogue[6]  = { t: "and we shall work to repair the kingdom.", s: "Bria", port: BriaDialogue };
dialogue[7]  = { t: "I cannot thank you all enough for the help that you\u0027ve provided us with. The kingdom is in your debt.", s: "Bria", port: BriaDialogue };
dialogue[8]  = { t: "It is my duty to you as your knight M\u0027lady, but thank you for your kind words.", s: "Erin", port: ErinDialogue };
dialogue[9]  = { t: "I can continue to escort you until the force is fully put together?", s: "Erin", port: ErinDialogue };
dialogue[10] = { t: "That would be greatly appreciated, thank you Erin.", s: "Bria", port: BriaDialogue };
dialogue[11] = { t: "Addeline, Milly, is there anything that I could do to assist you both?", s: "Bria", port: BriaDialogue };
dialogue[12] = { t: "You\u0027re free to stay at the castle until we can get you back to your homes.", s: "Bria", port: BriaDialogue };
dialogue[13] = { t: "I" + chr(39) + "d appreciate some materials to complete my records of what\u0027s happened!", s: "Milly", port: MillyDialogue };
dialogue[14] = { t: "Not to mention, a few books at the library were destroyed when King Phi took over,", s: "Milly", port: MillyDialogue };
dialogue[15] = { t: "so if there\u0027s any way that they could be refound\u002E\u002E?", s: "Milly", port: MillyDialogue };
dialogue[16] = { t: "Of course, that isn\u0027t a problem. And you, Addeline?", s: "Bria", port: BriaDialogue };
dialogue[17] = { t: "I think\u002E\u002E\u002E all I need for now is to make sure my home gets all the supplies it needs to properly rebuild.", s: "Addeline", port: AddelineDialogue };
dialogue[18] = { t: "What matters most right now is ensuring everyone is getting the support they need.", s: "Addeline", port: AddelineDialogue };
dialogue[19] = { t: "Well, it sounds like there\u0027s a lot to get done!", s: "Bria", port: BriaDialogue };
dialogue[20] = { t: "I\u0027ll do my best to fulfill these requests, and ensure that the kingdom remains balanced in the future.", s: "Bria", port: BriaDialogue };
dialogue[21] = { t: "*The scene fades to black.*", s: "", port: -1 };
dialogue[22] = { t: "And so\u002E\u002E\u002E the story of PEMDAS Pandemonium comes to a close.", s: "Narrator", port: -1 };
dialogue[23] = { t: "And everyone lived happily ever after.", s: "Narrator", port: -1 };