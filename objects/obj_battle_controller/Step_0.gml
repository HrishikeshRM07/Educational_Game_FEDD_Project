// ==========================================
// 0. ANIMATION & FLASH DECAY LOGIC
// ==========================================
if (addeline_is_attacking) {
    addeline_frame += 0.2; // ATTACK SPEED
    if (addeline_frame >= addeline_anim_end) {
        addeline_is_attacking = false;
        addeline_frame = 0; // Return to idle
    }
} else {
    addeline_frame += 0.2; // IDLE SPEED
    if (addeline_frame >= 10 || addeline_frame < 0) addeline_frame = 0; 
}

// NEW: Horatio Idle Animation Loop (7 frames)
if (enemy_hp > 0) {
    horatio_frame += 0.2; // Adjust 0.2 to make him animate faster or slower
    if (horatio_frame >= 7) { 
        horatio_frame = 0; 
    }
}

// Flash effect decay
if (player_flash_alpha > 0) player_flash_alpha -= 0.05;

if (enemy_hp <= 0) {
    // Death fade out logic
    if (enemy_alpha > 0) enemy_alpha -= 0.015;
    // Lock Horatio to flashing red while he fades
    enemy_flash_color = c_red;
    enemy_flash_alpha = 1.0; 
} else {
    if (enemy_flash_alpha > 0) enemy_flash_alpha -= 0.05;
}

// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape)) room_goto(rm_PostBattleStory);

// --- 1. HP CLAMPING & VICTORY CHECK ---
player_hp = clamp(player_hp, 0, player_max_hp);
enemy_hp = clamp(enemy_hp, 0, 50);

if (enemy_hp <= 0 && win_timer == -1) {
    win_timer = 180; // 3 seconds at 60fps
    fairy_text = "You did it! Horatio is defeated!";
}

if (win_timer > 0) {
    win_timer--;
    if (win_timer == 0) room_goto(rm_PostBattleStory);
    exit; 
}

// --- 2. SEQUENCE TIMER LOGIC ---
if (attack_timer > 0) {
    attack_timer--;
    
    // Added stage 4 here to trigger the new Shield Tutorial
    if (tutorial_stage == 0 || tutorial_stage == 2 || tutorial_stage == 4) {
        if (attack_timer == 120) {
            if (tutorial_stage == 0) fairy_text = "Here comes his attack! Prepare yourself to solve this equation!";
            if (tutorial_stage == 2) fairy_text = "Horatio is utilizing another skill to summon an ME! Prepare yourself!";
            if (tutorial_stage == 4) fairy_text = "Watch out! Horatio is launching a massive direct attack! Get ready to DEFEND!";
        }
        
        if (attack_timer == 0) {
            if (tutorial_stage == 0) {
                player_hp -= 20; 
                player_flash_color = c_red; player_flash_alpha = 1.0; // Red Hurt Flash
                fairy_text = "Uh oh! That hit you bad! But don't worry, you can also heal. Click on Additive Power!";
                tutorial_stage = 1;
                battle_state = BattleState.PLAYER_MENU;
            } else if (tutorial_stage == 2) {
                fairy_text = "He's gathering forces... but we have a skill for this. Press on Double Sub!";
                tutorial_stage = 3;
                battle_state = BattleState.PLAYER_MENU;
            } else if (tutorial_stage == 4) {
                // --- ENTER SHIELD TUTORIAL ---
                battle_state = BattleState.DEFEND_SOLVE;
                defend_timer = defend_timer_max;
                player_input = "";
                
                // Addeline specific math (Addition only)
                problem_val1 = irandom_range(1, 12);
                problem_val2 = irandom_range(1, 12);
                problem_answer = problem_val1 + problem_val2;
                problem_question = string(problem_val1) + " + " + string(problem_val2) + " = ?";
                
                fairy_text = "Quick! Solve this addition problem to raise your shield and block the damage!";
            }
        }
    }
}

