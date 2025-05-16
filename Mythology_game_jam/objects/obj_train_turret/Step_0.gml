// Checks if owner instance still exists
if (!instance_exists(owner))
{
	// Destroys this turret
	instance_destroy();
}

// Checks if game is currently paused
if (global.is_paused)
{
	// Exits event to not run it
	exit;	
}

// Stores change in time to be used for movements
var _delta_time = 0.000001 * delta_time;

// Checks if the player still exists and the win screen is not shown
if (instance_exists(obj_player) && !instance_exists(obj_game_win_screen))
{
	// Calculates the player direction
	var _player_direction = point_direction(x, y, obj_player.x, obj_player.y);
	
	// Adds 30 to direction (Adjustment for the sprites snapped roatations
	_player_direction += 30;
	
	// Checks if player has created more than 360 turn
	if (_player_direction >= 360)
	{
		// Removes added value since should be below full loop
		_player_direction -= 360;	
	}
	
	// Picks frame based on the direction and sprite image length
	var _frame = floor(_player_direction / (360 / sprite_get_number(sprite_index)));
	
	// Sets the sprite image to calulated frame
	image_index = _frame;
	
	// Checks if ammo is depleated
	if (ammo_count == 0)
	{
		// Checks if enough reload time has passed
		if (reload_time >= reload_cooldown)
		{
			// Sets ammo count to size
			ammo_count = ammo_size;
		}
		else
		{
			// Adds time passed to reload timer
			reload_time += _delta_time;
		}
	}
	
	// If enough time has passed
	if (fire_time >= fire_rate)
	{
		// Fire the turret
		fire();
	}
	else
	{
		// Add move passed time to the turret
		fire_time += _delta_time;
	}
}



