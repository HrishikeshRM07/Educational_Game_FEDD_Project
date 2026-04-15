// ==========================================
// --- HEALTH MANAGEMENT ---
// ==========================================
player_hp = clamp(player_hp, 0, player_max_hp);
milly_hp = clamp(milly_hp, 0, milly_max_hp);


// ==========================================
// 0. ANIMATION LOGIC
// ==========================================
// Addeline
if (addeline_is_attacking) {
    addeline_frame += 0.5; 
    if (addeline_frame >= addeline_anim_end) {
        addeline_is_attacking = false; 
        addeline_frame = 0; 
    }
} else {
    addeline_frame += 0.2; 
    if (addeline_frame >= 10 || addeline_frame < 0) addeline_frame = 0; 
}

// Milly
if (milly_is_attacking) {
    milly_frame += 0.5;
    if (milly_frame >= milly_anim_end) {
        milly_is_attacking = false; 
        milly_frame = 0;
    }
} else {
    milly_frame += 0.2;
    if (milly_frame >= 10 || milly_frame < 0) milly_frame = 0;
}

// Boss Animation (10 Idle Frames)
if (enemies[0][1] > 0) { 
    enemies[0][5] += 0.2; 
    if (enemies[0][5] >= 10) enemies[0][5] = 0;
}


// ==========================================
// --- FLASH & DEATH FADE DECAYS ---
// ==========================================
// Players
if (player_flash_alpha > 0) player_flash_alpha -= 0.05;
if (milly_flash_alpha > 0) milly_flash_alpha -= 0.05;

// Make players disappear if dead (after flash finishes)
if (player_hp <= 0 && player_flash_alpha <= 0 && player_alpha > 0) player_alpha -= 0.05;
if (milly_hp <= 0 && milly_flash_alpha <= 0 && milly_alpha > 0) milly_alpha -= 0.05;

// Boss Flash & Fade Decay
if (enemies[0][1] > 0) { 
    if (enemies[0][8] > 0) enemies[0][8] -= 0.05; 
} else {
    if (enemies[0][8] > 0) enemies[0][8] -= 0.05; 
    else if (enemies[0][6] > 0) enemies[0][6] -= 0.05; // Fade boss to 0 alpha on death
}


// ==========================================
// 1. TYPEWRITER EFFECT
// ==========================================
if (fairy_text != previous_fairy_text) { 
    text_progress = 0; 
    previous_fairy_text = fairy_text; 
}
if (text_progress < string_length(fairy_text)) text_progress += text_speed;


// ==========================================
// 2. CHARACTER SWITCHING
// ==========================================
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0) {
    if (mouse_check_button_pressed(mb_left)) {
        // Addeline's Hitbox
        if (mouse_x >= 140 && mouse_x <= 240 && mouse_y >= 660 && mouse_y <= 740) { 
            active_char = 0; 
            menu_index = 0; 
        }
        // Milly's Hitbox
        else if (mouse_x >= 385 && mouse_x <= 485 && mouse_y >= 660 && mouse_y <= 740) { 
            active_char = 1; 
            menu_index = 0; 
        }
    }
}


// ==========================================
// 3. ENEMY ATTACK TIMER
// ==========================================
if (battle_state == BattleState.ENEMY_TURN) {
    if (attack_timer > 0) {
        attack_timer--;
    } else {
        // Skip the menu and jump straight to solving!
        battle_state = BattleState.DEFEND_SOLVE;
        
        // Randomly assign a problem type (1 through 4)
        selected_skill = irandom_range(1, 4); 
        
        // Randomly pick between Addeline's math (0) and Milly's math (1)
        var random_math_type = irandom_range(0, 1);
        
        // Generate the problem using both random values!
        generate_problem(selected_skill, random_math_type); 
        
        defend_timer = defend_timer_max;
        player_input = ""; // Clear any leftover numbers
        fairy_text = "Incoming attack! Be ready for any type of math!";
    }
}