// --- 3. MAIN BATTLE STATE MACHINE ---
switch (battle_state) {
    case BattleState.PLAYER_MENU:
        // Navigation
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) menu_index = clamp(menu_index + 2, 0, 3);
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")))  menu_index = clamp(menu_index - 2, 0, 3);
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
            if (menu_index == 0) menu_index = 1; else if (menu_index == 2) menu_index = 3;
        }
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
            if (menu_index == 1) menu_index = 0; else if (menu_index == 3) menu_index = 2;
        }

        // Selection
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
            var skill_map = [1, 2, 3, 4]; 
            var potential_skill = skill_map[menu_index];
            
            var can_use = false;
            if (tutorial_stage == 0 && potential_skill == 2) can_use = true; 
            if (tutorial_stage == 1 && potential_skill == 1) can_use = true; 
            if (tutorial_stage == 3 && potential_skill == 4) can_use = true; 
            if (tutorial_stage == 4 && potential_skill == 3) can_use = true; 
            if (tutorial_stage >= 5) can_use = true; 

            if (can_use) {
                selected_skill = potential_skill;
                generate_problem(selected_skill, 0); 
                battle_state = BattleState.PLAYER_SOLVE;
                player_input = ""; 
                
                if (tutorial_stage == 0) fairy_text = "In order to use <Skill 2: Subtraction>, you need to remove the second number from the first number!";
                if (tutorial_stage == 1) fairy_text = "For this spell, you’ll need to put two numbers together. Put them together to find the total!";
                if (tutorial_stage == 3) fairy_text = "This is pretty similar to <Skill 2> but now you’ll be subtracting multiple smaller numbers from one bigger number!";
                if (tutorial_stage == 4) fairy_text = "In order to do this you just need to add a bunch of numbers together! It doesn’t matter what order that you do it in.";
            } else {
                fairy_text = "Not that one! We need to follow the mathemagical steps first.";
            }
        }
    break;

    case BattleState.PLAYER_SOLVE:
        // Input
        for (var i = 0; i <= 9; i++) {
            if (keyboard_check_pressed(ord(string(i)))) player_input += string(i);
        }
        if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

        // Check Answer
        if (keyboard_check_pressed(vk_enter) && player_input != "") {
            if (real(player_input) == problem_answer) {
                execute_skill(selected_skill); 
                is_showing_hint = false;
                
                addeline_is_attacking = true;
                
                if (selected_skill == 1) {        // Additive Heal
                    addeline_frame = 24; addeline_anim_end = 38;
                    player_flash_color = c_green; player_flash_alpha = 1.0; // Green Heal Flash
                } else if (selected_skill == 2) { // Subtraction
                    addeline_frame = 10; addeline_anim_end = 24;
                    enemy_flash_color = c_red; enemy_flash_alpha = 1.0; // Flash Enemy Red
                } else if (selected_skill == 3) { // Commutative
                    addeline_frame = 52; addeline_anim_end = 67;
                    enemy_flash_color = c_red; enemy_flash_alpha = 1.0;
                } else if (selected_skill == 4) { // Double Sub
                    addeline_frame = 38; addeline_anim_end = 52;
                    enemy_flash_color = c_red; enemy_flash_alpha = 1.0;
                }
                
                if (tutorial_stage == 0) {
                    fairy_text = "Well done!"; 
                    attack_timer = 240; 
                    battle_state = BattleState.ENEMY_TURN; 
                } 
                else if (tutorial_stage == 1) {
                    fairy_text = "Well done!";
                    attack_timer = 240; 
                    tutorial_stage = 2; 
                    battle_state = BattleState.ENEMY_TURN;
                }
                else if (tutorial_stage == 3) {
                    fairy_text = "You knocked out the ME! You're almost there. I'll give us extra time...";
                    tutorial_stage = 4;
                    battle_state = BattleState.PLAYER_MENU;
                }
                else if (tutorial_stage == 4) {
                    // Start the Shield Tutorial attack!
                    fairy_text = "Great job! But Horatio is getting angry. Prepare for a heavy strike!";
                    attack_timer = 240;
                    battle_state = BattleState.ENEMY_TURN; 
                }
                else {
                    battle_state = BattleState.ENEMY_TURN;
                }
            } 
            else {
                player_input = "";
                if (selected_skill == 2) fairy_text = "Think of it like this: If I had 3 apples, and I gave 1 to you, I’d be left with 2 apples. Now you try it!";
                if (selected_skill == 1) fairy_text = "For example! If you have 3 bows and I have 6 bows, together we’d have 9 bows. Now you try it!";
                if (selected_skill == 4) fairy_text = "If I have 38 cupcakes, I give 3 to you and 5 to a friend, I’ll have 38-3-5 left, which is 30! Now you try it.";
                if (selected_skill == 3) fairy_text = "If I have 10 cookies, you give me 5, and a friend gives me 5, I'd end up with 20! The order doesn't matter!";
            }
        }
    break;

    case BattleState.DEFEND_SOLVE:
        for (var i = 0; i <= 9; i++) {
            if (keyboard_check_pressed(ord(string(i)))) player_input += string(i);
        }
        if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

        defend_timer--;

        // Timer Ran Out - Take Damage
        if (defend_timer <= 0) {
            player_hp -= 30;
            player_flash_color = c_red; player_flash_alpha = 1.0; // Flash red
            tutorial_stage = 5;
            battle_state = BattleState.PLAYER_MENU;
            fairy_text = "Too slow! His attack broke through! Remember to answer quickly to block. You're ready to go now! Give it your best shot!";
        }

        // Check Answer
        if (keyboard_check_pressed(vk_enter) && player_input != "") {
            if (real(player_input) == problem_answer) {
                player_flash_color = c_white; player_flash_alpha = 1.0; // White Shield Flash
                tutorial_stage = 5;
                battle_state = BattleState.PLAYER_MENU;
                fairy_text = "Perfect block! The shield completely negated the damage! You're ready to go! Give it your best shot!";
            } else {
                player_input = "";
                fairy_text = "Incorrect! Try again quickly before he strikes!";
            }
        }
    break;

    case BattleState.ENEMY_TURN:
        if (attack_timer <= 0) battle_state = BattleState.PLAYER_MENU;
    break;
}