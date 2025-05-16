/// Scripts for saving and loading save data from buffers

// Returns the value game from the buffers returning -1 if nothing exits
function scr_savedata_load()
{
	// Loads buffer for highscore
	var _highscore_buffer = buffer_load("SHMUP_HS.sav");
	
	// Checks if buffer exists
	if(buffer_exists(_highscore_buffer))
	{
		// Goes to the start of the buffer
		buffer_seek(_highscore_buffer, buffer_seek_start, 0);
	
		// Returns the high score value from the buffer
		return buffer_read(_highscore_buffer, buffer_u64);
	}
	else
	{
		// Creates highscore buffer
		_highscore_buffer = buffer_create(16384, buffer_fixed, 2);
		
		// Goes to the start of the buffer
		buffer_seek(_highscore_buffer, buffer_seek_start, 0);

		// Writes highscore value to the buffer
		buffer_write(_highscore_buffer, buffer_u64, -1);
	
		// Saves the new empty highscore buffer
		buffer_save(_highscore_buffer, "SHMUP_HS.sav");
		
		return -1;
	}
}

// Stores the paramater value in the save buffer
function scr_savedata_save(_score)
{
	// Loads buffer for highscore
	var _highscore_buffer = buffer_load("SHMUP_HS.sav");
	
	// Checks if buffer exists
	if(!buffer_exists(_highscore_buffer))
	{
		// Creates highscore buffer
		_highscore_buffer = buffer_create(16384, buffer_fixed, 2);
	}

	// Goes to the start of the buffer
	buffer_seek(_highscore_buffer, buffer_seek_start, 0);

	// Writes highscore value to the buffer
	buffer_write(_highscore_buffer, buffer_u64, _score);
	
	// Saves the new highscore buffer
	buffer_save(_highscore_buffer, "SHMUP_HS.sav");
}