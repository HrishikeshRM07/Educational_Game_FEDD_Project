battle_state = BattleState.PLAYER_MENU;

max_waves = 3; 
current_wave = 1; 
win_timer = -1; 
lose_timer = -1;

// --- WAVE 1 SETUP ---
enemies = [ 
    ["GoldmanShort", 40, room_width - 320, 600, GoldmanShort, 0], 
    ["GoldmanShort", 40, room_width - 180, 600, GoldmanShort, 0]
];

// --- PLAYER SETUP ---
player_hp = 100; player_max_hp = 100;
milly_hp = 100;  milly_max_hp = 100;
erin_hp = 100;   erin_max_hp = 100;

active_char = 2; // Start on Erin to introduce her
is_tutorial = false; 

milly_heal_buff = 0; party_buff = 0; enemy_debuff = 0;
erin_dmg_boost = false; // For Erin's Skill 1

selected_skill = -1;
problem_question = ""; problem_answer = 0;
problem_val1 = 0; problem_val2 = 0; 
player_input = ""; menu_index = 0; 

spell_timer_max = 600; spell_timer = spell_timer_max;
defend_timer_max = 300; defend_timer = defend_timer_max;
attack_timer = 0;       

fairy_text = "Bria: Erin joined the team! Her skills use powers and roots! Let's clear these waves out!";
previous_fairy_text = "";
text_progress = 0; text_speed = 0.5;

// --- HEALTH & STATE MANAGEMENT ---
player_hp = clamp(player_hp, 0, player_max_hp);
milly_hp = clamp(milly_hp, 0, milly_max_hp);
erin_hp = clamp(erin_hp, 0, erin_max_hp);

// --- 8. ANIMATION SETUP ---
addeline_frame = 0; addeline_is_attacking = false; addeline_anim_end = 0;
milly_frame = 0;    milly_is_attacking = false;    milly_anim_end = 0;
erin_frame = 0;     erin_is_attacking = false;     erin_anim_end = 0;