// Checks if game has ended
if (instance_exists(obj_game_win_screen))
{
	// Exits event as player cannot be hurt anymore
	exit;	
}

// Checks if the projectile is from the player
if (other.owner == self)
{
	// Exits event before doing any other actions
	exit;	
}
else
{
	// Checks the projectile is airbound and on level with actually hitting the player
	if (!other.is_airbound)
	{
		// Exits event before doing any other actions
		exit;	
	}
}

// Checks for a player shield
if (instance_exists(obj_player_shield))
{
	// Creates a small explosion
	var _new_explosion = instance_create_layer(other.x, other.y, "Explosions", obj_sprite_animation_manager);
	_new_explosion.sprite_index = spr_explosion_small;
	
	// Plays hit sound effect
	audio_play_sound(snd_hit_small, 100, false);
	
	// Destroys the projectile
	instance_destroy(other);
	
	// End the event here as the player cannot be damaged
	exit;
}

// Checks if the player is in a hurt state
if (!is_hurt)
{
	// Changes the players hurt state
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
	
		// Creates a new hit effect
		var _new_crit = instance_create_layer(x, y, "UI", obj_crit_indicator);
		_new_crit.crit_font = global.font_text;
		_new_crit.crit_text = string("RIP");
		_new_crit.crit_colour = c_red;
	
		// Call for gamepad vibration
		gamepad_vibration(1.0, 1.0, 0.5);
		
		// Destroys the player
		instance_destroy();
	}
	else
	{
		// Creates small explosion on the projectile
		var _new_explosion = instance_create_layer(other.x, other.y, "Explosions", obj_sprite_animation_manager);
		_new_explosion.sprite_index = spr_explosion_small;
	
		// Plays small explosion sound effect
		audio_play_sound(snd_explosion_small, 100, false);
		// Call for gamepad vibration
		gamepad_vibration(0.5, 0.5, 0.2);
	}
}
else
{
	// Plays small explosion sound effect
	audio_play_sound(snd_hit_small, 100, false);	
}

// Destroy the projectile since has hit
instance_destroy(other);