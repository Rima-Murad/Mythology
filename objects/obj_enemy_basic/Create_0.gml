/// Enemy Basic Object
// Smaller enemy type that fires single shot

// Inherit the parent event
event_inherited();

// Sets the sprites tilting left and right and default
default_sprite = spr_plane_enemy_small_1;
left_sprite = spr_plane_enemy_small_l_turn_1;
right_sprite = spr_plane_enemy_small_r_turn_1;

// Engine sound file attached to plane
engine_sound_file = snd_engine_enemy_1;

// Sets base move speeds
x_move_speed = 4;
y_move_speed = 8;

// Sets the target position as the middle of the screen
target_x = 135;
target_y = 0;

// Sets adjusted aim tolerance for when knowing when to start firing at the player
aim_tolerance = 50;

// Sets base ammmo
base_ammo = 30;
// Sets the current ammo to the base ammo
ammo_count = base_ammo;

// Sets a reload timer to zero for use later knowing how long since the enemy last fired
reload_timer = 0;
// Sets the reload cooldown/threshold to an adjusted value
reload_cooldown = 2;

// Lock on timer for how long enemy has been able to fire at player
lockon_timer = 0;
// Threshold value for when enemy can actually fire at the player
lockon_threshold = 0.5;

// Flag for knowing if enemy is alternate firing or not
alt_fire = false;

// Function called when then enemy fires
fire = function()
{
	// Creates left fired projectile
	var _new_l_proj = instance_create_layer(x - 14, y + 20, "Projectiles", obj_enemy_projectile);
	// Sets owner
	_new_l_proj.owner = self;
	// Sets the image index based on alt fire flag
	_new_l_proj.image_index = alt_fire? 0 : 1;
	// Sets direction to travel down
	_new_l_proj.direction = 270;
	
	// Creates right fired projectile
	var _new_r_proj = instance_create_layer(x + 12.5, y + 20, "Projectiles", obj_enemy_projectile);
	
	// Sets owner
	_new_r_proj.owner = self;
	// Sets the image index based on alt fire flag
	_new_r_proj.image_index = alt_fire? 1 : 0;
	// Sets direction to travel down
	_new_r_proj.direction = 270;
	
	// Plays the enemy firing sound
	audio_play_sound(snd_enemy_fire_2, 100, false);
	
	// Toggles alt fire flag
	alt_fire = !alt_fire;
	
	// Decreased ammo count
	ammo_count--;
	// Resets reload timer
	reload_timer = 0;
	
	// Checks if ammo is depleated
	if (ammo_count <= 0)
	{
		// Sets reloading to true
		is_reloading = true;	
	}
}