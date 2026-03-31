// --- SET UP THE ANCHOR COORDINATES ---
var box_x = 100; 
var box_y = 500; 
var box_w = 1100; 
var box_h = 250;  

// Safety check: only draw UI if the dialogue hasn't ended.
if (current_line < array_length(dialogue)) {
    var data = dialogue[current_line];
    
    // ==========================================
    // LAYER 1: THE PORTRAIT 
    // ==========================================
    var port_x, port_y, x_scale;
    
    // Logic is universal for any character!
    if (data.s == "Horatio") {
        port_x = box_x + box_w - 80; 
        x_scale = -1;              
    } else {
        port_x = box_x + 210;        
        x_scale = 1;               
    }
    
    port_y = box_y + 120; 

    var face_frame = 0;


    if (variable_struct_exists(data, "f")) {
        face_frame = data.f;
    }
    else if (data.s == "Addeline") {
        if (player_hp > 99) face_frame = 0;
        else if (player_hp > 40) face_frame = 1;
        else if (player_hp > 0) face_frame = 2;
        else face_frame = 3;
    }
    if (sprite_exists(data.port)) {
        draw_sprite_ext(data.port, face_frame, port_x, port_y, x_scale, 1, 0, c_white, 1);
    }

    // ==========================================
    // LAYER 2: THE BOX 
    // ==========================================
    if (sprite_exists(spr_dialogue_base)) {
        draw_sprite_stretched(spr_dialogue_base, 0, box_x-130, box_y-70, box_w+210, box_h+70);
    }

    // ==========================================
    // LAYER 2.5: THE NAME TAG BACKGROUND
    // ==========================================
    var name_tag_absolute_x = 130; 
    var name_tag_absolute_y = 470; 
    var name_tag_scale = 20.0; 
    var name_tag_manual_width = 380; 
    var name_tag_manual_height = 100; 

    if (sprite_exists(pl_name)) {
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

    // ==========================================
    // LAYER 3: THE TEXT & TYPEWRITER 
    // ==========================================
    if (asset_get_index("fnt_dialogue") != -1) {
        draw_set_font(fnt_dialogue);
    }

    // --- SPEAKER NAME ---
    var name_absolute_x = 290; 
    var name_absolute_y = 515; 
    draw_set_color(c_black);        
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle); 
    draw_text_transformed(name_absolute_x, name_absolute_y, data.s, 1.1, 1.1, 0);

    // --- MAIN DIALOGUE ---
    var text_absolute_x = 200; 
    var text_absolute_y = 570; 
    var text_max_width = 800; 
    var line_spacing = 40;     
    var current_text_to_draw = string_copy(data.t, 1, floor(text_progress)); 
    
    draw_set_halign(fa_left); 
    draw_set_valign(fa_top); 
    draw_set_color(make_color_rgb(40, 40, 40)); 
    draw_text_ext(text_absolute_x, text_absolute_y, current_text_to_draw, line_spacing, text_max_width);

    // --- SKIP PROMPT ---
    var prompt_absolute_x = 1200; 
    var prompt_absolute_y = 675; 
    draw_set_halign(fa_right);      
    draw_set_color(c_gray);         
    
    if (text_progress >= string_length(data.t)) {
        draw_text(prompt_absolute_x, prompt_absolute_y, "Press ENTER >");
    }
    
    // --- CLEANUP ---
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
}