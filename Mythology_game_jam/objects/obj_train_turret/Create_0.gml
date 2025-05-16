/// Enemy Turret Object
// Turret object attached to trains that will fire towards the player

// Sets the turrets owner to unset
owner = noone;

// Sets car id for position in train
car_id = -1;

// Ammo size for turrets and sets count to this (how many bullets can shoot before reload needed)
ammo_size = 100;
ammo_count = ammo_size;

// Time taken to reload before ammo is restocked
reload_cooldown = 5.0;
reload_time = reload_cooldown;

// Fire rates
fire_rate = 2.0;
fire_time = 0.0;

// State of firing sprite
alt_fire = false;

// Fire function called when turret fires
fire = function()
{
	// Creates fired projectile
	var _new_proj = instance_create_layer(x, y - 5, "Bombs", obj_enemy_projectile);
	
	// Sets owner
	_new_proj.owner = self;
	_new_proj.image_index = alt_fire? 0 : 1;
	_new_proj.image_xscale = 0.25;
	_new_proj.image_yscale = 0.25;
	
	// Sets direction to point towards player from offset position
	_new_proj.direction = point_direction(x, y - 5, obj_player.x, obj_player.y);
	
	// Sets projectile to a slower speed
	_new_proj.set_speed *= 0.4;
	
	// Specifies that the projectile is not yet airbound and cannot hurt the player yet
	_new_proj.is_airbound = false;
	
	// Inverts the alertative fire flag swapping its sprite
	alt_fire = !alt_fire;
	
	// Reduces the ammo by one
	ammo_count--;
	// Resets the firerate cooldown
	fire_time = 0;
	
	// Chooses a random turret sound effect
	var _turret_sound = choose(snd_turret_fire_1, snd_turret_fire_2, snd_turret_fire_3);
	// Plays turret sound
	audio_play_sound(_turret_sound, 100, false);
	
	// Checks if ammo count is depleated
	if (ammo_count <= 0)
	{
		// Starts the reload timer
		reload_time = 0;
	}
}