/// Splash Manager Object
// Checks all global variables that need to be used exist or creates them here before letting the player do anything

// Sets global paused flag to false since game has just started or been restarted
global.is_paused = false;

// Flag for if game is in debug mode
global.is_debug = false;

// Sets the global music used for the main menu
global.music = audio_play_sound(snd_boss_music, 100, true, 0.5);

// Stick cooldown value set to zero
global.stick_cooldown = 0;

// Checks if bitmap fonts have been loaded in
if (!variable_global_exists("font_score") || !variable_global_exists("font_text"))
{
	// Calls font loader script to set them up
	scr_font_load_all();
}

// Checks for High Score and loads in value if unset
if (!variable_global_exists("highscore"))
{
	// Sets global variable with custom load script
	global.highscore = scr_savedata_load();	
}

// Checks if global variable for muted state exists
if (!variable_global_exists("is_muted"))
{
	// Sets state to false so it can be used
    global.is_muted = false;
}

// Checks for if main music is playing
if (variable_global_exists("music_main"))
{
	// Checks if main music is playing
	if (audio_is_playing(global.main_music))
	{	
		// Stops the current playing music
		audio_stop_sound(global.main_music);
	}
}

// Checks if shadow list exists already
if (variable_global_exists("shadow_list"))
{
	// Clears the existing shadow list
	ds_list_clear(global.shadow_list);
}
else
{
	// Creates a new shadow list
	global.shadow_list = ds_list_create();
}

// Checks if game is using a platform that supports shaders
if (shaders_are_supported())
{
	// Checks the shaders have been compiled
	if (shader_is_compiled(sh_blur) && shader_is_compiled(sh_highlighted))
    {
        // Sets shader flag to true
		global.can_shader = true;
    }
	else
	{
		// Sets shader flag to false
		global.can_shader = false;
	}
}
else
{
	// Sets shader flag to false
	global.can_shader = false;
}

// Checks if game is using a platform that requires touch input
if (os_type == os_ios || os_type == os_android)
{
	// Sets flag to true
	global.is_touch = true;
}
else
{
	// Sets flag to false
	global.is_touch = false;
}

// State for shadows set to true by default (artistic choice!)
global.shadow_mode_toggle = true;

// Spawns in splash screen menu
var _new_splash_seq = instance_create_layer(0,0, "Instances", obj_sequence_manager);
_new_splash_seq.create_seq(seq_splash_menu, "Instances");
_new_splash_seq.can_die = false;