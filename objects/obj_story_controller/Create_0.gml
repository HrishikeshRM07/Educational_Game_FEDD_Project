// 1. Text Content
story_text[0] = "Long ago, the world was at peace";
story_text[1] = "There lived two faires and a King.";
story_text[2] = "They were best of friends.";
story_text[3] = "Untill something changed";
story_text[4] = "King PHI was corrupted and laid havoc acrossed the world.";
story_text[5] = "Land was attacked and villages fell";
story_text[6] = "The two Faires tried to stop up";
story_text[7] = "But to no avail as one of the fairy sisters got trapped by the King";
story_text[8] = "The Other fairy sister, Bria, escaped";
story_text[9] = "In search of some worthy enough to defeat King Phi";

// 2. Custom Positions for each line (Adjust these numbers!)
// Format: [Index] = Value;
// X is left/right (0 to room_width), Y is up/down (0 to room_height)

// Line 0
story_spr_x[0] = room_width / 2; story_spr_y[0] = 300;
// Line 1
story_spr_x[1] = room_width / 2 - 150; story_spr_y[1] = 250;
// Line 2
story_spr_x[2] = room_width / 2 + 150; story_spr_y[2] = 250;
// Line 3
story_spr_x[3] = room_width / 2; story_spr_y[3] = 400;
// Line 4
story_spr_x[4] = 200; story_spr_y[4] = 200;
// Line 5
story_spr_x[5] = room_width - 200; story_spr_y[5] = 200;
// Line 6
story_spr_x[6] = room_width / 2; story_spr_y[6] = 300;
// Line 7
story_spr_x[7] = room_width / 2; story_spr_y[7] = 200;
// Line 8
story_spr_x[8] = 150; story_spr_y[8] = 400;
// Line 9
story_spr_x[9] = room_width / 2; story_spr_y[9] = 300;

// 3. Logic Variables
current_line = 0;
text_alpha = 0;       
fade_speed = 0.01;    // Speed of fade (0.01 is slow, 0.05 is fast)
fade_state = "in";    
timer = 150;          // How long to stay on screen