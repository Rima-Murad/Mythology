// Checks if the game is paused
if (global.is_paused)
{
	// Exits the event as motion blur wont need to update
	exit;	
}

// Stores the previous x and y positions as the motion blur can now update
prev_x = x;
prev_y = y;

// Resets touch input variables
touch_input_shot = false;
touch_input_bomb = false;