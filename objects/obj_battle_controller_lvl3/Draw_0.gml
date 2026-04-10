// --- 0. PREP ---
if (asset_get_index("fnt_battle") != -1) draw_set_font(fnt_dialogue); 

// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_Level3PostBattle);
}


// --- 1. DRAW CHARACTERS & BOSS ---
if (sprite_exists(AddelineBattle)) draw_sprite(AddelineBattle, floor(addeline_frame), 210, 840);
if (sprite_exists(MillyBattle)) draw_sprite(MillyBattle, floor(milly_frame), 450, 840); 

// Draw Boss (Scale set to 1.4 for larger size to match 1080p)
var boss = enemies[0];
if (boss[1] > 0) {
    draw_sprite_ext(boss[4], floor(boss[5]), 1200, 900, 1, 1, 0, c_white, 1); 
    draw_set_halign(fa_center); 
    draw_set_color(c_yellow);
}

// --- 2. FAIRY DIALOGUE BOX (TOP) ---
var fairy_box_w = 1880; var fairy_box_h = 320;                
if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, 10, 15, fairy_box_w, fairy_box_h);

draw_set_halign(fa_left); draw_set_valign(fa_top);
draw_set_color(c_black); draw_text(200, 125, "BRIA"); 
draw_set_color(make_color_rgb(40, 40, 40));
draw_text_ext(200, 170, string_copy(fairy_text, 1, floor(text_progress)), 35, fairy_box_w - 125);

// --- 3. BOTTOM LEFT HUD ---
var p_y = 950; var shift_x = 140;    

// --- ADDELINE (Left) ---
var ad_x = shift_x - 42; var ad_y = p_y + 84;  
var ad_face = (player_hp > 70) ? 0 : (player_hp > 30 ? 1 : 2);

draw_set_color(active_char == 0 ? c_yellow : c_white);
draw_roundrect_ext(56 + shift_x, p_y - 28, 196 + shift_x, p_y + 84, 10, 10, true); 

if (sprite_exists(AddelineBUI)) draw_sprite_ext(AddelineBUI, ad_face, ad_x, ad_y, 0.7, 0.7, 0, c_white, 1);

draw_set_halign(fa_center); draw_set_valign(fa_middle);
draw_set_color(c_white); 
draw_text(126 + shift_x, p_y + 7, string(player_hp));
draw_text(126 + shift_x, p_y + 21, "___");
draw_text(126 + shift_x, p_y + 56, string(player_max_hp));

// --- MILLY (Right) ---
var mil_x = 294 + shift_x; 
var mil_y = p_y - 14; 

draw_set_color(active_char == 1 ? c_yellow : c_white);
draw_roundrect_ext(399 + shift_x, p_y - 28, 539 + shift_x, p_y + 84, 10, 10, true);

if (sprite_exists(MillyBUI)) draw_sprite_ext(MillyBUI, 0, mil_x, mil_y, 0.7, 0.7, 0, c_white, 1);

draw_set_color(c_white); 
draw_text(469 + shift_x, p_y + 7, string(milly_hp));
draw_text(469 + shift_x, p_y + 21, "___");
draw_text(469 + shift_x, p_y + 56, string(milly_max_hp));

draw_set_valign(fa_top);

// --- 4. BOTTOM RIGHT MENU BOX ---
var box_x = 910; var box_y = 770; var box_w = 980; var box_h = 280;        
if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);

// --- 5. GRID SKILLS ---
if (battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) {
    draw_set_halign(fa_left); draw_set_valign(fa_top);
    
    var tx_st = 1080; var ty_st = 900; var cs = 420; var rs = 84;     
    var skills = (battle_state == BattleState.DEFEND_MENU) ? ["Quick Shield", "Math Barrier", "Logic Wall", "Aegis"] : 
                 ((active_char == 0) ? ["Add it up!", "Sub-tract HP", "Share health!", "Double Down"] : 
                                       ["Health Multiply", "Divide it out!", "Share buffs!", "Long Way Down"]);
    
    for (var i = 0; i < 4; i++) {
        var is_sel = (menu_index == i);
        var tx = tx_st + ((i >= 2 ? 1 : 0) * cs);
        var ty = ty_st + ((i % 2) * rs);
        
        draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
        draw_text(tx, ty, (is_sel ? "> " : "  ") + skills[i]); 
    }
}

// --- 6. SOLVE STATE ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    draw_set_halign(fa_center); draw_set_valign(fa_top);
    
    var scx = 1400; var ssy = 875; var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    var cur_t = is_def ? defend_timer/defend_timer_max : spell_timer/spell_timer_max;
    
    draw_set_color(is_def ? c_red : c_aqua);
    draw_rectangle(scx - 140, ssy + 28, scx - 140 + (cur_t * 280), ssy - 14, false);

    draw_set_color(c_blue);
    draw_text(scx, ssy, is_def ? "-- DEFEND SPELL --" : "-- MATH SPELL --");
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text(scx, ssy + 63, problem_question);
    draw_text(scx, ssy + 126, "ANS: " + player_input + "_");
}
draw_set_valign(fa_top);