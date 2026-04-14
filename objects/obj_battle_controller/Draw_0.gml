// ==========================================
// 0. DRAW ADDELINE BATTLE SPRITE
// ==========================================
if (sprite_exists(AddelineBattle)) {
    // Normal Draw
    draw_sprite_ext(AddelineBattle, floor(addeline_frame), 350, 840, 1, 1, 0, c_white, 1);
    
    // Addeline Flash Overlay
    if (player_flash_alpha > 0) {
        gpu_set_fog(true, player_flash_color, 0, 0);
        draw_sprite_ext(AddelineBattle, floor(addeline_frame), 350, 840, 1, 1, 0, c_white, player_flash_alpha);
        gpu_set_fog(false, c_white, 0, 0);
    }
}

// ==========================================
// 0.5 DRAW HORATIO
// ==========================================
if (sprite_exists(Horatio)) { 
    // Normal Draw: Now uses floor(horatio_frame) instead of 0
    draw_sprite_ext(Horatio, floor(horatio_frame), horatio_x, horatio_y, 1, 1, 0, c_white, enemy_alpha); 
    
    // Enemy Flash Overlay: Also updated to use floor(horatio_frame)
    if (enemy_flash_alpha > 0 && enemy_alpha > 0) {
        gpu_set_fog(true, enemy_flash_color, 0, 0);
        draw_sprite_ext(Horatio, floor(horatio_frame), horatio_x, horatio_y, 1, 1, 0, c_white, min(enemy_flash_alpha, enemy_alpha)); 
        gpu_set_fog(false, c_white, 0, 0);
    }
}

// --- CUSTOM FONT SETUP ---

draw_set_font(fnt_battle);


// ==========================================
// 1. FAIRY DIALOGUE BOX (TOP)
// ==========================================
var fairy_box_x = 140;                 
var fairy_box_y = 100;                 

var fairy_box_w = 1750;                
var fairy_box_h = 320;                

if (sprite_exists(spr_dialogue_base)) {
    draw_sprite_stretched(spr_dialogue_base, 0, 10, 15, fairy_box_w, fairy_box_h);
}

draw_set_halign(fa_left); 
draw_set_valign(fa_top);
draw_set_color(c_black); 

draw_text_transformed(fairy_box_x + 60, fairy_box_y + 20, "Bria", 1.4, 1.4, 0); 
draw_set_color(make_color_rgb(40, 40, 40));

var text_max_width = (fairy_box_w / 1.4) - 200; 
draw_text_ext_transformed(fairy_box_x + 60, fairy_box_y + 70, fairy_text, 22, text_max_width, 1.4, 1.4, 0);

if (tutorial_stage > 1 && tutorial_stage < 4) {
	if (sprite_exists(GoldmanShort)) {
		draw_sprite_ext(GoldmanShort, floor(horatio_frame), horatio_x - 50, horatio_y - 30, 0.45, 0.45, 0, c_white, enemy_alpha);
	}
	if (enemy_flash_alpha > 0 && enemy_alpha > 0) {
		gpu_set_fog(true, enemy_flash_color, 0, 0);
        draw_sprite_ext(GoldmanShort, floor(horatio_frame), horatio_x - 50, horatio_y - 30, 0.45, 0.45, 0, c_white, min(enemy_flash_alpha, enemy_alpha)); 
        gpu_set_fog(false, c_white, 0, 0);
    }
}

// ==========================================
// 3. BOTTOM LEFT HUD (PORTRAIT + STACKED HP)
// ==========================================
var port_x = 170;
var port_y = room_height;

var face = (player_hp > 99) ? 0 : (player_hp > 40 ? 1 : (player_hp > 0 ? 2 : 3));
if (sprite_exists(AddelineBUI)) {
    draw_sprite_ext(AddelineBUI, face, port_x, port_y - 20, 1.15, 1.15, 0, c_white, 1);
}

draw_set_halign(fa_center); 
draw_set_valign(fa_middle);
draw_set_color(c_white); 

draw_text_transformed(port_x + 170, port_y - 140, string(player_hp), 1.4, 1.4, 0);
draw_text_transformed(port_x + 170, port_y - 120, "___", 1.4, 1.4, 0);
draw_text_transformed(port_x + 170, port_y - 75, string(player_max_hp), 1.4, 1.4, 0);

// ==========================================
// 4. BOTTOM RIGHT MENU BOX (BACKGROUND ONLY)
// ==========================================
var box_x = 910;       
var box_y = 770;        
var box_w = 980;        
var box_h = 280;        

if (sprite_exists(spr_dialogue_base)) {
    draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);
}

// ==========================================
// 5. GRID SKILLS (TEXT ONLY)
// ==========================================
if (battle_state == BattleState.PLAYER_MENU) {
    draw_set_halign(fa_left);
    
    var text_start_x = 1080;  
    var text_start_y = 900;   
    var col_spacing = 420;   
    var row_spacing = 85;     
    
    var skills = ["Add it up!", "Sub-tract the health", "Share the health!", "Double Down"];
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
        
        var tx = text_start_x + (col * col_spacing);
        var ty = text_start_y + (row * row_spacing);
        
        if (is_locked) {
            draw_set_color(c_gray);
        } else {
            draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
        }
        
        var prefix = (is_sel) ? "> " : "  "; 
        draw_text_transformed(tx, ty, prefix + skills[i], 1.4, 1.4, 0); 
    }
}

// --- 6. SOLVE STATE / DEFEND STATE ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    draw_set_halign(fa_center);
    
    var solve_center_x = 1400; 
    var solve_start_y = 875;   
    
    var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    
    // UI swaps between blue text for attacking/healing, and red for Defending!
    draw_set_color(is_def ? c_red : c_blue);
    draw_text_transformed(solve_center_x, solve_start_y, is_def ? "-- EMERGENCY DEFEND! --" : "-- MATH SPELL --", 1.4, 1.4, 0);
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text_transformed(solve_center_x, solve_start_y + 60, problem_question, 1.4, 1.4, 0);
    draw_text_transformed(solve_center_x, solve_start_y + 120, "ANS: " + player_input + "_", 1.4, 1.4, 0);
}