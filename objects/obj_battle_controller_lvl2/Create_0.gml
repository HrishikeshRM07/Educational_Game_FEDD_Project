// --- 1. BATTLE STATES ---
battle_state = BattleState.PLAYER_MENU;

max_waves = 4; // Updated to 4 Waves
current_wave = 1; 
win_timer = -1; 
lose_timer = -1; 

// --- 2. WAVE & ENEMY SETUP ---
// Structure: [Name, HP, X, Y, Sprite, AnimFrame, FadeAlpha, FlashColor, FlashAlpha]
// Wave 1: Ananan, Parabolate
enemies = [ 
    ["Ananan", 30, room_width - 450, 710, Ananan, 0, 1.0, c_white, 0.0], 
    ["Parabolate", 30, room_width - 250, 840, Parabolate, 0, 1.0, c_white, 0.0]
];

// --- 3. CHARACTER STATS ---
player_hp = 100; player_max_hp = 100;
milly_hp = 40;   milly_max_hp = 100;

active_char = 1; // Start on Milly for the Tutorial
milly_tutorial_step = 0; // 0=Skill1, 1=Skill2, 2=Skill3, 3=Skill4, 4=Tutorial Done!
is_tutorial = true;

milly_heal_buff = 0; party_buff = 0; enemy_debuff = 0;
target_index = 0; // Target tracking

// --- 4. MATH & UI ---
selected_skill = -1;
problem_question = ""; problem_answer = 0;
problem_val1 = 0; problem_val2 = 0; problem_val3 = 0; // Added val3 for multi-step math
player_input = ""; menu_index = 0; 
targeting_phase = false; 

// --- 5. TIMERS ---
spell_timer_max = 900; spell_timer = spell_timer_max;
defend_timer_max = 900; defend_timer = defend_timer_max;
attack_timer = 0;        

// --- 6. TYPEWRITER TEXT ---
fairy_text = "Milly\u0027s skills focus on multiplication and division. Let\u0027s start with multiplication! Health multiplies! Provides a buff to the amount of health that can be restored with one healing skill! You can think of multiplying something a bit like adding the same number over and over. If I have 10 strawberries, and I double (multiply by 2) that amount, then I\u0027ll end up with 20 strawberries, which is the same as 10 + 10! Now you give it a try.";
previous_fairy_text = "";
text_progress = 0; text_speed = 0.75;

// Health & State Clamping
player_hp = clamp(player_hp, 0, player_max_hp);
milly_hp = clamp(milly_hp, 0, milly_max_hp);
is_tutorial = (milly_tutorial_step < 4);

// --- 7. ANIMATION SETUP ---
addeline_frame = 0; addeline_is_attacking = false; addeline_anim_end = 0;
milly_frame = 0; milly_is_attacking = false; milly_anim_end = 0;

// --- 8. FLASH & FADE EFFECTS ---
player_flash_color = c_white; player_flash_alpha = 0.0;
milly_flash_color = c_white; milly_flash_alpha = 0.0;