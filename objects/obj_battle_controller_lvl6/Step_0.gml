// ==========================================
// 0. ANIMATION & STATE LOGIC
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

// Boss Animation & Flash Decay
if (enemies[0][1] > 0) { 
    enemies[0][5] += 0.2; 
    if (enemies[0][5] >= 32) enemies[0][5] = 0; 
    if (enemies[0][8] > 0) enemies[0][8] -= 0.05; 
} else {
    if (enemies[0][8] > 0) enemies[0][8] -= 0.05; 
    if (enemies[0][6] > 0) enemies[0][6] -= 0.05; 
}

// --- 1. TYPEWRITER EFFECT ---
if (fairy_text != previous_fairy_text) { 
    text_progress = 0; previous_fairy_text = fairy_text; 
}
if (text_progress < string_length(fairy_text)) text_progress += text_speed;

// --- 2. DIALOGUE THRESHOLD LOGIC ---
var current_phi_hp = enemies[0][1];
if (current_phi_hp > 0 && battle_state == BattleState.PLAYER_MENU) {
    if (current_phi_hp <= phi_max_hp * 0.75 && current_phi_hp > phi_max_hp * 0.5 && !triggered_34) {
        fairy_text = "Addeline: You thought that you could just get away with destroying everything in your sight? Well you thought wrong! You can\u0027t do whatever you want without consequences, and you\u0027re going to face them now!";
        triggered_34 = true;
    } else if (current_phi_hp <= phi_max_hp * 0.5 && current_phi_hp > phi_max_hp * 0.25 && !triggered_12) {
        fairy_text = "Milly: I\u0027ll make sure that history knows all of the crimes you\u0027ve committed! Everyone will remember your name, and the truth of what you did to our world!";
        triggered_12 = true;
    } else if (current_phi_hp <= phi_max_hp * 0.25 && current_phi_hp > 0 && !triggered_14) {
        fairy_text = "Erin: You took so many people\u0027s homes from them. The stability of a day to day life. I\u0027ll make sure you never feel steady on your own two feet again.";
        triggered_14 = true;
    }
}

// --- 3. CHARACTER SWITCHING (MANUAL OVERRIDE) ---
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0) {
    if (mouse_check_button_pressed(mb_left)) {
        if (mouse_y >= 924 && mouse_y <= 1036) {
            for (var i = 0; i < 3; i++) {
                var btn_x1 = hud_start_x + (i * hud_btn_spacing);
                var btn_x2 = btn_x1 + hud_btn_width;
                if (mouse_x >= btn_x1 && mouse_x <= btn_x2) {
                    active_char = i; 
                    menu_index = 0; 
                }
            }
        }
    }
}

// --- 4. ENEMY ATTACK TIMER & RANDOM DEFEND GENERATION ---
if (battle_state == BattleState.ENEMY_TURN) {
    if (attack_timer > 0) {
        attack_timer--;
    } else {
        battle_state = BattleState.DEFEND_SOLVE;
        defend_timer = defend_timer_max;
        player_input = "";
        fairy_text = "Bria: Incoming attack from King Phi! Solve this quickly to block!";
        
        var op = irandom(4); // 0: +, 1: -, 2: *, 3: /, 4: ^2
        if (op == 0) {
            problem_val1 = irandom_range(20, 100); problem_val2 = irandom_range(20, 100);
            problem_answer = problem_val1 + problem_val2;
            problem_question = string(problem_val1) + " + " + string(problem_val2) + " = ?";
        } else if (op == 1) {
            problem_val1 = irandom_range(50, 150); problem_val2 = irandom_range(10, problem_val1);
            problem_answer = problem_val1 - problem_val2;
            problem_question = string(problem_val1) + " - " + string(problem_val2) + " = ?";
        } else if (op == 2) {
            problem_val1 = irandom_range(5, 12); problem_val2 = irandom_range(5, 12);
            problem_answer = problem_val1 * problem_val2;
            problem_question = string(problem_val1) + " x " + string(problem_val2) + " = ?";
        } else if (op == 3) {
            problem_val2 = irandom_range(3, 10); problem_answer = irandom_range(3, 12);
            problem_val1 = problem_answer * problem_val2;
            problem_question = string(problem_val1) + " / " + string(problem_val2) + " = ?";
        } else if (op == 4) {
            problem_val1 = irandom_range(3, 12);
            problem_answer = problem_val1 * problem_val1;
            problem_question = string(problem_val1) + "\u00B2 = ?"; // Now it prints like 5² = ?
        }
    }
}

// --- 5. MENU NAVIGATION ---
if (battle_state == BattleState.PLAYER_MENU && win_timer <= 0) {
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
    if (keyboard_check_pressed(vk_enter)) {
        selected_skill = menu_index + 1;
        player_input = ""; 
        generate_problem(selected_skill, active_char); 
        spell_timer = spell_timer_max;
        battle_state = BattleState.PLAYER_SOLVE;
    }
}

