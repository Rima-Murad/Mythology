/// Retry button object
// Button used to restart

// Inherit the parent event
event_inherited();

// Sets icon sprite
icon_sprite = spr_icon_retry;

// Sets button alt
highlight_button_sprite = spr_button_over;

// Stores how many gamepad count
var _max_pads = gamepad_get_device_count();

// Loops through the gamepads
for (var _i = 0; _i < _max_pads; _i++)
{
	// Checks the gamepad is connected
    if (gamepad_is_connected(_i))
    {
		// Changes state to hovered by default
		curr_button_state = BUTTON_STATE.HOVERED;
		
		// Leave loop
		break;	
	}	
}

// Fuction called when button is triggered
button_triggered = function()
{
	// Creates gamepad vibration
	gamepad_vibration(0.1, 0.1, 0.1);
	
	// Plays sound
	audio_play_sound(snd_button_push, 100, false);
	
	// Restarts the current room
	room_restart();	
}

// Set function for when selecting the previous option
prev_option = function()
{
	// Unsets all the other buttons
	with (obj_button_highlight)
	{
		// Changes state
		curr_button_state = BUTTON_STATE.IDLE;
	}
	
	// Sets other button
	obj_button_menu.curr_button_state = BUTTON_STATE.HOVERED;
}

// Set function for when selecting the next option
next_option = function()
{
	// Unsets all the other buttons
	with (obj_button_highlight)
	{
		// Changes state
		curr_button_state = BUTTON_STATE.IDLE;
	}
	
	// Sets other button
	obj_button_menu.curr_button_state = BUTTON_STATE.HOVERED
}