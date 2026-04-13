// ==========================================
// 0. ANIMATION & FLASH DECAY LOGIC
// ==========================================
// Addeline
if (addeline_is_attacking) {
    addeline_frame += 0.5; // ATTACK SPEED
    if (addeline_frame >= addeline_anim_end) {
        addeline_is_attacking = false;
        addeline_frame = 0; // Return to idle
    }
} else {
    addeline_frame += 0.2; // IDLE SPEED
    if (addeline_frame >= 10 || addeline_frame < 0) addeline_frame = 0; 
}

// Player Flash Decay
if (player_flash_alpha > 0) player_flash_alpha -= 0.05;

// Enemies
for (var i = 0; i < array_length(enemies); i++) {
    if (enemies[i][1] > 0) { // If enemy is alive
        var max_frames = 6; 
        enemies[i][5] += 0.2; // Anim Speed
        if (enemies[i][5] >= max_frames) enemies[i][5] = 0;
        
        // Enemy Flash Decay
        if (enemies[i][8] > 0) enemies[i][8] -= 0.05;
    } else {
        // Enemy Dead: Fade out and flash red
        if (enemies[i][6] > 0) enemies[i][6] -= 0.02; // Fade Alpha
        enemies[i][7] = c_red; // Lock flash color
        enemies[i][8] = 1.0;   // Lock flash alpha
    }
}

// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape) && !targeting_phase) room_goto(rm_Level1PostBattle);

// 1. HP CLAMPING
player_hp = clamp(player_hp, 0, 100);

// 2. TYPEWRITER LOGIC
if (fairy_text != previous_fairy_text) {
    text_progress = 0;
    previous_fairy_text = fairy_text;
}
if (text_progress < string_length(fairy_text)) {
    text_progress += text_speed;
}

// 3. ENEMY ATTACK SEQUENCE (EASIER MATH + SLOWER TIME)
if (attack_timer > 0) {
    attack_timer--;
    if (attack_timer > 240) fairy_text = "Great hit, Addeline! Get ready...";
    else if (attack_timer > 0) fairy_text = "They are attacking! Prepare yourself!";
    
    if (attack_timer == 0) {
        battle_state = BattleState.DEFEND_SOLVE;
        defend_timer = defend_timer_max;
        player_input = "";
        
        // --- EASIER PROBLEM GENERATION (0-9 only) ---
        if (irandom(1) == 0) {
            var a = irandom_range(1, 12);
            var b = irandom_range(1, 12);
            problem_answer = a + b;
            problem_question = string(a) + " + " + string(b) + " = ?";
        } else {
            var a = irandom_range(5, 9);
            var b = irandom_range(1, a);
            problem_answer = a - b;
            problem_question = string(a) + " - " + string(b) + " = ?";
        }
        
        fairy_text = "Quick! Solve the easy equation to raise your shield!";
    }
}

// 4. PLAYER INPUT - ATTACK MENU & TARGETING
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0) {
    
    var trigger_math_gen = false; // Local flag to transition to solving

    if (!targeting_phase) {
        // --- SKILL SELECTION PHASE ---
        if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
        if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
        if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
        if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;
        
        var skill_map = [1, 2, 3, 4]; 
        if (skill_map[menu_index] == 1) {
            fairy_text = "Provides heal to one party member: Click on Add it up!, and we can solve the problem together! For this spell, you\u0027ll\nneed to put two numbers together. For example! If you have 3 bows and I have 6 bows, if we put our bows together then we" + chr(39) +"d have 9 bows.";
        } else if (skill_map[menu_index] == 2) {
            fairy_text = "Deals damage to one enemy: In order to use Sub-tract the health, you need to remove the\nsecond number from the first number!\nYou can think of it like this: If I had 3 apples, and I gave 1 of them to you, I" + chr(39) + "d be left with 2 apples.";
        } else if (skill_map[menu_index] == 3) {
            fairy_text = "Provides party heal: In order to do this you just need to add a bunch of numbers together! It doesn\u0027t matter what \norder that you do it in. For example if I have 10 cookies, you give me 5, and a friend of mine gives me 5 I" + chr(39) + "d end up\nwith 20! It doesn\u0027t matter if my friend gives it to me first or you give it to me first,\nI\u0027ll still end up with the same amount of cookies!";
        } else {
            fairy_text = "Multi-target attack: This is pretty similar to Sub-tract the health!, but now you\u0027ll be subtracting multiple smaller\nnumbers from one bigger number! If you need a way to think about it, if I have 38 cupcakes, I give 3 to you, and I give \n5 to a friend of mine I\u0027ll have 38-3-5 cupcakes, which means I" + chr(39) + "d be left with 30 cupcakes!";
        }
        
        if (keyboard_check_pressed(vk_enter)) {
            selected_skill = menu_index + 1;
            
            // Only Skill 2 requires enemy targeting
            if (selected_skill == 2) {
                targeting_phase = true;
                if (array_length(enemies) > 0 && enemies[target_index][1] <= 0) {
                    for (var i = 0; i < array_length(enemies); i++) {
                        if (enemies[i][1] > 0) { target_index = i; break; }
                    }
                }
            } else {
                trigger_math_gen = true; // Skip targeting
            }
        }
    } else {
        // --- ENEMY TARGETING PHASE (Only for Skill 2) ---
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_right)) {
            var start_idx = target_index;
            for (var i = 1; i < array_length(enemies); i++) {
                var check_idx = (start_idx + i) % array_length(enemies);
                if (enemies[check_idx][1] > 0) { target_index = check_idx; break; }
            }
        }
        if (keyboard_check_pressed(vk_left)) {
            var start_idx = target_index;
            for (var i = 1; i < array_length(enemies); i++) {
                var check_idx = (start_idx - i + array_length(enemies)) % array_length(enemies);
                if (enemies[check_idx][1] > 0) { target_index = check_idx; break; }
            }
        }

        if (keyboard_check_pressed(vk_enter)) {
            targeting_phase = false; 
            trigger_math_gen = true; 
        }
        
        if (keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_escape)) {
            targeting_phase = false;
        }
    }
    
    // --- MATH GENERATION TRIGGER ---
    if (trigger_math_gen) {
        generate_problem(selected_skill, 0);
        player_input = "";
        spell_timer = spell_timer_max;
        battle_state = BattleState.PLAYER_SOLVE;
        fairy_text = "Solve it to cast your spell!";
    }
}

