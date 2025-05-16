// Checks if touch id has not been set, game is paused or a game over screen is showing
if (touch_id == -1 || global.is_paused || instance_exists(obj_game_win_screen) || instance_exists(obj_game_over_screen))
{
	// Destroys this object as it cannot be used
	instance_destroy();	
}

// Checks if the device button attached to object is not longer held
if (!device_mouse_check_button(touch_id, mb_left))
{	
	// Destroys object as is no longer being used
	instance_destroy(); 
}
else
{
	// Checks the player exists
	if (instance_exists(obj_player))
	{
		// Sets the players touch values based on the objects original position and the clamped held position and a scale of -1 to 1
		obj_player.touch_input_x = clamp((x - device_mouse_x(touch_id)) * (-1 / sprite_width), -1, 1);
		obj_player.touch_input_y = clamp((y - device_mouse_y(touch_id)) * (-1 / sprite_height), -1, 1);
	}
}