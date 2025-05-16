// Checks if the game is currently paused
if (global.is_paused)
{
	// Stops the sprites animation
	image_speed = 0;
	// Exits the step event as enemy shouldnt update
	exit;
}

// Resumes the sprite animation
image_speed = 1;

// Creates a temp variable for delta time so value will not have to be recalulated several times
var _delta_time = delta_time * 0.000001;

// Calculates the current percentage based on the planes y position
var _percent = clamp(y, 0, 480) * (1 / 480);
// Sets target x to the value from specified curve and percentage
target_x = (animcurve_channel_evaluate(movement_curve, _percent) + 1) * 0.5 * 270;

// Sets the buffer values to zero as no adjustments needed for the leader
target_buffer_x = 0;
target_buffer_y = 0;

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

// Sets target y to default to bottow of the screen
target_y = 480 + sprite_height * 1.5;

// Checks if player is alive and plane isnt finished or reloading
if (instance_exists(obj_player) && !is_finished && !is_reloading)
{
	// Adds change in time to reload timer
	reload_timer += _delta_time;
	// Sets flag for firing to false
	var _can_fire = false;
	
	// Adjusts the y position by movespeed since planes need to always move
	y += y_move_speed * _delta_time;
	
	// Checks if player is in front of enemy
	if (y < obj_player.y)
	{
		// Sets firing flag to true
		_can_fire = true;
	}
	else
	{
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

