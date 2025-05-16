/// Quit button object
// Button used to quit game

// Inherit the parent event
event_inherited();

// Sets icon sprite
icon_sprite = spr_icon_exit;

// Sets button alt
highlight_button_sprite = spr_button_corner_over;

// Changes the triggered functionality of the button
button_triggered = function()
{
	// Creates gamepad vibration
	gamepad_vibration(0.1, 0.1, 0.1);
	
	// Plays sound
	audio_play_sound(snd_button_push, 100, false);
	
	// Checks if the game is able to quit on the current platform
	if (os_type == os_android || os_type == os_windows || os_type == os_macosx || os_type == os_linux)
	{
		// End the current game
		game_end();
	}
	else
	{
		// Restarts the current game as calling game end might cause issue on platform
		game_restart();	
	}
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
	obj_button_controls.curr_button_state = BUTTON_STATE.HOVERED;
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
	obj_button_play.curr_button_state = BUTTON_STATE.HOVERED;
}