
battle_state = BattleState.PLAYER_MENU;

max_waves = 3; 
current_wave = 1; 
win_timer = -1; 

// Start with Linearf and Parabolate, formatted for animations and pushed down to the ground
enemies = [ 
    ["Linearf", 30, room_width - 320, 510, Linearf, 0], 
    ["Parabolate", 30, room_width - 180, 600, Parabolate, 0],
    ["Linearf", 30, room_width - 460, 600, Linearf, 0]
];

player_hp = 100; player_max_hp = 100;
milly_hp = 40;   milly_max_hp = 100;

active_char = 1; // Start on Milly
milly_tutorial_step = 0; // 0=Skill1, 1=Skill2, 2=Skill3, 3=Skill4, 4=Tutorial Done!
is_tutorial = true;

milly_heal_buff = 0; party_buff = 0; enemy_debuff = 0;

selected_skill = -1;
problem_question = ""; problem_answer = 0;
problem_val1 = 0; problem_val2 = 0; // For hints
player_input = ""; menu_index = 0; 

spell_timer_max = 600; spell_timer = spell_timer_max;
defend_timer_max = 300; defend_timer = defend_timer_max;
attack_timer = 0;       

fairy_text = "Bria: Milly’s skills focus on multiplication and division. Let’s start with multiplication! <Skill 1> Provides a buff to healing! Now you give it a try.";
previous_fairy_text = "";
text_progress = 0; text_speed = 0.5;

// --- HEALTH & STATE MANAGEMENT ---
player_hp = clamp(player_hp, 0, player_max_hp);
milly_hp = clamp(milly_hp, 0, milly_max_hp);
is_tutorial = (milly_tutorial_step < 4);

// --- 8. ANIMATION SETUP ---
addeline_frame = 0;
addeline_is_attacking = false;
addeline_anim_end = 0;

milly_frame = 0;
milly_is_attacking = false;
milly_anim_end = 0;