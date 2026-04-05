battle_state = BattleState.PLAYER_MENU;
win_timer = -1; 
lose_timer = -1;

// --- BOSS SETUP ---
// Increased Y coordinate to 620 to push the boss lower
enemies = [ 
    ["SummationScorpion", 250, room_width - 250, 620, SummationScorpion, 0] 
];

// --- PLAYER SETUP ---
player_hp = 100; player_max_hp = 100;
milly_hp = 100;  milly_max_hp = 100; // Assuming Milly starts full for the boss!

active_char = 0; // Start on Addeline
is_tutorial = false; // Turned off for the boss fight

milly_heal_buff = 0; party_buff = 0; enemy_debuff = 0;

selected_skill = -1;
problem_question = ""; problem_answer = 0;
problem_val1 = 0; problem_val2 = 0; 
player_input = ""; menu_index = 0; 

spell_timer_max = 600; spell_timer = spell_timer_max;
defend_timer_max = 300; defend_timer = defend_timer_max;
attack_timer = 0;       

fairy_text = "Bria: Watch out! It's the Summation Scorpion! Its attacks are much stronger!";
previous_fairy_text = "";
text_progress = 0; text_speed = 0.5;

// --- ANIMATION SETUP ---
addeline_frame = 0; addeline_is_attacking = false; addeline_anim_end = 0;
milly_frame = 0;    milly_is_attacking = false;    milly_anim_end = 0;