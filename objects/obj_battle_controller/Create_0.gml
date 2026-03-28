// --- 1. BATTLE STATES ---
enum BattleState {
    PLAYER_MENU,
    PLAYER_SOLVE,
    ENEMY_TURN,
    WIN,
    LOSE,
    DEFEND_MENU,  // NEW
    DEFEND_SOLVE
}
battle_state = BattleState.PLAYER_MENU;

// --- 2. CHARACTER STATS & POSITIONS ---
player_hp = 100;
enemy_hp = 50;

// Coordinates for the floating HP boxes
addeline_x = 200;  
addeline_y = 450; 
horatio_x = room_width - 250; 
horatio_y = 400; 

// --- 3. MATH SYSTEM ---
selected_skill = -1;
problem_question = "";
problem_answer = 0;
player_input = "";
problem_val1 = 0;
problem_val2 = 0;

// --- 4. NAVIGATION & UI ---
// 0=TopLeft, 1=BottomLeft, 2=TopRight, 3=BottomRight
menu_index = 0; 
tutorial_active = true;
tutorial_stage = 0;
is_showing_hint = false;
wrong_answer_hint = "";
win_timer = 180;

// --- POSITIONING ---
addeline_x = 180;
addeline_y = 480;
horatio_x = room_width - 200;
horatio_y = 420;

// --- MENU NAVIGATION ---
menu_index = 0; // 0: TopLeft, 1: BottomLeft, 2: TopRight, 3: BottomRight
selected_skill = -1;
battle_state = BattleState.PLAYER_MENU;

// Visual polish
cursor_x = 0; // For smooth underline movement

// --- TUTORIAL SCRIPTING ---
attack_timer = 0; // Initialize the timer so the Step Event can read it
tutorial_stage = 0; 
fairy_text = "Thank you for your help! Let me show you how mathemagical skills work so that you can defeat Horatio. First, press on Subtraction.";

// --- HP STATS ---
player_hp = 100;
player_max_hp = 100; 
enemy_hp = 50;

win_timer = -1; // -1 means the battle is still going