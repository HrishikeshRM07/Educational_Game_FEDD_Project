// 1. HP CLAMPING
player_hp = clamp(player_hp, 0, 100);

// 2. 7-SECOND ENEMY SEQUENCE (3s Wait + 4s Attack)
if (attack_timer > 0) {
    attack_timer--;
    if (attack_timer > 240) fairy_text = "Great hit, Addeline! Get ready...";
    else if (attack_timer > 0) fairy_text = "They are attacking! Prepare yourself!";
    
    if (attack_timer == 0) {
        var total_dmg = 0;
        for (var i = 0; i < array_length(enemies); i++) {
            if (enemies[i][1] > 0) total_dmg += 6; // Small damage from each alive slime
        }
        player_hp -= total_dmg;
        battle_state = BattleState.PLAYER_MENU;
        fairy_text = "Your turn! Pick a spell!";
    }
}

// 3. WAVE & VICTORY LOGIC
var all_dead = true;
for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) all_dead = false; }

if (all_dead && attack_timer <= 0) {
    if (current_wave < max_waves) {
        if (win_timer == -1) {
            win_timer = 120; // 2 second pause
            fairy_text = "Well done! That's one wave down!";
        }
        
        if (win_timer > 0) win_timer--;
        
        if (win_timer == 0) {
            current_wave++;
            fairy_text = "Oh no! More enemies are appearing!";
            enemies = [
                ["Slime A", 30, room_width-320, 420], 
                ["Slime B", 30, room_width-180, 520], 
                ["Slime C", 30, room_width-460, 520]
            ];
            win_timer = -1;
        }
    } else {
        if (win_timer == -1) win_timer = 180;
        fairy_text = "You did it! The area is clear!";
        if (win_timer > 0) win_timer--;
        if (win_timer == 0) room_goto(rm_PostBattleStory);
    }
}

// 4. PLAYER INPUT & MATH
if (battle_state == BattleState.PLAYER_MENU && attack_timer <= 0) {
    // Standard Navigation code (WASD/Arrows)
    if (keyboard_check_pressed(vk_right)) menu_index = clamp(menu_index + 2, 0, 3);
    if (keyboard_check_pressed(vk_left))  menu_index = clamp(menu_index - 2, 0, 3);
    if (keyboard_check_pressed(vk_down))  menu_index = (menu_index % 2 == 0) ? menu_index + 1 : menu_index;
    if (keyboard_check_pressed(vk_up))    menu_index = (menu_index % 2 != 0) ? menu_index - 1 : menu_index;

    if (keyboard_check_pressed(vk_enter)) {
        selected_skill = menu_index + 1;
        generate_problem(selected_skill);
        player_input = "";
        spell_timer = spell_timer_max;
        battle_state = BattleState.PLAYER_SOLVE;
    }
}

if (battle_state == BattleState.PLAYER_SOLVE) {
    spell_timer--;
    if (spell_timer <= 0) { attack_timer = 240; battle_state = BattleState.ENEMY_TURN; }

    for (var i = 0; i <= 9; i++) { if (keyboard_check_pressed(ord(string(i)))) player_input += string(i); }
    if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

    if (keyboard_check_pressed(vk_enter) && player_input != "") {
        if (real(player_input) == problem_answer) {
            if (selected_skill == 1) {
                player_hp += 20; // HEAL PLAYER
            } else {
                for (var i = 0; i < array_length(enemies); i++) { if (enemies[i][1] > 0) enemies[i][1] -= 15; }
            }
            attack_timer = 420; // Start the 7s sequence
            battle_state = BattleState.ENEMY_TURN;
        } else { player_input = ""; }
    }
}