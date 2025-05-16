// Checks if game is paused
if (global.is_paused)
{
	// Exits from event
	exit;	
}

// Stores delta time for movement and timers
var _delta_time =  delta_time * 0.000001;
// Stores a reference of self to compare against later
var _self = self;

// Adds the change in time to the frame counter
frame_counter += _delta_time;

if (frame_counter > (1 / 15) && is_moving)
{
	// Reduces the frame counter by a frames time
	frame_counter -= (1/15);
	// Sets the alt frame state to its opposite state
	is_alt_frame = !is_alt_frame;
}

// Checks for movement
if (is_moving)
{
	// Stores the tracks tilemap id
	var _track_id = layer_tilemap_get_id("Tracks");
	
	// Calculates the new move distance based on delta time and move speed
	var _move_distance = _delta_time * 4 * train_move_speed;
	
	// Switch statement for what way the train is facing
	switch(facing)
	{
		// Facing right
		case 0:
			
			// Checks if track exists ahead
			if (can_leave || collision_point(x + 16 + _move_distance, y, _track_id, false, true) == _track_id)
			{
				// Checks that a train does not exist ahead
				if ((collision_point(x + 16 + _move_distance, y, obj_enemy_train, false, true) != noone) 
				|| (collision_point(x + 16 + _move_distance, y, obj_train_car, false, true) != noone))
				{
					// Stops the train from moving
					is_moving = false;
					break;
				}
				
				// Creates array for new data
				var _new_data = [_move_distance, 0, facing];
				// New move added
				ds_list_add(movement_list, _new_data);
			}
			else
			{
				// Stops the train from moving
				is_moving = false;	
			}
			
			break;
			
		// Facing up
		case 1:
		
			// Checks if track exists ahead
			if (collision_point(x, y - 16 - _move_distance, _track_id, false, true) == _track_id)
			{
				// Checks that a train does not exist ahead
				if ((collision_point(x, y - 16 - _move_distance, obj_enemy_train, false, true) != noone) 
				|| (collision_point(x, y - 16 - _move_distance, obj_train_car, false, true) != noone))
				{
					// Stops the train from moving
					is_moving = false;
					break;
				}
				
				// Creates array for new data
				var _new_data = [0, -_move_distance, facing];
				// New move added
				ds_list_add(movement_list, _new_data);
			}
			else
			{
				// Stops the train from moving
				is_moving = false;	
			}
				
			break;
			
		// Facing left
		case 2:
			
			// Checks if track exists ahead
			if (can_leave || collision_point(x - 16 - _move_distance, y, _track_id, false, true) == _track_id)
			{
				// Checks that a train does not exist ahead
				if ((collision_point(x - 16 + _move_distance, y, obj_enemy_train, false, true) != noone) 
				|| (collision_point(x - 16 + _move_distance, y, obj_train_car, false, true) != noone))
				{
					// Stops the train from moving
					is_moving = false;
					break;
				}
				
				// Creates array for new data
				var _new_data = [-_move_distance, 0, facing];
				// New move added
				ds_list_add(movement_list, _new_data);
			}
			else
			{
				// Stops the train from moving
				is_moving = false;	
			}
			
			break;
			
		// Facing down
		case 3:
			
			// Checks if track exists ahead
			if (collision_point(x, y + 16 + _move_distance, _track_id, false, true) == _track_id)
			{
				// Checks that a train does not exist ahead
				if ((collision_point(x, y + 16 + _move_distance, obj_enemy_train, false, true) != noone) 
				|| (collision_point(x, y + 16 + _move_distance, obj_train_car, false, true) != noone))
				{
					// Stops the train from moving
					is_moving = false;
					break;
				}
				
				// Creates array for new data
				var _new_data = [0, _move_distance, facing];
				// New move added
				ds_list_add(movement_list, _new_data);
			}
			else
			{
				// Stops the train from moving
				is_moving = false;	
			}
				
			break;
	}
	
	// Checks if train is no longer moving
	if (!is_moving)
	{
		var _dx = 0;
		var _dy = 0;
		
		// Switch for face used
		switch(facing)
		{
			// Right
			case 0:
				// Sets actual difference
				_dx += 8;
			break;
		
			case 1: // Up
				// Sets actual difference
				_dy -= 8;	
			break;
		
			case 2: // Left
				// Sets actual difference
				_dx -= 8;
			break;
		
			case 3: // Down
				// Sets actual difference
				_dy += 8;
			break;
		}
		
		// Change and reset direction if possible
		for (var _direction = 0; _direction < 4; _direction++)
		{
			if (!(_direction == facing || _direction == facing - 2 || _direction == facing + 2))
			{
				// Variables for the change in positions and checks posiitions needed because of perspective 
				var _cx = 0;
				var _cy = 0;
	
				// Swich for direction used
				switch(_direction)
				{
					// Right
					case 0:
						// Sets check distance
						_cx += 16;
					break;
				
					case 1: // Up
						// Sets check distance
						_cy -= 16;
					break;
				
					case 2: // Left
						// Sets check distance
						_cx -= 16;
					break;
				
					case 3: // Down
						// Sets check distance
						_cy += 16;
					break;
				}
		
				// Checks if collision with track is possible
				if ((collision_point(x + _dx + _cx, y + _dy + _cy, _track_id, false, true) == _track_id) 
				&& (collision_point(x + _dx + _cx, y + _dy + _cy, obj_enemy_train, false, true) != obj_enemy_train))
				{				
					// Get last entry
					var _last_data = ds_list_find_value(movement_list, ds_list_size(movement_list) - 1);
					
					var _x_adjust = 0;
					var _y_adjust = 0;
					
					switch (facing)
					{
						case 0:
						break;
						case 1:
						_y_adjust -= 3;	
						break;
						case 2:
						break;
						case 3:
						_y_adjust -= 3;	
						break;
					}
					
					// Creates array for new data
					var _new_data = [_dx + _last_data[0] + _x_adjust, _dy + _last_data[1] + _y_adjust, _direction];
					
					// Sets the direction
					facing = _direction;
					
					// New move added
					ds_list_add(movement_list, _new_data);
					
					// Applies movement
					apply_movement();
				
					// Sets is moving state back to true
					is_moving = true;
					
					// Breaks the loop
					break;
				}
			}
		}
	}
	else
	{
		// Applies movement
		apply_movement();
	}
}

// Sets the current image based on the facing and if alt frame or not
image_index = facing * 2 + is_alt_frame;

// Creates new value based on ground movement
var _ny = obj_game_manager.ground_move_speed * _delta_time;

// Adjusts the y position
y += _ny;

// Loops through all the trains cars
for (var _i = 0; _i < cars_count; _i++)
{
	// Applies the movement
	cars[_i][1] += _ny;
}

// Loops through all the train car objects (collision masks)
with(obj_train_car)
{
	// Checks if the object has this train set as its owner
	if (owner == _self)
	{
		// Adjusts the y position
		y += _ny;
	}
}

// Loops through all the train turret objects
with(obj_train_turret)
{
	// Checks if the object has this train set as its owner
	if (owner == _self)
	{
		// Adjusts the y position
		y += _ny;
	}
}

// Checks if the train has gone off of the screen too far
if (y > room_height + sprite_height * (1 + (facing == 3 ? cars_count : 0)))
{
	// Destroys the instance
	instance_destroy();	
}