// Gamepad input state
var _gp_pause = false;
// Stores how many gamepad count
var _max_pads = gamepad_get_device_count();

// Loops through the gamepads
for (var _i = 0; _i < _max_pads; _i++)
{
	// Checks the gamepad is connected
    if (gamepad_is_connected(_i))
    {
		// Sets variable to gamepad state
		_gp_pause = gamepad_button_check_released(_i, gp_start);	
		break;
    }
}

// Checks if player has pressed the escape key
if (keyboard_check_released(vk_escape) || _gp_pause)
{
	// Calls the button function
	button_triggered();
}

// Checks if the game is currently in a paused state
if (global.is_paused || instance_exists(obj_game_win_screen) || instance_exists(obj_game_over_screen))
{
	// Exits the event as it wont need to update
	exit;	
}

// Inherit the parent event
event_inherited();