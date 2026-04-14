// --- 0. PREP ---
draw_set_font(fnt_battle);
if (keyboard_check_pressed(vk_escape) && !targeting_phase) room_goto(rm_Level2PostBattle);

// --- 1. DRAW CHARACTERS & ENEMIES ---
// Draw Addeline
if (sprite_exists(AddelineBattle)) {
    draw_sprite(AddelineBattle, floor(addeline_frame), 250, 840);
    if (player_flash_alpha > 0) {
        gpu_set_fog(true, player_flash_color, 0, 0);
        draw_sprite_ext(AddelineBattle, floor(addeline_frame), 250, 840, 1, 1, 0, c_white, player_flash_alpha);
        gpu_set_fog(false, c_white, 0, 0);
    }
}

// Draw Milly
if (sprite_exists(MillyBattle)) {
    draw_sprite(MillyBattle, floor(milly_frame), 450, 840); 
    if (milly_flash_alpha > 0) {
        gpu_set_fog(true, milly_flash_color, 0, 0);
        draw_sprite_ext(MillyBattle, floor(milly_frame), 450, 840, 1, 1, 0, c_white, milly_flash_alpha);
        gpu_set_fog(false, c_white, 0, 0);
    }
}

// Draw enemies with Flash & Fade Overlays & Bria targeting
for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    
    // Base Fade Draw (Using en[6] for alpha)
    draw_sprite_ext(en[4], floor(en[5]), en[2], en[3], 0.45, 0.45, 0, c_white, en[6]); 
    
    // Flash Draw
    if (en[8] > 0 && en[6] > 0) {
        gpu_set_fog(true, en[7], 0, 0);
        draw_sprite_ext(en[4], floor(en[5]), en[2], en[3], 0.45, 0.45, 0, c_white, min(en[8], en[6]));
        gpu_set_fog(false, c_white, 0, 0);
    }

    // Draw Bria Hovering Target Indicator ONLY during targeting phase or single-target solve phase
    if (i == target_index && en[1] > 0 && (targeting_phase || (battle_state == BattleState.PLAYER_SOLVE && selected_skill == 2))) {
        var hover_y = en[3] - 180 + (sin(current_time / 150) * 10); 
        if (sprite_exists(Bria)) {
            draw_sprite_ext(Bria, 0, en[2], hover_y - 40, 1, 1, 0, c_white, 1);
        }
    }
}

// --- 2. FAIRY DIALOGUE BOX (TOP) ---
var fairy_box_w = 1750;                
var fairy_box_h = 320;                

if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, 5, 10, fairy_box_w, fairy_box_h);

draw_set_halign(fa_left); draw_set_valign(fa_top);
draw_set_color(c_black); 
draw_text_transformed(200, 125, "BRIA", 1.4, 1.4, 0); 

draw_set_color(make_color_rgb(40, 40, 40));
var text_to_draw = string_copy(fairy_text, 1, floor(text_progress));
draw_text_ext_transformed(200, 170, text_to_draw, 20, (fairy_box_w / 1.4) - 200, 1.4, 1.4, 0);

// --- 3. BOTTOM LEFT HUD (DUAL PORTRAITS + HP) ---
// --- ADDELINE (Left) ---
var ad_x = 100;
var ad_y = 1035;  
var ad_alpha = (is_tutorial) ? 0.5 : 1; 
var ad_face = (player_hp <= 0) ? 4 : ((player_hp > 70) ? 0 : (player_hp > 30 ? 1 : 2)); 

draw_set_color(active_char == 0 ? c_yellow : (is_tutorial ? c_dkgray : c_white));
draw_roundrect_ext(200, 920, 340, 1040, 14, 14, true); 

if (sprite_exists(AddelineBUI)) draw_sprite_ext(AddelineBUI, ad_face, ad_x, ad_y, 0.7, 0.7, 0, c_white, ad_alpha);

draw_set_halign(fa_center); draw_set_valign(fa_middle);
draw_set_color(is_tutorial ? c_gray : c_white); 
draw_text_transformed(270, 960, string(player_hp), 1.4, 1.4, 0);
draw_text_transformed(270, 975, "___", 1.4, 1.4, 0);
draw_text_transformed(270, 1010, string(player_max_hp), 1.4, 1.4, 0);

