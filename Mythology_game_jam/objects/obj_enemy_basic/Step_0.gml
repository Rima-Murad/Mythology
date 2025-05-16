// Inherit the parent event
event_inherited();

// Checks if the game is currently paused
if (global.is_paused)
{
	// Stops the sprites animation
	image_speed = 0;
	// Exits the step event as enemy shouldnt update
	exit;
}

// Creates a temp variable for delta time so value will not have to be recalulated several times
var _delta_time = delta_time * 0.000001;

// Resumes the sprite animation
image_speed = 1;

// Checks if player is alive and plane isnt finished or reloading
if (instance_exists(obj_player) && !is_finished && !is_reloading)
{
	// Adds change in time to reload timer
	reload_timer += _delta_time;
	// Sets flag for firing to false
	var _can_fire = false;
		
	// Checks if player is in front of enemy
	if (y < obj_player.y)
	{
		// Sets firing flag to true
		_can_fire = true;
		
		// Checks if the player is in front of the enemy but not too close
		if (y < obj_player.y - (sprite_height * 0.5 + obj_player.sprite_height * 0.5))
		{
			// Targets the players x position
			target_x = obj_player.x;
			// Targets ahead of the players y position
			target_y = clamp(max(target_y, obj_player.y - (sprite_height + obj_player.sprite_height)), 0, 80);
		}
		else
		{
			// Sets the target x to the left or right of the player as to not crash into them
			target_x = clamp((obj_player.x > x? min(target_x, obj_player.x - sprite_width * 2) : max(target_x, obj_player.x + sprite_width * 2)), 0, room_width);
			
			// Checks if the player is far enough away
			if (x > obj_player.x - (sprite_width * 0.5 + obj_player.sprite_width * 0.5) * 0.75 && x < obj_player.x + (sprite_width * 0.5 + obj_player.sprite_width * 0.5) * 0.75)
			{
				// Targets the current enemy y position from going forward
				target_y = clamp(y, 0, 80);
			}
			else
			{
				// Targets the current player y position from going forward
				target_y = clamp(obj_player.y, y, 80);
			}
		}
	}
	else
	{
		// Targets the current player y position from going forward
		target_y = clamp(obj_player.y, y, 80);
	
		// Checks if plane has gone off screen
		if (y > 480 + sprite_height)
		{
			// Destroys the plane
			instance_destroy();
		}
	}
	
	// Checks if the plane can fire
	if (_can_fire)
	{
		// Checks if player is within sight tolerances of plane
		if (x > obj_player.x - aim_tolerance && x < obj_player.x + aim_tolerance)
		{
			// Adds value to lockone timer
			lockon_timer += _delta_time;
		}
		else
		{
			// Resets the lockon timer
			lockon_timer = 0;	
		}
		
		// Checks if the lock on timers have been met
		if (lockon_timer >= lockon_threshold && reload_timer >= reload_cooldown)
		{
			// Calls the fire function
			fire();
		}
	}
}
// Checks if the player no longer exists
else if (!instance_exists(obj_player))
{
	// Sets the plane to finished mode (flys off screen)
	is_finished = true;
}