/// Player Object
// Main object for the player within the game

// States for player 
enum PLAYER_STATE
{
	SPAWNING_1,
	SPAWNING_2,
	PLAYING,
	COMPLETED,
	SIZE
}

// States for the players upgrade status
enum SHOT_STYLE
{
	SHOT_SMALL,
	SHOT_BIG,
	MISSILE_SMALL,
	MISSILE_BIG,
	SIZE
}

// Variables for the current levels projectiles are at
curr_shot_level = 1;
curr_bomb_level = 1;

// Flag used for when bomb is upgraded to larger variant
is_bomb_big = false;

// Sets the current player state
curr_player_state = PLAYER_STATE.SPAWNING_1;

// Sets the current player state
curr_player_shot_style = SHOT_STYLE.SHOT_SMALL;

// Sets the players current hp
hp = global.is_debug? 999 : 3;

// Setup speed
velo_x = 0;
velo_y = 0;

// Speed threshold for sprite to change
tilt_threshold = 20;

// Buffers for the objects collision with walls since swaps between sprite collision masks
width_buffer = 30;
height_buffer = 25;

// Standard move speed for the x and y directions
x_move_speed = 16;
y_move_speed = 32;

// Drag rates for x and y movement
x_drag = 0.92;
y_drag = 0.95;

// Maximum speeds allowed for x and y speeds
max_x_speed = 120;
max_y_speed = 120;

// Reload timers for firing rate
reload_timer = 0;
reload_cooldown = 0.2;

// Reload timer for dropping bombs
bomb_timer = 0;

// State and timers used for hit (flashed) state
is_hurt = false;
hurt_timer = 0;
hurt_cooldown = 0.5;

// Creates and sets up new shadow for the player
shadow = instance_create_layer(x, y, "Shadows", obj_shadow);
shadow.owner = self;
shadow.sprite_index = (global.shadow_mode_toggle? spr_plane_player_shadow : spr_plane_player_shadow_old);
shadow.image_alpha = 0.9;

// Stores previous x and y positions for use with motion blur
prev_x = x;
prev_y = y;

// Uniform vector 2 of the velocity sent to the shader
uni_velo = shader_get_uniform(sh_blur, "u_velo");

// Player starts at 130% scale
image_xscale = 1.3;
image_yscale = 1.3;

// Plays and stores the engine sound
engine_sound = audio_play_sound(snd_engine_player, 100, true, clamp(0.2 * image_xscale, 0, 1));

// Touch input variables
touch_input_shot = false;
touch_input_bomb = false;
touch_input_x = 0;
touch_input_y = 0;