if (is_tutorial) {
    draw_set_color(c_red);
    draw_text_transformed(ad_x + 20, ad_y - 125, "LOCKED", 1.4, 1.4, 0);
}

// --- MILLY (Right) ---
var mil_x = 435; 
var mil_y = 940; 
var mil_face = (milly_hp <= 0) ? 4 : ((milly_hp > 70) ? 0 : (milly_hp > 30 ? 1 : 2)); 

draw_set_color(active_char == 1 ? c_yellow : c_white);
draw_roundrect_ext(540, 920, 680, 1040, 14, 14, true);

if (sprite_exists(MillyBUI)) draw_sprite_ext(MillyBUI, mil_face, mil_x, mil_y, 0.7, 0.7, 0, c_white, 1);

draw_set_color(c_white); 
draw_text_transformed(610, 960, string(milly_hp), 1.4, 1.4, 0);
draw_text_transformed(610, 975, "___", 1.4, 1.4, 0);
draw_text_transformed(610, 1010, string(milly_max_hp), 1.4, 1.4, 0);

draw_set_valign(fa_top); 

// --- 4. BOTTOM RIGHT MENU BOX ---
var box_x = 910;       
var box_y = 770;        
var box_w = 980;        
var box_h = 280;        

if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);

// --- 5. GRID SKILLS (TEXT) / TARGETING PROMPT ---
if (battle_state == BattleState.PLAYER_MENU) {
    
    if (!targeting_phase) {
        draw_set_halign(fa_left); draw_set_valign(fa_top);
        
        var text_start_x = 1080;  
        var text_start_y = 890;   
        var col_spacing = 420;    
        var row_spacing = 85;     
        
        var skills = [];
        if (active_char == 0) skills = ["Add it up!", "Sub-tract the health", "Share the health!", "Double Down"];
        else skills = ["Health multiplies!", "Divide it out!", "Share the buffs!", "Long Way Down"];
        
        for (var i = 0; i < 4; i++) {
            var is_sel = (menu_index == i);
            var is_locked = (is_tutorial && i != milly_tutorial_step);
            
            var col = (i >= 2) ? 1 : 0;
            var row = (i % 2);
            
            var tx = text_start_x + (col * col_spacing);
            var ty = text_start_y + (row * row_spacing);
            
            if (is_locked) draw_set_color(c_gray);
            else draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
            
            var prefix = (is_sel) ? "> " : "  "; 
            draw_text_transformed(tx, ty, prefix + skills[i], 1.4, 1.4, 0); 
        }
    } else {
        // --- DRAW TARGETING PROMPT INSTEAD OF SKILLS ---
        draw_set_halign(fa_center); draw_set_valign(fa_middle);
        draw_set_color(c_blue);
        draw_text_transformed(box_x + (box_w / 2), box_y + (box_h / 2) - 30, "- SELECT TARGET -", 1.8, 1.8, 0);
        
        draw_set_color(make_color_rgb(40, 40, 40));
        draw_text_transformed(box_x + (box_w / 2), box_y + (box_h / 2) + 30, "Press SPACE to switch, ENTER to lock in!", 1.3, 1.3, 0);
        
        draw_set_halign(fa_left); draw_set_valign(fa_top); // Reset alignment
    }
}

// --- 6. SOLVE STATE ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    draw_set_halign(fa_center); draw_set_valign(fa_top);
    
    var solve_center_x = 1400; 
    var solve_start_y = 875;   
    var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    
    var cur_t = is_def ? defend_timer/defend_timer_max : spell_timer/spell_timer_max;
    draw_set_color(is_def ? c_red : c_aqua);
    draw_rectangle(solve_center_x - 150, solve_start_y + 30, solve_center_x - 150 + (cur_t * 300), solve_start_y - 15, false);

    draw_set_color(c_blue);
    draw_text_transformed(solve_center_x, solve_start_y, is_def ? "-- DEFEND SPELL --" : "-- MATH SPELL --", 1.4, 1.4, 0);
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text_transformed(solve_center_x, solve_start_y + 60, problem_question, 1.4, 1.4, 0);
    draw_text_transformed(solve_center_x, solve_start_y + 120, "ANS: " + player_input + "_", 1.4, 1.4, 0);
}
draw_set_valign(fa_top); // Reset alignment