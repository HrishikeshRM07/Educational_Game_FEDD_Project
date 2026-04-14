// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape) && !targeting_phase) room_goto(rm_Level4_PostBattle);

// ==========================================
// 0. ANIMATION & EFFECT LOGIC
// ==========================================
// Health Clamping
player_hp = clamp(player_hp, 0, player_max_hp);
milly_hp = clamp(milly_hp, 0, milly_max_hp);
erin_hp = clamp(erin_hp, 0, erin_max_hp);

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

// Flash Decays
if (player_flash_alpha > 0) player_flash_alpha -= 0.05;
if (milly_flash_alpha > 0) milly_flash_alpha -= 0.05;
if (erin_flash_alpha > 0) erin_flash_alpha -= 0.05;

for (var i = 0; i < array_length(enemies); i++) {
    if (enemies[i][1] > 0) { 
        enemies[i][5] += 0.2; if (enemies[i][5] >= 10) enemies[i][5] = 0;
        if (enemies[i][8] > 0) enemies[i][8] -= 0.05; // Enemy Flash Decay
    } else {
        // DEATH ANIMATION: Flash decays normally while alpha fades out
        if (enemies[i][8] > 0) enemies[i][8] -= 0.05; 
        if (enemies[i][6] > 0) enemies[i][6] -= 0.05; // Sped up the fade out slightly
    }
}

// --- 1. TYPEWRITER EFFECT ---
if (fairy_text != previous_fairy_text) { 
    text_progress = 0; previous_fairy_text = fairy_text; 
}
if (text_progress < string_length(fairy_text)) text_progress += text_speed;

// --- 2. ENEMY ATTACK TIMER ---
if (battle_state == BattleState.ENEMY_TURN) {
    if (attack_timer > 0) {
        attack_timer--;
    } else {
        // Skip DEFEND_MENU and go straight to solving
        battle_state = BattleState.DEFEND_SOLVE;
        player_input = "";
        defend_timer = defend_timer_max;
        fairy_text = "Quick! Solve this to block!";
        
        // DEFEND MATH LOGIC (Random Operations)
        var op = irandom(3); 
        if (op == 0) {
            problem_val1 = irandom_range(15, 60); problem_val2 = irandom_range(15, 60); problem_answer = problem_val1 + problem_val2;
            problem_question = string(problem_val1) + " + " + string(problem_val2) + " = ?";
        } else if (op == 1) {
            problem_val1 = irandom_range(40, 100); problem_val2 = irandom_range(10, problem_val1); problem_answer = problem_val1 - problem_val2;
            problem_question = string(problem_val1) + " - " + string(problem_val2) + " = ?";
        } else if (op == 2) {
            problem_val1 = irandom_range(3, 12); problem_val2 = irandom_range(3, 12); problem_answer = problem_val1 * problem_val2;
            problem_question = string(problem_val1) + " x " + string(problem_val2) + " = ?";
        } else if (op == 3) {
            problem_val2 = irandom_range(3, 10); problem_answer = irandom_range(3, 12); problem_val1 = problem_answer * problem_val2;
            problem_question = string(problem_val1) + " / " + string(problem_val2) + " = ?";
        }
    }
}

