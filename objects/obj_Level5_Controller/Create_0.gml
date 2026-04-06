dialogue = [];

dialogue[0] = { t: "So, Erin, what was your time in the castle like?", s: "Milly", port: MillyDialogue };
dialogue[1] = { t: "Before King Phi came it was actually very nice. I was mostly focused on defense, so patrols and the like,", s: "Erin", port: ErinDialogue };
dialogue[2] = { t: "but everyone was treated well. The work was steady, and we never had to worry under the twin’s care.", s: "Erin", port: ErinDialogue };
dialogue[3] = { t: "Hopefully, once King Phi is gone, we can go back to that kind of peace too.", s: "Milly", port: MillyDialogue };
dialogue[4] = { t: "I have a feeling that’s what everyone wants.", s: "Bria", port: BriaDialogue };
dialogue[5] = { t: "For now though, we have one last set of soldiers, so think of this as your last piece of training before King Phi.", s: "Bria", port: BriaDialogue };


// --- 2. SCENE STATE VARIABLES ---
current_line = 0;
player_hp = 100;

// --- 3. TYPEWRITER VARIABLES ---
text_progress = 0;
text_speed = 0.5;