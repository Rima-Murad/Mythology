// Checks if is selected
if (curr_button_state == BUTTON_STATE.HOVERED)
{
	// Gamepad input state
	var _gp_active = false;
	var _gp_prev = false;
	var _gp_next = false;
	
	// Stores how many gamepad count
	var _max_pads = gamepad_get_device_count();

	// Loops through the gamepads
	for (var _i = 0; _i < _max_pads; _i++)
	{
		// Checks the gamepad is connected
	    if (gamepad_is_connected(_i))
	    {
			// Sets variables to gamepad states
			_gp_active = (gamepad_button_check_pressed(_i, gp_face1) || gamepad_button_check_pressed(_i, gp_start));
			_gp_prev = gamepad_button_check_pressed(_i, gp_padu) || (round(clamp(-gamepad_axis_value(_i, gp_axislv), 0, 1)) && global.stick_cooldown <= 0);
			_gp_next = gamepad_button_check_pressed(_i, gp_padd) || (round(clamp(gamepad_axis_value(_i, gp_axislv), 0, 1)) && global.stick_cooldown <= 0);
			break;
	    }
	}

	// Checks if player has pressed the use button
	if (keyboard_check_pressed(vk_return) || _gp_active)
	{
		// Calls the button function
		curr_button_state = BUTTON_STATE.PRESSED;
	}
	// Checks last state was not idle
	else if (last_button_state != BUTTON_STATE.IDLE)
	{
		// Checks for the previous option
		if (keyboard_check_released(vk_up) || _gp_prev)
		{
			// Resets the stick cooldown
			global.stick_cooldown = 0.2;
			// Calls the functionality
			prev_option();
		}
		// Checks for the next option
		else if (keyboard_check_released(vk_down) || _gp_next)
		{
			// Resets the stick cooldown
			global.stick_cooldown = 0.2;
			// Calls the functionality
			next_option();
		}
	}
}

// Switch statement for the button states to change the target sprite
switch(curr_button_state)
{
	// Idle state
	case BUTTON_STATE.IDLE:
		// Sets sprite to default
		sprite_index = default_button_sprite;
		image_blend = c_white;
		break;
	// Hovered state
	case BUTTON_STATE.HOVERED:
		// Sets sprite to hovered
		sprite_index = highlight_button_sprite;
		image_blend = c_white;
		break;
	// Pressed state
	case BUTTON_STATE.PRESSED:
		// Sets sprite to pressed
		sprite_index = highlight_button_sprite;
		image_blend = c_ltgrey;
		break;
	// Released state
	case BUTTON_STATE.RELEASED:
		// Sets sprite to released
		sprite_index = default_button_sprite;
		image_blend = c_ltgrey;
		break;
}