/// Touch UI bomb button object
// Used by the player to drop bombs

// Inherit the parent event
event_inherited();

// State for knowing if button was in realeased state
has_released = true;

// Changes the touch input function
touch_action = function()
{
	// Checks if button was up
	if (has_released)
	{
		// Checks that the player still exists
		if (instance_exists(obj_player))
		{
			// Tells the player that it has a touch input for bombs
			obj_player.touch_input_bomb = true;	
		}
	
		// Sets button state to down
		has_released = false;
	}
}
