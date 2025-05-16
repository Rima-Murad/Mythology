// Inherit the parent event
event_inherited();

// Checks if game is paused or game over screen exists
if (global.is_paused || instance_exists(obj_game_over_screen) || instance_exists(obj_game_win_screen))
{
	// Exits the event as healthbar doesn't need drawn
	exit;
}

// Sets the alpha level to 75%
draw_set_alpha(0.75);
// Sets back colour to black
draw_set_color(c_black);
// Draws black rectangle (Outline)
draw_rectangle(x - 21, y - 41, x + 21, y - 37, false);
// Set draw colour to default white
draw_set_color(c_white);
// Draw healthbar for enemies health
draw_healthbar(x - 20, y - 40, x + 20, y - 38, (hp / 64) * 100, c_ltgrey, c_red, c_red, 0, true, false);
// Reset draw alpha to 100% 
draw_set_alpha(1.0);