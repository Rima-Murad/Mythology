/// Menu button object
// Button used to return to the main menu

// Inherit the parent event
event_inherited();

// Sets icon sprite
icon_sprite = spr_icon_home;

// Sets button alt
highlight_button_sprite = spr_button_over;

// Button function
button_triggered = function()
{
	// Creates gamepad vibration
	gamepad_vibration(0.1, 0.1, 0.1);
	
	// Plays sound
	audio_play_sound(snd_button_push, 100, false);
	
	// Sends player back to splash screen
	room_goto(rm_splash);
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
	
	// Checks for what type of menu exists
	if (instance_exists(obj_pause_screen))
	{
		// Sets other button
		obj_button_continue.curr_button_state = BUTTON_STATE.HOVERED
	}
	else
	{
		// Sets other button
		obj_button_retry.curr_button_state = BUTTON_STATE.HOVERED
	}
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
	
	// Checks for what type of menu exists
	if (instance_exists(obj_pause_screen))
	{
		// Sets other button
		obj_button_continue.curr_button_state = BUTTON_STATE.HOVERED
	}
	else
	{
		// Sets other button
		obj_button_retry.curr_button_state = BUTTON_STATE.HOVERED
	}
}