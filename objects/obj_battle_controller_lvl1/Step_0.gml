// 1. HP CLAMPING
player_hp = clamp(player_hp, 0, 100);

// 2. TYPEWRITER LOGIC
// If the text changes, reset the typewriter automatically
if (fairy_text != previous_fairy_text) {
    text_progress = 0;
    previous_fairy_text = fairy_text;
}
if (text_progress < string_length(fairy_text)) {
    text_progress += text_speed;
}

// 3. ENEMY ATTACK SEQUENCE
if (attack_timer > 0) {
    attack_timer--;
    if (attack_timer > 240) fairy_text = "Great hit, Addeline! Get ready...";
    else if (attack_timer > 0) fairy_text = "They are attacking! Prepare yourself!";
    
    if (attack_timer == 0) {
        // Instead of taking damage instantly, move to defense phase!
        battle_state = BattleState.DEFEND_MENU;
        menu_index = 0;
        fairy_text = "Quick! Pick a shield to defend!";
    }
}

// 4. PLAYER INPUT - ATTACK MENU
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0) {
    if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
    if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
    if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
    if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;

    if (keyboard_check_pressed(vk_enter)) {
        selected_skill = menu_index + 1;
        generate_problem(selected_skill, 0);
        player_input = "";
        spell_timer = spell_timer_max;
        battle_state = BattleState.PLAYER_SOLVE;
        fairy_text = "Solve it to cast your spell!";
    }
}

// 5. PLAYER INPUT - DEFEND MENU
if (battle_state == BattleState.DEFEND_MENU) {
    if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
    if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
    if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
    if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;

    if (keyboard_check_pressed(vk_enter)) {
        selected_skill = menu_index + 1;
        generate_problem(selected_skill, 0); // Generates a problem just like attacking
        player_input = "";
        defend_timer = defend_timer_max;
        battle_state = BattleState.DEFEND_SOLVE;
        fairy_text = "Block the attack!";
    }
}

// 6. TYPING THE ANSWER (Works for both Offense and Defense)
if (battle_state == BattleState.PLAYER_SOLVE || battle_state == BattleState.DEFEND_SOLVE) {
    
    // Handle typing numbers
    for (var i = 0; i <= 9; i++) { if (keyboard_check_pressed(ord(string(i)))) player_input += string(i); }
    if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

    // If Attacking
    if (battle_state == BattleState.PLAYER_SOLVE) {
        spell_timer--;
        if (spell_timer <= 0) { 
            attack_timer = 240; 
            battle_state = BattleState.ENEMY_TURN; 
            fairy_text = "Time's up! You missed your turn!";
        }

        if (keyboard_check_pressed(vk_enter) && player_input != "") {
            if (real(player_input) == problem_answer) {
                
                // 1. Heal or Damage
                if (selected_skill == 1) {
                    player_hp += 20; // HEAL
                } else {
                    for (var i = 0; i < array_length(enemies); i++) { 
                        if (enemies[i][1] > 0) enemies[i][1] -= 15; 
                    } // DAMAGE
                }
                
                // 2. NEW: Check if we just killed the last enemy!
                var enemies_dead = true;
                for (var i = 0; i < array_length(enemies); i++) { 
                    if (enemies[i][1] > 0) enemies_dead = false; 
                }
                
                // 3. Decide what happens next
                if (enemies_dead) {
                    attack_timer = 0; // Cancel the enemy attack!
                    battle_state = BattleState.PLAYER_MENU; // Return to menu so the Victory logic triggers
                } else {
                    attack_timer = 420; // Start the 7s enemy sequence
                    battle_state = BattleState.ENEMY_TURN;
                }
                
            } else { 
                player_input = ""; // Clears if wrong
            }
        }
    }

    // If Defending
    if (battle_state == BattleState.DEFEND_SOLVE) {
        defend_timer--;
        var missed_defense = false;

        // Check if they pressed enter to submit an answer
        if (keyboard_check_pressed(vk_enter) && player_input != "") {
            if (real(player_input) == problem_answer) {
                // Correct! Blocked!
                fairy_text = "Perfect Block! Your turn!";
                battle_state = BattleState.PLAYER_MENU;
                menu_index = 0;
            } else {
                // Wrong answer!
                missed_defense = true;
            }
        }

        // Check if time ran out
        if (defend_timer <= 0) {
            missed_defense = true;
        }

        // If they got it wrong OR ran out of time
        if (missed_defense) {
            var total_dmg = 0;
            for (var i = 0; i < array_length(enemies); i++) {
                if (enemies[i][1] > 0) total_dmg += 6; 
            }
            player_hp -= total_dmg;
            fairy_text = "Ouch! You took damage! Your turn!";
            battle_state = BattleState.PLAYER_MENU;
            menu_index = 0;
        }
    }
}

// 7. WAVE & VICTORY LOGIC (Unchanged from your logic)
var all_dead = true;
for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) all_dead = false; }

if (all_dead && attack_timer <= 0 && battle_state == BattleState.PLAYER_MENU) {
    if (current_wave < max_waves) {
        if (win_timer == -1) { win_timer = 120; fairy_text = "Well done! That's one wave down!"; }
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) {
            current_wave++;
            fairy_text = "Oh no! More enemies are appearing!";
            enemies = [ ["Slime A", 30, room_width-320, 420], ["Slime B", 30, room_width-180, 520], ["Slime C", 30, room_width-460, 520] ];
            win_timer = -1;
        }
    } else {
        if (win_timer == -1) win_timer = 180;
        fairy_text = "You did it! The area is clear!";
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) room_goto(rm_Level1PostBattle);
    }
}