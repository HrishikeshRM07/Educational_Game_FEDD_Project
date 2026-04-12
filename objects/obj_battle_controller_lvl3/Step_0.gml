// --- HEALTH MANAGEMENT ---
player_hp = clamp(player_hp, 0, player_max_hp);
milly_hp = clamp(milly_hp, 0, milly_max_hp);

// ==========================================
// 0. ANIMATION LOGIC
// ==========================================
// Addeline
if (addeline_is_attacking) {
    addeline_frame += 0.5; 
    if (addeline_frame >= addeline_anim_end) {
        addeline_is_attacking = false; addeline_frame = 0; 
    }
} else {
    addeline_frame += 0.2; 
    if (addeline_frame >= 10 || addeline_frame < 0) addeline_frame = 0; 
}

// Milly
if (milly_is_attacking) {
    milly_frame += 0.5;
    if (milly_frame >= milly_anim_end) {
        milly_is_attacking = false; milly_frame = 0;
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

// --- 1. TYPEWRITER EFFECT ---
if (fairy_text != previous_fairy_text) { 
    text_progress = 0; previous_fairy_text = fairy_text; 
}
if (text_progress < string_length(fairy_text)) text_progress += text_speed;

// --- 2. CHARACTER SWITCHING ---
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0) {
    if (mouse_check_button_pressed(mb_left)) {
        // Addeline's Hitbox
        if (mouse_x >= 140 && mouse_x <= 240 && mouse_y >= 660 && mouse_y <= 740) { 
            active_char = 0; menu_index = 0; 
        }
        // Milly's Hitbox
        else if (mouse_x >= 385 && mouse_x <= 485 && mouse_y >= 660 && mouse_y <= 740) { 
            active_char = 1; menu_index = 0; 
        }
    }
}


// --- 3. ENEMY ATTACK TIMER ---
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

// --- 4. MENU NAVIGATION ---
if ((battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) && win_timer <= 0) {
    
    // Normal Navigation
    if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
    if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
    if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
    if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;
	
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

// --- 5. SOLVING MATH ---
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
        // BOSS DAMAGE INCREASED
        player_hp -= 30; 
        milly_hp -= 30; 
        battle_state = BattleState.PLAYER_MENU; 
    }

    // Submitting an Answer
    if (keyboard_check_pressed(vk_enter) && player_input != "") {
        
        if (real(player_input) == problem_answer) {
            // --- CORRECT ANSWER ---
            if (is_defending) {
                battle_state = BattleState.PLAYER_MENU;
                fairy_text = "Perfect block! Now counterattack!";
            } else {
                if (active_char == 0) { // ADDELINE
                    addeline_is_attacking = true;
                    if (selected_skill == 1) { 
                        addeline_frame = 24; addeline_anim_end = 38; 
                        if (player_hp <= milly_hp) player_hp = min(player_hp + 20, player_max_hp); 
                        else milly_hp = min(milly_hp + 20, milly_max_hp);
                    }
                    else if (selected_skill == 2) { 
                        addeline_frame = 10; addeline_anim_end = 24; 
                        if (enemies[0][1] > 0) enemies[0][1] -= 15;
                    }
                    else if (selected_skill == 3) { 
                        addeline_frame = 52; addeline_anim_end = 67; 
                        player_hp = min(player_hp + 15, player_max_hp); 
                        milly_hp = min(milly_hp + 15, milly_max_hp);
                    }
                    else if (selected_skill == 4) { 
                        addeline_frame = 38; addeline_anim_end = 52; 
                        if (enemies[0][1] > 0) enemies[0][1] -= 25; // Boss hit harder by AoE skill
                    }
                } 
                else if (active_char == 1) { // MILLY
                    milly_is_attacking = true;
                    if (selected_skill == 1) { 
                        milly_frame = 10; milly_anim_end = 25; milly_heal_buff = 3; 
                    }
                    else if (selected_skill == 2) { 
                        milly_frame = 25; milly_anim_end = 40; 
                        if (enemies[0][1] > 0) enemies[0][1] -= 15; 
                    }
                    else if (selected_skill == 3) { 
                        milly_frame = 40; milly_anim_end = 55; party_buff = 3; 
                    }
                    else if (selected_skill == 4) { 
                        milly_frame = 55; milly_anim_end = 71; enemy_debuff = 3; 
                    }
                }

                if (enemies[0][1] <= 0) { 
                    attack_timer = 0; battle_state = BattleState.PLAYER_MENU;
                } else { 
                    attack_timer = 120; battle_state = BattleState.ENEMY_TURN; 
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

// --- 6. VICTORY LOGIC (BOSS DEFEATED) ---
if (enemies[0][1] <= 0 && attack_timer <= 0 && battle_state == BattleState.PLAYER_MENU) {
    if (win_timer == -1) { 
        win_timer = 180; 
        fairy_text = "We did it! The Summation Scorpion has been defeated!"; 
    }
    if (win_timer > 0) win_timer--;
    
    // Change this room to wherever you want the player to go after the boss!
    if (win_timer == 0) room_goto(rm_Level3PostBattle); 
}
// --- 7. DEFEAT LOGIC (PARTY WIPED) ---
if (player_hp <= 0 && milly_hp <= 0) {
    if (lose_timer == -1) { 
        lose_timer = 180; // Wait about 3 seconds before resetting
        fairy_text = "The Summation Scorpion defeated us... Let's try again!"; 
        
        // Force the state to stop the battle from continuing in the background
        battle_state = BattleState.PLAYER_MENU; 
        attack_timer = 0; 
    }
    
    if (lose_timer > 0) lose_timer--;
    
    // Once the timer hits 0, restart the room completely!
    if (lose_timer == 0) room_goto(rm_Level3Story); 
}
