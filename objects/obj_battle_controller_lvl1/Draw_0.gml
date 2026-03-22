// --- 1. DRAW CHARACTERS (Moved UP) ---
// Original Y was 480/420, changing to 400/340 to move them up
draw_sprite_ext(pl_ad, 0, 180, 400, 1, 1, 0, c_white, 1);
draw_sprite_ext(pl_fairy, 0, 300, 340, 1, 1, 0, c_white, 1);

// --- 2. DRAW ENEMIES (No Bars, just Numbers) ---
for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    if (en[1] > 0) {
        draw_sprite(spr_enemy_slime, 0, en[2], en[3]); 
        
        // Just the Numbers (Horatio style)
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text(en[2], en[3] - 40, string(en[1]) + " / 30");
    }
}

// --- 3. FAIRY DIALOGUE BOX (Shifted Left) ---
var f_y = 30;
var box_margin = 30; // Original was 30, keep this for symmetry
draw_set_alpha(0.8); draw_set_color(c_black); 
draw_roundrect(box_margin, f_y, room_width - box_margin, f_y + 120, false);
draw_set_alpha(1); draw_set_color(c_white); 
draw_roundrect(box_margin, f_y, room_width - box_margin, f_y + 120, true);

draw_set_halign(fa_left);
draw_text(box_margin + 20, f_y + 15, "BRIA");
// Text padding adjusted (50 -> 40) to move text slightly more left
draw_text_ext(box_margin + 20, f_y + 45, fairy_text, 22, room_width - 100);

// --- 4. MENU & MATH UI (Shifted Left) ---
var ui_y = room_height - 180;
// Changing menu_x_start to be closer to the middle/left
var menu_x_start = (room_width / 2) - 100; // Moved 102 pixels to the left
var menu_x_end = room_width - 50;

draw_set_alpha(0.9); draw_set_color(c_black); 
draw_roundrect(menu_x_start, ui_y, menu_x_end, ui_y + 160, false);
draw_set_alpha(1); draw_set_color(c_white); 
draw_roundrect(menu_x_start, ui_y, menu_x_end, ui_y + 160, true);

if (battle_state == BattleState.PLAYER_MENU) {
    var skills = ["Additive Heal", "Subtraction", "Commutative", "Double Sub"];
    for (var i = 0; i < 4; i++) {
        draw_set_color(menu_index == i ? c_yellow : c_white);
        // Adjusted tx to move text left within the box
        var tx = menu_x_start + 30 + (i >= 2 ? 220 : 0); 
        var ty = ui_y + 40 + (i % 2 == 0 ? 0 : 60);
        draw_text(tx, ty, (menu_index == i ? "> " : "") + skills[i]);
    }
}

if (battle_state == BattleState.PLAYER_SOLVE) {
    var mid_x = (menu_x_start + menu_x_end) / 2;
    draw_set_color(c_aqua);
    draw_rectangle(mid_x - 100, ui_y + 20, mid_x - 100 + (spell_timer/600 * 200), ui_y + 30, false);
    draw_set_color(c_white); draw_set_halign(fa_center);
    draw_text(mid_x, ui_y + 70, problem_question);
    draw_text(mid_x, ui_y + 120, "ANS: " + player_input + "_");
}

// --- 5. PLAYER PORTRAIT & HP FRAME ---
var portrait_x = 100;
var portrait_y = 550;

// Draw the Black Background for the HP Box
draw_set_alpha(0.8); 
draw_set_color(c_black);
draw_roundrect_ext(55, 738, 165, 762, 10, 10, false);

// Draw the White Border for the HP Box
draw_set_alpha(1); 
draw_set_color(c_white);
draw_roundrect_ext(55, 738, 165, 762, 10, 10, true);

// Draw the actual Portrait
// (0 = Healthy, 1 = Hurt, 2 = Danger)
var face_index = (player_hp > 70) ? 0 : (player_hp > 30 ? 1 : 2);
draw_sprite_ext(spr_Addeline_Portraits, face_index, portrait_x, portrait_y, 0.6, 0.6, 0, c_white, 1);

// Draw the HP Text inside the frame
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(110, 742, string(player_hp) + " / 100");

// OPTIONAL: Add a small green HP bar under the text for extra polish
draw_set_color(c_dkgray);
draw_rectangle(60, 765, 160, 770, false); // Background of bar
draw_set_color(c_lime);
draw_rectangle(60, 765, 60 + (player_hp / 100 * 100), 770, false); // The actual health