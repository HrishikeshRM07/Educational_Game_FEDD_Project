// --- 1. BATTLE STATES ---
enum BattleState {
    PLAYER_MENU,
    PLAYER_SOLVE,
    ENEMY_TURN,
    WIN,
    LOSE
}
battle_state = BattleState.PLAYER_MENU;

// --- 2. CHARACTER STATS ---
player_hp = 100;
enemy_hp = 50;

// --- 3. MATH SYSTEM VARIABLES ---
selected_skill = -1;
problem_question = "";
problem_answer = 0;
player_input = "";

// These store the specific numbers used in the current math problem
// so the Fairy can reference them in her hints (e.g., "Take 4 from 10")
problem_val1 = 0;
problem_val2 = 0;

// --- 4. TUTORIAL & HINT SYSTEM ---
tutorial_active = true;   
tutorial_stage = 0;      
win_timer = 180;          

// Logic for showing the visual apple hints
is_showing_hint = false;  
wrong_answer_hint = "";    