// --- STEP EVENT: obj_battle_controller ---
// --- DEBUG SKIP ---
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_PostBattleStory);
}
// 1. HP CLAMPING & VICTORY CHECK
player_hp = clamp(player_hp, 0, 100);
enemy_hp = clamp(enemy_hp, 0, 50);

// If Horatio hits 0 HP, trigger the win timer (if not already triggered)
if (enemy_hp <= 0 && win_timer == -1) {
    win_timer = 180; // 3 seconds at 60fps
    fairy_text = "You did it! Horatio is defeated!";
}

// Countdown to transition to the next room
if (win_timer > 0) {
    win_timer--;
    if (win_timer == 0) room_goto(rm_PostBattleStory);
    exit; // Stop running the rest of the battle logic if we won
}

// 2. SEQUENCE TIMER LOGIC (Pauses and Scripted Events)
if (attack_timer > 0) {
    attack_timer--;
    
    // Stage 0 (Sub) & Stage 2 (Heal completed -> ME Summon)
    if (tutorial_stage == 0 || tutorial_stage == 2) {
        if (attack_timer == 120) {
            if (tutorial_stage == 0) fairy_text = "Here comes his attack! Prepare yourself to solve this equation!";
            if (tutorial_stage == 2) fairy_text = "Horatio is utilizing another skill to summon an ME! Prepare yourself!";
        }
        
        if (attack_timer == 0) {
            if (tutorial_stage == 0) {
                player_hp -= 20; 
                fairy_text = "Uh oh! That hit you bad! But don't worry, you can also heal. Click on Additive Power!";
                tutorial_stage = 1;
            } else {
                fairy_text = "He's gathering forces... but we have a skill for this. Press on <Skill 4>!";
                tutorial_stage = 3;
            }
            battle_state = BattleState.PLAYER_MENU;
        }
    }
}

// 3. MAIN BATTLE STATE MACHINE
switch (battle_state) 
{
    case BattleState.PLAYER_MENU:
        // --- NAVIGATION ---
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) menu_index = clamp(menu_index + 2, 0, 3);
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")))  menu_index = clamp(menu_index - 2, 0, 3);
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
            if (menu_index == 0) menu_index = 1; else if (menu_index == 2) menu_index = 3;
        }
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
            if (menu_index == 1) menu_index = 0; else if (menu_index == 3) menu_index = 2;
        }

        // --- FORCED TUTORIAL SELECTION ---
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
                generate_problem(selected_skill); 
                battle_state = BattleState.PLAYER_SOLVE;
                player_input = ""; 
                
                // Explanations on click
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
        // --- INPUT ---
        for (var i = 0; i <= 9; i++) {
            if (keyboard_check_pressed(ord(string(i)))) player_input += string(i);
        }
        if (keyboard_check_pressed(vk_backspace)) player_input = string_delete(player_input, string_length(player_input), 1);

        // --- CHECK ANSWER ---
        if (keyboard_check_pressed(vk_enter) && player_input != "") {
            if (real(player_input) == problem_answer) {
                execute_skill(selected_skill); 
                is_showing_hint = false;
                
                // SUCCESS LOGIC PER STAGE
                if (tutorial_stage == 0) {
                    fairy_text = "Well done!"; 
                    attack_timer = 240; 
                    battle_state = BattleState.ENEMY_TURN; 
                } 
                else if (tutorial_stage == 1) {
                    fairy_text = "Well done!";
                    attack_timer = 240; // 2s "Well done", 2s "ME Summon"
                    tutorial_stage = 2; 
                    battle_state = BattleState.ENEMY_TURN;
                }
                else if (tutorial_stage == 3) {
                    fairy_text = "You knocked out the ME! You're almost there. I'll give us extra time...";
                    tutorial_stage = 4;
                    battle_state = BattleState.PLAYER_MENU;
                }
                else if (tutorial_stage == 4) {
                    fairy_text = "You're ready to go! Give it your best shot!";
                    tutorial_stage = 5;
                    battle_state = BattleState.PLAYER_MENU; // No turn change for Commutative
                }
                else {
                    battle_state = BattleState.ENEMY_TURN;
                }
            } 
            else {
                // WRONG - Hints
                player_input = "";
                if (selected_skill == 2) fairy_text = "Think of it like this: If I had 3 apples, and I gave 1 to you, I’d be left with 2 apples. Now you try it!";
                if (selected_skill == 1) fairy_text = "For example! If you have 3 bows and I have 6 bows, together we’d have 9 bows. Now you try it!";
                if (selected_skill == 4) fairy_text = "If I have 38 cupcakes, I give 3 to you and 5 to a friend, I’ll have 38-3-5 left, which is 30! Now you try it.";
                if (selected_skill == 3) fairy_text = "If I have 10 cookies, you give me 5, and a friend gives me 5, I'd end up with 20! The order doesn't matter!";
            }
        }
    break;

    case BattleState.ENEMY_TURN:
        if (attack_timer <= 0) battle_state = BattleState.PLAYER_MENU;
    break;
}