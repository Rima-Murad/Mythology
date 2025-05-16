// Checks if game has been paused
if (global.is_paused)
{
	// Exits event
	exit;	
}

// Checks if game has finished
if (instance_exists(obj_game_over_screen) || instance_exists(obj_game_win_screen))
{
	// Exits event
	exit;	
}

// Only performs check when spawned has not been used
if (!has_spawned)
{
	// Checks if spawner is in correct position just above the screen
	if (y >= -16 && y < 0)
	{
		// Spawns new train
		var _new_train = instance_create_layer(x, y, "Trains", obj_enemy_train);
		
		// Checks if spawner is on left or right of screen
		if (x <= 135)
		{
			// Sets the train to forced full size coming from left of screen
			_new_train.spawn_direction(0);
		}
		else
		{
			// Sets the train to forced full size coming from roght of screen
			_new_train.spawn_direction(2);
		}
		
		// Check new train did spawn
		if (instance_exists(_new_train))
		{	
			// Set its movement
			_new_train.set_movement();
		}
		
		// Sets spawned flag to true
		has_spawned = true;
		// Alerts gamemanager object train check has occured
		obj_game_manager.prev_train_check = true;
	}
}