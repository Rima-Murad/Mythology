// Checks if the game is currently in a paused state
if (global.is_paused || instance_exists(obj_game_win_screen) || instance_exists(obj_game_over_screen))
{
	// Exits the event as it wont need to update
	exit;	
}

// Inherit the parent event
event_inherited();
