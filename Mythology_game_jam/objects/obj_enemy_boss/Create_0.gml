/// Enemy Boss Object
// Larger enemy type that fires rapid shots (with health bar)

// Inherit the parent event
event_inherited();

// Sets the sprites tilting left and right and default
default_sprite = spr_plane_enemy_big_3;
left_sprite = spr_plane_enemy_big_l_turn_3;
right_sprite = spr_plane_enemy_big_r_turn_3;

// Engine sound file attached to plane
engine_sound_file = snd_engine_enemy_9;

// Sets base move speeds
x_move_speed = 2;
y_move_speed = 4;

// Sets the target position as the middle of the screen
target_x = 135;
target_y = 0;

// Sets adjusted aim tolerance for when knowing when to start firing at the player
aim_tolerance = 120;

// Sets a higher base ammmo
base_ammo = 10;
// Sets the current ammo to the base ammo
ammo_count = base_ammo;

// Sets the reload cooldown/threshold
reload_timer = 0;
reload_cooldown = 0.2;

// Sets the magazine cooldown/threshold
mag_timer = 0;
mag_cooldown = 2;

// Threshold value for when enemy can actually fire at the player
lockon_timer = 0;
lockon_threshold = 1.0;

// Variable for tracking alt fire states
alt_fire = false;

// Set hp for enemy
hp = 64;

// Variable for keeping track of the shooting pattern spread angle
wave_multi = -2.5;

// Variable for enemy score value
score_value = 25000;

// Stops the music that was playing
audio_stop_sound(global.music);
// Starts playing the boss sting
boss_music = audio_play_sound(snd_boss_music, 100, false);

// Function called when then enemy fires
fire = function()
{
	// Creates left fired projectile
	var _new_l_proj = instance_create_layer(x - 14, y + 20, "Projectiles", obj_enemy_projectile);
	// Sets owner
	_new_l_proj.owner = self;
	// Sets the image index based on alt fire flag
	_new_l_proj.image_index = alt_fire? 0 : 1;
	// Sets direction to travel based on wave multi value
	_new_l_proj.direction = 270 + sin(pi * 0.2 * wave_multi) * 15;
	
	// Creates right fired projectile
	var _new_r_proj = instance_create_layer(x + 12.5, y + 20, "Projectiles", obj_enemy_projectile);
	// Sets owner
	_new_r_proj.owner = self;
	// Sets the image index based on alt fire flag
	_new_r_proj.image_index = alt_fire? 1 : 0;
	// Sets direction to travel based on wave multi value
	_new_r_proj.direction = 270 + sin(pi * 0.2 * wave_multi) * 15;
	
	// Plays the enemy firing sound
	audio_play_sound(snd_enemy_fire_3, 100, false);
	
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
		
		// Sets mag counter to 0
		mag_timer = 0;
	}
}