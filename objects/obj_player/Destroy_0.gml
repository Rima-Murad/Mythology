// Destroys the players shadow since they no longer exist
instance_destroy(shadow);

// Spawns in game over menu
var _new_menu_seq = instance_create_layer(0,0, "Menus", obj_sequence_manager);
_new_menu_seq.create_seq(seq_game_over_menu, "Menus");
_new_menu_seq.can_die = false;
_new_menu_seq.can_pause = false;

// Stops the engine sounds as it no longer exists
audio_stop_sound(engine_sound);
// Plays the long explosion sound
audio_play_sound(snd_explosion_long, 100, false);

// Checks for any bosses
with (obj_enemy_boss)
{
	// Stops the boss music from playing
	audio_stop_sound(boss_music);	
}