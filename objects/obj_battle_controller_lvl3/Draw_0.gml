// --- 0. PREP ---
if (asset_get_index("fnt_battle") != -1) draw_set_font(fnt_dialogue);

// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_Level3PostBattle);
}


// --- 1. DRAW CHARACTERS & BOSS ---
if (sprite_exists(AddelineBattle)) draw_sprite(AddelineBattle, floor(addeline_frame), 150, 600);
if (sprite_exists(MillyBattle)) draw_sprite(MillyBattle, floor(milly_frame), 320, 600); 

// Draw Boss (Scale set to 1 for larger size)
var boss = enemies[0];
if (boss[1] > 0) {
    draw_sprite_ext(boss[4], floor(boss[5]), boss[2], boss[3], 1.0, 1.0, 0, c_white, 1); 
    draw_set_halign(fa_center); 
    draw_set_color(c_yellow);
    // Adjusted text height for larger boss sprite
    draw_text(boss[2], boss[3] - 100, string(boss[1]) + " / 250"); 
}

// --- 2. FAIRY DIALOGUE BOX (TOP) ---
var fairy_box_w = 1250; var fairy_box_h = 230;               
if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, 5, 10, fairy_box_w, fairy_box_h);

draw_set_halign(fa_left); draw_set_valign(fa_top);
draw_set_color(c_black); draw_text(145, 90, "BRIA"); 
draw_set_color(make_color_rgb(40, 40, 40));
draw_text_ext(145, 120, string_copy(fairy_text, 1, floor(text_progress)), 22, fairy_box_w - 90);

// --- 3. BOTTOM LEFT HUD ---
var p_y = 680; var shift_x = 100;    

// --- ADDELINE (Left) ---
var ad_x = shift_x - 30; var ad_y = p_y + 60;  
var ad_face = (player_hp > 70) ? 0 : (player_hp > 30 ? 1 : 2);

draw_set_color(active_char == 0 ? c_yellow : c_white);
draw_roundrect_ext(40 + shift_x, p_y - 20, 140 + shift_x, p_y + 60, 10, 10, true); 

if (sprite_exists(AddelineBUI)) draw_sprite_ext(AddelineBUI, ad_face, ad_x, ad_y, 0.5, 0.5, 0, c_white, 1);

draw_set_halign(fa_center); draw_set_valign(fa_middle);
draw_set_color(c_white); 
draw_text(90 + shift_x, p_y + 5, string(player_hp));
draw_text(90 + shift_x, p_y + 15, "___");
draw_text(90 + shift_x, p_y + 40, string(player_max_hp));

// --- MILLY (Right) ---
var mil_x = 210 + shift_x; 
var mil_y = p_y - 10; 

draw_set_color(active_char == 1 ? c_yellow : c_white);
draw_roundrect_ext(285 + shift_x, p_y - 20, 385 + shift_x, p_y + 60, 10, 10, true);

if (sprite_exists(MillyBUI)) draw_sprite_ext(MillyBUI, 0, mil_x, mil_y, 0.5, 0.5, 0, c_white, 1);

draw_set_color(c_white); 
draw_text(335 + shift_x, p_y + 5, string(milly_hp));
draw_text(335 + shift_x, p_y + 15, "___");
draw_text(335 + shift_x, p_y + 40, string(milly_max_hp));

draw_set_valign(fa_top);

// --- 4. BOTTOM RIGHT MENU BOX ---
var box_x = 650; var box_y = 550; var box_w = 700; var box_h = 200;        
if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);

// --- 5. GRID SKILLS ---
if (battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) {
    draw_set_halign(fa_left); draw_set_valign(fa_top);
    
    var tx_st = 770; var ty_st = 640; var cs = 300; var rs = 60;     
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
    
    var scx = 1000; var ssy = 625; var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    var cur_t = is_def ? defend_timer/defend_timer_max : spell_timer/spell_timer_max;
    
    draw_set_color(is_def ? c_red : c_aqua);
    draw_rectangle(scx - 100, ssy + 20, scx - 100 + (cur_t * 200), ssy - 10, false);

    draw_set_color(c_blue);
    draw_text(scx, ssy, is_def ? "-- DEFEND SPELL --" : "-- MATH SPELL --");
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text(scx, ssy + 45, problem_question);
    draw_text(scx, ssy + 90, "ANS: " + player_input + "_");
}
draw_set_valign(fa_top);