// 6. TYPING THE ANSWER 
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    
    for (var i = 0; i <= 9; i++) { if (keyboard_check_pressed(ord(string(i)))) player_input += string(i); }
    if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

    // If Attacking
    if (battle_state == BattleState.PLAYER_SOLVE) {
        spell_timer--;
        if (spell_timer <= 0) { 
            attack_timer = 240; 
            battle_state = BattleState.ENEMY_TURN; 
            fairy_text = "Time\u0027s up! You missed your turn!";
        }

        if (keyboard_check_pressed(vk_enter) && player_input != "") {
            if (real(player_input) == problem_answer) {
                
                // --- TRIGGER ADDELINE ATTACK ANIMATION ---
                addeline_is_attacking = true;
                if (selected_skill == 1) {        // Additive Heal
                    addeline_frame = 24; addeline_anim_end = 38;
                } else if (selected_skill == 2) { // Subtraction
                    addeline_frame = 10; addeline_anim_end = 24;
                } else if (selected_skill == 3) { // Commutative
                    addeline_frame = 52; addeline_anim_end = 67;
                } else if (selected_skill == 4) { // Double Sub
                    addeline_frame = 38; addeline_anim_end = 52;
                }
                
                if (selected_skill == 1) {
                    player_hp += 20; 
                    player_flash_color = c_green; player_flash_alpha = 1.0; // Green Heal Flash
                } else if (selected_skill == 2) {
                    // Deal damage only to targeted enemy
                    if (enemies[target_index][1] > 0) { 
                        enemies[target_index][1] -= 15; 
                        enemies[target_index][7] = c_red; 
                        enemies[target_index][8] = 1.0; 
                    } 
                } else {
                    // Deal damage to all enemies (AoE)
                    for (var i = 0; i < array_length(enemies); i++) { 
                        if (enemies[i][1] > 0) {
                            enemies[i][1] -= 15; 
                            enemies[i][7] = c_red; // Enemy Hit Flash Color
                            enemies[i][8] = 1.0;   // Enemy Hit Flash Alpha
                        }
                    } 
                }
                
                var enemies_dead = true;
                for (var i = 0; i < array_length(enemies); i++) { 
                    if (enemies[i][1] > 0) enemies_dead = false; 
                }
                
                if (enemies_dead) {
                    attack_timer = 0; 
                    battle_state = BattleState.PLAYER_MENU; 
                } else {
                    attack_timer = 420; 
                    battle_state = BattleState.ENEMY_TURN;
                }
                
            } else { 
                player_input = ""; 
            }
        }
    }

    // If Defending
    if (battle_state == BattleState.DEFEND_SOLVE) {
        defend_timer -= 0.5; // Decreases at half speed compared to the attack timer
        var missed_defense = false;

        if (keyboard_check_pressed(vk_enter) && player_input != "") {
            if (real(player_input) == problem_answer) {
                fairy_text = "Perfect Block! Your turn!";
                battle_state = BattleState.PLAYER_MENU;
                menu_index = 0;
                player_flash_color = c_white; player_flash_alpha = 1.0; // White Shield Flash
            } else {
                missed_defense = true;
            }
        }

        if (defend_timer <= 0) {
            missed_defense = true;
        }

        if (missed_defense) {
            var total_dmg = 0;
            for (var i = 0; i < array_length(enemies); i++) {
                if (enemies[i][1] > 0) total_dmg += 6; 
            }
            player_hp -= total_dmg;
            fairy_text = "Ouch! You took damage! Your turn!";
            battle_state = BattleState.PLAYER_MENU;
            menu_index = 0;
            player_flash_color = c_red; player_flash_alpha = 1.0; // Red Hurt Flash
        }
    }
}

// 7. WAVE & VICTORY LOGIC 
var all_dead = true;
for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) all_dead = false; }

if (all_dead && attack_timer <= 0 && battle_state == BattleState.PLAYER_MENU) {
    if (current_wave < max_waves) {
        if (win_timer == -1) { win_timer = 120; fairy_text = "Well done! That\u0027s one wave down!"; }
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) {
            current_wave++;
            fairy_text = "Oh no! More enemies are appearing!";
            
            // WAVE CONFIGURATIONS
            if (current_wave == 2) {
                enemies = [ 
                    ["Linearf", 30, room_width - 300, 710, Linearf, 0, 1.0, c_white, 0.0], 
                    ["Parabolate", 30, room_width - 600, 840, Parabolate, 0, 1.0, c_white, 0.0] 
                ];
            } else if (current_wave == 3) {
                enemies = [ 
                    ["GoldmanTall", 30, room_width - 300, 710, GoldmanTall, 0, 1.0, c_white, 0.0], 
                    ["Parabolate", 30, room_width - 600, 840, Parabolate, 0, 1.0, c_white, 0.0] 
                ];
            }
            win_timer = -1;
        }
    } else {
        if (win_timer == -1) win_timer = 180;
        fairy_text = "You did it! The area is clear!";
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) room_goto(rm_Level1PostBattle);
    }
}