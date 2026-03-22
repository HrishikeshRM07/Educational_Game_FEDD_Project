// --- 1. FAIRY DIALOGUE BOX ---
var fairy_box_y = 30;
var fairy_box_h = 120;
draw_set_alpha(0.85); draw_set_color(c_black);
draw_roundrect_ext(30, fairy_box_y, room_width - 30, fairy_box_y + fairy_box_h, 15, 15, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_roundrect_ext(30, fairy_box_y, room_width - 30, fairy_box_y + fairy_box_h, 15, 15, true);
draw_set_halign(fa_left);
draw_set_color(c_yellow);
draw_text_transformed(50, fairy_box_y + 15, "FAIRY", 1.2, 1.2, 0);
draw_set_color(c_white);
draw_text_ext(50, fairy_box_y + 45, fairy_text, 22, room_width - 100);

// --- 2. HP BOXES ---
draw_set_halign(fa_center);
// Horatio
draw_set_alpha(0.8); draw_set_color(c_black);
draw_roundrect_ext(horatio_x - 55, horatio_y - 95, horatio_x + 55, horatio_y - 75, 10, 10, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_roundrect_ext(horatio_x - 55, horatio_y - 95, horatio_x + 55, horatio_y - 75, 10, 10, true);
draw_text(horatio_x, horatio_y - 87, string(enemy_hp) + " / 50");
// Addeline
draw_set_alpha(0.8); draw_set_color(c_black);
draw_roundrect_ext(110 - 55, 750 - 12, 110 + 55, 750 + 12, 10, 10, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_roundrect_ext(110 - 55, 750 - 12, 110 + 55, 750 + 12, 10, 10, true);
draw_text(110, 750 - 8, string(player_hp) + " / 100");

// --- 3. CHARACTER PORTRAIT ---
var face = (player_hp > 99) ? 0 : (player_hp > 40 ? 1 : (player_hp > 0 ? 2 : 3));
draw_sprite_ext(spr_Addeline_Portraits, face, 100, 550, 0.65, 0.65, 0, c_white, 1);

// --- 4. EXTENDED MENU BOX ---
var ui_y = room_height - 180;
var ui_height = 160;
var menu_x_start = (room_width / 2) + 2;
var menu_x_end = room_width - 20;
draw_set_alpha(0.9); draw_set_color(c_black);
draw_roundrect_ext(menu_x_start, ui_y, menu_x_end, ui_y + ui_height, 15, 15, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_roundrect_ext(menu_x_start, ui_y, menu_x_end, ui_y + ui_height, 15, 15, true);

// --- 5. GRID SKILLS (FIXED GREY-OUT LOGIC) ---
if (battle_state == BattleState.PLAYER_MENU) {
    draw_set_halign(fa_left);
    var scale = 1.6;
    var col_dist = (menu_x_end - menu_x_start) / 2;
    var skills = ["Additive Heal", "Subtraction", "Commutative", "Double Sub"];
    var skill_ids = [1, 2, 3, 4]; 
    
    for (var i = 0; i < 4; i++) {
        var is_sel = (menu_index == i);
        var s_id = skill_ids[i];
        
        // STRICT LOCK LOGIC: Gray out everything EXCEPT the active tutorial skill
        var is_locked = true;
        if (tutorial_stage == 0 && s_id == 2) is_locked = false; // Subtraction only
        if (tutorial_stage == 1 && s_id == 1) is_locked = false; // Heal only
        if (tutorial_stage == 3 && s_id == 4) is_locked = false; // Double Sub only
        if (tutorial_stage == 4 && s_id == 3) is_locked = false; // Commutative only
        if (tutorial_stage >= 5) is_locked = false;              // Free play
        
        var tx = menu_x_start + 40 + (i >= 2 ? col_dist : 0);
        var ty = ui_y + 40 + (i % 2 == 0 ? 0 : 65);
        
        // Visual Color Application
        if (is_locked) {
            draw_set_color(c_dkgray);
        } else {
            draw_set_color(is_sel ? c_yellow : c_white);
        }
        
        var prefix = (is_sel) ? "> " : "";
        draw_text_transformed(tx, ty, prefix + skills[i], scale, scale, 0);
        
        if (is_sel && !is_locked) {
            var tw = string_width(prefix + skills[i]) * scale;
            draw_line_width(tx, ty + 42, tx + tw, ty + 42, 3);
        }
    }
}

// --- 6. SOLVE STATE ---
if (battle_state == BattleState.PLAYER_SOLVE) {
    draw_set_halign(fa_center);
    var mid_menu_x = (menu_x_start + menu_x_end) / 2;
    draw_set_color(c_aqua);
    draw_text_transformed(mid_menu_x, ui_y + 25, "-- MATH SPELL --", 1.1, 1.1, 0);
    draw_set_color(c_white);
    draw_text_transformed(mid_menu_x, ui_y + 70, problem_question, 1.8, 1.8, 0);
    draw_text_transformed(mid_menu_x, ui_y + 125, "ANS: " + player_input + "_", 1.4, 1.4, 0);
}