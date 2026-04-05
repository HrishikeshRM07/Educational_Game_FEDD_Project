
battle_state = BattleState.PLAYER_MENU;

// --- 2. WAVE & ENEMY SETUP ---
max_waves = 3;
current_wave = 1;
win_timer = -1; 

enemies = [
    ["Absarf", 30, room_width - 320, 510, Absarf, 0], // Pushed down to 580
    ["Ananan", 30, room_width - 180, 600, Ananan, 0], // Pushed down to 600
    ["Absarf", 30, room_width - 460, 600, Absarf, 0]  // Pushed down to 600
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

// --- 5. TIMERS ---
spell_timer_max = 600; 
spell_timer = spell_timer_max;
defend_timer_max = 300; // 5 seconds to solve the defense problem
defend_timer = defend_timer_max;
attack_timer = 0;       

// --- 6. TYPEWRITER TEXT ---
fairy_text = "Bria: Use any skill you like! We have to clear all 3 waves!";
previous_fairy_text = "";
text_progress = 0;
text_speed = 0.5;

// --- 7. ANIMATION SETUP ---
addeline_frame = 0;
addeline_is_attacking = false;
addeline_anim_end = 0;