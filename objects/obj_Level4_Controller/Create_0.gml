// --- 1. DIALOGUE SCRIPT ---

dialogue = [];

// Opening dialogue
dialogue[0] = { t: "Looks like we’re almost to the castle everyone. King Phi is in our reach too.", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[1] = { t: "We’ve come a long way… hopefully defeating him can help us start to recover.", s: "Addeline", port: AddelineDialogue, f: 1 };
dialogue[2] = { t: "My home… and your sister, Bria.", s: "Addeline", port: AddelineDialogue, f: 3 };
dialogue[3] = { t: "Wait wait wait, Bria has a sister?", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[4] = { t: "Yes, my twin… although King Phi captured both her and I when he first took over.", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[5] = { t: "Wow… King Phi really set off so much for everyone.", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[6] = { t: "He’s the reason I started writing everything down myself.", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[7] = { t: "The libraries weren’t allowed to take notes without review… so I ran off and made my own records.", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[8] = { t: "So it really was King Phi who caused so many ripple effects for everyone here.", s: "Addeline", port: AddelineDialogue };
dialogue[9] = { t: "It’s hard to imagine how many lives he’s changed…", s: "Addeline", port: AddelineDialogue };

// Erin enters
dialogue[10] = { t: "Halt! For what reason do you approach the castle?", s: "Erin", port: ErinDialogue, f: 3 };
dialogue[11] = { t: "We’re here to stop King Phi.", s: "Addeline", port: AddelineDialogue, f: 2 };
dialogue[12] = { t: "You’re here to fight King Phi?", s: "Erin", port: ErinDialogue, f: 2 };
dialogue[13] = { t: "You’re either very powerful… or very dumb.", s: "Erin", port: ErinDialogue, f: 3 };
dialogue[14] = { t: "I’ll have you know these two have been training under me.", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[15] = { t: "And based on your outfit… I’d assume you’re a former guard of the castle?", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[16] = { t: "Yes, I— wait… you recognize this uniform?", s: "Erin", port: ErinDialogue, f: 2 };
dialogue[17] = { t: "Bria… is that you?", s: "Erin", port: ErinDialogue, f: 0 };
dialogue[18] = { t: "Erin?", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[19] = { t: "Yes! I’m so glad you’re alright, m’lady.", s: "Erin", port: ErinDialogue, f: 1 };
dialogue[20] = { t: "If it’s you who’s come to fight King Phi… then there’s no way we can lose.", s: "Erin", port: ErinDialogue, f: 1 };
dialogue[21] = { t: "Bria, how do you know Erin?", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[22] = { t: "Erin was one of the castle guards…", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[23] = { t: "She was there when King Phi first took over.", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[24] = { t: "Well, we’re in good hands if we’ve got a soldier with us.", s: "Addeline", port: AddelineDialogue, f: 1 };
dialogue[25] = { t: "And it looks like we’re about to get real experience…", s: "Addeline", port: AddelineDialogue, f: 1 };
dialogue[26] = { t: "Soldiers are heading this way now.", s: "Addeline", port: AddelineDialogue, f: 2 };
dialogue[27] = { t: "Then let’s get ready to fight!", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[28] = { t: "Erin — are you with us?", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[29] = { t: "Let’s go!", s: "Erin", port: ErinDialogue, f: 3 };

// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0;
text_speed = 0.5;


// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0;
text_speed = 0.5;