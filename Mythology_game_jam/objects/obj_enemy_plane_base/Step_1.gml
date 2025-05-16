// Checks if game is paused
if (global.is_paused)
{
	// Exits out of event
	exit;	
}

// Updates previous values to current ones
prev_x = x;
prev_y = y;

// Checks if audio for engine is playing
if (!audio_is_playing(engine_sound))
{
	// Plays the engines audio sound
	engine_sound = audio_play_sound(engine_sound_file, 100, true, 0.5);	
}

// Checks if plane is not leader
if (!is_leader)
{
	// Sets flag for knowing if leader exists
	var _has_leader = false;
	
	// Loops through all planes
	with (obj_enemy_plane_base)
	{
		// Checks plane is leader
		if (is_leader)
		{
			// Sets flag to true
			_has_leader = true;	
		}
	}

	// Checks if leader has not been set
	if (!_has_leader)
	{
		// Sets this plane as a leader
		is_leader = true;	
	}
}