// Wont let button select when close button exists
if (!instance_exists(obj_button_close))
{
	// State of if a button is selected
	var _has_selected = false;

	// Loops though the buttons
	with (obj_button_highlight)
	{
		// Checks if the button is not idle
		if (curr_button_state != BUTTON_STATE.IDLE)
		{
			// Changes state
			_has_selected = true;
			break;
		}
	}

	// Checks state has not been met
	if (!_has_selected)
	{
		// Gamepad input state
		var _input = false;
	
		// Stores how many gamepad count
		var _max_pads = gamepad_get_device_count();

		// Loops through the gamepads
		for (var _i = 0; _i < _max_pads; _i++)
		{
			// Checks the gamepad is connected
		    if (gamepad_is_connected(_i))
		    {
				// Sets variables to input states
				_input = (gamepad_button_check_released(_i, gp_padu) || gamepad_button_check_released(_i, gp_padd) || (round(abs(gamepad_axis_value(_i, gp_axislv))) && global.stick_cooldown <= 0))
				break;
		    }
		}
	
		// Check for keyboard inputs
		if (keyboard_check_released(vk_up) || keyboard_check_released(vk_down))
		{
			_input = true;	
		}
	
		// Check final input
		if (_input)
		{
			// Resets the stick cooldown
			global.stick_cooldown = 0.2;
			
			// Set state to selected
			curr_button_state = BUTTON_STATE.HOVERED;
		}
	}
}

// Inherit the parent event
event_inherited();

