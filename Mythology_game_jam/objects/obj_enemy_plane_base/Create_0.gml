/// Base enemy plane object
// Base plane used for all enemy types both pathed and smart

// Variable for enemy health
hp = 1;

// Variable for enemy score value
score_value = 100;

// Enemies movement
velo_x = 0;
velo_y = 0;

// Sets base move speeds
x_move_speed = 4;
y_move_speed = 8;

// Drag rates for x and y movement
x_drag = 0.92;
y_drag = 0.95;

// Maximum speeds allowed for x and y speeds
max_x_speed = 60;
max_y_speed = 75;

// Enemies tilt threshold for swapping sprites
tilt_threshold = 22;

// Used to know if plane is using left or right tilting sprites for scaling reasons
is_titled = false;

// Keeps track on the planes reloading state
is_reloading = false;
// Tells if the plane is finished and should fly off screen
is_finished = false;

// Base ammo changed later for each plane
base_ammo = 3;
// Ammo count set from base value
ammo_count = base_ammo;

// Mag timer 
mag_timer = 0;
// Mag cooldown timer
mag_cooldown = 6;

// Variables for the sprites tilting left and right and default
default_sprite = -1;
left_sprite = -1;
right_sprite = -1;

// Variables for the planes target position
target_x = xstart;
target_y = ystart;

// Buffers for the target position
target_buffer_x = 0;
target_buffer_y = 0;

// Keeps track of how long enemy planes are intersecting 
collision_time = 0;

// Creates and sets up new shadow for the enemy plane
shadow = instance_create_layer(x, y, "Shadows", obj_shadow);
shadow.owner = self;
shadow.sprite_index = (global.shadow_mode_toggle? spr_plane_enemy_shadow : spr_plane_enemy_shadow_old);
shadow.image_alpha = 0.9;

// Drop rate for pickups
drop_rate = 50;

// Variables used for keeping track of if enemy has been hit
is_hit = false;
hit_timer = 0;
hit_cooldown = 0.1;

// Used if plane becomes lead plane and has priority
is_leader = false;

// Engine sound file and sound id when played
engine_sound_file = snd_engine_enemy_1;
engine_sound = -1;

// Temp flag for if leader exists
var _has_leader = false;

// Checks other planes
with (obj_enemy_plane_base)
{
	// Checks if plane is a leader
	if (is_leader)
	{
		// Sets flag to true
		_has_leader = true;	
	}
}

// Checks if flag was still false
if (!_has_leader)
{
	// Sets this plane as leader
	is_leader = true;	
}

// Previous positions used for motion blur effects
prev_x = x;
prev_y = y;

// Uniform value for velocity passed into shader
uni_velo = shader_get_uniform(sh_blur, "u_velo");