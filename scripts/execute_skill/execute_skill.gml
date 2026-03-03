function execute_skill(skill)
{
    switch(skill)
    {
        case 1: // Additive Heal
            player_hp += 15;
        break;
        
        case 2: // Subtraction Attack
            enemy_hp -= 15;
        break;
        
        case 3: // Commutative Heal
            player_hp += 25;
        break;
        
        case 4: // Double Subtraction Attack
            enemy_hp -= 25;
        break;
    }

    // Check if enemy died
    if (enemy_hp <= 0)
    {
        enemy_hp = 0;       // Optional: prevent negative display
        battle_state = BattleState.WIN;
    }
}