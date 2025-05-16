// Checks if plane has flown below the bottom of the screen
if (y > room_height + sprite_height)
{
	// Destroys the plane
	instance_destroy();
}