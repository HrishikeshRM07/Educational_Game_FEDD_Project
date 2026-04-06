if (asset_get_index("fnt_battle") != -1) draw_set_font(fnt_dialogue);

if (sprite_exists(AddelineBattle)) draw_sprite(AddelineBattle, floor(addeline_frame), 100, 600);
if (sprite_exists(MillyBattle)) draw_sprite(MillyBattle, floor(milly_frame), 250, 600); 
if (sprite_exists(ErinBattle)) draw_sprite(ErinBattle, floor(erin_frame), 400, 600); 

for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    if (en[1] > 0) {
        draw_sprite_ext(en[4], floor(en[5]), en[2], en[3], 0.45, 0.45, 0, c_white, 1); 
        draw_set_halign(fa_center); 
        draw_set_color(c_yellow);
        
        var max_e_hp = " / 40";
        if (en[0] == "GoldmanTall") max_e_hp = " / 60";
        if (en[0] == "Aundroid") max_e_hp = " / 80";
        
        draw_text(en[2], en[3] - 60, string(en[1]) + max_e_hp); 
    }
}

var fairy_box_w = 1250; var fairy_box_h = 230;                
if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, 5, 10, fairy_box_w, fairy_box_h);

draw_set_halign(fa_left); draw_set_valign(fa_top);
draw_set_color(c_black); draw_text(145, 90, "BRIA"); 
draw_set_color(make_color_rgb(40, 40, 40));
draw_text_ext(145, 120, string_copy(fairy_text, 1, floor(text_progress)), 22, fairy_box_w - 90);

// --- 3. BOTTOM LEFT HUD (ALL UNLOCKED) ---
var p_y = 680;        
var hps = [player_hp, milly_hp, erin_hp];
var max_hps = [player_max_hp, milly_max_hp, erin_max_hp];
var portraits = [AddelineBUI, MillyBUI_1, ErinBUI];

for (var i = 0; i < 3; i++) {
    var box_left = hud_start_x + (i * hud_btn_spacing); 
    var box_right = box_left + hud_btn_width; 
    
    var port_x = box_left - 75; 
    var port_y = p_y + 65;
    
    if (sprite_exists(portraits[i])) {
        var face = (hps[i] > 70) ? 0 : (hps[i] > 30 ? 1 : 2);
        draw_sprite_ext(portraits[i], (i == 0) ? face : 0, port_x, port_y, 0.5, 0.5, 0, c_white, 1.0);
    }

    if (active_char == i) draw_set_color(c_yellow);
    else draw_set_color(c_white);
    
    draw_roundrect_ext(box_left, p_y - 20, box_right, p_y + 60, 10, 10, true); 

    var center_x = box_left + (hud_btn_width / 2); 
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_set_color(c_white); 
    
    draw_text(center_x, p_y + 5, string(hps[i]));
    draw_text(center_x, p_y + 15, "___");
    draw_text(center_x, p_y + 40, string(max_hps[i]));
}
draw_set_valign(fa_top); 

// --- 4. BOTTOM RIGHT ATTACK MENU ---
if (battle_state == BattleState.PLAYER_MENU) {
    var box_x = 650; var box_y = 550; var box_w = 700; var box_h = 200;         
    if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);

    draw_set_halign(fa_left); draw_set_valign(fa_top);
    var text_start_x = 770;  var text_start_y = 640;   
    var col_spacing = 300;   var row_spacing = 60;     
    
    var skills = [];
    if (active_char == 0) skills = ["Add it up!", "Sub-tract HP", "Share health!", "Double Down"];
    else if (active_char == 1) skills = ["Health Multiply", "Divide it out!", "Share buffs!", "Long Way Down"];
    else if (active_char == 2) skills = ["Damage Squared", "Root of Problem", "Hit it again!", "Perfectly Balanced"];
    
    for (var i = 0; i < 4; i++) {
        var is_sel = (menu_index == i);
        var col = (i >= 2) ? 1 : 0;
        var row = (i % 2);
        var tx = text_start_x + (col * col_spacing);
        var ty = text_start_y + (row * row_spacing);
        
        draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
        draw_text(tx, ty, (is_sel ? "> " : "  ") + skills[i]); 
    }
}

// --- 5. MATH SOLVING HUD ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    
    // --> ADD THIS: Draw the background box so the text is readable!
    var box_x = 650; var box_y = 550; var box_w = 700; var box_h = 200;         
    if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);
    
    draw_set_halign(fa_center); draw_set_valign(fa_top);
    var solve_center_x = 1000; var solve_start_y = 625;    
    var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    
    var cur_t = is_def ? defend_timer/defend_timer_max : spell_timer/spell_timer_max;
    draw_set_color(is_def ? c_red : c_aqua);
    draw_rectangle(solve_center_x - 100, solve_start_y + 20, solve_center_x - 100 + (cur_t * 200), solve_start_y - 10, false);

    draw_set_color(c_blue);
    draw_text(solve_center_x, solve_start_y, is_def ? "-- EMERGENCY DEFEND! --" : "-- MATH SPELL --");
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text(solve_center_x, solve_start_y + 45, problem_question);
    draw_text(solve_center_x, solve_start_y + 90, "ANS: " + player_input + "_");
}
draw_set_valign(fa_top);