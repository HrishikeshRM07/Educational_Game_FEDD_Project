draw_text(50,50, "Player HP: " + string(player_hp));
draw_text(1150,50, "Enemy HP: " + string(enemy_hp));

switch(battle_state)
{
    case BattleState.PLAYER_MENU:
        draw_text(250,650,"1: Additive Heal");
        draw_text(250,710,"2: Subtraction Attack");
        draw_text(450,650,"3: Commutative Heal");
        draw_text(450,710,"4: Double Sub Attack");
    break;
    
    case BattleState.PLAYER_SOLVE:
        draw_text(50,200,"Solve: " + problem_question);
        draw_text(50,240,"Your Answer: " + player_input);
    break;
    
    case BattleState.WIN:
        draw_text(room_width/2, room_height/2, "YOU WIN!");
    break;
    
    case BattleState.LOSE:
        draw_text(room_width/2, room_height/2, "YOU LOSE!");
    break;
}

// Draw HP regardless of state
draw_text(50,50, "Player HP: " + string(player_hp));
draw_text(1150,50, "Enemy HP: " + string(enemy_hp));