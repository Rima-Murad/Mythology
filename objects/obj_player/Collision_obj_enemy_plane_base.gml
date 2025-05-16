// Checks if the win screen is showing
if (instance_exists(obj_game_win_screen))
{
	// Stops the rest of the event since game is techinally over
	exit;	
}

// Calculate the bounce between the player and other plane from their direction and distance from each other
var _new_dir = point_direction(other.x, other.y, x, y);
var _new_speed = point_distance(other.x, other.y, x, y);

// Calculate the new velocity that is added to the player
var _nx = lengthdir_x(_new_speed, _new_dir);
var _ny = lengthdir_y(_new_speed, _new_dir);

// Adds the new velocity to existing velocity at scale
velo_x += _nx * 20;
velo_y -= _ny * 20;

// Checks if a shield exists
if (instance_exists(obj_player_shield))
{
	// Creates an explosion
	var _new_explosion = instance_create_layer(other.x, other.y, "Explosions", obj_sprite_animation_manager);
	_new_explosion.sprite_index = spr_explosion_big;
	
	// Plays sound
	audio_play_sound(snd_explosion_big, 100, false);
	
	// Checks other plane is not the boss
	if (other.object_index != obj_enemy_boss)
	{
		// Destroys the other plane
		instance_destroy(other);
	}
	
	// Exits from the event since player cant get hurt with a shield
	exit;
}

// Checks the player isnt in a hurt state
if (!is_hurt)
{
	// Puts player into hurt state
	is_hurt = true;
	
	// Reduces hp
	hp--;

	// Checks if player has ran out of health
	if (hp <= 0)
	{
		// Creates a big explosion
		var _new_explosion = instance_create_layer(x, y, "Explosions", obj_sprite_animation_manager);
		_new_explosion.sprite_index = spr_explosion_big;
		
		// Plays big explosion sound effect
		audio_play_sound(snd_explosion_big, 100, false);
	
		var _new_crit = instance_create_layer(x, y, "UI", obj_crit_indicator);
		_new_crit.crit_font = global.font_text;
		_new_crit.crit_text = string("RIP");
		_new_crit.crit_colour = c_red;
	
		// Calls gamepad vibration effect
		gamepad_vibration(1.0, 1.0, 0.5);
		
		// Destroys the player
		instance_destroy();
	}
	else
	{
		// Creates a big explosion
		var _new_explosion = instance_create_layer(other.x, other.y, "Explosions", obj_sprite_animation_manager);
		_new_explosion.sprite_index = spr_explosion_big;
		
		// Plays big explosion sound effect
		audio_play_sound(snd_explosion_big, 100, false);
	
		// Calls gamepad vibration effect
		gamepad_vibration(0.5, 0.5, 0.2);
	}
	
	// Checks other plane is not the boss
	if (other.object_index != obj_enemy_boss)
	{
		// Destroys the other plane
		instance_destroy(other);
	}
}
else
{
	// Plays protected hit sounds
	audio_play_sound(snd_explosion_small, 100, false);
	audio_play_sound(snd_hit_small, 100, false);
}

