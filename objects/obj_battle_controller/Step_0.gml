switch (battle_state)
{
    case BattleState.PLAYER_MENU:
        var key = -1;
        if (keyboard_check_pressed(ord("1"))) key = 1;
        if (keyboard_check_pressed(ord("2"))) key = 2;
        if (keyboard_check_pressed(ord("3"))) key = 3;
        if (keyboard_check_pressed(ord("4"))) key = 4;

        if (key != -1) {
            // Tutorial Lock: Force correct skill selection
            if (tutorial_active) {
                var required = [2, 1, 4, 3]; 
                if (key != required[tutorial_stage]) exit; 
            }
            
            selected_skill = key;
            generate_problem(selected_skill); // Make sure this sets problem_val1/val2
            battle_state = BattleState.PLAYER_SOLVE;
            is_showing_hint = false; // Clear any old hints
        }
    break;
    
    case BattleState.PLAYER_SOLVE:
        // Typing Input
        for (var i = 0; i <= 9; i++) {
            if (keyboard_check_pressed(ord(string(i)))) player_input += string(i);
        }

        if (keyboard_check_pressed(vk_backspace)) {
            player_input = string_delete(player_input, string_length(player_input), 1);
        }

        // Check Answer
        if (keyboard_check_pressed(vk_enter)) {
            if (player_input != "") {
                if (real(player_input) == problem_answer) {
                    // --- CORRECT ---
                    is_showing_hint = false; // Turn OFF the hint/image immediately
                    execute_skill(selected_skill);
                    player_input = "";

                    if (tutorial_active) {
                        tutorial_stage++;
                        if (tutorial_stage > 3) tutorial_active = false;
                    }

                    // Skill 3 Logic: No Turn Change
                    if (selected_skill == 3) {
                        battle_state = BattleState.PLAYER_MENU;
                    } else if (battle_state == BattleState.PLAYER_SOLVE) {
                        battle_state = BattleState.ENEMY_TURN;
                    }
                } else {
                    // --- WRONG ---
                    is_showing_hint = true; // Turn ON the hint/image
                    player_input = "";      // Clear input for a fresh try

                    switch(selected_skill) {
                        case 1: wrong_answer_hint = "Try counting up! If you have " + string(problem_val1) + " and add " + string(problem_val2) + ", what's the total?"; break;
                        case 2: wrong_answer_hint = "Start with " + string(problem_val1) + " and take away " + string(problem_val2) + ". How many are left?"; break;
                        case 4: wrong_answer_hint = "Subtract the first small number, then subtract the next one from what's left!"; break;
                        case 3: wrong_answer_hint = "The order doesn't matter! 5 + 10 is the same as 10 + 5."; break;
                    }
                }
            }
        }
    break;

    case BattleState.ENEMY_TURN:
        player_hp -= 5;
        battle_state = (player_hp <= 0) ? BattleState.LOSE : BattleState.PLAYER_MENU;
    break;

    case BattleState.WIN:
        win_timer--;
        if (win_timer <= 0) room_goto(rm_PostBattleStory);
    break;
}


