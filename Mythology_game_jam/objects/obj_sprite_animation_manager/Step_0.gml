// Checks if the game is currently paused
if (global.is_paused)
{
	// Stops the sprites animation
	image_speed = 0;
}
else
{
	// Resumes the sprite animation
	image_speed = 1;
	
	// Moves the animtions y position by movespeed and delta time
	y += delta_time * 0.000001 * move_speed;
}

