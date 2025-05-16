// Checks if the game is paused
if (global.is_paused)
{
	// Exits the event as the cloud wont need to update
	exit;	
}

// Adjusts the cloud position from its move speed and time passed
y += delta_time * 0.000001 * move_speed;

// Checks if the cloud has gone off the bottom of the screen
if (y > room_height + sprite_height)
{
	// Destroys the cloud
	instance_destroy();	
}