/// Enemy (Big - Single) Object
// Larger enemy type that fires single shot

// Inherit the parent event
event_inherited();

// Sets the sprites tilting left and right and default
default_sprite = demon_1;
left_sprite = demon_1;
right_sprite = demon_1;

// Engine sound file attached to plane
engine_sound_file = snd_engine_enemy_7;

// Sets base move speeds
x_move_speed = 4;
y_move_speed = 3;

// Sets the target position as the middle of the screen
target_x = 135;
target_y = 0;

// Sets adjusted aim tolerance for when knowing when to start firing at the player
aim_tolerance = 80;

// Sets a higher base ammmo
base_ammo = 6;
// Sets the current ammo to the base ammo
ammo_count = base_ammo;

// Sets the reload cooldown/threshold to an adjusted value
reload_cooldown = 1.2;

// Threshold value for when enemy can actually fire at the player
lockon_threshold = 0.5;

// Set hp for enemy
hp = 2;

// Variable for enemy score value
score_value = 250;

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
	_new_l_proj.image_index = alt_fire? 1 : 0;
	// Sets direction to travel down
	_new_r_proj.direction = 270;
	
	// Calls the admin function
	fire_admin();
}