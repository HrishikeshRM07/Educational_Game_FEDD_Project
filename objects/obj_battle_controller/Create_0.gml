enum BattleState {
    PLAYER_MENU,
    PLAYER_SOLVE,
    ENEMY_TURN,
    WIN,
    LOSE
}

battle_state = BattleState.PLAYER_MENU;

player_hp = 100;
enemy_hp = 50;

selected_skill = -1;
problem_question = "";
problem_answer = 0;
player_input = "";