// ==========================================
// 0. ANIMATION & EFFECT LOGIC
// ==========================================
// Addeline
if (addeline_is_attacking) {
    addeline_frame += 0.5; 
    if (addeline_frame >= addeline_anim_end) { addeline_is_attacking = false; addeline_frame = 0; }
} else {
    addeline_frame += 0.2; 
    if (addeline_frame >= 10 || addeline_frame < 0) addeline_frame = 0; 
}

// Milly
if (milly_is_attacking) {
    milly_frame += 0.5;
    if (milly_frame >= milly_anim_end) { milly_is_attacking = false; milly_frame = 0; }
} else {
    milly_frame += 0.2;
    if (milly_frame >= 10 || milly_frame < 0) milly_frame = 0;
}

// Player Flash Decay
if (player_flash_alpha > 0) player_flash_alpha -= 0.05;
if (milly_flash_alpha > 0) milly_flash_alpha -= 0.05;

// Enemies
for (var i = 0; i < array_length(enemies); i++) {
    if (enemies[i][1] > 0) { 
        enemies[i][5] += 0.2; 
        if (enemies[i][5] >= 10) enemies[i][5] = 0;
        if (enemies[i][8] > 0) enemies[i][8] -= 0.05; // Enemy Flash Decay
    } else {
        if (enemies[i][6] > 0) enemies[i][6] -= 0.02; // Enemy Death Fade
        enemies[i][7] = c_red;
        enemies[i][8] = 1.0;
    }
}

// --- 1. TYPEWRITER EFFECT ---
if (fairy_text != previous_fairy_text) { 
    text_progress = 0; 
    previous_fairy_text = fairy_text; 
}
if (text_progress < string_length(fairy_text)) text_progress += text_speed;

// --- 2. ENEMY ATTACK TIMER & INSTANT DEFENSE ---
if (battle_state == BattleState.ENEMY_TURN) {
    if (attack_timer > 0) {
        attack_timer--;
    } else {
        battle_state = BattleState.DEFEND_SOLVE;
        defend_timer = defend_timer_max;
        player_input = "";
        fairy_text = "Bria: Incoming attack! Solve this quickly to block!";
        
        var op = irandom(3); 
        if (op == 0) {
            problem_val1 = irandom_range(15, 60); problem_val2 = irandom_range(15, 60);
            problem_answer = problem_val1 + problem_val2;
            problem_question = string(problem_val1) + " + " + string(problem_val2) + " = ?";
        } else if (op == 1) {
            problem_val1 = irandom_range(40, 100); problem_val2 = irandom_range(10, problem_val1);
            problem_answer = problem_val1 - problem_val2;
            problem_question = string(problem_val1) + " - " + string(problem_val2) + " = ?";
        } else if (op == 2) {
            problem_val1 = irandom_range(3, 12); problem_val2 = irandom_range(3, 12);
            problem_answer = problem_val1 * problem_val2;
            problem_question = string(problem_val1) + " x " + string(problem_val2) + " = ?";
        } else if (op == 3) {
            problem_val2 = irandom_range(3, 10); problem_answer = irandom_range(3, 12);
            problem_val1 = problem_answer * problem_val2;
            problem_question = string(problem_val1) + " / " + string(problem_val2) + " = ?";
        }
    }
}

