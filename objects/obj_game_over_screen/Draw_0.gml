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
draw_text_ext_transformed(135, 161, "GAME OVER!", 0, 300, image_xscale * 2, image_yscale * 2, image_angle);

// Set font
draw_set_font(global.font_text);

// Sets draw colour
draw_set_color(c_white);
draw_set_alpha(image_alpha);

// Draw banner body
draw_text_ext_transformed(135, 190, "UNLUCKY! TRY AGAIN!", 10, 300, image_xscale, image_yscale, image_angle);

// Resets colour
draw_set_alpha(1.0);

// Resets alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);