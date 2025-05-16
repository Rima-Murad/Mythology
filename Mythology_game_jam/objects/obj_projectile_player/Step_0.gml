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
	// Checks if the shot is not a missile
	if (current_shot_type == PROJECTILE_TYPE.SHOT_SMALL || current_shot_type == PROJECTILE_TYPE.SHOT_BIG)
	{
		// Sets the speed to the set speed
		speed = set_speed;
	}
	else
	{
		// Sets the speed to the set speed
		speed = set_speed * 0.9;
	}
	
	// Resumes the sprite animation
	image_speed = 1;
}