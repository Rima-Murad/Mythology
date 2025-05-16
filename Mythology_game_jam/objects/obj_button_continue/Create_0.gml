/// Continue button object
// Button used to resume game

// Inherit the parent event
event_inherited();

// Sets icon sprite
icon_sprite = spr_icon_continue;

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

// Button function
button_triggered = function()
{
	// Creates gamepad vibration
	gamepad_vibration(0.1, 0.1, 0.1);
	
	// Plays sound
	audio_play_sound(snd_button_push, 100, false);
	
	// Sets game state to no longer paused
	global.is_paused = false;
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
	
	// Sets the button to hovered
	obj_button_menu.curr_button_state = BUTTON_STATE.HOVERED
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
	
	// Sets the button to hovered
	obj_button_menu.curr_button_state = BUTTON_STATE.HOVERED
}