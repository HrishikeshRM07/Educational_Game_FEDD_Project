// 1. TOP UI: PLAYER PORTRAIT & HP BARS

// --- A. ADDELINE'S DYNAMIC PORTRAIT ---
var face_index = 0; 
if (player_hp > 99) face_index = 0; 
else if (player_hp > 40) face_index = 1; 
else if (player_hp > 0) face_index = 2; 
else face_index = 3;

// --- B. HERO UI BOX (Left Side) ---
draw_set_alpha(0.6); draw_set_color(c_black);
// Draw a black backing box for the hero stats
draw_roundrect_ext(10, 10, 400, 95, 15, 15, false);
draw_set_alpha(1); draw_set_color(c_white);

// Draw the face back at your preferred coordinates
draw_sprite_ext(spr_Addeline_Portraits, face_index, 67, -2, 0.5, 0.5, 0, c_white, 1);

// Position the text and bar inside the black box
var hero_text_x = 135;
draw_set_halign(fa_left);
draw_text(hero_text_x, 30, "ADDELINE HP");
draw_healthbar(hero_text_x, 60, hero_text_x + 240, 80, player_hp, c_black, c_red, c_green, 0, true, true);


// --- C. ENEMY UI BOX (Right Side) ---
draw_set_alpha(0.6); draw_set_color(c_black);
// Draw a matching black backing box for Horatio
draw_roundrect_ext(room_width - 400, 10, room_width - 10, 95, 15, 15, false);
draw_set_alpha(1); draw_set_color(c_white);

// Enemy HP Content
draw_set_halign(fa_right);
var enemy_text_x = room_width - 25;
draw_text(enemy_text_x, 30, "HORATIO HP");
draw_healthbar(enemy_text_x - 240, 60, enemy_text_x, 80, (enemy_hp/50)*100, c_black, c_red, c_orange, 1, true, true);

// 2. FAIRY INSTRUCTION / HINT BOX
if (tutorial_active || is_showing_hint) {
    var display_text = "";
    var box_color = c_black;

    if (is_showing_hint) {
        display_text = "Fairy: " + wrong_answer_hint;
        box_color = make_color_rgb(180, 60, 60); 
    } else {
        box_color = c_black;
        switch(tutorial_stage) {
            case 0: display_text = "Fairy: Welcome! Press [2] Subtraction! Subtract the smallest from the largest!"; break;
            case 1: display_text = "Fairy: It seems that you're hurt! Press [1] Additive Power to heal. Put the numbers together!"; break;
            case 2: display_text = "Fairy: Press [4] Double Sub for more damage! Subtract both small numbers from the big one."; break;
            case 3: display_text = "Fairy: [3] Commutative Property! Add them in any order, I'll give us extra time!"; break;
        }
    }

    draw_set_color(box_color);
    draw_set_alpha(0.85);
    // Moved the box down slightly (to y=130) so it doesn't touch the HP bars
    draw_roundrect_ext(150, 130, room_width - 150, 240, 25, 25, false);
    
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text_ext(room_width/2, 155, display_text, 30, room_width - 350);
}

// 3. BOTTOM COMMAND BOX
var box_h = 220;
var box_y = room_height - box_h;
draw_set_alpha(0.8); draw_set_color(c_black);
draw_rectangle(0, box_y, room_width, room_height, false);
draw_set_alpha(1); draw_set_color(c_white);
draw_rectangle(15, box_y + 15, room_width - 15, room_height - 15, true);

// 4. BATTLE CONTENT
draw_set_halign(fa_left);
switch(battle_state) {
    case BattleState.PLAYER_MENU:
        draw_set_color(c_yellow); draw_text(50, box_y + 40, "CHOOSE A MATHEMAGICAL SKILL:");
        draw_set_color(c_white);
        draw_text(80, box_y + 90,  "[1] Additive Heal");
        draw_text(80, box_y + 150, "[2] Subtraction Attack");
        draw_text(450, box_y + 90,  "[3] Commutative Heal");
        draw_text(450, box_y + 150, "[4] Double Sub Attack");
    break;
    
    case BattleState.PLAYER_SOLVE:
        draw_set_halign(fa_center);
        draw_set_color(c_aqua);
        draw_text(room_width/2, box_y + 40, "--- SOLVE THE SPELL ---");
        draw_set_color(c_white);
        draw_text_transformed(room_width/2, box_y + 90, "PROBLEM: " + problem_question, 1.5, 1.5, 0);
        draw_text(room_width/2, box_y + 150, "ANSWER: " + player_input + "_");
        
        if (is_showing_hint == true) {
            var img_x = room_width / 2;
            var img_y = room_height / 2 - 50; // Nudged up so it doesn't cover the problem text
            var img_to_draw = -1;

            switch(selected_skill) {
                case 1: img_to_draw = spr_AdditionHint; break;
                case 2: img_to_draw = spr_SubtractionHint; break;
                case 3: img_to_draw = spr_AdditionHint; break;
                case 4: img_to_draw = spr_SubtractionHint; break;
            }

            if (img_to_draw != -1) {
                // Background shadow for the hint image to make it "pop"
                draw_set_color(c_black); draw_set_alpha(0.5);
                draw_rectangle(img_x - 105, img_y - 65, img_x + 105, img_y + 65, false);
                draw_set_alpha(1);
                draw_sprite_ext(img_to_draw, 0, img_x, img_y, 0.2, 0.2, 0, c_white, 1);
            }
        }
    break;
    
    case BattleState.ENEMY_TURN:
        draw_set_halign(fa_center);
        draw_text(room_width/2, box_y + 100, "Horatio is gathering dark energy...");
    break;
    
    case BattleState.WIN:
        draw_set_halign(fa_center); draw_text_transformed(room_width/2, room_height/2, "VICTORY!", 3, 3, 0);
    break;
}