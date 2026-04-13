// --- 0. PREP ---
if (asset_get_index("fnt_battle") != -1) {
    draw_set_font(fnt_dialogue);
}

// --- 1. DRAW CHARACTERS & ENEMIES ---
// Draw Addeline with Flash Overlay
if (sprite_exists(AddelineBattle)) {
    draw_sprite(AddelineBattle, floor(addeline_frame), 350, 840);
    
    if (player_flash_alpha > 0) {
        gpu_set_fog(true, player_flash_color, 0, 0);
        draw_sprite_ext(AddelineBattle, floor(addeline_frame), 350, 840, 1, 1, 0, c_white, player_flash_alpha);
        gpu_set_fog(false, c_white, 0, 0);
    }
}

// Draw enemies using their arrays and Flash Overlays
for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    
    // Normal Draw (Uses Alpha at index 6 to fade out on death)
    draw_sprite_ext(en[4], floor(en[5]), en[2], en[3], 0.45, 0.45, 0, c_white, en[6]);
    
    // Flash Overlay (Color at 7, FlashAlpha at 8)
    if (en[8] > 0 && en[6] > 0) {
        gpu_set_fog(true, en[7], 0, 0);
        draw_sprite_ext(en[4], floor(en[5]), en[2], en[3], 0.45, 0.45, 0, c_white, min(en[8], en[6]));
        gpu_set_fog(false, c_white, 0, 0);
    }
}

// --- 2. FAIRY DIALOGUE BOX (TOP) ---
var fairy_box_w = 1750;                
var fairy_box_h = 320;                

if (sprite_exists(spr_dialogue_base)) {
    draw_sprite_stretched(spr_dialogue_base, 0, 5, 10, fairy_box_w, fairy_box_h);
}

draw_set_halign(fa_left); 
draw_set_valign(fa_top);
draw_set_color(c_black); 
draw_text_transformed(200, 125, "BRIA", 1.4, 1.4, 0); 

draw_set_color(make_color_rgb(40, 40, 40));
var text_to_draw = string_copy(fairy_text, 1, floor(text_progress));
var text_max_width = (fairy_box_w / 1.4) - 90; 
draw_text_ext_transformed(200, 170, text_to_draw, 22, text_max_width, 1.4, 1.4, 0);


// --- 3. BOTTOM LEFT HUD (PORTRAIT + STACKED HP) ---
var port_x = 170;
var port_y = room_height;

var face_index = (player_hp > 70) ? 0 : (player_hp > 30 ? 1 : 2);
if (sprite_exists(AddelineBUI)) {
    draw_sprite_ext(AddelineBUI, face_index, port_x, port_y - 20, 1, 1, 0, c_white, 1);
}

draw_set_halign(fa_center); 
draw_set_valign(fa_middle);
draw_set_color(c_white); 
draw_text_transformed(port_x + 170, port_y - 140, string(player_hp), 1.4, 1.4, 0);
draw_text_transformed(port_x + 170, port_y - 120, "___", 1.4, 1.4, 0);
draw_text_transformed(port_x + 170, port_y - 75, string(player_max_hp), 1.4, 1.4, 0);


// --- 4. BOTTOM RIGHT MENU BOX ---
var box_x = 910;       
var box_y = 770;        
var box_w = 980;        
var box_h = 280;        

if (sprite_exists(spr_dialogue_base)) {
    draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);
}

// --- 5. GRID SKILLS (TEXT ONLY) ---
if (battle_state == BattleState.PLAYER_MENU) {
    draw_set_halign(fa_left);
    
    var text_start_x = 1080;  
    var text_start_y = 890;   
    var col_spacing = 420;    
    var row_spacing = 85;     
    
    var skills = ["Add it up!", "Sub-tract the health", "Share the health!", "Double Down"];
    
    for (var i = 0; i < 4; i++) {
        var is_sel = (menu_index == i);
        var col = (i >= 2) ? 1 : 0;
        var row = (i % 2);
        
        var tx = text_start_x + (col * col_spacing);
        var ty = text_start_y + (row * row_spacing);
        
        draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
        var prefix = (is_sel) ? "> " : "  "; 
        draw_text_transformed(tx, ty, prefix + skills[i], 1.4, 1.4, 0); 
    }
}

// --- 6. SOLVE STATE ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    draw_set_halign(fa_center);
    
    var solve_center_x = 1400; 
    var solve_start_y = 875;   
    
    // Timer Bar
    var cur_t = (battle_state == BattleState.PLAYER_SOLVE) ? spell_timer/spell_timer_max : defend_timer/defend_timer_max;
    draw_set_color(battle_state == BattleState.PLAYER_SOLVE ? c_aqua : c_red);
    draw_rectangle(solve_center_x - 150, solve_start_y + 30, solve_center_x - 150 + (cur_t * 300), solve_start_y - 15, false);

    var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    draw_set_color(is_def ? c_maroon : c_blue);
    draw_text_transformed(solve_center_x, solve_start_y, is_def ? "-- EMERGENCY DEFEND! --" : "-- MATH SPELL --", 1.4, 1.4, 0);
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text_transformed(solve_center_x, solve_start_y + 60, problem_question, 1.4, 1.4, 0);
    draw_text_transformed(solve_center_x, solve_start_y + 120, "ANS: " + player_input + "_", 1.4, 1.4, 0);
}

draw_set_valign(fa_top); // Reset alignment