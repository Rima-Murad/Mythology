/// Wave Manager Object 
// Handles the waves of enemies spawned into the game

// Sets the inital stage and level variables to zero
stage = 0;
level = 0;

// Flag for knowing if its a new stage
is_new_stage = false;

// Flag for when stage is in spawning mode (prevents changes)
is_spawning = false;

// Time player has been on level
level_time = 0;
// Time allowed on level before forced progression
level_time_threshold = 0;

// State for if boss has occured
has_bossed = false;

// Death handle for telling this object spawning can be set to false again
death_handle = function()
{
	obj_wave_manager.is_spawning = false;	
}