// --- 3. MENU NAVIGATION & TARGETING ---
if (battle_state == BattleState.PLAYER_MENU && win_timer <= 0) {
    
    var trigger_math_gen = false;
    
    if (!targeting_phase) {
        // --- SKILL SELECTION ---
        if (is_tutorial && battle_state == BattleState.PLAYER_MENU) {
            menu_index = erin_tutorial_step; 
        } else {
            if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
            if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
            if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
            if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;
			var skill_map = [1, 2, 3, 4]; 
			if (active_char == 0) {
				if (skill_map[menu_index] == 1) {
					fairy_text = "Provides heal to one party member: Click on Add it up!, and we can solve the problem together! For this spell, you\u0027ll need to put two numbers together. For example! If you have 3 bows and I have 6 bows, if we put our bows together then we" + chr(39) +"d have 9 bows.";
				} else if (skill_map[menu_index] == 2) {
					fairy_text = "Deals damage to one enemy: In order to use Sub-tract the health, you need to remove the second number from the first number! You can think of it like this: If I had 3 apples, and I gave 1 of them to you, I" + chr(39) + "d be left with 2 apples.";
				} else if (skill_map[menu_index] == 3) {
					fairy_text = "Provides party heal: In order to do this you just need to add a bunch of numbers together! It doesn\u0027t matter what order that you do it in. For example if I have 10 cookies, you give me 5, and a friend of mine gives me 5 I" + chr(39) + "d end up with 20! It doesn\u0027t matter if my friend gives it to me first or you give it to me first, I\u0027ll still end up with the same amount of cookies!";
				} else {
					fairy_text = "Multi-target attack: This is pretty similar to Sub-tract the health!, but now you\u0027ll be subtracting multiple smaller numbers from one bigger number! If you need a way to think about it, if I have 38 cupcakes, I give 3 to you, and I give 5 to a friend of mine I\u0027ll have 38-3-5 cupcakes, which means I" + chr(39) + "d be left with 30 cupcakes!";
				}
			} else if (active_char == 1) {
				if (skill_map[menu_index] == 1) {
					fairy_text = "Boosts the amount of HP that can be healed to one party member (lasts 3 turns). You can think of multiplying something a bit like adding the same number over and over. If I have 10 strawberries, and I double (multiply by 2) that amount, then I\u0027ll end up with 20 strawberries, which is the same as 10 + 10! Now you give it a try";
				} else if (skill_map[menu_index] == 2) {
					fairy_text = "Deals damage to one enemy: To use this skill, we need to use division. Think of it like how many times one number can go into another number! For example, if I have 6 cakes, and the recipe says I need to use 2 then I\u0027ll be putting in the eggs 3 times!";
				} else if (skill_map[menu_index] == 3) {
					fairy_text = "Provides defense & damage buff to whole party (lasts 3 turns): This means that your next attacks will hit harder and any damage taken. In order to do this, we\u0027ll need to use the distributive property! That means multiplying everything that\u0027s outside the parentheses to what\u0027s inside of the parentheses. For example, if I need to triple the cookies that two sets of partners have, I" + chr(39) + "d write it as 3(2 + 2), and to distribute it I" + chr(39) + "d multiply each 2 by 3. This would get me 6 + 6, which gives me 12!";
				} else {
					fairy_text = "Provides defense & damage debuff to all enemies (lasts 3 turns): For this, we’re going to divide, but we may not get a whole number. For example if I have 15 apples and I\u0027m breaking it up into sets of twos, I\u0027ll have 7 sets of two apples with 1 apple remaining, which means that I\u0027ll have half a set. This means the answer to 15 " + chr(247) + " 2 is 7.5 sets of apples!";
				}
			} else {
				if (skill_map[menu_index] == 1) {
					fairy_text = "Doubles damage of Erin\u0027s next attack: When something is squared, that means you\u0027re multiplying it by itself one time. For example, if I have 3\u00B2 that means that I have 3 x 3, which equals 9! You can think of the number in the exponent as the number of times something will multiply by itself. But be careful! You can\u0027t add numbers when you do exponents, you can only multiply them.";
				} else if (skill_map[menu_index] == 2) {
					fairy_text = "Deals damage to one enemy, drains 5 of Erin’s HP: Deals damage to your enemy! You can think of it like the opposite of squaring something. When you have a number inside of " + chr(8730) + " that means you\u0027re finding out what multiplied by itself equals the number inside of " + chr(8730) + ". For example, if I need to find the square root of 64, or " + chr(8730) + "64, I know that 8 x 8 is 64, so the " + chr(8730) + "64 should be 8!";
				} else if (skill_map[menu_index] == 3) {
					fairy_text = "Multi-hit attack (for each additional power, Erin gets another hit on the enemy):  For example, if I have 2\u00B3, that\u0027s 2 x 2 x 2, which is the same as 4 x 2, leading me to an answer of 8! And since we\u0027re raising 2 to the third power, Erin will get 3 hits on the enemy!";
				} else {
					fairy_text = "Erin drains HP of the targeted enemy and heals herself: It\u0027s used by identifying what a perfect square is made from! For example, if I have the equation x\u00B2 - 4, where x can be any number you want it to be, then I know that its the same as (x+2)(x-2) because when I distribute, (x + 2) to (x - 2), I get back to x\u00B2 - 4!";
				}
			}
		}

        if (keyboard_check_pressed(vk_enter)) {
            selected_skill = menu_index + 1;
            
            // Skill 2 requires targeting (unless defending)
            if (selected_skill == 2 && battle_state == BattleState.PLAYER_MENU) {
                targeting_phase = true;
                if (array_length(enemies) > 0 && enemies[target_index][1] <= 0) {
                     for (var i = 0; i < array_length(enemies); i++) {
                         if (enemies[i][1] > 0) { target_index = i; break; }
                     }
                }
            } else {
                trigger_math_gen = true; // Auto-target / AoE skips phase
            }
        }
    } else {
        // --- ENEMY TARGETING PHASE ---
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
            targeting_phase = false; trigger_math_gen = true; 
        }
        if (keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_escape)) {
            targeting_phase = false;
        }
    }
    
    // --- MATH GENERATION TRIGGER ---
    if (trigger_math_gen) {
        player_input = ""; 
        
        if (battle_state == BattleState.PLAYER_MENU) {
            spell_timer = spell_timer_max;
            battle_state = BattleState.PLAYER_SOLVE;
            
            // PLAYER SKILL MATH LOGIC
            if (active_char == 0) { // Addeline
                if (selected_skill == 1) { 
                    problem_val1 = irandom_range(2, 20); problem_val2 = irandom_range(2, 20);
                    problem_answer = problem_val1 + problem_val2;
                    problem_question = string(problem_val1) + " + " + string(problem_val2) + " = ?";
                } else if (selected_skill == 2) { 
                    problem_val1 = irandom_range(10, 40); problem_val2 = irandom_range(1, problem_val1 - 1);
                    problem_answer = problem_val1 - problem_val2;
                    problem_question = string(problem_val1) + " - " + string(problem_val2) + " = ?";
                } else if (selected_skill == 3) { 
                    problem_val1 = irandom_range(2, 12); problem_val2 = irandom_range(2, 12); problem_val3 = irandom_range(2, 12);
                    problem_answer = problem_val1 + problem_val2 + problem_val3;
                    problem_question = string(problem_val1) + " + " + string(problem_val2) + " + " + string(problem_val3) + " = ?";
                } else if (selected_skill == 4) { 
                    problem_val1 = irandom_range(20, 50); problem_val2 = irandom_range(2, 10); problem_val3 = irandom_range(2, 10);
                    problem_answer = problem_val1 - problem_val2 - problem_val3;
                    problem_question = string(problem_val1) + " - " + string(problem_val2) + " - " + string(problem_val3) + " = ?";
                }
            } else if (active_char == 1) { // Milly
                if (selected_skill == 1) { 
                    problem_val1 = irandom_range(3, 12); problem_val2 = irandom_range(3, 12);
                    problem_answer = problem_val1 * problem_val2;
                    problem_question = string(problem_val1) + " x " + string(problem_val2) + " = ?";
                } else if (selected_skill == 2) { 
                    problem_val2 = irandom_range(2, 12); problem_answer = irandom_range(2, 12);
                    problem_val1 = problem_answer * problem_val2; 
                    problem_question = string(problem_val1) + " / " + string(problem_val2) + " = ?";
                } else if (selected_skill == 3) { 
                    problem_val1 = irandom_range(2, 6); problem_val2 = irandom_range(1, 6); problem_val3 = irandom_range(1, 6);
                    problem_answer = problem_val1 * (problem_val2 + problem_val3);
                    problem_question = string(problem_val1) + "(" + string(problem_val2) + " + " + string(problem_val3) + ") = ?";
                } else if (selected_skill == 4) { 
                    var temp_base = irandom_range(3, 12); problem_val1 = (temp_base * 2) + 1; 
                    problem_answer = problem_val1 / 2;
                    problem_question = string(problem_val1) + " / 2 = ?";
                }
            } else if (active_char == 2) { // Erin
                if (selected_skill == 1) { // Square
                    problem_val1 = irandom_range(2, 12);
                    problem_answer = problem_val1 * problem_val1;
                    problem_question = string(problem_val1) + "² = ?";
                } else if (selected_skill == 2) { // Square Root
                    problem_answer = irandom_range(2, 12);
                    problem_val1 = problem_answer * problem_answer;
                    problem_question = "\u221A" + string(problem_val1) + " = ?";
                } else if (selected_skill == 3) { // Cube
                    problem_val1 = irandom_range(2, 5);
                    problem_answer = problem_val1 * problem_val1 * problem_val1;
                    problem_question = string(problem_val1) + "³ = ?";
                } else if (selected_skill == 4) { // Square Root (Harder for balance)
                    problem_answer = irandom_range(10, 20);
                    problem_val1 = problem_answer * problem_answer;
                    problem_question = "\u221A" + string(problem_val1) + " = ?";
                }
            }
        }
    }
}

