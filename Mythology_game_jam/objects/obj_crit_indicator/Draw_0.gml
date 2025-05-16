// Set font
draw_set_font(crit_font);

// Sets draw colour
draw_set_color(crit_colour);
draw_set_alpha(crit_alpha);

// Set alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw text
draw_text_ext_transformed(x,y, crit_text, crit_scale + 10, 300, crit_scale, crit_scale, 0);

// Resets colour
draw_set_color(c_white);
draw_set_alpha(1.0);

// Resets alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);