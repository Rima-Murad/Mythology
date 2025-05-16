// Calls update script for gamepad vibrations
gp_vibration_update();

// Checks if in browser
if (os_browser != browser_not_a_browser)
{
	// Sets the window size to the browser
	window_set_size(browser_width, browser_height);
	// Sets the window to its center
	window_center();
}

// Stores delta time for movements and timers
var _delta_time = delta_time * 0.000001;

// Checks if the stick cooldown is greater than zero
if (global.stick_cooldown > 0)
{
	// Decreases the cooldown
	global.stick_cooldown -= _delta_time;
}

// Reduce the seascape timer
seascape_timer -= _delta_time;

// Checks if the timer is finished
if (seascape_timer <= 0)
{
	// Sets a new timer with random set range
	seascape_timer = random_range(4, 16);
	// Plays the wave sound
	audio_play_sound(snd_seascape_wave, 100, false);
}

// Checks if the game has been paused
if (global.is_paused)
{
	// Exits out of event and nothing else needs to update
	exit;	
}

// Temp flag for if level has shifted
var _has_looped = false;

// Loops through the ground layers
for (var _i = 0; _i < array_length(ground_layers); _i++)
{
	// Sets the layer to its position plus the moved distance 
	layer_y(ground_layers[_i], layer_get_y(ground_layers[_i]) + ground_move_speed * _delta_time);
	
	// Checks if the distance has gone above zero and looped back around
	if (layer_get_y(ground_layers[_i]) >= 0)
	{
		// Moves the layer back to where it started starting the loop again
		layer_y(ground_layers[_i], layer_get_y(ground_layers[_i]) - 4352);
		
		// Sets the looped flag
		_has_looped = true;
	}
}

// Loops through all the trains spawners
with (obj_train_spawner)
{
	// Adjusts the train spawner positions
	y += obj_game_manager.ground_move_speed * _delta_time;
	
	// Checks if level has looped
	if (_has_looped)
	{
		// Moves the spawner position up
		y -= 4352;
		// Resets spawn flag
		has_spawned = false;	
	}
}

// Loops through all the buildings
with (obj_building__base)
{
	// Adjusts the building positions
	y += obj_game_manager.ground_move_speed * _delta_time;
	
	// Checks if level has looped
	if (_has_looped)
	{
		// Moves the position up
		y -= 4352;	
	}
}

// Checks if enough clouds exist
if (instance_number(obj_cloud) < cloud_count)
{
	// Sets up new y position and flag for knowing if cloud still has to be set
	var _new_y = -88;
	var _is_moved = true;
	
	// Checks if cloud has just been moved
	while (_is_moved)
	{
		// Sets flag to false
		_is_moved = false;
		
		// Checks against other clouds
		with (obj_cloud)
		{
			// If the clouds position is within 44 pixels of new position
			if (y > _new_y - 44 && y < _new_y + 44)
			{
				// Move the new cloud again
				_new_y -= 88;
				_is_moved = true;
			}
		}
	}
	
	// Creates the cloud in the new position
	instance_create_layer(random_range(0, room_width), _new_y, "Clouds", obj_cloud);
}

// Checks if game has finished
if (instance_exists(obj_game_over_screen) || instance_exists(obj_game_win_screen))
{
	// Exits event
	exit;	
}

// Gets the y position of the tracks layer
var _track_y = layer_get_y(ground_layers[3]);

// If the track has moved 16 pixels (1 tile)
if (floor(_track_y) % 16 == 0)
{	
	// Check if the previous train has checked
	if (!prev_train_check)
	{
		// Set flag to true to stop unnecessary checks
		prev_train_check = true;
		
		// Sets flag for if train can spawn
		var _can_spawn = true;

		// Loops through existing trains
		with (obj_enemy_train)
		{
			// Checks if position is near or above top of screen
			if (y < 16)
			{
				// Sets flag to false
				_can_spawn = false;
			}
		}
		
		// Loops through train spawners
		with (obj_train_spawner)
		{
			// Checks if position is near or above top of screen
			if (y > -128 && y < 128)
			{
				// Sets flag to false
				_can_spawn = false;
			}
		}
		
		// Checks flag
		if (_can_spawn)
		{
			// Sets id to track tilemap
			var _track_id = layer_tilemap_get_id("Tracks");
		
			// Array for the collision x points and count
			var _col_x = [];
			var _col_counts = 0;
	
			// Checks each tile location along the width of room
			for (var _i = 0; _i < 270 / 16; _i++)
			{
				// Sets a new x position based on the index
				var _nx = _i * 16 + 8;
			
				// Checks if a collision occurs with track at point
				if (collision_point(_nx, -88, _track_id, false, true) == _track_id)
				{
					// Adds the new colisions point to the array and increases its count
					_col_x[_col_counts] = _nx;
					_col_counts++;
				}
			}
		}
	}
}
else
{
	// Sets previous check flag back to false
	prev_train_check = false;	
}

