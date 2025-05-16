/// Game Manager Object
// Sets up the game initalising objects needed and storing level specific variables

// Sets up the global paused state variable
global.is_paused = false;

// Sets global variable for main background music
global.music = audio_play_sound(snd_main_music, 0.75, true);

// Sets global variable for seascape sound
global.sea_sound = audio_play_sound(snd_seascape_main, 100, true);

// Calls randomise to set new random seed for project
randomise();

// Player Score
current_points = 0;

// Sets room dimensions to default values
room_set_width(rm_levels, 270);
room_set_height(rm_levels, 480);

// Sets room dimensions as well
room_width = 270;
room_height = 480;

// Sets array of ground layer id's for scrolling
ground_layers[0] = layer_get_id("Water");
ground_layers[1] = layer_get_id("Land");
ground_layers[2] = layer_get_id("Forest");
ground_layers[3] = layer_get_id("Tracks");

// Sets grounds base move speed
ground_move_speed = 16;

// Sets the cloud count (how many can be spawned onto scene at once)
cloud_count = 8;

// Flag for knowing if previous train has been checked
prev_train_check = false;

// Function for moving the positions of all the ground based objects (done in function to allow creating order to take place)
set_ground_positions = function()
{
	// Moves all the ground layers 3872 pixels up (Restarting scene in room basically)
	for (var _i = 0; _i < array_length(ground_layers); _i++)
	{
		layer_y(ground_layers[_i], -3872);	
	}

	// Loops through all the trains spawners
	with (obj_train_spawner)
	{
		// Moves the spawner position up
		y -= 3872;
	}

	// Loops through all the building objects
	with (obj_building__base)
	{
		// Moves the position up
		y -= 3872;
	}
}

// Creates all the objects needed to play the game
instance_create_layer(0, 0, "Instances", obj_wave_manager);
instance_create_layer(0, 0, "Shadow_Surface", obj_shadow_manager);
instance_create_layer(135, 360 + 160, "Player", obj_player);
instance_create_layer(258, 20, "UI", obj_button_pause);
instance_create_layer(0, 0, "UI", obj_hud_score);

// Timer used for the seascape wave noises
seascape_timer = 10;

// Checks game has touch input enabled
if (global.is_touch)
{
	// Spawns in touch ui
	var _new_pause_seq = instance_create_layer(0,0, "Instances", obj_sequence_manager);
	_new_pause_seq.create_seq(seq_touch_ui, "Instances");
	_new_pause_seq.can_die = false;
	_new_pause_seq.can_pause = false;
}