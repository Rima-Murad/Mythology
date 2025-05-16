/// Train Object
// Head of enemy trains that appear on the ground

// Sets to not animate train
image_speed = 0;

// Variable used for storing what facing train uses
facing = 0;

// Counts what frame train sprite should use
frame_counter = 0;
// Checks if frame is alerternate or not
is_alt_frame = false;

// Score value for this train head
score_value = 2500;

// Stores the train car positions that will need to be created
cars = [];
// Count for how many train cars
cars_count = 0;

// Owner of this train element
owner = self;

// Checks if the train is moving
is_moving = true;

// Move speed of train
train_move_speed = 3;

// Can leave screen flag
can_leave = false;

// Chooses and plays random sound for trains engine
var _train_snd = choose(snd_train_movement_1, snd_train_movement_2, snd_train_movement_3);
train_sound = audio_play_sound(_train_snd, 100, true, 0.1);

// List of all the last taken movements
movement_list = ds_list_create();

// Function called when adding new train car (or checking if possible)
new_car = function(_x, _y, _direction, _is_forced = false)
{
	// Variables for the change in positions and checks posiitions needed because of perspective 
	var _dx = 0;
	var _cx = 0;
	var _dy = 0;
	var _cy = 0;
	
	// Swich for direction used
	switch(_direction)
	{
		// Left
		case 0:
		
			// Sets check distance
			_cx -= 20;
			
			// Checks if still head of train
			if (cars_count == 0)
			{
				// Sets actual difference
				_dx -= 16;
			}
			else
			{
				// Sets actual difference
				_dx -= 12;
			}
		break;
			
		case 1: // Down
		
			// Sets check distance
			_cy += 16;
			
			// Checks if still head of train
			if (cars_count == 0)
			{
				// Sets actual difference
				_dy += 6;	
			}
			else
			{
				// Sets actual difference
				_dy += 10;
			}
		break;
			
		case 2: // Right
		
			// Sets check distance
			_cx += 20;
			
			// Checks if still head of train
			if (cars_count == 0)
			{
				// Sets actual difference
				_dx += 16;
			}
			else
			{
				// Sets actual difference
				_dx += 12;
			}
		break;
			
		case 3: // Up
		
			// Sets actual difference
			_dy -= 10;
			// Sets check distance
			_cy -= 16;
			
		break;
	}
	
	// Gets the tracks id
	var _track_id = layer_tilemap_get_id("Tracks");
	
	// Checks the position is still on screen
	if (!_is_forced && (_x + _dx < 0 || _x + _dx > room_width))
	{
		return false;	
	}
	
	// Checks if collision with track is possible but not with another train
	if (_is_forced || ((collision_point(_x + _cx, _y + _cy, _track_id, false, true) == _track_id) 
	&& (collision_point(_x + _cx, _y + _cy, obj_enemy_train, false, true) != obj_enemy_train)))
	{
		// Stores the new positions within the cars array
		cars[cars_count] = [_x + _dx, _y + _dy, _direction];
		// Ups the count
		cars_count++;
		
		// Sets the direction
		facing = _direction;
		
		// Checks if 3rd or 5th car
		if (cars_count == 3 || cars_count == 5)
		{
			// Creates a new turret
			var _new_turret = instance_create_layer(_x + _dx, _y + _dy, "Turrets", obj_train_turret);
			_new_turret.owner = self;
			_new_turret.car_id = cars_count - 1;
		}
		
		// Returns true saying a new car has been made
		return true;
	}
	else
	{
		// Returns false saying a new car has not been made
		return false;	
	}
}

// Random spawning method for train (dynamic)
spawn_random = function()
{
	// Sets a random direction while storing the current state aswell adding together for actual facing
	var _curr_dir = 0;
	var _rng_dir = irandom(3);

	// Loops while no cars have been set
	while(cars_count == 0)
	{
		// Tries to create a new car from new set facing
		new_car(x, y, (_curr_dir + _rng_dir) % 4);
	
		// Increments the current direction count
		_curr_dir++;
	
		// Checks if the direction is greater than or equal to 4 (a full rotation)
		if (_curr_dir >= 4)
		{
			// Breaks out of this loop
			break;
		}
	}

	// While there is a head car but not too many
	while(cars_count > 0 && cars_count < 5)
	{
		// Calls function inside an if statement and breaks out of loop if new car is not set
		if (!new_car(cars[cars_count - 1][0], cars[cars_count - 1][1], facing))
		{
			break;
		}
	}

	// Checks if at this point a train has 1 or less cars
	if (cars_count <= 1)
	{	
		// Destroys the train as having this few cars is not ideal
		instance_destroy();	
	}

	// Loops through the cars
	for (var _i = 0; _i < cars_count; _i++)
	{
		// Creates a new train car object that acts as a collision mask at the cars position
		var _new_car_mask = instance_create_layer(cars[_i][0], cars[_i][1], "Ground_Explosions", obj_train_car);
		// Sets the cars owner to be itself
		_new_car_mask.owner = self;
		_new_car_mask.car_id = _i;
	}
}

// Set spawning method for train (forced)
spawn_direction = function(_new_facing)
{	
	// Tries to create a new car from new set facing
	new_car(x, y, _new_facing, true);

	// While not enough cars
	while(cars_count < 5)
	{
		// Calls new car at last position
		new_car(cars[cars_count - 1][0], cars[cars_count - 1][1], _new_facing, true)
	}

	// Loops through the cars
	for (var _i = 0; _i < cars_count; _i++)
	{
		// Creates a new train car object that acts as a collision mask at the cars position
		var _new_car_mask = instance_create_layer(cars[_i][0], cars[_i][1], "Ground_Explosions", obj_train_car);
		// Sets the cars owner to be itself
		_new_car_mask.owner = self;
		_new_car_mask.car_id = _i;
	}
}

