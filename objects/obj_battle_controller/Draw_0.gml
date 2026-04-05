// ==========================================
// 0. DRAW ADDELINE BATTLE SPRITE (NEW)
// ==========================================
// Adjust the 250 and 450 to place her exactly where you want her on the battlefield!
if (sprite_exists(AddelineBattle)) {
    draw_sprite(AddelineBattle, floor(addeline_frame), 250, 600);
}

// --- CUSTOM FONT SETUP ---
// Create a font asset in GMS named 'fnt_battle', select a clean pixel font (like Monogram), and set size to ~14.
if (asset_get_index("fnt_battle") != -1) {
    draw_set_font(fnt_dialogue);
}

// ==========================================
// 1. FAIRY DIALOGUE BOX (TOP)
// ==========================================
// --- CONFIG: Change these to resize/move the box! ---
var fairy_box_x = 100;                 // Pushes it slightly off the left edge
var fairy_box_y = 75;                 // Distance from top edge

// FIX: Change this to a hard number (like 1000, 1200, 1400) until it looks right!
var fairy_box_w = 1250;               

var fairy_box_h = 230;                // Height of the box

if (sprite_exists(spr_dialogue_base)) {
    draw_sprite_stretched(spr_dialogue_base, 0, 5, 10, fairy_box_w, fairy_box_h);
}

// ... everything else below this stays exactly the same
draw_set_halign(fa_left); 
draw_set_valign(fa_top);
draw_set_color(c_black); 

// Auto-aligns text based on your box config
draw_text(fairy_box_x + 45, fairy_box_y + 15, "FAIRY"); 
draw_set_color(make_color_rgb(40, 40, 40));

// Text wraps automatically based on the box width
var text_max_width = fairy_box_w - 90; 
draw_text_ext(fairy_box_x + 45, fairy_box_y + 45, fairy_text, 22, text_max_width);


// ==========================================
// 2. HORATIO IN-WORLD HP (FLOATING)
// ==========================================
draw_set_halign(fa_center); 
draw_set_valign(fa_middle);
draw_set_color(c_yellow);
draw_text(horatio_x, horatio_y, string(enemy_hp) + " / 50");


// ==========================================
// 3. BOTTOM LEFT HUD (PORTRAIT + STACKED HP)
// ==========================================
var port_x = 120;
var port_y = room_height;

var face = (player_hp > 99) ? 0 : (player_hp > 40 ? 1 : (player_hp > 0 ? 2 : 3));
if (sprite_exists(AddelineBUI)) {
    draw_sprite_ext(AddelineBUI, face, port_x, port_y - 14, 0.8, 0.8, 0, c_white, 1);
}

draw_set_halign(fa_center); 
draw_set_valign(fa_middle);
draw_set_color(c_white); 
draw_text(port_x + 120, port_y - 100, string(player_hp));
draw_text(port_x + 120, port_y - 85, "___");
draw_text(port_x + 120, port_y - 55, string(player_max_hp));


// ==========================================
// 4. BOTTOM RIGHT MENU BOX (BACKGROUND ONLY)
// ==========================================
// --- BOX CONFIG: These ONLY change the background image! ---
var box_x = 650;       // Hard position for the box's left edge (Change this!)
var box_y = 550;        // Hard position for the box's top edge (Change this!)
var box_w = 700;        // Width of the box
var box_h = 200;        // Height of the box

if (sprite_exists(spr_dialogue_base)) {
    // I removed the -50 and -39 math here so it draws exactly where you tell box_x and box_y to be
    draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);
}

// ==========================================
// 5. GRID SKILLS (TEXT ONLY)
// ==========================================
if (battle_state == BattleState.PLAYER_MENU) {
    draw_set_halign(fa_left);
    
    // --- TEXT CONFIG: These ONLY change the text! ---
    var text_start_x = 770;  // Exact X position where the top-left skill starts
    var text_start_y = 640;   // Exact Y position where the top-left skill starts
    var col_spacing = 300;    // Horizontal distance between Column 1 and Column 2
    var row_spacing = 60;     // Vertical distance between Row 1 and Row 2
    
    var skills = ["Additive Heal", "Subtraction", "Commutative", "Double Sub"];
    var skill_ids = [1, 2, 3, 4]; 
    
    for (var i = 0; i < 4; i++) {
        var is_sel = (menu_index == i);
        var s_id = skill_ids[i];
        
        var is_locked = true;
        if (tutorial_stage == 0 && s_id == 2) is_locked = false; 
        if (tutorial_stage == 1 && s_id == 1) is_locked = false; 
        if (tutorial_stage == 3 && s_id == 4) is_locked = false; 
        if (tutorial_stage == 4 && s_id == 3) is_locked = false; 
        if (tutorial_stage >= 5) is_locked = false;              
        
        var col = (i >= 2) ? 1 : 0;
        var row = (i % 2);
        
        // Text calculates purely off your new text variables, completely ignoring the box
        var tx = text_start_x + (col * col_spacing);
        var ty = text_start_y + (row * row_spacing);
        
        if (is_locked) {
            draw_set_color(c_gray);
        } else {
            draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
        }
        
        var prefix = (is_sel) ? "> " : "  "; 
        draw_text(tx, ty, prefix + skills[i]); 
    }
}
// --- 6. SOLVE STATE ---
if (battle_state == BattleState.PLAYER_SOLVE) {
    draw_set_halign(fa_center);
    
    // --- SOLVE TEXT CONFIG: Change these to move the math problem! ---
    // Try to center this X value inside wherever you put your box
    var solve_center_x = 1000; 
    
    // This controls how high up the math spell text starts
    var solve_start_y = 600+25;   
    
    draw_set_color(c_blue);
    draw_text(solve_center_x, solve_start_y, "-- MATH SPELL --");
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text(solve_center_x, solve_start_y + 45, problem_question);
    draw_text(solve_center_x, solve_start_y + 90, "ANS: " + player_input + "_");
}