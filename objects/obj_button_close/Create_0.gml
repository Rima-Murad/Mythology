/// Close button object
// Button used to close controls screen

// Inherit the parent event
event_inherited();

// Sets button to active
curr_button_state = BUTTON_STATE.HOVERED;

// Sets icon sprite
icon_sprite = spr_icon_exit;

// Sets button alt
highlight_button_sprite = spr_button_close_over;

// Changes the triggered functionality of the button
button_triggered = function()
{
	// Creates gamepad vibration
	gamepad_vibration(0.1, 0.1, 0.1);
	
	// Plays sound
	audio_play_sound(snd_button_push, 100, false);
	
	// Stores how many gamepad count
	var _max_pads = gamepad_get_device_count();

	// Loops through the gamepads
	for (var _i = 0; _i < _max_pads; _i++)
	{
		// Checks the gamepad is connected
	    if (gamepad_is_connected(_i))
	    {
			// Sets button to highlighted state
			obj_button_controls.curr_button_state = BUTTON_STATE.HOVERED;
			break;
	    }
	}
	
	// Destroys the control screen
	instance_destroy(obj_control_screen);
}