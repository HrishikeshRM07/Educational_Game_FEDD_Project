// --- 0. PREP ---
if (asset_get_index("fnt_battle") != -1) {
    draw_set_font(fnt_dialogue);
}

// --- 1. DRAW CHARACTERS & ENEMIES ---
// Draw Addeline correctly
if (sprite_exists(AddelineBattle)) {
    draw_sprite(AddelineBattle, floor(addeline_frame), 250, 600);
}

// Draw enemies using their assigned sprites and frames
for (var i = 0; i < array_length(enemies); i++) {
    var en = enemies[i];
    if (en[1] > 0) { // If HP > 0
        draw_sprite_ext(en[4], floor(en[5]), en[2], en[3], 0.45, 0.45, 0, c_white, 1);
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

draw_set_halign(fa_left); 
draw_set_valign(fa_top);
draw_set_color(c_black); 
draw_text(145, 90, "BRIA"); 

draw_set_color(make_color_rgb(40, 40, 40));
var text_to_draw = string_copy(fairy_text, 1, floor(text_progress));
var text_max_width = fairy_box_w - 90; 
draw_text_ext(145, 120, text_to_draw, 22, text_max_width);


// --- 3. BOTTOM LEFT HUD (PORTRAIT + STACKED HP) ---
var port_x = 120;
var port_y = room_height;

var face_index = (player_hp > 70) ? 0 : (player_hp > 30 ? 1 : 2);
if (sprite_exists(AddelineBUI)) {
    draw_sprite_ext(AddelineBUI, face_index, port_x, port_y - 14, 0.8, 0.8, 0, c_white, 1);
}

draw_set_halign(fa_center); 
draw_set_valign(fa_middle);
draw_set_color(c_white); 
draw_text(port_x + 120, port_y - 100, string(player_hp));
draw_text(port_x + 120, port_y - 85, "___");
draw_text(port_x + 120, port_y - 55, string(player_max_hp));


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
    draw_set_halign(fa_left);
    
    var text_start_x = 770;  
    var text_start_y = 640;   
    var col_spacing = 300;    
    var row_spacing = 60;     
    
    var skills = (battle_state == BattleState.PLAYER_MENU) ? 
        ["Additive Heal", "Subtraction", "Commutative", "Double Sub"] : 
        ["Quick Shield", "Math Barrier", "Logic Wall", "Aegis"];
    
    for (var i = 0; i < 4; i++) {
        var is_sel = (menu_index == i);
        var col = (i >= 2) ? 1 : 0;
        var row = (i % 2);
        
        var tx = text_start_x + (col * col_spacing);
        var ty = text_start_y + (row * row_spacing);
        
        draw_set_color(is_sel ? c_blue : make_color_rgb(40, 40, 40)); 
        var prefix = (is_sel) ? "> " : "  "; 
        draw_text(tx, ty, prefix + skills[i]); 
    }
}

// --- 6. SOLVE STATE ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    draw_set_halign(fa_center);
    
    var solve_center_x = 1000; 
    var solve_start_y = 625;   
    
    // Timer Bar
    var cur_t = (battle_state == BattleState.PLAYER_SOLVE) ? spell_timer/spell_timer_max : defend_timer/defend_timer_max;
    draw_set_color(battle_state == BattleState.PLAYER_SOLVE ? c_aqua : c_red);
    draw_rectangle(solve_center_x - 100, solve_start_y + 20, solve_center_x - 100 + (cur_t * 200), solve_start_y - 10, false);

    draw_set_color(c_blue);
    draw_text(solve_center_x, solve_start_y, "-- MATH SPELL --");
    
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_text(solve_center_x, solve_start_y + 45, problem_question);
    draw_text(solve_center_x, solve_start_y + 90, "ANS: " + player_input + "_");
}

draw_set_valign(fa_top); // Reset alignment