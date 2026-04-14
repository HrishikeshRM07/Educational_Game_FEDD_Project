// --- 1. BATTLE STATES ---

battle_state = BattleState.PLAYER_MENU;

// --- 2. WAVE & ENEMY SETUP (SCALED FOR 1080p) ---
max_waves = 3;
current_wave = 1;
win_timer = -1; 

// Enemy Array Structure:
// [Name, HP, X, Y, Sprite, AnimFrame, Alpha, FlashColor, FlashAlpha]
enemies = [
    ["Linearf", 30, room_width - 450, 710, Linearf, 0, 1.0, c_white, 0.0]
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
target_index = 0;        // <--- ADD THIS
targeting_phase = false; // <--- ADD THIS


// --- 5. TIMERS ---
spell_timer_max = 600; 
spell_timer = spell_timer_max;
defend_timer_max = 600; // Increased to 10 seconds for a more relaxed defense
defend_timer = defend_timer_max;
attack_timer = 0;       

// --- 6. TYPEWRITER TEXT ---
fairy_text = "Bria: Use any skill you like! We have to clear all 3 waves!";
previous_fairy_text = "";
text_progress = 0;
text_speed = 2000;

// --- 7. ANIMATION SETUP ---
addeline_frame = 0;
addeline_is_attacking = false;
addeline_anim_end = 0;

// --- 8. FLASH & VISUAL EFFECTS ---
player_flash_color = c_white;
player_flash_alpha = 0;