// Checks if the game is currently paused
if (global.is_paused)
{
	// Stops the sprites animation
	image_speed = 0;
	// Exits out of event
	exit;
}

// Resumes the sprite animation
image_speed = 1;

// Creates a temp variable for delta time so value will not have to be recalulated several times
var _delta_time = delta_time * 0.000001;

// Checks if this plane is the current leader
if (!is_leader)
{
	// Creates temp variables for self count and new position adjustments
	var _self = self;
	var _nbc = 0;
	var _nbx = 0;
	var _nby = 0;

	// Loops through all enemy planes
	with (obj_enemy_plane_base)
	{
		// Checks the current id is not the same as the original plane
		if (id != _self)
		{
			// Calculates the new distance between the planes
			var _new_dist = point_distance(x, y, _self.x, _self.y);
			
			// Checks if the plane is too close
			if (_new_dist < (sprite_width + _self.sprite_width) * 0.55)
			{
				// Increments the count
				_nbc++;
			
				// Calculates a new direction between planes
				var _new_dir = point_direction(x, y, _self.x, _self.y);
			
				// Adds adjustments to the values based on their distance and direction
				_nbx += lengthdir_x(_new_dist * 0.55, _new_dir);
				_nby += lengthdir_y(_new_dist * 0.55, _new_dir);
			}
		}
	}
	
	// Adjusts the target buffers by the sum of these new values mulitplied by their count (strength) 
	target_buffer_x = _nbx * _nbc;
	target_buffer_y = _nby * _nbc;
}
else
{
	// Sets the buffer values to zero as no adjustments needed for the leader
	target_buffer_x = 0;
	target_buffer_y = 0;
}

// Checks if plane should be moving left
if ((x + velo_x) > (target_x + target_buffer_x))
{
	// Calculates the change in positions
	var _dx = (x + velo_x) - (target_x + target_buffer_x);
	// Adjusts the velocity by limited value
	velo_x -= min(x_move_speed, _dx);
}

// Checks if plane should be moving right
if ((x + velo_x) < (target_x + target_buffer_x))
{
	// Calculates the change in positions
	var _dx = (target_x + target_buffer_x) - (x + velo_x);
	// Adjusts the velocity by limited value
	velo_x += min(x_move_speed, _dx);
}

// Checks if plane should be moving forward
if ((y - velo_y) > (target_y + target_buffer_y))
{
	// Calculates the change in positions
	var _dy = (y - velo_y) - (target_y + target_buffer_y);
	// Adjusts the velocity by limited value
	velo_y += min(y_move_speed, _dy);
}

// Checks if plane should be moving backwards
if ((y - velo_y) < (target_y + target_buffer_y))
{
	// Calculates the change in positions
	var _dy = (target_y + target_buffer_y) - (y - velo_y);
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
// Adjusts the y position by its y speed and time but limited by not moving backwards
y = max(y, y - velo_y * _delta_time);

// Checks if plane is reloading or finished
if (is_finished || is_reloading)
{
	// Checks if player still exists
	if (instance_exists(obj_player))
	{
		// Checks if to the left of the player
		if (x < obj_player.x)
		{
			// Sets left as target
			target_x = - sprite_width;	
		}
		else
		{
			// Sets right as target
			target_x = 270 + sprite_width;	
		}
		
		// Checks if player is not infront
		if (x < obj_player.x - (sprite_width * 0.5 + obj_player.sprite_width * 0.5) * 0.75 || x > obj_player.x + (sprite_width * 0.5 + obj_player.sprite_width * 0.5) * 0.75)
		{
			// Sets bottom of screen as target
			target_y = 480 + sprite_height * 1.5;
		}
	}
	else
	{
		// Checks if left side
		if (x < 135)
		{
			// Sets left as target
			target_x = sprite_width;	
		}
		else
		{
			// Sets right as target
			target_x = 270 - sprite_width;	
		}
		
		// Sets bottom of screen as target
		target_y = 480 + sprite_height * 1.5;
	}
}