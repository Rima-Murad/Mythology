// Temp state for if gamepad was pressed
var _was_gp_pressed = false;

// Checks pressed buttons
if (curr_button_state == BUTTON_STATE.PRESSED)
{
	// Gamepad input state
	var _gp_released = false;
	
	// Stores how many gamepad count
	var _max_pads = gamepad_get_device_count();

	// Loops through the gamepads
	for (var _i = 0; _i < _max_pads; _i++)
	{
		// Checks the gamepad is connected
	    if (gamepad_is_connected(_i))
	    {
			// Sets variables to gamepad states
			_gp_released = (gamepad_button_check_released(_i, gp_face1) || gamepad_button_check_released(_i, gp_start));
			break;
	    }
	}

	// Checks if player has pressed the use button
	if (keyboard_check_released(vk_return) || _gp_released)
	{
		// Calls the button function
		curr_button_state = BUTTON_STATE.RELEASED;
		_was_gp_pressed = true;
	}
}

// Checks if the button has been released
if (curr_button_state == BUTTON_STATE.RELEASED)
{
	// Calls the triggered function to call the buttons action
	button_triggered();
	
	// Checks if gamepad was used for press
	if (_was_gp_pressed)
	{
		curr_button_state = BUTTON_STATE.HOVERED;	
	}
}

// Sets variable for the buttons last state
last_button_state = curr_button_state;