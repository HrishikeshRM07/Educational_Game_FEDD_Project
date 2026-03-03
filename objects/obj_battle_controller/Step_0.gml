
switch (battle_state)
{
    case BattleState.PLAYER_MENU:
        if (keyboard_check_pressed(ord("1")))
        {
            selected_skill = 1;
            generate_problem(selected_skill);
            battle_state = BattleState.PLAYER_SOLVE;
        }
        if (keyboard_check_pressed(ord("2")))
        {
            selected_skill = 2;
            generate_problem(selected_skill);
            battle_state = BattleState.PLAYER_SOLVE;
        }
        if (keyboard_check_pressed(ord("3")))
        {
            selected_skill = 3;
            generate_problem(selected_skill);
            battle_state = BattleState.PLAYER_SOLVE;
        }
        if (keyboard_check_pressed(ord("4")))
        {
            selected_skill = 4;
            generate_problem(selected_skill);
            battle_state = BattleState.PLAYER_SOLVE;
        }
    break;
    
    case BattleState.PLAYER_SOLVE:
        // Number Input
        for (var i = 0; i <= 9; i++)
        {
            if (keyboard_check_pressed(ord(string(i))))
            {
                player_input += string(i);
            }
        }

        // Backspace
        if (keyboard_check_pressed(vk_backspace))
        {
            if (string_length(player_input) > 0) {
                player_input = string_delete(player_input, string_length(player_input), 1);
            }
        }

        // Enter
        if (keyboard_check_pressed(vk_enter))
        {
            if (real(player_input) == problem_answer)
                {
                    execute_skill(selected_skill);
                }
                player_input = "";

                // Only go to enemy turn if battle still ongoing
                if (battle_state == BattleState.PLAYER_SOLVE)
                {
                    battle_state = BattleState.ENEMY_TURN;
                }
        }
    break;

    case BattleState.ENEMY_TURN:
        player_hp -= 5;
        if (player_hp <= 0)
        {
            battle_state = BattleState.LOSE;
        }
        else
        {
            battle_state = BattleState.PLAYER_MENU;
        }
    break;
}

