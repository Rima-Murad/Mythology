// Sets draw colour
draw_set_color(c_black);
draw_set_alpha(0.2 * image_alpha);

// Draw rectangle behind screen (background)
draw_rectangle(0, 0, 270, 480, false);

// Draw screen (banner)
draw_self();

// Set font
draw_set_font(global.font_text_white);

// Sets draw colour
draw_set_color(c_white);
draw_set_alpha(image_alpha);

// Set alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw banner heading
draw_text_ext_transformed(135, 161, "CONTROLS", 0, 300, image_xscale * 2, image_yscale * 2, image_angle);

// Draw Sprites
draw_sprite_ext(spr_controls_info_keys, 0, x + 36, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(spr_controls_info_joypad, 0, x, y + 50, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

// Set alignment
draw_set_halign(fa_left);

// Draw text
draw_text(x - 60, y - 20, "MOVEMENT");
draw_text(x - 60, y + 2, "FIRE");
draw_text(x - 60, y + 22, "BOMB");

// Draw text
draw_text(x - 85, y + 71, "MOVEMENT");
draw_text(x + 38, y + 60, "FIRE");
draw_text(x + 38, y + 71, "BOMB");

// Resets colour
draw_set_alpha(1.0);

// Resets alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);
