// --- 1. BATTLE STATES ---
enum BattleState {
    PLAYER_MENU, PLAYER_SOLVE, ENEMY_TURN, WIN, LOSE, DEFEND_MENU, DEFEND_SOLVE
}
battle_state = BattleState.PLAYER_MENU;

// --- 2. CHARACTER STATS & POSITIONS (SCALED FOR 1080p) ---
player_hp = 100;
player_max_hp = 100; 
enemy_hp = 50;

addeline_x = 250;  
addeline_y = 680; 

// Anchored to the new right edge and moved down
horatio_x = room_width - 470; 
horatio_y = 900; // Increased from 600 to push him further down

// --- 3. MATH SYSTEM ---
selected_skill = -1;
problem_question = "";
problem_answer = 0;
player_input = "";
problem_val1 = 0;
problem_val2 = 0;

// --- 4. NAVIGATION & UI ---
menu_index = 0; 
cursor_x = 0; 


// --- 5. TUTORIAL SCRIPTING ---
tutorial_active = true;
tutorial_stage = 0;
is_showing_hint = false;
wrong_answer_hint = "";

attack_timer = 0; 
win_timer = -1; 
fairy_text = "Thank you for your help! Let me show you how mathemagical skills work so that you can defeat Horatio. First, press the arrow key, until you\u0027re on the skill: Sub-tract the health";

// --- 6. ANIMATION SETUP ---
addeline_frame = 0;
addeline_is_attacking = false;
addeline_anim_end = 0;

horatio_frame = 0; // NEW: Horatio animation tracker

// --- 7. FLASH & VISUAL EFFECTS (NEW) ---
player_flash_color = c_white;
player_flash_alpha = 0;

enemy_flash_color = c_white;
enemy_flash_alpha = 0;
enemy_alpha = 1.0; // Used to make Horatio disappear on death

defend_timer_max = 300;
defend_timer = defend_timer_max;