// Wont let button select when close button exists
if (!instance_exists(obj_button_close))
{
	// Inherit the parent event
	event_inherited();
}

// Stores the gamepad input
var _gp_quit = false;
// Stores how many gamepad count
var _max_pads = gamepad_get_device_count();

// Loops through the gamepads
for (var _i = 0; _i < _max_pads; _i++)
{
	// Checks the gamepad is connected
    if (gamepad_is_connected(_i))
    {
		// Sets variable to gamepads input
		_gp_quit = gamepad_button_check_released(_i, gp_select);	
		break;
    }
}

// Checks if player has pressed the enter
if (keyboard_check_released(vk_escape) || _gp_quit)
{
	// Calls the buttons function
	button_triggered();
}