// Checks if the game is currently paused
if (global.is_paused)
{
	// Stops the sprites animation
	image_speed = 0;
	
	// Exits the event
	exit;
}

// Resumes the sprite animation
image_speed = 1;

// Reduces the shields life
shield_life -= delta_time * 0.000001;

// The image alpha will fade out when the shield is about to die
image_alpha = clamp(shield_life * 0.2, 0, 0.5);

// Checks if the life has finished
if (shield_life <= 0)
{
	// Destroys the shield
	instance_destroy();
}

// Follows the players movement
x = obj_player.x;
y = obj_player.y;