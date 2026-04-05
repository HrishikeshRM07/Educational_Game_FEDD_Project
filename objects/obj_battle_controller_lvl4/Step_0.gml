// ==========================================
// 0. ANIMATION LOGIC (ADDELINE, MILLY, ERIN & ENEMIES)
// ==========================================
if (addeline_is_attacking) {
    addeline_frame += 0.5; 
    if (addeline_frame >= addeline_anim_end) { addeline_is_attacking = false; addeline_frame = 0; }
} else {
    addeline_frame += 0.2; if (addeline_frame >= 10 || addeline_frame < 0) addeline_frame = 0; 
}

if (milly_is_attacking) {
    milly_frame += 0.5;
    if (milly_frame >= milly_anim_end) { milly_is_attacking = false; milly_frame = 0; }
} else {
    milly_frame += 0.2; if (milly_frame >= 10 || milly_frame < 0) milly_frame = 0;
}

if (erin_is_attacking) {
    erin_frame += 0.5;
    if (erin_frame >= erin_anim_end) { erin_is_attacking = false; erin_frame = 0; }
} else {
    erin_frame += 0.2; if (erin_frame >= 10 || erin_frame < 0) erin_frame = 0;
}

for (var i = 0; i < array_length(enemies); i++) {
    if (enemies[i][1] > 0) { 
        enemies[i][5] += 0.2; if (enemies[i][5] >= 10) enemies[i][5] = 0;
    }
}

// --- 1. TYPEWRITER EFFECT ---
if (fairy_text != previous_fairy_text) { 
    text_progress = 0; previous_fairy_text = fairy_text; 
}
if (text_progress < string_length(fairy_text)) text_progress += text_speed;

// --- 2. CHARACTER SWITCHING (Updated for 3 Hitboxes) ---
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0) {
    if (mouse_check_button_pressed(mb_left)) {
        if (mouse_y >= 660 && mouse_y <= 740) {
            if (mouse_x >= 140 && mouse_x <= 240) { active_char = 0; menu_index = 0; }      // Addeline
            else if (mouse_x >= 280 && mouse_x <= 380) { active_char = 1; menu_index = 0; } // Milly
            else if (mouse_x >= 420 && mouse_x <= 520) { active_char = 2; menu_index = 0; } // Erin
        }
    }
}

// --- 3. ENEMY ATTACK TIMER ---
if (battle_state == BattleState.ENEMY_TURN) {
    if (attack_timer > 0) {
        attack_timer--;
    } else {
        battle_state = BattleState.DEFEND_MENU;
        menu_index = 0;
        fairy_text = "Bria: Quick! Pick a shield to defend!";
    }
}

// --- 4. MENU NAVIGATION ---
if ((battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) && win_timer <= 0) {
    if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
    if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
    if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
    if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;

    if (keyboard_check_pressed(vk_enter)) {
        selected_skill = menu_index + 1;
        player_input = ""; 
        
        if (battle_state == BattleState.PLAYER_MENU) {
            generate_problem(selected_skill, active_char); 
            spell_timer = spell_timer_max;
            battle_state = BattleState.PLAYER_SOLVE;
        } else if (battle_state == BattleState.DEFEND_MENU) {
            generate_problem(selected_skill, 0); 
            defend_timer = defend_timer_max;
            battle_state = BattleState.DEFEND_SOLVE;
        }
    }
}

