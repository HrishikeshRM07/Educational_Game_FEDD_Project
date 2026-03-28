// 1. Level 2 Pre-Battle Script
dialogue[0] = { t: "Looks like Horatio is just up ahead. We must be getting close to the Summation Scorpion’s lair at this point. How are you feeling Addeline?", s: "Bria", port: AddelineBUI }; // Assuming Bria shares the portrait sprite or has her own
dialogue[1] = { t: "I’m doing OK! King Phi has a lot of forces, which is worrying me a bit. If this is how he is before reaching full power I feel like it’ll be near impossible to defeat him by the time we get there.", s: "Addeline", port: AddelineBUI };
dialogue[2] = { t: "Yeah, it’s definitely getting worse, not to mention how deserted it feels. Like somebody is always watching us.", s: "Bria", port: AddelineBUI };
dialogue[3] = { t: "I don’t think we’re alone after all Bria. Get ready for another fight!", s: "Addeline", port: AddelineBUI };
dialogue[4] = { t: "Wait wait wait! I promise I’m not with King Phi, I’m just a librarian who wanted to see what was happening! I’ve been keeping track of everything that’s happened recently to create a book for the library.", s: "Milly", port: MillyBUI };
dialogue[5] = { t: "And you decided the way to go about that was following us around without a word?", s: "Bria", port: AddelineBUI };
dialogue[6] = { t: "Not to mention the fact that we have no reason to trust you.", s: "Addeline", port: AddelineBUI };
dialogue[7] = { t: "Nevermind, obviously there are enemies coming, and we don’t have time for arguing. Can you fight?", s: "Addeline", port: AddelineBUI };
dialogue[8] = { t: "I’m not the best at fighting, but I’ll do my best to support you!", s: "Milly", port: MillyBUI };
dialogue[9] = { t: "Alright newbie! Let’s see what you can do.", s: "Bria", port: AddelineBUI };

current_line = 0;
text_progress = 0; 
text_speed = 0.5;

// Positions
addeline_x = 200;
addeline_y = room_height - 500;

// Milly's Position (further to the right)
milly_x = 600;
milly_y = room_height - 500;

