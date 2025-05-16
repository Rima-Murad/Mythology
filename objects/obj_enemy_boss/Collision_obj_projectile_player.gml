// Stores projectiles positions before destroying it
var _px = other.x;
var _py = other.y;

// Checks if hit shot was bullet
if (other.current_shot_type == PROJECTILE_TYPE.SHOT_SMALL || other.current_shot_type == PROJECTILE_TYPE.SHOT_BIG)
{
	// Reduces hp
	hp--;
}
else
{
	// Reduces hp by 2 since hit by missile
	hp -= 2;	
}


// Destroys the other instance
instance_destroy(other);

// Sets hit timer to cooldown value
hit_timer = hit_cooldown;

// Checks if enemy has ran out of health
if (hp <= 0)
{
	// Creates a big explosion
	var _new_explosion = instance_create_layer(x, y, "Explosions", obj_sprite_animation_manager);
	_new_explosion.sprite_index = spr_explosion_big;
	
	// Plays long explosion sound as boss is defeated
	audio_play_sound(snd_explosion_long, 100, false);
	
	// Adds the score value of the enemy to the players total
	obj_game_manager.current_points += score_value;
	
	// Creates a critical indicator for the points added to the players score
	var _new_crit = instance_create_layer(x, y, "UI", obj_crit_indicator);
	_new_crit.crit_text = string(score_value);
	_new_crit.crit_colour = c_yellow;
	
	// Long vibration added
	gamepad_vibration(0.5, 1.0, 1.0);
	
	// Destroys the enemy object
	instance_destroy();
}
else
{
	// Creates small explosion on the projectile
	var _new_explosion = instance_create_layer(_px, _py, "Explosions", obj_sprite_animation_manager);
	_new_explosion.sprite_index = spr_explosion_small;
	
	// Plays a random hit sound file
	var _hit_sound = choose(snd_energy_shield_hit_1, snd_energy_shield_hit_2);
	audio_play_sound(_hit_sound, 100, false);
}