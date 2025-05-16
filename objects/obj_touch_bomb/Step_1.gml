// Checks if the game is paused, player is destroyed or the game is finished
if (global.is_paused || !instance_exists(obj_player) || instance_exists(obj_game_win_screen))
{
	// Exits event before anything happens
	exit;	
}

// Checks if the touch id is set
if (touch_id != -1)
{
	// Checks if set ID is pressed
	if (device_mouse_check_button(touch_id, mb_any))
	{
		// Changes the buttons blend colour
		image_blend = c_dkgrey;
		// Calls the touch action
		touch_action();
	}
	
	// Checks if the ID is unpressed or no longer on position
	else if (!device_mouse_check_button(touch_id, mb_any) || !instance_position(device_mouse_x_to_gui(touch_id), device_mouse_y_to_gui(touch_id), mb_any))
	{
		// Changes the buttons blend colour
		image_blend = c_white;
		// Resets the touch id
		touch_id = -1;
	}
}
else
{
	// Sets button back to released state
	has_released = true;	
}