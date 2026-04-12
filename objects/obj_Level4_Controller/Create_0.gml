// --- 1. DIALOGUE SCRIPT ---

dialogue = [];

// Opening dialogue
dialogue[0] = { t: "Looks like we’re at the castle grounds everyone. King Phi is in our reach too.", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[1] = { t: "We’ve come a long way… hopefully defeating him can help us start to recover.", s: "Addeline", port: AddelineDialogue, f: 1 };
dialogue[2] = { t: "My home, and your sister Bria.", s: "Addeline", port: AddelineDialogue, f: 3 };
dialogue[3] = { t: "Wait wait wait, Bria has a sister?", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[4] = { t: "Yes, my twin… Although King Phi had captured both her and I when he first took over", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[5] = { t: "Wow… King Phi really set off so much for everyone.", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[6] = { t: "I mean, he is the reason that I started writing down everything myself.", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[7] = { t: "The libraries weren’t being allowed to take any notes without them being reviewed\nso I ran off to make my own account.", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[8] = { t: "So it was really just King Phi who caused so many side effects for everyone here.", s: "Addeline", port: AddelineDialogue };
dialogue[9] = { t: "It’s hard to imagine how many other people he could’ve changed the lives of.", s: "Addeline", port: AddelineDialogue };

// Erin enters
dialogue[10] = { t: "Halt! For what reason do you approach the castle?", s: "Erin", port: ErinDialogue, f: 3 };
dialogue[11] = { t: "We’re here to stop King Phi.", s: "Addeline", port: AddelineDialogue, f: 2 };
dialogue[12] = { t: "You’re here to fight King Phi?", s: "Erin", port: ErinDialogue, f: 2 };
dialogue[13] = { t: "You’re either very powerful or very dumb.", s: "Erin", port: ErinDialogue, f: 3 };
dialogue[14] = { t: "I’ll have you know that these two have been personally learning under me.", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[15] = { t: "Based on your outfit I’d assume you are a former guard of the castle?", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[16] = { t: "Yes, I- wait. You recognize the old uniform?", s: "Erin", port: ErinDialogue, f: 2 };
dialogue[17] = { t: "Bria, is that you?", s: "Erin", port: ErinDialogue, f: 0 };
dialogue[18] = { t: "Erin?", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[19] = { t: "Yes! I’m so glad you’re OK, m’lady.", s: "Erin", port: ErinDialogue, f: 1 };
dialogue[20] = { t: "If it’s you who has come to fight King Phi, then there is certainly no way to lose.", s: "Erin", port: ErinDialogue, f: 1 };
dialogue[21] = { t: "Bria, how do you know Erin?", s: "Milly", port: MillyDialogue, f: 2 };
dialogue[22] = { t: "Erin was one of the former guards at the castle,", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[23] = { t: "who also was there when King Phi had initially taken over.", s: "Bria", port: BriaDialogue, f: 1 };
dialogue[24] = { t: "Well, we’re in good hands if we have a soldier with us.", s: "Addeline", port: AddelineDialogue, f: 1 };
dialogue[25] = { t: "And I think we’re about to get some real hands-on experience", s: "Addeline", port: AddelineDialogue, f: 1 };
dialogue[26] = { t: "considering soldiers are coming towards us now.", s: "Addeline", port: AddelineDialogue, f: 2 };
dialogue[27] = { t: "Let’s get ready to fight!", s: "Bria", port: BriaDialogue, f: 3 };
dialogue[28] = { t: "Erin, are you with us?", s: "Bria", port: BriaDialogue, f: 1 };
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