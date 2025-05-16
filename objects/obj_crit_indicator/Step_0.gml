// Checks if game is paused
if (global.is_paused)
{
	// Exits the event
	exit;
}

// Calculates the current time passed
var _delta_time = delta_time * 0.000001;

// Takes time passed away from life remaining
life_remaining -= _delta_time;

// Checks if the texts life has finished
if (life_remaining <= 0)
{
	// Reduces the alpha value since fading out
	crit_alpha -= _delta_time;
	
	// Checks if alpha value is no longer visible
	if (crit_alpha <= 0)
	{
		// Checks if can call wave has been set
		if (can_call_wave)
		{
			// Calls a new wave via the wave managers death handle
			obj_wave_manager.death_handle();	
		}
		
		// Destroys this object
		instance_destroy();
	}
}

// Moves the text up at the move speed for the time passed
y -= move_speed * _delta_time;