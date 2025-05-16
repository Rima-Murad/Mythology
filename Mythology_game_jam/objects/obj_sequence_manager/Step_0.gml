// Checks if owner has been attached
if (owner != noone)
{
	// Adjusts the coordinates to follow the owner
	x = owner.x;
	y = owner.y;
}

// Checks if a sequence has been set
if (set_sequence != -1)
{
	// Checks if the sequnece has finished
	if (layer_sequence_is_finished(set_sequence))
	{
		// Checks if the sequence can die
		if (can_die)
		{
			// Destroys the sequence
			layer_sequence_destroy(set_sequence);
		}
		
		// Checks if the death flag has been set
		if (has_death)
		{
			// Runs the stored death function
			stored_function();	
		}
		
		// Destroys this sequences manager object
		instance_destroy();
	}
	else
	{
		// Updates the sequence position to the objects
		layer_sequence_x(set_sequence, x);
		layer_sequence_y(set_sequence, y);
	}
}
else
{
	// Destroys this manager object as no sequence exists
	instance_destroy();
}

// Checks if the sequence ignores game pauses
if (!can_pause)
{
	// Exits the event as the sequence will not care about pauses
	exit;	
}

// Checks if the game is paused
if (global.is_paused)
{
	// Checks if the sequence is not paused
	if (!layer_sequence_is_paused(set_sequence))
	{
		// Pauses the set sequence
		layer_sequence_pause(set_sequence);
	}
}
else
{
	// Checks if the sequence is paused
	if (layer_sequence_is_paused(set_sequence))
	{
		// Resumes the sequenece
	    layer_sequence_play(set_sequence);
	}
}