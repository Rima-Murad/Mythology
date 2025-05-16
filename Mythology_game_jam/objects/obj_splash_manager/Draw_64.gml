// Checks if the game is using debug mode
if (global.is_debug)
{
	// Sets font
	draw_set_font(global.font_text_white);
	draw_set_color(c_fuchsia);

	// Write message for debug mode
	draw_text_transformed(x + 50, y + 50, "DEBUG MODE", 5, 5, 0);

	// Resets draw colour
	draw_set_color(c_white);
}

