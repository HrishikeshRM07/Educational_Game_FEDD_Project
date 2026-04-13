battle_state = BattleState.PLAYER_MENU;
win_timer = -1; 
lose_timer = -1;

// --- BOSS SETUP ---
// Increased Y coordinate to 620 to push the boss lower
// Pushes boss to the right side of the 1366 width
// --- BOSS SETUP ---
enemies = [ 
    // [Name, HP, X, Y, Sprite, AnimFrame, FadeAlpha, FlashColor, FlashAlpha]
    ["SummationScorpion", 250, 1100, 620, SummationScorpion, 0, 1.0, c_white, 0.0] 
];

// --- PLAYER SETUP ---
player_hp = 100; player_max_hp = 100;
milly_hp = 100;  milly_max_hp = 100; 

active_char = 0; 
is_tutorial = false; 

milly_heal_buff = 0; party_buff = 0; enemy_debuff = 0;

selected_skill = -1;
problem_question = ""; problem_answer = 0;
problem_val1 = 0; problem_val2 = 0; 
player_input = ""; menu_index = 0; 

spell_timer_max = 600; spell_timer = spell_timer_max;
defend_timer_max = 300; defend_timer = defend_timer_max;
attack_timer = 0;       

fairy_text = "Watch out! It's the Summation Scorpion! Its attacks are much stronger!";
previous_fairy_text = "";
text_progress = 0; text_speed = 0.5;

// --- ANIMATION & FLASH SETUP ---
addeline_frame = 0; addeline_is_attacking = false; addeline_anim_end = 0;
milly_frame = 0;    milly_is_attacking = false;    milly_anim_end = 0;

player_flash_color = c_white; player_flash_alpha = 0.0; player_alpha = 1.0;
milly_flash_color = c_white;  milly_flash_alpha = 0.0;  milly_alpha = 1.0;