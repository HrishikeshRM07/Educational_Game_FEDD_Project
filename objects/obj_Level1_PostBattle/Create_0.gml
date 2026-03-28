// 1. Post-Battle Dialogue Script
dialogue[0] = { t: "This is getting easier each time! Thank you Bria. Although I do have to ask, do you know why so much destruction has happened because of King Phi?", s: "Addeline", spr: pl_ad, port: AddelineBUI };
dialogue[1] = { t: "Since King Phi has wanted power for a long time, he’s willing to go to any length in order to get it. At first, the problems could be solved with a quick fix, such as needing to replant some trees, but as time passed, the issues seemed to multiply… Until it got to a point where I was kidnapped, and the Summation Scorpion attacked your town. King Phi’s actions have created an effect that has spread across the kingdom.", s: "Bria", spr: pl_fairy, port: AddelineBUI };
dialogue[2] = { t: "That… makes a lot of sense! Thank you Bria.", s: "Addeline", spr: pl_ad, port: AddelineBUI };
dialogue[3] = { t: "Not a problem Addeline! Now, let’s keep moving, I can’t help but feel like we’re being followed, and the sooner that we find Horatio, the closer we’ll be to beating King Phi.", s: "Bria", spr: pl_fairy, port: AddelineBUI };

current_line = 0;
text_progress = 0; 
text_speed = 0.5;

// Positions
addeline_x = 200;
addeline_y = room_height - 500;