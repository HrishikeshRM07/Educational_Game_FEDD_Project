// ==========================================
// 1. DRAWING THE FADE TO BLACK 
// ==========================================
// We draw this first so the characters/background fade away, 
// but the dialogue box and text drawn underneath will stay on top!
if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    // Draw a rectangle over the entire 1920x1080 screen
    draw_rectangle(0, 0, 1920, 1080, false); 
    draw_set_alpha(1.0); // Reset alpha so the dialogue box doesn't turn invisible!
}

// ==========================================
// 2. DIALOGUE BOX UI DRAWING
// ==========================================
var box_x = 160; 
var box_y = 720; 
var box_w = 1600; 
var box_h = 320;  

// Safety check: only draw if the dialogue hasn't ended.
if (current_line < array_length(dialogue)) {
    var data = dialogue[current_line];
    
    // --- LAYER 1: THE PORTRAIT (DRAWN FIRST = BACK) ---
    var port_x, port_y, x_scale;
    
    if (data.s == "King Phi" || data.s == "Narrator") {
        port_x = box_x + box_w - 120; 
        x_scale = 1.3;              
    } else {
        port_x = box_x + 300;        
        x_scale = 1.3;               
    }
    
    port_y = box_y + 170; 

    var face_frame = 0;

    // Use dialogue-defined emotion FIRST
    if (variable_struct_exists(data, "f")) {
        face_frame = data.f;
    }
    else if (data.s == "Addeline") {
        if (player_hp > 99) face_frame = 0;
        else if (player_hp > 40) face_frame = 1;
        else if (player_hp > 0) face_frame = 2;
        else face_frame = 3;
    }

    // Only draw the portrait if the screen IS NOT fully faded to black yet
    if (sprite_exists(data.port) && fade_alpha < 1) {
        draw_sprite_ext(data.port, face_frame, port_x, port_y, x_scale, 1.3, 0, c_white, 1 - fade_alpha);
    }

    // --- LAYER 2: THE MAIN BOX ---
    if (sprite_exists(spr_dialogue_base)) {
        draw_sprite_stretched(spr_dialogue_base, 0, box_x-190, box_y-90, box_w+300, box_h+90);
    }

    // --- LAYER 2.5: THE NAME TAG BACKGROUND ---
    var name_tag_absolute_x = 180; 
    var name_tag_absolute_y = 660; 
    
    var name_tag_scale = 28.0; 
    var name_tag_manual_width = 500; 
    var name_tag_manual_height = 140; 

    // Hide the nametag if there's no speaker
    if (sprite_exists(pl_name) && data.s != "") {
        var final_x_scale, final_y_scale;
        if (name_tag_manual_width > 0 && name_tag_manual_height > 0) {
            final_x_scale = name_tag_manual_width / sprite_get_width(pl_name);
            final_y_scale = name_tag_manual_height / sprite_get_height(pl_name);
        } else {
            final_x_scale = name_tag_scale;
            final_y_scale = name_tag_scale;
        }
        draw_sprite_ext(pl_name, 0, name_tag_absolute_x, name_tag_absolute_y, final_x_scale, final_y_scale, 0, c_white, 1);
    }

    // --- LAYER 3: TEXT RENDERING ---
    if (asset_get_index("fnt_dialogue") != -1) {
        draw_set_font(fnt_dialogue);
    }

    // Speaker Name
    var name_absolute_x = 410; 
    var name_absolute_y = 730; 
    
    draw_set_color(c_black);        
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle); 
    draw_text_transformed(name_absolute_x, name_absolute_y, data.s, 1.4, 1.4, 0);

    // Main Dialogue
    var text_absolute_x = 280; 
    var text_absolute_y = 800; 
    var text_max_width = 1100; // Width before scaling occurs
    var line_spacing = 40;     
    
    var current_text_to_draw = string_copy(data.t, 1, floor(text_progress)); 
    
    draw_set_halign(fa_left); 
    draw_set_valign(fa_top); 
    draw_set_color(make_color_rgb(40, 40, 40)); 
    draw_text_ext_transformed(text_absolute_x, text_absolute_y, current_text_to_draw, line_spacing, text_max_width, 1.3, 1.3, 0);

    // Skip Prompt
    var prompt_absolute_x = 1750; 
    var prompt_absolute_y = 940; 
    
    draw_set_halign(fa_right);      
    draw_set_color(c_gray);          
    
    if (text_progress >= string_length(data.t)) {
        draw_text_transformed(prompt_absolute_x, prompt_absolute_y, "Press ENTER >", 1.3, 1.3, 0);
    }
    
    // --- CLEANUP ---
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
}