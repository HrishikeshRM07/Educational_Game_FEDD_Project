// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_Level1PostBattle);
}
// 1. DRAW CHARACTERS & ENEMIES
draw_sprite_ext(pl_ad, 0, 180, 400, 1, 1, 0, c_white, 1);


for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    if (en[1] > 0) {
        draw_sprite(spr_enemy_slime, 0, en[2], en[3]); 
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text(en[2], en[3] - 40, string(en[1]) + " / 30");
    }
}

// 2. FAIRY DIALOGUE BOX (With Typewriter)
var f_y = 30;
var box_margin = 30; 
draw_set_alpha(0.8); draw_set_color(c_black); 
draw_roundrect(box_margin, f_y, room_width - box_margin, f_y + 120, false);
draw_set_alpha(1); draw_set_color(c_white); 
draw_roundrect(box_margin, f_y, room_width - box_margin, f_y + 120, true);

draw_set_halign(fa_left);
draw_text(box_margin + 20, f_y + 15, "BRIA");

// Cut the text based on the current text_progress
var text_to_draw = string_copy(fairy_text, 1, floor(text_progress));
draw_text_ext(box_margin + 20, f_y + 45, text_to_draw, 22, room_width - 100);


// 3. MENU & MATH UI
var ui_y = room_height - 180;
var menu_x_start = (room_width / 2) - 100; 
var menu_x_end = room_width - 50;

draw_set_alpha(0.9); draw_set_color(c_black); 
draw_roundrect(menu_x_start, ui_y, menu_x_end, ui_y + 160, false);
draw_set_alpha(1); draw_set_color(c_white); 
draw_roundrect(menu_x_start, ui_y, menu_x_end, ui_y + 160, true);

// DRAW SKILLS (Changes based on if you are attacking or defending)
if (battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) {
    
    var skills = [];
    if (battle_state == BattleState.PLAYER_MENU) {
        skills = ["Additive Heal", "Subtraction", "Commutative", "Double Sub"];
    } else {
        // Defense skills!
        skills = ["Quick Shield", "Math Barrier", "Logic Wall", "Aegis"];
    }

    for (var i = 0; i < 4; i++) {
        draw_set_color(menu_index == i ? c_yellow : c_white);
        var tx = menu_x_start + 30 + (i >= 2 ? 220 : 0); 
        var ty = ui_y + 40 + (i % 2 == 0 ? 0 : 60);
        draw_text(tx, ty, (menu_index == i ? "> " : "") + skills[i]);
    }
}

// DRAW THE PROBLEM SOLVER
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    var mid_x = (menu_x_start + menu_x_end) / 2;
    
    // Timer Bar (Changes color depending on attack vs defend)
    if (battle_state == BattleState.PLAYER_SOLVE) {
        draw_set_color(c_aqua);
        draw_rectangle(mid_x - 100, ui_y + 20, mid_x - 100 + (spell_timer/600 * 200), ui_y + 30, false);
    } else {
        draw_set_color(c_red); // Red timer for panic during defense!
        draw_rectangle(mid_x - 100, ui_y + 20, mid_x - 100 + (defend_timer/300 * 200), ui_y + 30, false);
    }
    
    draw_set_color(c_white); draw_set_halign(fa_center);
    draw_text(mid_x, ui_y + 70, problem_question);
    draw_text(mid_x, ui_y + 120, "ANS: " + player_input + "_");
}

// 4. PLAYER PORTRAIT & HP FRAME
var portrait_x = 100;
var portrait_y = 550;

draw_set_alpha(0.8); draw_set_color(c_black);
draw_roundrect_ext(55, 738, 165, 762, 10, 10, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_roundrect_ext(55, 738, 165, 762, 10, 10, true);

var face_index = (player_hp > 70) ? 0 : (player_hp > 30 ? 1 : 2);
draw_sprite_ext(spr_Addeline_Portraits, face_index, portrait_x, portrait_y, 0.6, 0.6, 0, c_white, 1);

draw_set_halign(fa_center); draw_set_color(c_white);
draw_text(110, 742, string(player_hp) + " / 100");

// HP Bar
draw_set_color(c_dkgray);
draw_rectangle(60, 765, 160, 770, false); 
draw_set_color(c_lime);
draw_rectangle(60, 765, 60 + (player_hp / 100 * 100), 770, false);