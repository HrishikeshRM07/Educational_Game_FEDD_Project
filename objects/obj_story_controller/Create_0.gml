// 1. Text Content
dialogue[1] = { t: "And so… the story of PEMDAS Pandemonium comes to a close. And everyone lived happily ever after.", s: "Narrator", port: -1 };

// 2. Custom Positions for each line (Adjust these numbers!)
// Format: [Index] = Value;
// X is left/right (0 to room_width), Y is up/down (0 to room_height)

// Line 0
story_spr_x[0] = room_width / 2; story_spr_y[0] = 300;
// Line 1

// 3. Logic Variables
current_line = 0;
text_alpha = 0;       
fade_speed = 0.01;    // Speed of fade (0.01 is slow, 0.05 is fast)
fade_state = "in";    
timer = 150;          // How long to stay on screen