// Function used to blow up the train carriages when completed
blow_up = function()
{
	// Creates a big explosion
	var _new_explosion = instance_create_layer(x, y, "Ground_Explosions", obj_sprite_animation_manager);
	_new_explosion.sprite_index = spr_explosion_big;
	// Sets the explosions scale to 50%
	_new_explosion.image_xscale = 0.5;
	_new_explosion.image_yscale = 0.5;
	
	// Plays sound file for the explosion
	audio_play_sound(snd_explosion_big, 100, false);
	
	// Sets a score counter
	var _score = score_value;
	
	// Loops through all the connected train cars
	for (var _i = 0; _i < cars_count; _i++)
	{
		// Creates a small explosion
		var _new_explosion_small = instance_create_layer(cars[_i][0], cars[_i][1], "Ground_Explosions", obj_sprite_animation_manager);
		_new_explosion_small.sprite_index = spr_explosion_small;
		
		// Set the animation size to 75%
		_new_explosion_small.image_xscale = 0.75;
		_new_explosion_small.image_yscale = 0.75;
		
		// Sets explosion to retain ground move speed
		_new_explosion_small.move_speed = obj_game_manager.ground_move_speed;
		
		// Adds 500 points to counter per train car destroyed
		_score += 500;
	}
	
	// Adds the score to the current player points
	obj_game_manager.current_points += _score;
	
	// Creates a critical indicator for the points added to the players score
	var _new_crit = instance_create_layer(x, y, "UI", obj_crit_indicator);
	_new_crit.crit_text = string(_score);
	_new_crit.crit_colour = c_yellow;
	
	// Adds gamepad vibration for the explosion effects
	gamepad_vibration(1.0, 0.5, 0.4);
	
	// Destroys the enemy object
	instance_destroy();
}

// Length of movement memory per car
movement_memory = 1 / (delta_time * 0.000001);

// Function used to set up magic movement
set_movement = function()
{
	// Calculates the new move distance based on delta time and move speed
	var _move_distance = delta_time * 0.000001 * 4 * train_move_speed;
	
	// Sets required distance
	var _req_distance = (array_length(cars) + 1.5) * movement_memory;
		
	// Loops movement to be added for all the cars based on the facing
	for (var _i = 0; _i < _req_distance; _i++)
	{
		var _new_data = -1;
		
		// Switch statement for what way the train is facing
		switch(facing)
		{
			// Facing right
			case 0:
				// Creates array for new data
				_new_data =  [_move_distance, 0, facing];
				// New move added
				ds_list_add(movement_list, _new_data);
			
			break;
			
			// Facing up
			case 1:
				// Creates array for new data
				_new_data = [0, -_move_distance, facing];
				// New move added
				ds_list_add(movement_list, _new_data);
			break;
			
			// Facing left
			case 2:
				// Creates array for new data
				_new_data = [-_move_distance, 0, facing];
				// New move added
				ds_list_add(movement_list, _new_data);
			break;

			// Facing down
			case 3:
				// Creates array for new data
				_new_data = [0, _move_distance, facing];
				// New move added
				ds_list_add(movement_list, _new_data);
			break;
		}
	}
}

// Function used to apply movement
apply_movement = function()
{
	var _last_movement = ds_list_find_value(movement_list, ds_list_size(movement_list) - 1);
	
	// Moves the train
	x += _last_movement[0];
	y += _last_movement[1];
	
	// Loops through the train cars
	for (var _i = 0; _i < cars_count; _i++)
	{
		// Finds movement based on car
		var _car_movement = ds_list_find_value(movement_list, (ds_list_size(movement_list) - 1) - ((_i + 1) * movement_memory));
		
		// Moves the cars
		cars[_i][0] += _car_movement[0];
		cars[_i][1] += _car_movement[1];
		
		if (cars[_i][2] != _car_movement[2])
		{
			switch(cars[_i][2])
			{
				case 0:
					cars[_i][0] += 4;
					
					if (_i != 0)
					{
						if (_car_movement[2] == 1)
						{
							cars[_i][1] -= 2;
						}
						else
						{
							cars[_i][1] += 2;
						}
					}
					
					break;
				case 1:
					if (_car_movement[2] == 0)
					{
						cars[_i][0] -= 4;
					}
					else
					{
						cars[_i][0] += 4;
					}
					
					if (_i != 0)
					{
						cars[_i][1] += 2;
					}
					
					break;
				case 2:
					cars[_i][0] -= 4;
					
					if (_i != 0)
					{
						if (_car_movement[2] == 1)
						{
							cars[_i][1] -= 2;
						}
						else
						{
							cars[_i][1] += 2;
						}
					}
					
					break;
				case 3:
					if (_car_movement[2] == 0)
					{
						cars[_i][0] -= 4;
					}
					else
					{
						cars[_i][0] += 4;
					}
					
					if (_i != 0)
					{
						cars[_i][1] -= 2;
					}
					
					break;
			}
			
			cars[_i][2] = _car_movement[2];
		}
	}
	
	// Removes the oldest movement
	ds_list_delete(movement_list, 0);
	
	// Sets variable to self
	var _self = self;
	
	// Loops through the train cars
	with(obj_train_car)
	{
		// Checks if owner is this train
		if (owner == _self)
		{
			// Moves the cars
			x = _self.cars[car_id][0];
			y = _self.cars[car_id][1];	
		}
	}
	
	// Loops through the turret objects
	with(obj_train_turret)
	{
		// Checks if owner is this train
		if (owner == _self)
		{
			// Moves the turrets
			x = _self.cars[car_id][0];
			y = _self.cars[car_id][1];
		}
	}
}