/// Empty Pathed Enemy
// Used as a parent object for other pathed enemies

// Inherit the parent event
event_inherited();

// Sets the sprites tilting left and right and default
default_sprite = -1;
left_sprite = -1;
right_sprite = -1;

// Engine sound file attached to plane
engine_sound_file = -1;

// Sets base move speeds
x_move_speed = 0;
y_move_speed = 0;

// Sets the target position as the middle of the screen
target_x = 135;
target_y = 0;

// Sets the movement curve (default staight line value)
movement_curve = animcurve_get_channel(ac_diagonal, "straight");

// Calulate the enemies position within the curve
var _percent = clamp(y, 0, 480) * (1 / 480);

// Set the target x value to the current percentage in the curve
target_x = (animcurve_channel_evaluate(movement_curve, _percent) + 1) * 0.5 * 270;

// Sets a flag to check if curve has been changed
has_curve_set = false;

// Function for updating what animation curve should be used for movement
set_movement_curve = function(_new_curve, _curve_name) 
{
	// Checks if the curve has already been changed first
	if (!has_curve_set)
	{
		// Sets the the new movement curve from input variables
		movement_curve = animcurve_get_channel(_new_curve, _curve_name);
		
		// Calculates the current percentage based on y position
		var _percent = clamp(y, 0, 480) * (1 / 480);
		
		// Sets the target x value from percentage and new curve
		target_x = (animcurve_channel_evaluate(movement_curve, _percent) + 1) * 0.5 * 270;
		
		// Sets has curve flag back to true as curve has been changed and shouldnt be rewritten
		has_curve_set = true;
	}
}

// Sets adjusted aim tolerance for when knowing when to start firing at the player
aim_tolerance = 0;

// Sets a higher base ammmo
base_ammo = 0;
// Sets the current ammo to the base ammo
ammo_count = base_ammo;

// Sets a reload timer to zero for use later knowing how long since the enemy last fired
reload_timer = 0;
// Sets the reload cooldown/threshold to an adjusted value
reload_cooldown = 0;

// Lock on timer for how long enemy has been able to fire at player
lockon_timer = 0;
// Threshold value for when enemy can actually fire at the player
lockon_threshold = 0;

// Flag for knowing if enemy is alternate firing or not
alt_fire = false;

// Set hp for enemy
hp = 1;

// Variable for enemy score value
score_value = 0;

// Function called when firing occurs to handle reloads and effects
fire_admin = function()
{
	// Plays the enemy firing sound
	audio_play_sound(snd_enemy_fire_1, 100, false);
	
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

// Empty function called when then enemy fires
fire = function()
{
	// Create Projectiles here in each child event
	
	// Calls the admin function
	fire_admin();
}