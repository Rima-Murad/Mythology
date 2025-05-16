// Sets the draw font to the text font loaded into the game
draw_set_font(global.font_text);
// Draws the player 1 text
draw_text(x, y, "PLAYER 1");

// Store the current score as a string
var _string_score = string(obj_game_manager.current_points);

// Calculate the scores current length
var _score_length = string_length(_string_score);

// Limit the maximum length to 8 characters
// If larger than 8 no leading zeros will be added and the score will just extend across the screen
_score_length = min(_score_length, 8);

// Set the new string with up to 8 leading zeros and then the actual score
var _new_string = string_repeat("0", 8 - _score_length) + _string_score;

// Sets the draw font to the score font loaded into the game
draw_set_font(global.font_score);
// Draws the modified score text
draw_text(x, y + 10, _new_string);

// Checks if debug
if (global.is_debug)
{
	// Set debug font and colours
	draw_set_font(global.font_text_white);
	draw_set_color(c_fuchsia);

	// Draw debug info
	draw_text(x, y + 30, "DEBUG MODE");
	draw_text(x, y + 40, "STAGE: " + string(obj_wave_manager.stage));
	draw_text(x, y + 50, "LEVEL: " + string(obj_wave_manager.level));
	draw_text(x, y + 70, "HS: " + string(global.highscore));
}

// Sets draw colour
draw_set_color(c_white);

// Checks if player still exists
if (instance_exists(obj_player))
{
	// Checks if player still has health and loops though available hp
	for (var _i = 0; _i < obj_player.hp; _i++)
	{
		// Draw health sprite icon
		draw_sprite(spr_icon_health, 0, room_width - 16 - _i * 16, 464);
	}
	
	if (global.is_debug)
	{
		// Set debug font and colours
		draw_set_font(global.font_text_white);
		draw_set_color(c_fuchsia);

		// Draw debug info
		draw_text(x, y + 60 + 340, "SHOT STATE: " + string(obj_player.curr_player_shot_style));
		draw_text(x, y + 70 + 340, "SHOT LEVEL: " + string(obj_player.curr_shot_level));
		draw_text(x, y + 80 + 340, "BOMB STATE: " + string(obj_player.is_bomb_big ? "TRUE" : "FALSE"));
		draw_text(x, y + 90 + 340, "BOMB LEVEL: " + string(obj_player.curr_bomb_level));
		
		// Resets draw colour
		draw_set_color(c_white);
	}
}