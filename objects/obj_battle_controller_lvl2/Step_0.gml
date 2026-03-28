// --- HEALTH & STATE MANAGEMENT ---
player_hp = clamp(player_hp, 0, player_max_hp);
milly_hp = clamp(milly_hp, 0, milly_max_hp);
is_tutorial = (milly_tutorial_step < 4);

// --- 1. TYPEWRITER EFFECT ---
if (fairy_text != previous_fairy_text) { 
    text_progress = 0; 
    previous_fairy_text = fairy_text; 
}
if (text_progress < string_length(fairy_text)) {
    text_progress += text_speed;
}

// --- 2. CHARACTER SWITCHING (Mouse Click) ---
// Only allow switching if we are in the main menu, NOT in tutorial, and NOT being attacked
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0 && !is_tutorial) {
    if (mouse_check_button_pressed(mb_left)) {
        // Adjust these coordinates if your portraits are drawn elsewhere!
        // Addeline's Portrait Box (Left)
        if (mouse_x >= 40 && mouse_x <= 180 && mouse_y >= 590 && mouse_y <= 760) { 
            active_char = 0; 
            menu_index = 0; 
        }
        // Milly's Portrait Box (Right)
        else if (mouse_x >= 190 && mouse_x <= 330 && mouse_y >= 590 && mouse_y <= 760) { 
            active_char = 1; 
            menu_index = 0; 
        }
    }
}

// --- 3. ENEMY ATTACK TIMER ---
// If it's the enemy's turn, count down before forcing the player to defend
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
if (battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) {
    
    // Tutorial Lock
    if (is_tutorial && battle_state == BattleState.PLAYER_MENU) {
        menu_index = milly_tutorial_step; 
    } else {
        // Normal Navigation
        if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
        if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
        if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
        if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;
    }

    // Selecting a Skill
    if (keyboard_check_pressed(vk_enter)) {
        selected_skill = menu_index + 1;
        player_input = ""; // Clear old answers
        
        if (battle_state == BattleState.PLAYER_MENU) {
            generate_problem(selected_skill, active_char); 
            spell_timer = spell_timer_max;
            battle_state = BattleState.PLAYER_SOLVE;
        } else if (battle_state == BattleState.DEFEND_MENU) {
            generate_problem(selected_skill, 0); // Defense uses basic addition/subtraction
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
        fairy_text = "Bria: Too slow! Brace yourself!";
        attack_timer = 120; // Short pause before enemy attacks
        battle_state = BattleState.ENEMY_TURN; 
    }
    if (defend_timer <= 0 && is_defending) { 
        fairy_text = "Bria: Ouch! We took a hit!";
        player_hp -= 15; 
        milly_hp -= 15; 
        battle_state = BattleState.PLAYER_MENU; 
    }

    // Submitting an Answer
    if (keyboard_check_pressed(vk_enter) && player_input != "") {
        
        if (real(player_input) == problem_answer) {
            // --- CORRECT ANSWER ---
            if (is_defending) {
                battle_state = BattleState.PLAYER_MENU;
                fairy_text = "Bria: Great block! Now it's our turn.";
            } else {
                // Determine effect based on character
                if (active_char == 0) { // ADDELINE
                    if (selected_skill == 1) player_hp += 20; 
                    else for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) enemies[i][1] -= 15; }
                } 
                else if (active_char == 1) { // MILLY
                    if (selected_skill == 1) { milly_hp = milly_max_hp; }
                    else if (selected_skill == 2) { enemies[0][1] -= 10; }
                    else if (selected_skill == 3) { party_buff = 3; }
                    else if (selected_skill == 4) { enemy_debuff = 3; }

                    // Advance Tutorial
                    if (is_tutorial && selected_skill == (milly_tutorial_step + 1)) {
                        milly_tutorial_step++;
                        if (milly_tutorial_step == 1) fairy_text = "Bria: Excellent! <Skill 2> damages enemies using division. Try it!";
                        else if (milly_tutorial_step == 2) fairy_text = "Bria: Nice! <Skill 3> uses the distributive property. Multiply the outside by the inside!";
                        else if (milly_tutorial_step == 3) fairy_text = "Bria: <Skill 4> debuffs enemies. Divide by 2. Don't forget the .5 decimal!";
                        else if (milly_tutorial_step == 4) fairy_text = "Bria: Tutorial done! You can now click on Addeline's portrait to switch to her.";
                    }
                }

                // Check for Win or Enemy Turn
                var enemies_dead = true;
                for (var i = 0; i < array_length(enemies); i++) { 
                    if (enemies[i][1] > 0) enemies_dead = false; 
                }
                
                if (enemies_dead) { 
                    fairy_text = "Bria: We did it! The slimes are defeated!";
                    battle_state = BattleState.PLAYER_MENU; // Prevents attacks while dead
                } else { 
                    attack_timer = 120; // Give a short pause before the defend screen pops up
                    battle_state = BattleState.ENEMY_TURN; 
                }
            }
        } else { 
            // --- WRONG ANSWER ---
            player_input = ""; // Clear their wrong answer so they can try again
            if (active_char == 0) {
                if (selected_skill == 1) fairy_text = "Bria: Hint! Try counting up from " + string(problem_val1) + ".";
                else if (selected_skill == 2) fairy_text = "Bria: Hint! Take " + string(problem_val2) + " away from " + string(problem_val1) + ".";
                else fairy_text = "Bria: Careful! Check your math again.";
            } else {
                if (selected_skill == 1) fairy_text = "Bria: Hint! What is " + string(problem_val1) + " groups of " + string(problem_val2) + "?";
                else if (selected_skill == 2) fairy_text = "Bria: Hint! How many times does " + string(problem_val1) + " fit into that number?";
                else if (selected_skill == 3) fairy_text = "Bria: Hint! Multiply " + string(problem_val1) + " by both inside numbers, then add them.";
                else if (selected_skill == 4) fairy_text = "Bria: Hint! Half of " + string(problem_val1) + " is " + string(problem_val1 / 2) + ".";
            }
        }
    }
}