if (asset_get_index("fnt_battle") != -1) draw_set_font(fnt_dialogue);

// Characters (With Flashes)
if (sprite_exists(AddelineBattle)) {
    draw_sprite(AddelineBattle, floor(addeline_frame), 140, 840);
    if (player_flash_alpha > 0) { gpu_set_fog(true, player_flash_color, 0, 0); draw_sprite_ext(AddelineBattle, floor(addeline_frame), 140, 840, 1, 1, 0, c_white, player_flash_alpha); gpu_set_fog(false, c_white, 0, 0); }
}
if (sprite_exists(MillyBattle)) {
    draw_sprite(MillyBattle, floor(milly_frame), 350, 840); 
    if (milly_flash_alpha > 0) { gpu_set_fog(true, milly_flash_color, 0, 0); draw_sprite_ext(MillyBattle, floor(milly_frame), 350, 840, 1, 1, 0, c_white, milly_flash_alpha); gpu_set_fog(false, c_white, 0, 0); }
}
if (sprite_exists(ErinBattle)) {
    draw_sprite(ErinBattle, floor(erin_frame), 560, 840); 
    if (erin_flash_alpha > 0) { gpu_set_fog(true, erin_flash_color, 0, 0); draw_sprite_ext(ErinBattle, floor(erin_frame), 560, 840, 1, 1, 0, c_white, erin_flash_alpha); gpu_set_fog(false, c_white, 0, 0); }
}

// Enemies (Fades, Flashes, Health Bars & Hover Targeting)
for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    
    // Fade Draw
    draw_sprite_ext(en[4], floor(en[5]), en[2], en[3], 0.63, 0.63, 0, c_white, en[6]); 
    
    // Flash Overlay
    if (en[8] > 0 && en[6] > 0) {
        gpu_set_fog(true, en[7], 0, 0);
        draw_sprite_ext(en[4], floor(en[5]), en[2], en[3], 0.63, 0.63, 0, c_white, min(en[8], en[6]));
        gpu_set_fog(false, c_white, 0, 0);
    }

    if (en[1] > 0) {
        draw_set_halign(fa_center); draw_set_color(c_yellow);
        draw_text(en[2], en[3] - 84, string(en[1]) + (en[0] == "GoldmanTall" ? " / 60" : " / 40")); 
        
        // Target Indicator
        if (i == target_index && (targeting_phase || (battle_state == BattleState.PLAYER_SOLVE && selected_skill == 2))) {
            var hover_y = en[3] - 180 + (sin(current_time / 150) * 10); 
            if (sprite_exists(Bria)) draw_sprite_ext(Bria, 0, en[2], hover_y, 0.5, 0.5, 0, c_white, 1);
        }
    }
}

// Fairy Text
var fairy_box_w = 1750; var fairy_box_h = 322;                
if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, 7, 14, fairy_box_w, fairy_box_h);

draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_color(c_black); draw_text(203, 126, "BRIA"); 
draw_set_color(make_color_rgb(40, 40, 40)); draw_text_ext(203, 168, string_copy(fairy_text, 1, floor(text_progress)), 31, fairy_box_w - 126);

// HUD / Portraits
var p_y = 952;        
var hps = [player_hp, milly_hp, erin_hp];
var max_hps = [player_max_hp, milly_max_hp, erin_max_hp];
var portraits = [AddelineBUI, MillyBUI_1, ErinBUI];

