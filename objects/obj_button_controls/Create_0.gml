/// Controls button object
// Button used to open controls screen

// Inherit the parent event
event_inherited();

// Sets icon sprite
icon_sprite = spr_icon_controls;

// Sets button alt
highlight_button_sprite = spr_button_over;

// Button function
button_triggered = function()
{
	// Creates gamepad vibration
	gamepad_vibration(0.1, 0.1, 0.1);
	
	// Plays sound
	audio_play_sound(snd_button_push, 100, false);
	
	// Sets buttons current state back to idle
	curr_button_state = BUTTON_STATE.IDLE;
	
	// Spawns in control menu
	var _new_seq = instance_create_layer(0,0, "High_Menu", obj_sequence_manager);
	_new_seq.create_seq(seq_control_menu, "High_Menu");
	_new_seq.can_die = false;
	_new_seq.can_pause = false;
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
	obj_button_mute.curr_button_state = BUTTON_STATE.HOVERED;
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
	obj_button_quit.curr_button_state = BUTTON_STATE.HOVERED;
}