// ==========================================
// 4. MENU NAVIGATION
// ==========================================
if ((battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) && win_timer <= 0) {
    
    // Normal Navigation
    if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
    if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
    if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
    if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;
    
    var skill_map = [1, 2, 3, 4]; 
    
    // Dialogue Updates based on selected skill
    if (active_char == 0) { // ADDELINE
        if (skill_map[menu_index] == 1) {
            fairy_text = "Provides heal to one party member: Click on Add it up!, and we can solve the problem together! For this spell, you'll need to put two numbers together. For example! If you have 3 bows and I have 6 bows, if we put our bows together then we'd have 9 bows.";
        } else if (skill_map[menu_index] == 2) {
            fairy_text = "Deals damage to one enemy: In order to use Sub-tract the health, you need to remove the second number from the first number! You can think of it like this: If I had 3 apples, and I gave 1 of them to you, I'd be left with 2 apples.";
        } else if (skill_map[menu_index] == 3) {
            fairy_text = "Provides party heal: In order to do this you just need to add a bunch of numbers together! It doesn't matter what order that you do it in. For example if I have 10 cookies, you give me 5, and a friend of mine gives me 5 I'd end up with 20! It doesn't matter if my friend gives it to me first or you give it to me first, I'll still end up with the same amount of cookies!";
        } else {
            fairy_text = "Multi-target attack: This is pretty similar to Sub-tract the health!, but now you'll be subtracting multiple smaller numbers from one bigger number! If you need a way to think about it, if I have 38 cupcakes, I give 3 to you, and I give 5 to a friend of mine I'll have 38-3-5 cupcakes, which means I'd be left with 30 cupcakes!";
        }
    } else { // MILLY
        if (skill_map[menu_index] == 1) {
            fairy_text = "Boosts the amount of HP that can be healed to one party member (lasts 3 turns). You can think of multiplying something a bit like adding the same number over and over. If I have 10 strawberries, and I double (multiply by 2) that amount, then I'll end up with 20 strawberries, which is the same as 10 + 10! Now you give it a try";
        } else if (skill_map[menu_index] == 2) {
            fairy_text = "Deals damage to one enemy: To use this skill, we need to use division. Think of it like how many times one number can go into another number! For example, if I have 6 cakes, and the recipe says I need to use 2 then I'll be putting in the eggs 3 times!";
        } else if (skill_map[menu_index] == 3) {
            fairy_text = "Provides defense & damage buff to whole party (lasts 3 turns): This means that your next attacks will hit harder and any damage taken. In order to do this, we'll need to use the distributive property! That means multiplying everything that's outside the parentheses to what's inside of the parentheses. For example, if I need to triple the cookies that two sets of partners have, I'd write it as 3(2 + 2), and to distribute it I'd multiply each 2 by 3. This would get me 6 + 6, which gives me 12!";
        } else {
            fairy_text = "Provides defense & damage debuff to all enemies (lasts 3 turns): For this, we’re going to divide, but we may not get a whole number. For example if I have 15 apples and I'm breaking it up into sets of twos, I'll have 7 sets of two apples with 1 apple remaining, which means that I'll have half a set. This means the answer to 15 " + chr(247) + " 2 is 7.5 sets of apples!";
        }
    }
    
    // Selecting a Skill
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


// ==========================================
// 5. SOLVING MATH
// ==========================================
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    
    // Typing Logic
    for (var i = 0; i <= 9; i++) { 
        if (keyboard_check_pressed(ord(string(i)))) player_input += string(i); 
    }
    if (keyboard_check_pressed(190) || keyboard_check_pressed(110)) player_input += "."; 
    if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

    var is_defending = (battle_state == BattleState.DEFEND_SOLVE);
    
    // Timer Logic
    if (is_defending) defend_timer--; else spell_timer--;

    // Time's Up Logic (Failed)
    if (spell_timer <= 0 && !is_defending) { 
        fairy_text = "Too slow! Brace yourself!";
        attack_timer = 120; 
        battle_state = BattleState.ENEMY_TURN; 
    }
    if (defend_timer <= 0 && is_defending) { 
        fairy_text = "A massive hit! The boss is relentless!";
        player_hp -= 30; 
        milly_hp -= 30; 
        
        player_flash_color = c_red; 
        player_flash_alpha = 1.0;
        milly_flash_color = c_red;  
        milly_flash_alpha = 1.0;
        
        battle_state = BattleState.PLAYER_MENU; 
    }

    // Submitting an Answer
    if (keyboard_check_pressed(vk_enter) && player_input != "") {
        
        if (real(player_input) == problem_answer) {
            // --- CORRECT ANSWER ---
            if (is_defending) {
                battle_state = BattleState.PLAYER_MENU;
                fairy_text = "Perfect block! Now counterattack!";
                player_flash_color = c_white; player_flash_alpha = 1.0;
                milly_flash_color = c_white;  milly_flash_alpha = 1.0;
            } else {
                if (active_char == 0) { // ADDELINE
                    addeline_is_attacking = true;
                    if (selected_skill == 1) { 
                        addeline_frame = 32; addeline_anim_end = 38; 
                        if (player_hp <= milly_hp) { player_hp = min(player_hp + 20, player_max_hp); player_flash_color = c_green; player_flash_alpha = 1.0; } 
                        else { milly_hp = min(milly_hp + 20, milly_max_hp); milly_flash_color = c_green; milly_flash_alpha = 1.0; }
                    }
                    else if (selected_skill == 2) { 
                        addeline_frame = 25; addeline_anim_end = 38; 
                        if (enemies[0][1] > 0) { enemies[0][1] -= 15; enemies[0][7] = c_red; enemies[0][8] = 1.0; }
                    }
                    else if (selected_skill == 3) { 
                        addeline_frame = 39; addeline_anim_end = 52; 
                        player_hp = min(player_hp + 15, player_max_hp); 
                        milly_hp = min(milly_hp + 15, milly_max_hp);
                        player_flash_color = c_green; player_flash_alpha = 1.0;
                        milly_flash_color = c_green; milly_flash_alpha = 1.0;
                    }
                    else if (selected_skill == 4) { 
                        addeline_frame = 53; addeline_anim_end = 67; 
                        if (enemies[0][1] > 0) { enemies[0][1] -= 25; enemies[0][7] = c_red; enemies[0][8] = 1.0; }
                    }
                } 
                else if (active_char == 1) { // MILLY
                    milly_is_attacking = true;
                    if (selected_skill == 1) { 
                        milly_frame = 25; milly_anim_end = 38; milly_heal_buff = 3; 
                        milly_flash_color = c_green; milly_flash_alpha = 1.0;
                    }
                    else if (selected_skill == 2) { 
                        milly_frame = 39; milly_anim_end = 51; 
                        if (enemies[0][1] > 0) { enemies[0][1] -= 15; enemies[0][7] = c_red; enemies[0][8] = 1.0; } 
                    }
                    else if (selected_skill == 3) { 
                        milly_frame = 52; milly_anim_end = 62; party_buff = 3; 
                        player_flash_color = c_green; player_flash_alpha = 1.0; 
                        milly_flash_color = c_green; milly_flash_alpha = 1.0;
                    }
                    else if (selected_skill == 4) { 
                        milly_frame = 63; milly_anim_end = 71; enemy_debuff = 3; 
                        enemies[0][7] = c_red; enemies[0][8] = 1.0;
                    }
                }

                // --- AUTOMATIC TURN SWITCHING LOGIC ---
                var enemies_dead = (enemies[0][1] <= 0);
                
                if (enemies_dead) { 
                    attack_timer = 0; 
                    battle_state = BattleState.PLAYER_MENU; 
                    active_char = 0;
                } else {
                    // 1. Cycle to the next character (Addeline -> Milly -> Enemy)
                    if (active_char == 0) {
                        active_char = 1; 
                        battle_state = BattleState.PLAYER_MENU; 
                    } else { // If Milly just went, it's the boss's turn!
                        attack_timer = 120; 
                        battle_state = BattleState.ENEMY_TURN; 
                        active_char = 0; 
                        
                    }
                    
                    // 2. Skip dead characters (prevent softlocks)
                    while (battle_state != BattleState.ENEMY_TURN && 
                           ((active_char == 0 && player_hp <= 0) || 
                            (active_char == 1 && milly_hp <= 0))) {
                        
                        active_char++;
                        if (active_char > 1) { // If both players have moved or are dead
                            battle_state = BattleState.ENEMY_TURN;
                            attack_timer = 120;
                            active_char = 0;
                        }
                    }

                    // 3. Reset menu and update dialogue
                    if (battle_state == BattleState.PLAYER_MENU) {
                        menu_index = 0;
                        if (active_char == 1) fairy_text = "Nice hit! Milly, your turn!";
                        if (active_char == 0) fairy_text = "Great job! Addeline, you're up!";
                    }
                }
            }
        } else { 
            // --- WRONG ANSWER ---
            player_input = ""; 
            if (active_char == 0) {
                if (selected_skill == 1) fairy_text = "Hint! Try counting up from " + string(problem_val1) + ".";
                else if (selected_skill == 2) fairy_text = "Hint! Take " + string(problem_val2) + " away from " + string(problem_val1) + ".";
                else fairy_text = "Careful! Check your math again.";
            } else {
                if (selected_skill == 1) fairy_text = "Hint! What is " + string(problem_val1) + " groups of " + string(problem_val2) + "?";
                else if (selected_skill == 2) fairy_text = "Hint! How many times does " + string(problem_val1) + " fit into that number?";
                else if (selected_skill == 3) fairy_text = "Hint! Multiply " + string(problem_val1) + " by both inside numbers, then add them.";
                else if (selected_skill == 4) fairy_text = "Hint! Half of " + string(problem_val1) + " is " + string(problem_val1 / 2) + ".";
            }
        }
    }
}


// ==========================================
// 6. VICTORY LOGIC (BOSS DEFEATED)
// ==========================================
if (enemies[0][1] <= 0 && attack_timer <= 0 && battle_state == BattleState.PLAYER_MENU) {
    if (win_timer == -1) { 
        win_timer = 180; 
        fairy_text = "We did it! The Summation Scorpion has been defeated!"; 
    }
    if (win_timer > 0) win_timer--;
    
    if (win_timer == 0) room_goto(rm_Level3PostBattle); 
}

// ==========================================
// 7. DEFEAT LOGIC (PARTY WIPED)
// ==========================================
if (player_hp <= 0 && milly_hp <= 0) {
    if (lose_timer == -1) { 
        lose_timer = 180; 
        fairy_text = "The Summation Scorpion defeated us... Let's try again!"; 
        
        // Force the state to stop the battle from continuing
        battle_state = BattleState.PLAYER_MENU; 
        attack_timer = 0; 
    }
    
    if (lose_timer > 0) lose_timer--;
    
    if (lose_timer == 0) room_goto(rm_Level3Story); 
}