for (var i = 0; i < 3; i++) {
    var box_left = hud_start_x + (i * hud_btn_spacing); 
    var box_right = box_left + hud_btn_width; 
    var port_x = box_left - 105; 
    var port_y = p_y + 91;

    var is_locked = (is_tutorial && i != 2); // Only Erin is unlocked in tutorial
    var draw_alpha = is_locked ? 0.4 : 1.0;
    
    if (sprite_exists(portraits[i])) {
        // Updated Portrait Logic!
        var hp_pct = (hps[i] / max_hps[i]) * 100;
        var face = 0; 
        if (hp_pct <= 0) { face = 3; }         // Dead
        else if (hp_pct <= 30) { face = 2; }   // Critical
        else if (hp_pct <= 70) { face = 1; }   // Hurt
        
        draw_sprite_ext(portraits[i], face, port_x, port_y, 0.7, 0.7, 0, c_white, draw_alpha);
    }

    if (is_locked) {
        draw_set_halign(fa_center); draw_set_color(c_red); draw_text(port_x, port_y - 84, "LOCKED");
    }

    if (active_char == i) draw_set_color(c_yellow);
    else draw_set_color(is_locked ? c_dkgray : c_white);
    
    draw_roundrect_ext(box_left, p_y - 28, box_right, p_y + 84, 14, 14, true); 

    var center_x = box_left + (hud_btn_width / 2); 
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_set_color(is_locked ? c_gray : c_white); 
    draw_text(center_x, p_y + 7, string(hps[i])); draw_text(center_x, p_y + 21, "___"); draw_text(center_x, p_y + 56, string(max_hps[i]));
}
draw_set_valign(fa_top); 

// Menu / Skills Box
var box_x = 910; var box_y = 770; var box_w = 980; var box_h = 280;          
if (sprite_exists(spr_dialogue_base)) draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);

if (battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) {
    if (!targeting_phase) {
        draw_set_halign(fa_left); draw_set_valign(fa_top);
        var text_start_x = 1078;  var text_start_y = 896;   
        var col_spacing = 420;   var row_spacing = 84;      
        
        var skills = [];
        if (battle_state == BattleState.DEFEND_MENU) {
            skills = ["Quick Shield", "Math Barrier", "Logic Wall", "Aegis"];
        } else {
            if (active_char == 0) skills = ["Add it up!", "Sub-tract HP", "Share health!", "Double Down"];
            else if (active_char == 1) skills = ["Health Multiply", "Divide it out!", "Share buffs!", "Long Way Down"];
            else if (active_char == 2) skills = ["Damage Squared", "Root of Problem", "Hit it again!", "Perfectly Balanced"];
        }
        
        for (var i = 0; i < 4; i++) {
            var is_sel = (menu_index == i);
            var is_disabled = (is_tutorial && i != erin_tutorial_step && battle_state == BattleState.PLAYER_MENU);
            
            var col = (i >= 2) ? 1 : 0; var row = (i % 2);
            var tx = text_start_x + (col * col_spacing); var ty = text_start_y + (row * row_spacing);
            
            if (is_disabled) draw_set_color(c_dkgray); else draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
            draw_text(tx, ty, (is_sel ? "> " : "  ") + skills[i]); 
        }
    } else {
        // TARGETING PROMPT
        draw_set_halign(fa_center); draw_set_valign(fa_middle);
        draw_set_color(c_blue); draw_text(box_x + (box_w / 2), box_y + (box_h / 2) - 30, "- SELECT TARGET -");
        draw_set_color(make_color_rgb(40, 40, 40)); draw_text_transformed(box_x + (box_w / 2), box_y + (box_h / 2) + 30, "Press SPACE to switch, ENTER to lock in!", 0.8, 0.8, 0);
        draw_set_halign(fa_left); draw_set_valign(fa_top); 
    }
}

// Math Solving Box
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    draw_set_halign(fa_center); draw_set_valign(fa_top);
    var solve_center_x = 1400; var solve_start_y = 875;     
    var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    
    var cur_t = is_def ? defend_timer/defend_timer_max : spell_timer/spell_timer_max;
    draw_set_color(is_def ? c_red : c_aqua);
    draw_rectangle(solve_center_x - 140, solve_start_y + 28, solve_center_x - 140 + (cur_t * 280), solve_start_y - 14, false);

    draw_set_color(c_blue); draw_text(solve_center_x, solve_start_y, is_def ? "-- DEFEND SPELL --" : "-- MATH SPELL --");
    draw_set_color(make_color_rgb(40, 40, 40)); draw_text(solve_center_x, solve_start_y + 63, problem_question); draw_text(solve_center_x, solve_start_y + 126, "ANS: " + player_input + "_");
}
draw_set_valign(fa_top);