// --- 5. SOLVING MATH ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    
    for (var i = 0; i <= 9; i++) { 
        if (keyboard_check_pressed(ord(string(i)))) player_input += string(i); 
    }
    if (keyboard_check_pressed(190) || keyboard_check_pressed(110)) player_input += "."; 
    if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

    var is_defending = (battle_state == BattleState.DEFEND_SOLVE);
    if (is_defending) defend_timer--; else spell_timer--;

    if (spell_timer <= 0 && !is_defending) { 
        fairy_text = "Bria: Too slow! Brace yourself!";
        attack_timer = 120; battle_state = BattleState.ENEMY_TURN; 
    }
    if (defend_timer <= 0 && is_defending) { 
        fairy_text = "Bria: Ouch! We took a hit!";
        player_hp -= 15; milly_hp -= 15; erin_hp -= 15;
        battle_state = BattleState.PLAYER_MENU; 
    }

    if (keyboard_check_pressed(vk_enter) && player_input != "") {
        if (real(player_input) == problem_answer) {
            // --- CORRECT ANSWER ---
            if (is_defending) {
                battle_state = BattleState.PLAYER_MENU;
                fairy_text = "Bria: Great block! Now it's our turn.";
            } else {
                var target = 0; // Find first alive enemy
                for (var e = 0; e < array_length(enemies); e++) { if (enemies[e][1] > 0) { target = e; break; } }

                if (active_char == 0) { // ADDELINE
                    addeline_is_attacking = true;
                    if (selected_skill == 1) { 
                        addeline_frame = 24; addeline_anim_end = 38; 
                        player_hp = min(player_hp + 20, player_max_hp); 
                    }
                    else if (selected_skill == 2) { 
                        addeline_frame = 10; addeline_anim_end = 24; enemies[target][1] -= 15; 
                    }
                    else if (selected_skill == 3) { 
                        addeline_frame = 52; addeline_anim_end = 67; 
                        player_hp = min(player_hp + 15, player_max_hp); 
                        milly_hp = min(milly_hp + 15, milly_max_hp);
                        erin_hp = min(erin_hp + 15, erin_max_hp);
                    }
                    else if (selected_skill == 4) { 
                        addeline_frame = 38; addeline_anim_end = 52; 
                        for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) enemies[i][1] -= 15; }
                    }
                } 
                else if (active_char == 1) { // MILLY
                    milly_is_attacking = true;
                    if (selected_skill == 1) { milly_frame = 10; milly_anim_end = 25; milly_heal_buff = 3; }
                    else if (selected_skill == 2) { milly_frame = 25; milly_anim_end = 40; enemies[target][1] -= 15; }
                    else if (selected_skill == 3) { milly_frame = 40; milly_anim_end = 55; party_buff = 3; }
                    else if (selected_skill == 4) { milly_frame = 55; milly_anim_end = 71; enemy_debuff = 3; }
                }
                else if (active_char == 2) { // ERIN
                    erin_is_attacking = true;
                    var base_dmg = 20;
                    if (erin_dmg_boost) { base_dmg *= 2; erin_dmg_boost = false; }

                    if (selected_skill == 1) { // Damage Squared
                        erin_frame = 10; erin_anim_end = 25; erin_dmg_boost = true;
                    } 
                    else if (selected_skill == 2) { // Root of the Problem
                        erin_frame = 26; erin_anim_end = 41; enemies[target][1] -= base_dmg; erin_hp -= 5;
                    } 
                    else if (selected_skill == 3) { // Hit it again!
                        erin_frame = 42; erin_anim_end = 57; enemies[target][1] -= (base_dmg + 10);
                    } 
                    else if (selected_skill == 4) { // Perfectly Balanced
                        erin_frame = 58; erin_anim_end = 72; enemies[target][1] -= base_dmg; erin_hp = min(erin_hp + 15, erin_max_hp);
                    }
                }

                var enemies_dead = true;
                for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) enemies_dead = false; }
                
                if (enemies_dead) { 
                    attack_timer = 0; battle_state = BattleState.PLAYER_MENU;
                } else { 
                    attack_timer = 120; battle_state = BattleState.ENEMY_TURN; 
                }
            }
        } else { 
            // --- WRONG ANSWER ---
            player_input = ""; 
            if (active_char == 0) {
                if (selected_skill == 1) fairy_text = "Bria: Hint! Try counting up from " + string(problem_val1) + ".";
                else if (selected_skill == 2) fairy_text = "Bria: Hint! Take " + string(problem_val2) + " away from " + string(problem_val1) + ".";
                else fairy_text = "Bria: Careful! Check your math again.";
            } else if (active_char == 1) {
                if (selected_skill == 1) fairy_text = "Bria: Hint! What is " + string(problem_val1) + " groups of " + string(problem_val2) + "?";
                else if (selected_skill == 2) fairy_text = "Bria: Hint! How many times does " + string(problem_val1) + " fit into that number?";
                else if (selected_skill == 3) fairy_text = "Bria: Hint! Multiply " + string(problem_val1) + " by both inside numbers, then add them.";
                else if (selected_skill == 4) fairy_text = "Bria: Hint! Half of " + string(problem_val1) + " is " + string(problem_val1 / 2) + ".";
            } else if (active_char == 2) {
                if (selected_skill == 1) fairy_text = "Bria: Hint! Multiply the number by itself.";
                else if (selected_skill == 2) fairy_text = "Bria: Hint! What number multiplied by itself equals " + string(problem_val1) + "?";
                else if (selected_skill == 3) fairy_text = "Bria: Hint! Multiply the number by itself three times.";
                else if (selected_skill == 4) fairy_text = "Bria: Hint! Find the square root of that number.";
            }
        }
    }
}

// --- 7. WAVE & VICTORY LOGIC ---
var all_dead = true;
for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) all_dead = false; }

if (all_dead && attack_timer <= 0 && battle_state == BattleState.PLAYER_MENU) {
    if (current_wave < max_waves) {
        if (win_timer == -1) { win_timer = 120; fairy_text = "Bria: Well done! That's one wave down!"; }
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) {
            current_wave++;
            fairy_text = "Bria: Watch out! More enemies are appearing!";
            
            if (current_wave == 2) {
                enemies = [ 
                    ["GoldmanTall", 60, room_width-320, 510, GoldmanTall, 0], 
                    ["GoldmanShort", 40, room_width-180, 600, GoldmanShort, 0] 
                ];
            } else if (current_wave == 3) {
                enemies = [ 
                    ["GoldmanTall", 60, room_width-320, 510, GoldmanTall, 0], 
                    ["GoldmanTall", 60, room_width-180, 510, GoldmanTall, 0] 
                ];
            }
            win_timer = -1;
        }
    } else {
        if (win_timer == -1) win_timer = 180;
        fairy_text = "Bria: You did it! All 3 waves are clear!";
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) room_goto(rm_Level4_PostBattle); // Update room name as needed
    }
}

// --- 8. DEFEAT LOGIC ---
if (player_hp <= 0 && milly_hp <= 0 && erin_hp <= 0) {
    if (lose_timer == -1) { 
        lose_timer = 180; 
        fairy_text = "Bria: We were defeated... Let's try again!"; 
        battle_state = BattleState.PLAYER_MENU; attack_timer = 0; 
    }
    if (lose_timer > 0) lose_timer--;
    if (lose_timer == 0) room_goto(rm_Level4_Story);
}