// --- 4. SOLVING MATH ---
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    
    for (var i = 0; i <= 9; i++) { 
        if (keyboard_check_pressed(ord(string(i)))) player_input += string(i); 
    }
    if (keyboard_check_pressed(190) || keyboard_check_pressed(110)) player_input += "."; 
    if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

    var is_defending = (battle_state == BattleState.DEFEND_SOLVE);
    if (is_defending) defend_timer--; else spell_timer--;

    if (spell_timer <= 0 && !is_defending) { 
        fairy_text = "Too slow! Brace yourself!";
        attack_timer = 120; battle_state = BattleState.ENEMY_TURN; 
    }
    if (defend_timer <= 0 && is_defending) { 
        fairy_text = "Ouch! We took a hit!";
        player_hp -= 15; milly_hp -= 15; erin_hp -= 15;
        player_flash_color = c_red; player_flash_alpha = 1.0;
        milly_flash_color = c_red;  milly_flash_alpha = 1.0;
        erin_flash_color = c_red;   erin_flash_alpha = 1.0;
        battle_state = BattleState.PLAYER_MENU; 
    }

    if (keyboard_check_pressed(vk_enter) && player_input != "") {
        if (real(player_input) == problem_answer) {
            
            player_input = ""; 

            // --- CORRECT ANSWER ---
            if (is_defending) {
                battle_state = BattleState.PLAYER_MENU;
                fairy_text = "Great block! Now it\u0027s our turn.";
                player_flash_color = c_white; player_flash_alpha = 1.0; // WHITE = DEFEND
                milly_flash_color = c_white;  milly_flash_alpha = 1.0;
                erin_flash_color = c_white;   erin_flash_alpha = 1.0;
            } else {

                if (active_char == 0) { // ADDELINE
                    addeline_is_attacking = true;
                    if (selected_skill == 1) { 
                        addeline_frame = 24; addeline_anim_end = 38; 
                        player_hp = min(player_hp + 20, player_max_hp); 
                        player_flash_color = c_green; player_flash_alpha = 1.0; // GREEN = HEAL
                    }
                    else if (selected_skill == 2) { 
                        addeline_frame = 10; addeline_anim_end = 24; 
                        if (enemies[target_index][1] > 0) { enemies[target_index][1] -= 15; enemies[target_index][7] = c_red; enemies[target_index][8] = 1.0; } // RED = HURT
                    }
                    else if (selected_skill == 3) { 
                        addeline_frame = 52; addeline_anim_end = 67; 
                        player_hp = min(player_hp + 15, player_max_hp); 
                        milly_hp = min(milly_hp + 15, milly_max_hp);
                        erin_hp = min(erin_hp + 15, erin_max_hp);
                        player_flash_color = c_green; player_flash_alpha = 1.0; milly_flash_color = c_green; milly_flash_alpha = 1.0; erin_flash_color = c_green; erin_flash_alpha = 1.0; // GREEN = HEAL
                    }
                    else if (selected_skill == 4) { 
                        addeline_frame = 38; addeline_anim_end = 52; 
                        for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) { enemies[i][1] -= 15; enemies[i][7] = c_red; enemies[i][8] = 1.0; } } // RED = HURT
                    }
                } 
                else if (active_char == 1) { // MILLY
                    milly_is_attacking = true;
                    if (selected_skill == 1) { 
                        milly_frame = 10; milly_anim_end = 25; milly_heal_buff = 3; 
                        milly_flash_color = c_yellow; milly_flash_alpha = 1.0; // Buff color
                    }
                    else if (selected_skill == 2) { 
                        milly_frame = 25; milly_anim_end = 40; 
                        if (enemies[target_index][1] > 0) { enemies[target_index][1] -= 15; enemies[target_index][7] = c_red; enemies[target_index][8] = 1.0; } // RED = HURT
                    }
                    else if (selected_skill == 3) { 
                        milly_frame = 40; milly_anim_end = 55; party_buff = 3; 
                        player_flash_color = c_yellow; player_flash_alpha = 1.0; milly_flash_color = c_yellow; milly_flash_alpha = 1.0; erin_flash_color = c_yellow; erin_flash_alpha = 1.0; // Buff color
                    }
                    else if (selected_skill == 4) { 
                        milly_frame = 55; milly_anim_end = 71; enemy_debuff = 3; 
                        for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) { enemies[i][7] = c_fuchsia; enemies[i][8] = 1.0; } } // Debuff color
                    }
                }
                else if (active_char == 2) { // ERIN
                    erin_is_attacking = true;
                    var base_dmg = 20;
                    if (erin_dmg_boost) { base_dmg *= 2; erin_dmg_boost = false; }

                    if (selected_skill == 1) { 
                        erin_frame = 10; erin_anim_end = 25; erin_dmg_boost = true;
                        erin_flash_color = c_orange; erin_flash_alpha = 1.0; // Buff color
                    } 
                    else if (selected_skill == 2) { 
                        erin_frame = 26; erin_anim_end = 41; erin_hp -= 5;
                        erin_flash_color = c_red; erin_flash_alpha = 1.0; // RED = HURT (Self damage)
                        if (enemies[target_index][1] > 0) { enemies[target_index][1] -= base_dmg; enemies[target_index][7] = c_red; enemies[target_index][8] = 1.0; }  // RED = HURT
                    } 
                    else if (selected_skill == 3) { 
                        erin_frame = 42; erin_anim_end = 57; 
                        if (enemies[target_index][1] > 0) { enemies[target_index][1] -= (base_dmg + 10); enemies[target_index][7] = c_red; enemies[target_index][8] = 1.0; } // RED = HURT
                    } 
                    else if (selected_skill == 4) { 
                        erin_frame = 58; erin_anim_end = 72; erin_hp = min(erin_hp + 15, erin_max_hp);
                        erin_flash_color = c_green; erin_flash_alpha = 1.0; // GREEN = HEAL
                        if (enemies[target_index][1] > 0) { enemies[target_index][1] -= base_dmg; enemies[target_index][7] = c_red; enemies[target_index][8] = 1.0; } // RED = HURT
                    }

                    // Advance Tutorial
                    if (is_tutorial && selected_skill == (erin_tutorial_step + 1)) {
                        erin_tutorial_step++;
                        is_tutorial = (erin_tutorial_step < 4); 

                        if (erin_tutorial_step == 1) fairy_text = "Root of the Problem Deals damage to your enemy! You can think of it like the opposite of squaring something. When you have a number inside of " + chr(8730) + " that means you’re finding out what multiplied by itself equals the number inside of " + chr(8730) + ". For example, if I need to find the square root of 64, or " + chr(8730) + "64, I know that 8 x 8 is 64, so the " + chr(8730) + "64 should be 8!";
                        else if (erin_tutorial_step == 2) fairy_text = "Raised Powers lets Erin hit a single target multiple times! For each number above two that a number is raised to, Erin gets an additional hit on the enemy! For example, if I have 2" + chr(179) + ", that\u0027s 2 x 2 x 2, which is the same as 4 x 2, leading me to an answer of 8! And since we’re raising 2 to the third power, Erin will get 3 hits on the enemy!";
                        else if (erin_tutorial_step == 3) fairy_text = "Perfectlly Balanced allows Erin to take some of the enemies health for herself! It\u0027s used by identifying what a perfect square is made from! For example, if I have the equation x\u00B2 - 4, where x can be any number you want it to be, then I know that its the same as (x-2)(x+2) because when I distribute, (x - 2) to (x + 2), I get back to x\u00B2 + 4!";
                        else if (erin_tutorial_step == 4) { fairy_text = "That\u0027s all you need to know about Erin! Now finish this battle."; active_char = 0; battle_state = BattleState.PLAYER_MENU; }
                    }
                }

                var enemies_dead = true;
                for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) enemies_dead = false; }
                
                // Prevent enemies from dying during tutorial
                if (enemies_dead && is_tutorial) { enemies[0][1] = 40; enemies_dead = false; }

                // --- AUTOMATIC TURN SWITCHING LOGIC ---
                if (!is_tutorial && enemies_dead) { 
                    attack_timer = 0; battle_state = BattleState.PLAYER_MENU; active_char = 0;
                } else if (!is_tutorial) {
                    
                    if (erin_tutorial_step == 4 && active_char == 0) {
                        erin_tutorial_step = 5; 
                        battle_state = BattleState.PLAYER_MENU; 
                        menu_index = 0;
                    } else {
                        
                        if (active_char == 0) {
                            active_char = 1; 
                            battle_state = BattleState.PLAYER_MENU; 
                        } else if (active_char == 1) {
                            active_char = 2; 
                            battle_state = BattleState.PLAYER_MENU; 
                        } else {
                            attack_timer = 120; 
                            battle_state = BattleState.ENEMY_TURN; 
                            active_char = 0; 
                        }
                        
                        while (battle_state != BattleState.ENEMY_TURN && 
                               ((active_char == 0 && player_hp <= 0) || 
                                (active_char == 1 && milly_hp <= 0) || 
                                (active_char == 2 && erin_hp <= 0))) {
                            
                            active_char++;
                            if (active_char > 2) {
                                battle_state = BattleState.ENEMY_TURN;
                                attack_timer = 120;
                                active_char = 0;
                            }
                        }

                        if (battle_state == BattleState.PLAYER_MENU) {
                            menu_index = 0;
                            if (active_char == 1) fairy_text = "Nice hit! Milly, your turn!";
                            if (active_char == 2) fairy_text = "Awesome! Erin, finish it!";
                        }
                    }
                } else {
                    battle_state = BattleState.PLAYER_MENU; 
                }
            }
        } else { 
            // --- WRONG ANSWER ---
            player_input = ""; 
            if (is_defending) {
                fairy_text = "Block the attack! Re-check your math!";
            } else if (active_char == 0) {
                if (selected_skill == 1) fairy_text = "Hint! Try counting up from " + string(problem_val1) + ".";
                else if (selected_skill == 2) fairy_text = "Hint! Take " + string(problem_val2) + " away from " + string(problem_val1) + ".";
                else fairy_text = "Careful! Check your math again.";
            } else if (active_char == 1) {
                if (selected_skill == 1) fairy_text = "Hint! What is " + string(problem_val1) + " groups of " + string(problem_val2) + "?";
                else if (selected_skill == 2) fairy_text = "Hint! How many times does " + string(problem_val2) + " fit into " + string(problem_val1) + "?";
                else if (selected_skill == 3) fairy_text = "Hint! Multiply " + string(problem_val1) + " by both inside numbers, then add them.";
                else if (selected_skill == 4) fairy_text = "Hint! Half of " + string(problem_val1) + " is " + string(problem_val1 / 2) + ".";
            } else if (active_char == 2) {
                if (selected_skill == 1) fairy_text = "Hint! Multiply the number by itself.";
                else if (selected_skill == 2) fairy_text = "Hint! What number multiplied by itself equals " + string(problem_val1) + "?";
                else if (selected_skill == 3) fairy_text = "Hint! Multiply the number by itself three times.";
                else if (selected_skill == 4) fairy_text = "Hint! Find the square root of that number.";
            }
        }
    }
}

