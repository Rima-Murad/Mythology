// Checks if the game is paused, player is destroyed or the game is finished
if (global.is_paused || !instance_exists(obj_player) || instance_exists(obj_game_win_screen))
{
	// Exits event before anything happens
	exit;	
}

// Draws the ui button
draw_self();