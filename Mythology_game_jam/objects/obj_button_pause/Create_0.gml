/// Pause button object
// Pauses the game

// Inherit the parent event
event_inherited();

// Sets icon sprite
icon_sprite = spr_icon_pause;

// Sets button alt
highlight_button_sprite = spr_button_side_over;

// Changes the triggered functionality of the button
button_triggered = function()
{	
	// Checks game is not in gameover state
	if (!instance_exists(obj_game_over_screen) && !instance_exists(obj_game_win_screen))
	{
		// Creates gamepad vibration
		gamepad_vibration(0.1, 0.1, 0.1);
	
		// Plays sound
		audio_play_sound(snd_button_push, 100, false);
		
		// Checks game is not currently in a paused state
		if (!global.is_paused)
		{
			// Changes the game state to paused
			global.is_paused = true;
	
			// Sets buttons current state back to idle
			curr_button_state = BUTTON_STATE.IDLE;
		
			// Spawns in pause menu
			var _new_pause_seq = instance_create_layer(0,0, "Menus", obj_sequence_manager);
			_new_pause_seq.create_seq(seq_pause_menu, "Menus");
			_new_pause_seq.can_die = false;
			_new_pause_seq.can_pause = false;
		}
		else
		{
			// Changes the game state to unpaused
			global.is_paused = false;
		
			// Sets buttons current state back to idle
			curr_button_state = BUTTON_STATE.IDLE;
		}
	}
}