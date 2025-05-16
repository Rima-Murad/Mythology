// Checks if the game is currently paused
if (global.is_paused)
{
	// Stops the movement speed
	speed = 0;
	// Stops the sprites animation
	image_speed = 0;
}
else
{
	// Sets the speed to the set speed
	speed = set_speed;
	// Resumes the sprite animation
	image_speed = 1;
}