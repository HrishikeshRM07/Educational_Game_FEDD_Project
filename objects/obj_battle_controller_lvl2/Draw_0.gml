// --- 1. DRAW CHARACTERS & ENEMIES ---
// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_Level2PostBattle);
}

draw_sprite_ext(pl_ad, 0, 130, 400, 1, 1, 0, c_white, 1);
draw_sprite_ext(pl_ob, 0, 260, 400, 1, 1, 0, c_white, 1); 

for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    if (en[1] > 0) {
        draw_sprite(spr_enemy_slime, 0, en[2], en[3]); 
        draw_set_halign(fa_center); draw_set_color(c_white);
        draw_text(en[2], en[3] - 40, string(en[1]) + " / 30");
    }
}

// --- 2. FAIRY DIALOGUE BOX ---
var f_y = 30; var box_margin = 30; 
draw_set_alpha(0.8); draw_set_color(c_black); draw_roundrect(box_margin, f_y, room_width - box_margin, f_y + 120, false);
draw_set_alpha(1); draw_set_color(c_white); draw_roundrect(box_margin, f_y, room_width - box_margin, f_y + 120, true);
draw_set_halign(fa_left); draw_text(box_margin + 20, f_y + 15, "BRIA");
var text_to_draw = string_copy(fairy_text, 1, floor(text_progress));
draw_text_ext(box_margin + 20, f_y + 45, text_to_draw, 22, room_width - 100);

// --- 3. MENU UI ---
var ui_y = room_height - 180;
var menu_x_start = (room_width / 2) - 100; 
var menu_x_end = room_width - 50;

draw_set_alpha(0.9); draw_set_color(c_black); draw_roundrect(menu_x_start, ui_y, menu_x_end, ui_y + 160, false);
draw_set_alpha(1); draw_set_color(c_white); draw_roundrect(menu_x_start, ui_y, menu_x_end, ui_y + 160, true);

if (battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) {
    var skills = [];
    
    if (battle_state == BattleState.DEFEND_MENU) {
        skills = ["Quick Shield", "Math Barrier", "Logic Wall", "Aegis"];
    } else {
        if (active_char == 0) skills = ["Additive Heal", "Subtraction", "Commutative", "Double Sub"];
        else skills = ["Base Mult.", "Base Div.", "Distributive", "Long Div."];
    }

    for (var i = 0; i < 4; i++) {
        var text_col = (menu_index == i) ? c_yellow : (battle_state == BattleState.DEFEND_MENU ? c_aqua : c_white);
        draw_set_color(text_col);
        
        var tx = menu_x_start + 30 + (i >= 2 ? 220 : 0); 
        var ty = ui_y + 40 + (i % 2 == 0 ? 0 : 60);
        draw_text(tx, ty, (menu_index == i ? "> " : "") + skills[i]);
    }
}

// --- 4. DRAW THE PROBLEM SOLVER ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    var mid_x = (menu_x_start + menu_x_end) / 2;
    
    var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    var bar_col = is_def ? c_red : c_aqua;
    var timer_val = is_def ? defend_timer : spell_timer;
    var timer_max = is_def ? defend_timer_max : spell_timer_max;

    draw_set_color(bar_col); 
    draw_rectangle(mid_x - 100, ui_y + 20, mid_x - 100 + (timer_val/timer_max * 200), ui_y + 30, false);
    
    draw_set_color(c_white); draw_set_halign(fa_center);
    if (is_def) draw_text(mid_x, ui_y + 10, "DEFEND!");
    
    draw_text(mid_x, ui_y + 70, problem_question);
    draw_text(mid_x, ui_y + 120, "ANS: " + player_input + "_");
}

// --- 5. DUAL PLAYER PORTRAITS & HP FRAMES ---
var p_y = 740;

// Addeline Portrait (Left) - Gray out if locked by tutorial
draw_set_color(active_char == 0 ? c_yellow : (is_tutorial ? c_dkgray : c_white));
draw_roundrect_ext(40, p_y - 2, 180, p_y + 22, 10, 10, true);
draw_sprite_ext(AddelineBUI, 0, 80, p_y - 150, 0.5, 0.5, 0, (is_tutorial ? c_gray : c_white), 1);
draw_set_color(c_white); draw_set_halign(fa_left);
draw_text(110, p_y + 2, string(player_hp) + " / " + string(player_max_hp));
if (is_tutorial) { draw_set_color(c_red); draw_text(50, p_y - 160, "LOCKED"); }

// Milly Portrait (Right)
draw_set_color(active_char == 1 ? c_yellow : c_white); 
draw_roundrect_ext(190, p_y - 2, 330, p_y + 22, 10, 10, true);
draw_sprite_ext(MillyBUI, 0, 230, p_y - 150, 0.5, 0.5, 0, c_white, 1);
draw_set_color(c_white);
draw_text(260, p_y + 2, string(milly_hp) + " / " + string(milly_max_hp));