/// Script for all the functions that are created to change gamepad vibrations

// Function called to update the current games gamepad vibration levels
function gp_vibration_update()
{
	// Checks if the global list of time sources exist
	if (!variable_global_exists("ts_list"))
	{
		// Creates the timesource list
		global.ts_list = ds_list_create();
	}
	
	// Checks if the global variables for the left and right vibration levels exist
	if (!variable_global_exists("gpv_l") || !variable_global_exists("gpv_r"))
	{
		// Creates and sets the vibration levels to zero
		global.gpv_l = 0;
		global.gpv_r = 0;
	}
	
	// Calls the set vibration function with the clamped values between zero and one
	gamepad_set_vibration(0, clamp(global.gpv_l, 0, 1), clamp(global.gpv_r, 0, 1));
	
	// Checks when both the vibration levels are set to zero
	if (global.gpv_l == 0 && global.gpv_r == 0)
	{
		// Array of finished time sources
		var _finished_ts = [];
		
		// Loops through the timesources list
		for (var _i = 0; _i < ds_list_size(global.ts_list); _i++)
		{
			// Stores the current ts being checked
			var _ts = ds_list_find_value(global.ts_list, _i);
			
			// Checks if the time remaining is finished
			if (time_source_get_time_remaining(_ts) <= 0)
			{	
				// Stores the ts in the array
				_finished_ts[array_length(_finished_ts)] = _ts;
			}
		}
		
		// Loops through the finished ts array
		for (var _i = 0; _i < array_length(_finished_ts); _i++)
		{
			// Removes the time source from the list
			ds_list_delete(global.ts_list, ds_list_find_index(global.ts_list, _finished_ts[_i]));
			// Destroy the expired time source
			time_source_destroy(_finished_ts[_i]);
		}
	}
}

// Function used to adjust the gamepad vibration levels
function gamepad_vibration(_l_strength, _r_strength, _time)
{	
	// Kill handle created to remove the vibration levels when their time has expired
	var _kill_handle = function(_ls, _rs)
	{
		// Takes the left and right values from the global variables
		global.gpv_l -= _ls;
		global.gpv_r -= _rs;
	}
	
	// Creates a new time source for the kill handle to play after specified time has passed
	var _ts = time_source_create(time_source_game, _time, time_source_units_seconds, _kill_handle, [_l_strength, _r_strength]);
	
	// Adds the left and right values to the global variables
	global.gpv_l += _l_strength;
	global.gpv_r += _r_strength;
	
	// Calls the vibration update as it has been changed
	gp_vibration_update();
	
	// Starts the new time source
	time_source_start(_ts);
	
	// Adds this timesource to the list
	ds_list_add(global.ts_list, _ts);
}