// --- 6. SOLVING MATH ---
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
        fairy_text = "Bria: A massive hit! King Phi is ruthless!";
        player_hp -= 30; milly_hp -= 30; erin_hp -= 30;
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
                fairy_text = "Bria: Perfect block! Now counterattack!";
                player_flash_color = c_white; player_flash_alpha = 1.0;
                milly_flash_color = c_white;  milly_flash_alpha = 1.0;
                erin_flash_color = c_white;   erin_flash_alpha = 1.0;
            } else {
                if (active_char == 0) { // ADDELINE
                    addeline_is_attacking = true;
                    if (selected_skill == 1) { 
                        addeline_frame = 24; addeline_anim_end = 38; 
                        player_hp = min(player_hp + 20, player_max_hp); 
                        player_flash_color = c_green; player_flash_alpha = 1.0;
                    }
                    else if (selected_skill == 2) { 
                        addeline_frame = 10; addeline_anim_end = 24; 
                        enemies[0][1] -= 25; 
                        enemies[0][7] = c_red; enemies[0][8] = 1.0;
                    } 
                    else if (selected_skill == 3) { 
                        addeline_frame = 52; addeline_anim_end = 67; 
                        player_hp = min(player_hp + 15, player_max_hp); 
                        milly_hp = min(milly_hp + 15, milly_max_hp); 
                        erin_hp = min(erin_hp + 15, erin_max_hp); 
                        player_flash_color = c_green; player_flash_alpha = 1.0; milly_flash_color = c_green; milly_flash_alpha = 1.0; erin_flash_color = c_green; erin_flash_alpha = 1.0;
                    }
                    else if (selected_skill == 4) { 
                        addeline_frame = 38; addeline_anim_end = 52; 
                        enemies[0][1] -= 35; 
                        enemies[0][7] = c_red; enemies[0][8] = 1.0;
                    } 
                } 
                else if (active_char == 1) { // MILLY
                    milly_is_attacking = true;
                    if (selected_skill == 1) { 
                        milly_frame = 10; milly_anim_end = 25; milly_heal_buff = 3; 
                        milly_flash_color = c_yellow; milly_flash_alpha = 1.0;
                    }
                    else if (selected_skill == 2) { 
                        milly_frame = 25; milly_anim_end = 40; 
                        enemies[0][1] -= 25; 
                        enemies[0][7] = c_red; enemies[0][8] = 1.0;
                    }
                    else if (selected_skill == 3) { 
                        milly_frame = 40; milly_anim_end = 55; party_buff = 3; 
                        player_flash_color = c_yellow; player_flash_alpha = 1.0; milly_flash_color = c_yellow; milly_flash_alpha = 1.0; erin_flash_color = c_yellow; erin_flash_alpha = 1.0;
                    }
                    else if (selected_skill == 4) { 
                        milly_frame = 55; milly_anim_end = 71; enemy_debuff = 3; 
                        enemies[0][7] = c_fuchsia; enemies[0][8] = 1.0;
                    }
                }
                else if (active_char == 2) { // ERIN
                    erin_is_attacking = true;
                    var base_dmg = 30; 
                    if (erin_dmg_boost) { base_dmg *= 2; erin_dmg_boost = false; }

                    if (selected_skill == 1) { 
                        erin_frame = 10; erin_anim_end = 25; erin_dmg_boost = true; 
                        erin_flash_color = c_orange; erin_flash_alpha = 1.0;
                    } 
                    else if (selected_skill == 2) { 
                        erin_frame = 26; erin_anim_end = 41; 
                        enemies[0][1] -= base_dmg; erin_hp -= 5; 
                        erin_flash_color = c_red; erin_flash_alpha = 1.0; enemies[0][7] = c_red; enemies[0][8] = 1.0;
                    } 
                    else if (selected_skill == 3) { 
                        erin_frame = 42; erin_anim_end = 57; 
                        enemies[0][1] -= (base_dmg + 15); 
                        enemies[0][7] = c_red; enemies[0][8] = 1.0;
                    } 
                    else if (selected_skill == 4) { 
                        erin_frame = 58; erin_anim_end = 72; 
                        enemies[0][1] -= base_dmg; erin_hp = min(erin_hp + 15, erin_max_hp); 
                        erin_flash_color = c_green; erin_flash_alpha = 1.0; enemies[0][7] = c_red; enemies[0][8] = 1.0;
                    }
                }

                // --- AUTOMATIC TURN SWITCHING LOGIC ---
                var enemies_dead = (enemies[0][1] <= 0);
                
                if (enemies_dead) { 
                    attack_timer = 0; battle_state = BattleState.PLAYER_MENU; active_char = 0;
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
                    
                    // Skip dead characters
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
                        if (active_char == 1) fairy_text = "Bria: Nice hit! Milly, your turn!";
                        if (active_char == 2) fairy_text = "Bria: Awesome! Erin, finish it!";
                    }
                }
            }
        } else { 
            // --- WRONG ANSWER ---
            player_input = ""; 
            if (is_defending) {
                fairy_text = "Bria: Incorrect! Try again before King Phi strikes!";
            } else {
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
}

// --- 7. VICTORY LOGIC (KING PHI DEFEATED) ---
if (enemies[0][1] <= 0 && attack_timers <= 0 && battle_state == BattleState.PLAYER_MENU) {
    if (!triggered_0) { 
        win_timer = 300; 
        fairy_text = "Bria: You thought you could separate my twin and I forever. That we wouldn\u0027t ever escape, and you\u0027d get free reign for the rest of your life. Well the jokes on you because I would never let that happen! For as long as I live, I will protect those I care for."; 
        triggered_0 = true;
    }
    if (win_timer > 0) win_timer--;
    
    if (win_timer == 0) room_goto(rm_Level6_PostBattle); 
}

// --- 8. DEFEAT LOGIC (PARTY WIPED) ---
if (player_hp <= 0 && milly_hp <= 0 && erin_hp <= 0) {
    if (lose_timer == -1) { 
        lose_timer = 180; 
        fairy_text = "Bria: No... King Phi is too strong... We have to try again!"; 
        
        battle_state = BattleState.PLAYER_MENU; 
        attack_timer = 0; 
    }
    
    if (lose_timer > 0) lose_timer--;
    
    if (lose_timer == 0) room_goto(rm_Level6_Battle); 
}