// --- 3. MENU NAVIGATION & TARGETING ---
if (battle_state == BattleState.PLAYER_MENU && win_timer <= 0) {
    
    var trigger_math_gen = false; // Local flag to smoothly transition to solving
    
    if (!targeting_phase) {
        // --- SKILL SELECTION PHASE ---
        if (is_tutorial) {
            menu_index = milly_tutorial_step; // Lock to tutorial
        } else {
            if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
            if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
            if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
            if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;
        }

        if (keyboard_check_pressed(vk_enter)) {
            selected_skill = menu_index + 1;
            
            // Only Skill 2 requires enemy targeting. Heals/AoEs skip straight to math!
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
        player_input = ""; 
        spell_timer = spell_timer_max;
        battle_state = BattleState.PLAYER_SOLVE;
        
        // Generate problems based on specific skills
        if (active_char == 0) { // Addeline
            if (selected_skill == 1) { // 1 + 1 = 2
                problem_val1 = irandom_range(2, 20); problem_val2 = irandom_range(2, 20);
                problem_answer = problem_val1 + problem_val2;
                problem_question = string(problem_val1) + " + " + string(problem_val2) + " = ?";
            } else if (selected_skill == 2) { // 3 - 2 = 1
                problem_val1 = irandom_range(10, 40); problem_val2 = irandom_range(1, problem_val1 - 1);
                problem_answer = problem_val1 - problem_val2;
                problem_question = string(problem_val1) + " - " + string(problem_val2) + " = ?";
            } else if (selected_skill == 3) { // 3 + 4 + 5 = 12
                problem_val1 = irandom_range(2, 12); problem_val2 = irandom_range(2, 12); problem_val3 = irandom_range(2, 12);
                problem_answer = problem_val1 + problem_val2 + problem_val3;
                problem_question = string(problem_val1) + " + " + string(problem_val2) + " + " + string(problem_val3) + " = ?";
            } else if (selected_skill == 4) { // 10 - 5 - 2 = 3
                problem_val1 = irandom_range(20, 50); problem_val2 = irandom_range(2, 10); problem_val3 = irandom_range(2, 10);
                problem_answer = problem_val1 - problem_val2 - problem_val3;
                problem_question = string(problem_val1) + " - " + string(problem_val2) + " - " + string(problem_val3) + " = ?";
            }
        } else { // Milly
            if (selected_skill == 1) { // 4 * 5 = 20
                problem_val1 = irandom_range(3, 12); problem_val2 = irandom_range(3, 12);
                problem_answer = problem_val1 * problem_val2;
                problem_question = string(problem_val1) + " x " + string(problem_val2) + " = ?";
            } else if (selected_skill == 2) { // 9 / 3 = 3
                problem_val2 = irandom_range(2, 12); problem_answer = irandom_range(2, 12);
                problem_val1 = problem_answer * problem_val2; // Guarantees clean division
                problem_question = string(problem_val1) + " / " + string(problem_val2) + " = ?";
            } else if (selected_skill == 3) { // 3(2 + 6)
                problem_val1 = irandom_range(2, 6); problem_val2 = irandom_range(1, 6); problem_val3 = irandom_range(1, 6);
                problem_answer = problem_val1 * (problem_val2 + problem_val3);
                problem_question = string(problem_val1) + "(" + string(problem_val2) + " + " + string(problem_val3) + ") = ?";
            } else if (selected_skill == 4) { // 15 / 2 = 7.5 (Forces odd numbers so it always ends in .5)
                var temp_base = irandom_range(3, 12);
                problem_val1 = (temp_base * 2) + 1; // Makes it odd
                problem_answer = problem_val1 / 2;
                problem_question = string(problem_val1) + " / 2 = ?";
            }
        }
    }
}

// --- 4. SOLVING MATH ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    
    // Typing Logic
    for (var i = 0; i <= 9; i++) { 
        if (keyboard_check_pressed(ord(string(i)))) player_input += string(i); 
    }
    if (keyboard_check_pressed(190) || keyboard_check_pressed(110)) player_input += "."; 
    if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

    var is_defending = (battle_state == BattleState.DEFEND_SOLVE);
    if (is_defending) defend_timer--; else spell_timer--;

    // Time's Up Logic (Failed)
    if (spell_timer <= 0 && !is_defending) { 
        fairy_text = "Bria: Too slow! Brace yourself!";
        attack_timer = 120; 
        battle_state = BattleState.ENEMY_TURN; 
    }
    if (defend_timer <= 0 && is_defending) { 
        fairy_text = "Bria: Ouch! We took a hit!";
        player_hp = max(0, player_hp - 15); milly_hp = max(0, milly_hp - 15); 
        player_flash_color = c_red; player_flash_alpha = 1.0;
        milly_flash_color = c_red; milly_flash_alpha = 1.0;
        battle_state = BattleState.PLAYER_MENU; 
        active_char = 0; // Reset back to Addeline
    }

    // Submitting an Answer
    if (keyboard_check_pressed(vk_enter) && player_input != "") {
        
        if (real(player_input) == problem_answer) {
            // --- CORRECT ANSWER ---
            if (is_defending) {
                battle_state = BattleState.PLAYER_MENU;
                fairy_text = "Bria: Great block! Addeline, you're up!";
                active_char = 0; // Reset back to Addeline
                player_flash_color = c_white; player_flash_alpha = 1.0;
                milly_flash_color = c_white; milly_flash_alpha = 1.0;
            } else {
                
                // Determine effect based on character
                if (active_char == 0) { // ADDELINE
                    addeline_is_attacking = true;
                    
                    if (selected_skill == 1) { 
                        addeline_frame = 24; addeline_anim_end = 38; 
                        if (player_hp <= milly_hp) player_hp = min(player_hp + 20, player_max_hp); 
                        else milly_hp = min(milly_hp + 20, milly_max_hp);
                        player_flash_color = c_green; player_flash_alpha = 1.0;
                    } else if (selected_skill == 2) { 
                        addeline_frame = 10; addeline_anim_end = 24; 
                        if (enemies[target_index][1] > 0) { 
                            enemies[target_index][1] -= 15; 
                            enemies[target_index][7] = c_white; 
                            enemies[target_index][8] = 1.0; 
                        } 
                    } else if (selected_skill == 3) { 
                        addeline_frame = 52; addeline_anim_end = 67; 
                        player_hp = min(player_hp + 15, player_max_hp); milly_hp = min(milly_hp + 15, milly_max_hp);
                        player_flash_color = c_green; player_flash_alpha = 1.0;
                        milly_flash_color = c_green; milly_flash_alpha = 1.0;
                    } else if (selected_skill == 4) { 
                        addeline_frame = 38; addeline_anim_end = 52; 
                        for (var i = 0; i < array_length(enemies); i++) { 
                            if (enemies[i][1] > 0) { enemies[i][1] -= 15; enemies[i][7] = c_white; enemies[i][8] = 1.0; } 
                        }
                    }
                } 
                else if (active_char == 1) { // MILLY
                    milly_is_attacking = true;
                    
                    if (selected_skill == 1) { 
                        milly_frame = 10; milly_anim_end = 25; milly_heal_buff = 3; 
                        milly_flash_color = c_yellow; milly_flash_alpha = 1.0;
                    } else if (selected_skill == 2) { 
                        milly_frame = 25; milly_anim_end = 40; 
                        if (enemies[target_index][1] > 0) { 
                            enemies[target_index][1] -= 15; 
                            enemies[target_index][7] = c_white; 
                            enemies[target_index][8] = 1.0; 
                        } 
                    } else if (selected_skill == 3) { 
                        milly_frame = 40; milly_anim_end = 55; party_buff = 3; 
                        player_flash_color = c_yellow; player_flash_alpha = 1.0;
                        milly_flash_color = c_yellow; milly_flash_alpha = 1.0;
                    } else if (selected_skill == 4) { 
                        milly_frame = 55; milly_anim_end = 71; enemy_debuff = 3; 
                        for (var i = 0; i < array_length(enemies); i++) {
                            if (enemies[i][1] > 0) { enemies[i][7] = c_fuchsia; enemies[i][8] = 1.0; }
                        }
                    }

                    // Advance Tutorial
                    if (is_tutorial && selected_skill == (milly_tutorial_step + 1)) {
                        milly_tutorial_step++;
                        is_tutorial = (milly_tutorial_step < 4); 

                        if (milly_tutorial_step == 1) fairy_text = "Bria: Excellent! <Skill 2> damages enemies using division. Try it!";
                        else if (milly_tutorial_step == 2) fairy_text = "Bria: Nice! <Skill 3> uses the distributive property. Add the inside, then multiply the outside!";
                        else if (milly_tutorial_step == 3) fairy_text = "Bria: <Skill 4> debuffs enemies. Divide by 2. Don't forget the .5 decimal!";
                        else if (milly_tutorial_step == 4) {
                            fairy_text = "Bria: Tutorial done! Let's get them, Addeline!";
                            is_tutorial = false;
                        }
                    }
                }

                var enemies_dead = true;
                for (var i = 0; i < array_length(enemies); i++) { 
                    if (enemies[i][1] > 0) enemies_dead = false; 
                }
                
                if (enemies_dead && is_tutorial) {
                    enemies[0][1] = 30; // Keep enemies alive so tutorial doesn't break
                    enemies_dead = false;
                }

                // --- TURN LOGIC & SWITCHING ---
                if (!is_tutorial && enemies_dead) { 
                    attack_timer = 0;
                    battle_state = BattleState.PLAYER_MENU;
                    active_char = 0; // Reset back to Addeline for the next wave
                } else if (!is_tutorial) {
                    if (active_char == 0) {
                        active_char = 1; // Hand it over to Milly
                        battle_state = BattleState.PLAYER_MENU;
                        menu_index = 0;
                        fairy_text = "Bria: Nice hit! Milly, your turn!";
                    } else {
                        attack_timer = 120; // Enemy Turn
                        battle_state = BattleState.ENEMY_TURN; 
                        active_char = 0; // Prepare Addeline for next round
                    }
                } else {
                    battle_state = BattleState.PLAYER_MENU; // Stay in menu for tutorial
                }
            }
        } else { 
            // --- WRONG ANSWER HINTS ---
            player_input = ""; 
            if (is_defending) {
                fairy_text = "Bria: Block the attack! Re-check your math!";
            } else if (active_char == 0) {
                if (selected_skill == 1) fairy_text = "Bria: Hint! Try counting up from " + string(problem_val1) + ".";
                else if (selected_skill == 2) fairy_text = "Bria: Hint! Take " + string(problem_val2) + " away from " + string(problem_val1) + ".";
                else if (selected_skill == 3) fairy_text = "Bria: Hint! Add " + string(problem_val1) + " and " + string(problem_val2) + " first, then add " + string(problem_val3) + ".";
                else if (selected_skill == 4) fairy_text = "Bria: Hint! Take " + string(problem_val2) + " away from " + string(problem_val1) + " first.";
            } else {
                if (selected_skill == 1) fairy_text = "Bria: Hint! What is " + string(problem_val1) + " groups of " + string(problem_val2) + "?";
                else if (selected_skill == 2) fairy_text = "Bria: Hint! How many times does " + string(problem_val2) + " fit into " + string(problem_val1) + "?";
                else if (selected_skill == 3) fairy_text = "Bria: Hint! Add " + string(problem_val2) + " and " + string(problem_val3) + " first, then multiply by " + string(problem_val1) + "!";
                else if (selected_skill == 4) fairy_text = "Bria: Hint! Think of it like money. What's half of " + string(problem_val1) + "? Don't forget the .5!";
            }
        }
    }
}

