battle_state = BattleState.PLAYER_MENU;
win_timer = -1; 
lose_timer = -1;

// --- BOSS SETUP ---
phi_max_hp = 50; // 400 allows for clean thresholds: 300 (3/4), 200 (1/2), 100 (1/4)
// Positioned similarly to Summation Scorpion
enemies = [ 
    ["KingPhi", phi_max_hp, 1100, 620, KingPhi, 0] 
];

// --- DIALOGUE TRIGGERS ---
triggered_34 = false;
triggered_12 = false;
triggered_14 = false;
triggered_0 = false;

// --- PLAYER SETUP ---
player_hp = 100; player_max_hp = 100; // Addeline
milly_hp = 100;  milly_max_hp = 100;
erin_hp = 100;   erin_max_hp = 100;

active_char = 0; // Default to Addeline

milly_heal_buff = 0; party_buff = 0; enemy_debuff = 0;
erin_dmg_boost = false; 

selected_skill = -1;
problem_question = ""; problem_answer = 0;
problem_val1 = 0; problem_val2 = 0; 
player_input = ""; menu_index = 0; 

spell_timer_max = 600; spell_timer = spell_timer_max;
defend_timer_max = 300; defend_timer = defend_timer_max;
attack_timer = 0;       

// Battle Begins Dialogue
fairy_text = "Bria: This is it, everyone! King Phi is right in front of us. Be ready for anything!";
previous_fairy_text = "";
text_progress = 0; text_speed = 0.5;

// --- ANIMATION SETUP ---
addeline_frame = 0; addeline_is_attacking = false; addeline_anim_end = 0;
milly_frame = 0;    milly_is_attacking = false;    milly_anim_end = 0;
erin_frame = 0;     erin_is_attacking = false;     erin_anim_end = 0;

// --- UI VARIABLES ---
hud_start_x = 231;       
hud_btn_width = 98;      
hud_btn_spacing = 308;

// --- HEALTH & STATE MANAGEMENT ---
player_hp = clamp(player_hp, 0, player_max_hp);
milly_hp = clamp(milly_hp, 0, milly_max_hp);
erin_hp = clamp(erin_hp, 0, erin_max_hp);