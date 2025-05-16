/// Game over screen object
// Created and exists when the game is in a gameover state (player dies)

// Stops the current game music
audio_stop_sound(global.music);

// Plays the lose music sting
global.music = audio_play_sound(snd_lose_music, 100, false);

// Checks if the current score is higher than the set highscore
if (obj_game_manager.current_points > global.highscore)
{
	// Saves the new highscore using save function
	scr_savedata_save(obj_game_manager.current_points);
	
	// Stores the current score as the high score
	global.highscore = obj_game_manager.current_points;
}