// --- 0. PREP ---
if (asset_get_index("fnt_battle") != -1) {
    draw_set_font(fnt_dialogue);
}

// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_Level2PostBattle);
}

// --- 1. DRAW CHARACTERS & ENEMIES ---
draw_sprite_ext(pl_ad, 0, 130, 400, 1, 1, 0, c_white, 1);
draw_sprite_ext(pl_ob, 0, 260, 400, 1, 1, 0, c_white, 1); 

for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    if (en[1] > 0) {
        draw_sprite(spr_enemy_slime, 0, en[2], en[3]); 
        draw_set_halign(fa_center); 
        draw_set_color(c_yellow);
        draw_text(en[2], en[3] - 40, string(en[1]) + " / 30");
    }
}

// --- 2. FAIRY DIALOGUE BOX (TOP) ---
var fairy_box_w = 1250;               
var fairy_box_h = 230;                

if (sprite_exists(spr_dialogue_base)) {
    draw_sprite_stretched(spr_dialogue_base, 0, 5, 10, fairy_box_w, fairy_box_h);
}

draw_set_halign(fa_left); draw_set_valign(fa_top);
draw_set_color(c_black); 
draw_text(145, 90, "BRIA"); 

draw_set_color(make_color_rgb(40, 40, 40));
var text_to_draw = string_copy(fairy_text, 1, floor(text_progress));
draw_text_ext(145, 120, text_to_draw, 22, fairy_box_w - 90);

// --- 3. BOTTOM LEFT HUD (DUAL PORTRAITS + HP) ---
var p_y = 680;        // Increased to 680 to lower the UI further down the screen
var shift_x = 100;    // Keeps everything shifted right

// --- ADDELINE (Left) ---
var ad_x = shift_x - 30;
// Addeline is Bottom Center, so we put her origin at the bottom edge of the box
var ad_y = p_y + 60;  
var ad_alpha = (is_tutorial) ? 0.5 : 1; 
var ad_face = (player_hp > 70) ? 0 : (player_hp > 30 ? 1 : 2);

// Draw Addeline's Box
draw_set_color(active_char == 0 ? c_yellow : (is_tutorial ? c_dkgray : c_white));
draw_roundrect_ext(40 + shift_x, p_y - 20, 140 + shift_x, p_y + 60, 10, 10, true); 

// Draw Addeline's Portrait
if (sprite_exists(AddelineBUI)) {
    draw_sprite_ext(AddelineBUI, ad_face, ad_x, ad_y, 0.5, 0.5, 0, c_white, ad_alpha);
}

// Draw Addeline's Stacked HP (Vertical)
draw_set_halign(fa_center); draw_set_valign(fa_middle);
draw_set_color(is_tutorial ? c_gray : c_white); 
draw_text(90 + shift_x, p_y + 5, string(player_hp));
draw_text(90 + shift_x, p_y + 15, "___");
draw_text(90 + shift_x, p_y + 40, string(player_max_hp));

if (is_tutorial) {
    draw_set_color(c_red);
    draw_text(ad_x, ad_y - 90, "LOCKED");
}

// --- MILLY (Right) ---
// 1. PORTRAIT POSITION (Set back to 230 so it stays still)
var mil_x = 210 + shift_x; 
var mil_y = p_y - 10; 

// 2. BOX POSITION (Moved further right! Changed from 240/340 to 270/370)
draw_set_color(active_char == 1 ? c_yellow : c_white);
draw_roundrect_ext(270 + shift_x, p_y - 20, 370 + shift_x, p_y + 60, 10, 10, true);

// Draw Milly's Portrait
if (sprite_exists(MillyBUI)) { 
    draw_sprite_ext(MillyBUI, 0, mil_x, mil_y, 0.5, 0.5, 0, c_white, 1);
}

// 3. TEXT POSITION (Moved further right to stay inside the box. Changed to 320)
draw_set_color(c_white); 
draw_text(320 + shift_x, p_y + 5, string(milly_hp));
draw_text(320 + shift_x, p_y + 15, "___");
draw_text(320 + shift_x, p_y + 40, string(milly_max_hp));

draw_set_valign(fa_top); // Reset alignment for the rest of your UI

// --- 4. BOTTOM RIGHT MENU BOX ---
var box_x = 650;       
var box_y = 550;        
var box_w = 700;        
var box_h = 200;        

if (sprite_exists(spr_dialogue_base)) {
    draw_sprite_stretched(spr_dialogue_base, 0, box_x, box_y, box_w, box_h);
}

// --- 5. GRID SKILLS (TEXT ONLY) ---
if (battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) {
    draw_set_halign(fa_left); draw_set_valign(fa_top);
    
    var text_start_x = 770;  
    var text_start_y = 640;   
    var col_spacing = 300;    
    var row_spacing = 60;     
    
    var skills = [];
    if (battle_state == BattleState.DEFEND_MENU) {
        skills = ["Quick Shield", "Math Barrier", "Logic Wall", "Aegis"];
    } else {
        if (active_char == 0) skills = ["Additive Heal", "Subtraction", "Commutative", "Double Sub"];
        else skills = ["Base Mult.", "Base Div.", "Distributive", "Long Div."];
    }
    
    for (var i = 0; i < 4; i++) {
        var is_sel = (menu_index == i);
        var is_locked = (is_tutorial && i != milly_tutorial_step && battle_state == BattleState.PLAYER_MENU);
        
        var col = (i >= 2) ? 1 : 0;
        var row = (i % 2);
        
        var tx = text_start_x + (col * col_spacing);
        var ty = text_start_y + (row * row_spacing);
        
        if (is_locked) {
            draw_set_color(c_gray);
        } else {
            draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
        }
        
        var prefix = (is_sel) ? "> " : "  "; 
        draw_text(tx, ty, prefix + skills[i]); 
    }
}

// --- 6. SOLVE STATE ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    draw_set_halign(fa_center); draw_set_valign(fa_top);
    
    var solve_center_x = 1000; 
    var solve_start_y = 625;   
    var is_def = (battle_state == BattleState.DEFEND_SOLVE);
    
    // Timer Bar
    var cur_t = is_def ? defend_timer/defend_timer_max : spell_timer/spell_timer_max;
    draw_set_color(is_def ? c_red : c_aqua);
    draw_rectangle(solve_center_x - 100, solve_start_y + 140, solve_center_x - 100 + (cur_t * 200), solve_start_y + 150, false);

    draw_set_color(c_blue);
    draw_text(solve_center_x, solve_start_y, is_def ? "-- DEFEND SPELL --" : "-- MATH SPELL --");
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text(solve_center_x, solve_start_y + 45, problem_question);
    draw_text(solve_center_x, solve_start_y + 90, "ANS: " + player_input + "_");
}

draw_set_valign(fa_top); // Reset alignment