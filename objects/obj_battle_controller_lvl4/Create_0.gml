// ==========================================
// 1. BATTLE STATES & WAVES
// ==========================================
battle_state = BattleState.PLAYER_MENU;

max_waves = 3; 
current_wave = 1; 
win_timer = -1; 
lose_timer = -1;

// --- WAVE 1 SETUP ---
// Structure: [Name, HP, X, Y, Sprite, AnimFrame, FadeAlpha, FlashColor, FlashAlpha]
enemies = [ 
    ["GoldmanShort", 40, room_width - 252, 840, GoldmanShort, 0, 1.0, c_white, 0.0], 
    ["GoldmanShort", 40, room_width - 644, 840, GoldmanShort, 0, 1.0, c_white, 0.0],
    ["GoldmanTall", 60, room_width - 448, 714, GoldmanTall, 0, 1.0, c_white, 0.0]
];

// ==========================================
// 2. CHARACTER STATS & FLAGS
// ==========================================
player_hp = 100; player_max_hp = 100;
milly_hp = 100;  milly_max_hp = 100;
erin_hp = 100;   erin_max_hp = 100;

active_char = 2; // Start on Erin to introduce her
is_tutorial = true; 
erin_tutorial_step = 0; 

milly_heal_buff = 0; party_buff = 0; enemy_debuff = 0;
erin_dmg_boost = false; 
target_index = 0; 

// ==========================================
// 3. MATH & UI VARIABLES
// ==========================================
selected_skill = -1;
problem_question = ""; problem_answer = 0;
problem_val1 = 0; problem_val2 = 0; problem_val3 = 0;
player_input = ""; menu_index = 0; 
targeting_phase = false;

spell_timer_max = 1000; spell_timer = spell_timer_max;
defend_timer_max = 1000; defend_timer = defend_timer_max;
attack_timer = 0;        

fairy_text = "Erin\u0027s first skill Damage Squared will double the damage of Erin\u0027s next attack, although it does drain 5 of Erin’s health. Erin\u0027s skills are based around using exponents and square roots. When something is squared, that means you\u0027re multiplying it by itself one time. For example, if I have 3² that means that I have 3 x 3, which equals 9! You can think of the number in the exponent as the number of times something will multiply by itself. But be careful! You can\u0027t add numbers when you do exponents, you can only multiply them.";
previous_fairy_text = "";
text_progress = 0; text_speed = 0.5;

// ==========================================
// 4. ANIMATION & EFFECTS SETUP
// ==========================================
addeline_frame = 0; addeline_is_attacking = false; addeline_anim_end = 0;
milly_frame = 0;    milly_is_attacking = false;    milly_anim_end = 0;
erin_frame = 0;     erin_is_attacking = false;     erin_anim_end = 0;

player_flash_color = c_white; player_flash_alpha = 0.0;
milly_flash_color = c_white;  milly_flash_alpha = 0.0;
erin_flash_color = c_white;   erin_flash_alpha = 0.0;

// HUD Settings
hud_start_x = 231;       
hud_btn_width = 98;      
hud_btn_spacing = 308;
