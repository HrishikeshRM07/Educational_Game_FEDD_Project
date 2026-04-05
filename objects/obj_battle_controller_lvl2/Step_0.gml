// ==========================================
// 0. ANIMATION LOGIC (ADDELINE, MILLY & ENEMIES)
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

// Enemies (Both Linearf and Parabolate use 10 idle frames)
for (var i = 0; i < array_length(enemies); i++) {
    if (enemies[i][1] > 0) { 
        enemies[i][5] += 0.2; 
        if (enemies[i][5] >= 10) enemies[i][5] = 0;
    }
}

// --- 1. TYPEWRITER EFFECT ---
if (fairy_text != previous_fairy_text) { 
    text_progress = 0; 
    previous_fairy_text = fairy_text; 
}
if (text_progress < string_length(fairy_text)) {
    text_progress += text_speed;
}

// --- 2. CHARACTER SWITCHING (Updated for new positions) ---
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0 && !is_tutorial) {
    if (mouse_check_button_pressed(mb_left)) {
        
        // Addeline's Hitbox
        if (mouse_x >= 140 && mouse_x <= 240 && mouse_y >= 660 && mouse_y <= 740) { 
            active_char = 0; 
            menu_index = 0; 
        }
        
        // Milly's Hitbox (Shifted 15 pixels right to match the new box)
        else if (mouse_x >= 385 && mouse_x <= 485 && mouse_y >= 660 && mouse_y <= 740) { 
            active_char = 1; 
            menu_index = 0; 
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
// (Added 'win_timer <= 0' so players can't click things between waves!)
if ((battle_state == BattleState.PLAYER_MENU || battle_state == BattleState.DEFEND_MENU) && win_timer <= 0) {
    
    // Tutorial Lock
    if (is_tutorial && battle_state == BattleState.PLAYER_MENU) {
// ... rest of your code remains exactly the same ...
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
        fairy_text = "Bria: Too slow! Brace yourself!";
        attack_timer = 120; 
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
                    addeline_is_attacking = true;
                    
                    if (selected_skill == 1) { // Add it up! (Single Heal)
                        addeline_frame = 24; addeline_anim_end = 38; 
                        // Heals whichever character has the lowest health, capped at max HP
                        if (player_hp <= milly_hp) {
                            player_hp = min(player_hp + 20, player_max_hp); 
                        } else {
                            milly_hp = min(milly_hp + 20, milly_max_hp);
                        }
                    }
                    else if (selected_skill == 2) { // Sub-tract the health (Single Target Damage)
                        addeline_frame = 10; addeline_anim_end = 24; 
                        for (var i = 0; i < array_length(enemies); i++) { 
                            if (enemies[i][1] > 0) { enemies[i][1] -= 15; break; } // 'break' ensures only ONE is hit
                        }
                    }
                    else if (selected_skill == 3) { // Share the health! (Party Heal)
                        addeline_frame = 52; addeline_anim_end = 67; 
                        // Heals both, capped at max HP
                        player_hp = min(player_hp + 15, player_max_hp); 
                        milly_hp = min(milly_hp + 15, milly_max_hp);
                    }
                    else if (selected_skill == 4) { // Double Down (Multi-Target Damage)
                        addeline_frame = 38; addeline_anim_end = 52; 
                        for (var i = 0; i < array_length(enemies); i++) { 
                            if (enemies[i][1] > 0) enemies[i][1] -= 15; // Hits ALL alive enemies
                        }
                    }
                } 
                else if (active_char == 1) { // MILLY
                    milly_is_attacking = true;
                    
                    if (selected_skill == 1) { // Health multiplies! (Heal Buff)
                        milly_frame = 10; milly_anim_end = 25; 
                        milly_heal_buff = 3; 
                    }
                    else if (selected_skill == 2) { // Divide it out! (Single Target Damage)
                        milly_frame = 25; milly_anim_end = 40; 
                        for (var i = 0; i < array_length(enemies); i++) { 
                            if (enemies[i][1] > 0) { enemies[i][1] -= 15; break; } 
                        }
                    }
                    else if (selected_skill == 3) { // Share the buffs! (Party Buff)
                        milly_frame = 40; milly_anim_end = 55; 
                        party_buff = 3; 
                    }
                    else if (selected_skill == 4) { // Long Way Down (Multi-Target Debuff)
                        milly_frame = 55; milly_anim_end = 71; 
                        enemy_debuff = 3; 
                    }

                    // Advance Tutorial
                    if (is_tutorial && selected_skill == (milly_tutorial_step + 1)) {
                        milly_tutorial_step++;
                        is_tutorial = (milly_tutorial_step < 4); 

                        if (milly_tutorial_step == 1) fairy_text = "Bria: Excellent! <Skill 2> damages enemies using division. Try it!";
                        else if (milly_tutorial_step == 2) fairy_text = "Bria: Nice! <Skill 3> uses the distributive property. Multiply the outside by the inside!";
                        else if (milly_tutorial_step == 3) fairy_text = "Bria: <Skill 4> debuffs enemies. Divide by 2. Don't forget the .5 decimal!";
                        else if (milly_tutorial_step == 4) fairy_text = "Bria: Tutorial done! You can now click on Addeline's portrait to switch to her.";
                    }
                }

                // Temporary logic to bypass enemy turn if enemies die during tutorial
                var enemies_dead = true;
                for (var i = 0; i < array_length(enemies); i++) { 
                    if (enemies[i][1] > 0) enemies_dead = false; 
                }
                
                if (enemies_dead && is_tutorial) {
                    enemies[0][1] = 30; // Keep enemies alive so tutorial doesn't break
                }

                if (!is_tutorial && enemies_dead) { 
                    attack_timer = 0;
                    battle_state = BattleState.PLAYER_MENU;
                } else { 
                    if (is_tutorial) {
                        battle_state = BattleState.PLAYER_MENU;
                    } else {
                        attack_timer = 120; 
                        battle_state = BattleState.ENEMY_TURN; 
                    }
                }
            }
        } else { 
            // --- WRONG ANSWER ---
            player_input = ""; 
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

// --- 7. WAVE & VICTORY LOGIC ---
var all_dead = true;
for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) all_dead = false; }

// Only start waves once the tutorial is fully completed
if (all_dead && attack_timer <= 0 && battle_state == BattleState.PLAYER_MENU && !is_tutorial) {
    if (current_wave < max_waves) {
        if (win_timer == -1) { win_timer = 120; fairy_text = "Bria: Well done! That's one wave down!"; }
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) {
            current_wave++;
            fairy_text = "Bria: Watch out! More enemies are appearing!";
            // Reset with new enemies for the next wave
            enemies = [ 
                ["Parabolate", 30, room_width-320, 510, Parabolate, 0], 
                ["Linearf", 30, room_width-180, 600, Linearf, 0], 
                ["Parabolate", 30, room_width-460, 600, Parabolate, 0] 
            ];
            win_timer = -1;
        }
    } else {
        if (win_timer == -1) win_timer = 180;
        fairy_text = "Bria: You did it! The area is clear!";
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) room_goto(rm_Level2PostBattle);
    }
}