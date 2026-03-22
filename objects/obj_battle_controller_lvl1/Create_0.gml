// --- 1. BATTLE STATES ---
// (We assume BattleState is already defined in your global/tutorial script)
battle_state = BattleState.PLAYER_MENU;

// --- 2. WAVE & ENEMY SETUP ---
max_waves = 3;
current_wave = 1;
win_timer = -1; // Used for pauses between waves and final victory

// Array: [Name, HP, X, Y]
enemies = [
    ["Slime A", 30, room_width - 320, 420],
    ["Slime B", 30, room_width - 180, 520],
    ["Slime C", 30, room_width - 460, 520]
];

// --- 3. CHARACTER STATS ---
player_hp = 100;
player_max_hp = 100;

// --- 4. MATH & UI ---
selected_skill = -1;
problem_question = "";
problem_answer = 0;
player_input = "";
menu_index = 0; 
fairy_text = "Bria: Use any skill you like! We have to clear all 3 waves!";

// --- 5. TIMERS ---
spell_timer_max = 600; // 10 seconds at 60fps
spell_timer = spell_timer_max;
attack_timer = 0;      // Manages the 3s wait + 4s attack sequence