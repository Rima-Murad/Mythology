// Checks if the game is currently paused
if (global.is_paused)
{
	// Stops the sprites animation
	image_speed = 0;
	exit;
}

// Resumes the sprite animation
image_speed = 1;

// Creates a temp variable for delta time so value will not have to be recalulated several times
var _delta_time = delta_time * 0.000001;

// Clamps the target x value to within the room
target_x = clamp(target_x, sprite_width * 0.1, room_width - sprite_width * 0.1);

// Checks if the plane has finished
if (is_finished)
{
	// Tells the plane to fly out of the room
	target_y = room_height + sprite_height * 2;
}
else
{
	// Clamp the target y position to top quarter of screen
	target_y = clamp(target_y, sprite_height * 0.1, 120);
}

// Checks if plane should be moving left
if ((x + velo_x) > target_x)
{
	// Calculates the change in positions
	var _dx = (x + velo_x) - target_x;
	// Adjusts the velocity by limited value
	velo_x -= min(x_move_speed, _dx);
}

// Checks if plane should be moving right
if ((x + velo_x) < target_x)
{
	// Calculates the change in positions
	var _dx = target_x - (x + velo_x);
	// Adjusts the velocity by limited value
	velo_x += min(x_move_speed, _dx);
}

// Checks if plane should be moving forward
if ((y - velo_y) > target_y)
{
	// Calculates the change in positions
	var _dy = (y - velo_y) - target_y;
	// Adjusts the velocity by limited value
	velo_y += min(y_move_speed, _dy);
}

// Checks if plane should be moving backwards
if ((y - velo_y) < target_y)
{
	// Calculates the change in positions
	var _dy = target_y - (y - velo_y);
	// Adjusts the velocity by limited value
	velo_y -= min(y_move_speed, _dy);
}

// Adjusts the enemies momentum by drag
velo_x *= x_drag;
velo_y *= y_drag;

// Clamps the momentum by min and max allowed values
velo_x = clamp(velo_x, -max_x_speed, max_x_speed);
velo_y = clamp(velo_y, -max_y_speed, max_y_speed);

// Adjusts the x position by its x speed and time
x += velo_x * _delta_time;
y -= velo_y * _delta_time;

// Checks if the plane is has finished
if (is_finished)
{
	// Checks if the player exists
	if (instance_exists(obj_player))
	{
		// If to the left of the player
		if (x < obj_player.x)
		{
			// Go to the left
			target_x = sprite_width;
		}
		else
		{
			// Go to the right
			target_x = room_width - sprite_width;	
		}
	}
	else
	{
		// If on the left side of screen
		if (x < 135)
		{
			// Go to the left
			target_x = sprite_width;	
		}
		else
		{
			// Go to the right
			target_x = 270 - sprite_width;	
		}
	}
	
	// Checks if the plane has gone off screen
	if (y > 480 + sprite_height)
	{
		// Destroys the plane
		instance_destroy();
	}
}
else
{
	// Checks if player can be targeted
	if (instance_exists(obj_player))
	{		
		// Add time passed to wave multi value
		wave_multi += _delta_time * 3;

		// Adds time passed to reload timer
		reload_timer += _delta_time;
		
		// Checks if plane is reloading
		if (is_reloading)
		{
			// Reloads the magaizine counter
			mag_timer += _delta_time;
	
			// Checks timer has met threshold
			if (mag_timer >= mag_cooldown)
			{
				// Calls reloading as false
				is_reloading = false;
				// Sets ammo to base count
				ammo_count = base_ammo;
			}
		}
	
		// Sets temp variable for if firing possible
		var _can_fire = false;
	
		// Checks if in front of player
		if (y < obj_player.y)
		{
			// Allows firing
			_can_fire = true;
		
			// Sets target to just in front of the player
			target_x = obj_player.x;
			target_y = obj_player.y - sprite_height;

		}
		else
		{
			// Tells the plane to get as close to the player as possible and crash into them
			target_x = obj_player.x;
			target_y = clamp(obj_player.y, 0, 120);
			
			// Tels the plane to reload as it cant shoot the player
			is_reloading = true;
		}
	
		// Checks if firing is possible
		if (_can_fire)
		{
			// Checks if close enough horizontally to lock onto player
			if (x > obj_player.x - aim_tolerance && x < obj_player.x + aim_tolerance)
			{
				// Adjusts timer
				lockon_timer += _delta_time;	
			}
			else
			{
				// Resets timer
				lockon_timer = 0;	
			}
		
			// Check enemy has ammo
			if (ammo_count > 0)
			{
				// Checks if timer has reached threshold
				if (lockon_timer >= lockon_threshold && reload_timer >= reload_cooldown)
				{
					// Calls fire function
					fire();
				}
			}
		}

	}
	else
	{
		// Tells the plane to fly away
		is_finished = true;
	}
}

