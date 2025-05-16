/// Touch UI object for shooting
// Created and fuctional when possible for mobile and touch devices

// Inherit the parent event
event_inherited();

// Changes the touch input function
touch_action = function()
{
	// Checks that the player still exists
	if (instance_exists(obj_player))
	{
		// Tells the player that it has a touch input for shots
		obj_player.touch_input_shot = true;	
	}
}