// --- 5. WAVE & VICTORY LOGIC ---
var all_dead = true;
for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) all_dead = false; }

if (all_dead && attack_timer <= 0 && battle_state == BattleState.PLAYER_MENU && !is_tutorial) {
    if (current_wave < max_waves) {
        if (win_timer == -1) { win_timer = 120; fairy_text = "Bria: Well done! That's one wave down!"; }
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) {
            current_wave++;
            fairy_text = "Bria: Watch out! More enemies are appearing!";
            
            // --- 4 WAVES SETUP ---
            if (current_wave == 2) {
                enemies = [ 
                    ["GoldmanShort", 30, room_width-450, 710, GoldmanShort, 0, 1.0, c_white, 0.0], 
                    ["GoldmanTall", 30, room_width-250, 840, GoldmanTall, 0, 1.0, c_white, 0.0]
                ];
            } else if (current_wave == 3) {
                enemies = [ 
                    ["Ananan", 30, room_width-450, 710, Ananan, 0, 1.0, c_white, 0.0], 
                    ["Ananan", 30, room_width-250, 840, Ananan, 0, 1.0, c_white, 0.0], 
                    ["Linearf", 30, room_width-640, 840, Linearf, 0, 1.0, c_white, 0.0] 
                ];
            } else if (current_wave == 4) {
                enemies = [ 
                    ["GoldmanShort", 30, room_width-450, 710, GoldmanShort, 0, 1.0, c_white, 0.0], 
                    ["GoldmanTall", 30, room_width-250, 840, GoldmanTall, 0, 1.0, c_white, 0.0], 
                    ["Ananan", 30, room_width-640, 840, Ananan, 0, 1.0, c_white, 0.0] 
                ];
            }
            win_timer = -1;
        }
    } else {
        if (win_timer == -1) win_timer = 180;
        fairy_text = "Bria: You did it! The area is clear!";
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) room_goto(rm_Level2PostBattle);
    }
}