// --- 5. WAVE & DEFEAT LOGIC ---
var all_dead = true;
for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) all_dead = false; }

if (all_dead && attack_timer <= 0 && battle_state == BattleState.PLAYER_MENU && !is_tutorial) {
    if (current_wave < max_waves) {
        if (win_timer == -1) { win_timer = 120; fairy_text = "Well done! That\u0027s one wave down!"; }
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) {
            current_wave++;
            fairy_text = "Watch out! More enemies are appearing!";
            
            if (current_wave == 2) {
                enemies = [ 
                    ["GoldmanTall", 60, room_width-448, 714, GoldmanTall, 0, 1.0, c_white, 0.0], 
                    ["GoldmanShort", 40, room_width-252, 840, GoldmanShort, 0, 1.0, c_white, 0.0],
                    ["GoldmanTall", 60, room_width-644, 714, GoldmanTall, 0, 1.0, c_white, 0.0] 
                ];
            } else if (current_wave == 3) {
                enemies = [ 
                    ["GoldmanTall", 60, room_width-448, 714, GoldmanTall, 0, 1.0, c_white, 0.0], 
                    ["GoldmanTall", 60, room_width-252, 714, GoldmanTall, 0, 1.0, c_white, 0.0],
                    ["GoldmanTall", 60, room_width-644, 714, GoldmanTall, 0, 1.0, c_white, 0.0] 
                ];
            }
            win_timer = -1;
        }
    } else {
        if (win_timer == -1) win_timer = 180;
        fairy_text = "You did it! All 3 waves are clear!";
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) room_goto(rm_Level4_PostBattle); 
    }
}

if (player_hp <= 0 && milly_hp <= 0 && erin_hp <= 0) {
    if (lose_timer == -1) { 
        lose_timer = 180; 
        fairy_text = "We were defeated... Let\u0027s try again!"; 
        battle_state = BattleState.PLAYER_MENU; attack_timer = 0; 
    }
    if (lose_timer > 0) lose_timer--;
    if (lose_timer == 0) room_goto(rm_Level4_PostBattle);
}