// Checks if the game is current paused
if (global.is_paused)
{
	// Exits as the player wont need to update
	exit;
}

// Creates a temp variable for delta time so value will not have to be recalulated several times
var _delta_time = delta_time * 0.000001;

// Temp variables for the gamepad inputs
var _gp_x = 0;
var _gp_y = 0;
var _gp_fire = false;
var _gp_bomb = false;

// Checks if the game over win screen exists
if (!instance_exists(obj_game_win_screen))
{
	// Sets the engines sounds gain to a value scaled from the image scale
	audio_sound_gain(engine_sound, 0.2 * image_xscale, 0);
	
	// Stores how many gamepad count
	var _max_pads = gamepad_get_device_count();

	// Loops through the gamepads
	for (var _i = 0; _i < _max_pads; _i++)
	{
		// Checks the gamepad is connected
	    if (gamepad_is_connected(_i))
	    {
			// Sets the gamepads deadzone
	        gamepad_set_axis_deadzone(_i, 0.05);
		
			// Sets the x and y values from the gamepad axis
			_gp_x = gamepad_axis_value(_i, gp_axislh);
			_gp_y = gamepad_axis_value(_i, gp_axislv);
			
			// Adds the dpad movement to player
			_gp_x += gamepad_button_check(_i, gp_padr);
			_gp_x -= gamepad_button_check(_i, gp_padl);
			_gp_y += gamepad_button_check(_i, gp_padd);
			_gp_y -= gamepad_button_check(_i, gp_padu);
		
			// Checks the gamepad buttons and sets as appropriate 
			_gp_fire = gamepad_button_check(_i, gp_face1);
			_gp_bomb = gamepad_button_check_pressed(_i, gp_face3);
		
			// Breaks from gamepad loop
			break;
	    }
	}
	
	// Check for touch joystick
	if (instance_exists(obj_touch_joystick))
	{
		_gp_x = touch_input_x;
		_gp_y =	touch_input_y;
	}
	
	// Checks the player can move
	if (curr_player_state == PLAYER_STATE.PLAYING)
	{
		// Only checks keyboard inputs if the gamepad axis have no inputs
		if (_gp_x == 0 && _gp_y == 0)
		{
			// Checks for left input
			if (keyboard_check(vk_left) || keyboard_check(ord("A")))
			{
				// Adjusts x momentum by speed
				velo_x -= x_move_speed;
			}

			// Checks for right input
			if (keyboard_check(vk_right) || keyboard_check(ord("D")))
			{
				// Adjusts x momentum by speed
				velo_x += x_move_speed;
			}

			// Checks for up input
			if (keyboard_check(vk_up) || keyboard_check(ord("W")))
			{
				// Adjusts y momentum by speed
				velo_y += y_move_speed;
			}

			// Checks for down input
			if (keyboard_check(vk_down) || keyboard_check(ord("S")))
			{
				// Adjusts y momentum by speed
				velo_y -= y_move_speed;
			}
		}
		else
		{
			// Adds the gamepad values to the current velocity
			velo_x += _gp_x * x_move_speed;
			velo_y -= _gp_y * y_move_speed;
		}
	}
}
else
{
	// Sets the engines gain to zero
	audio_sound_gain(engine_sound, 0, 3000);
	
	// Checks if the player still needs to move up
	if (y > -100)
	{
		// Adds velocity to player to travel forward
		velo_y += y_move_speed;
	}
	
	// Sets the current player state to completed since now fully off screen
	curr_player_state = PLAYER_STATE.COMPLETED;
}

// Adjusts the players momentum by drag
velo_x *= x_drag;
velo_y *= y_drag;

// Clamps the players momentum by min and max allowed values
velo_x = clamp(velo_x, -max_x_speed, max_x_speed);
velo_y = clamp(velo_y, -max_y_speed, max_y_speed);

// Creates new temp values for the momentum to be passed though this update
var _nvx = velo_x * _delta_time;
var _nvy = velo_y * _delta_time;

// Checks if the player is currently playing
if (curr_player_state == PLAYER_STATE.PLAYING)
{
	// Checks the players current shot style
	switch (curr_player_shot_style)
	{
		// Small shot
		case SHOT_STYLE.SHOT_SMALL:
			// Sets reload rate
			reload_cooldown = 0.4;
			break;
		
		// Big shot
		case SHOT_STYLE.SHOT_BIG:
			// Sets reload rate
			reload_cooldown = 0.4;
			break;
			
		// Big missile
		case SHOT_STYLE.MISSILE_BIG:
			// Sets reload rate
			reload_cooldown = 0.6;
			break;
	}
	
	// Checks if player moving left off screen
	if (x - width_buffer + _nvx < -12)
	{
		// Resets position and current momentum
		x = -12 + width_buffer;
		_nvx = 0;	
	}
	// Checks if player moving right off screen
	else if (x + width_buffer + _nvx > room_width + 12)
	{
		// Resets position and current momentum
		x = room_width + 12 - width_buffer;
		_nvx = 0;	
	}

	// Checks if player moving up off screen
	if (y - height_buffer - _nvy < 0)
	{
		// Resets position and current momentum
		y = 0 + height_buffer;
		_nvy = 0;
	}
	// Checks if player moving down off screen
	else if (y + height_buffer - _nvy > room_height)
	{
		// Resets position and current momentum
		y = room_height - height_buffer;
		_nvy = 0;
	}
	
	// Scales the player back to 100% at faster rate
	image_xscale = lerp(image_xscale, 1, 0.02);
	image_yscale = image_xscale;
}
// Player is initally spawning (phase 1)
else if (curr_player_state == PLAYER_STATE.SPAWNING_1)
{
	// Lock the players velocity to travel forward to a certain point
	velo_x = 0;
	velo_y += _delta_time * 2 * (max_y_speed * _delta_time) * clamp((y - 350) / 100, 0, 4);
	
	// Sets their new velocity based from the calculated values
	_nvx = velo_x;
	_nvy = velo_y;
	
	// Checks if the player is above the position threshold for phase 2
	if (y <= 380)
	{
		// Sets the players state to phase 2
		curr_player_state = PLAYER_STATE.SPAWNING_2;
		
		// Shows new notification to prepare player
		var _new_crit = instance_create_layer(135, 160, "Notifications", obj_crit_indicator);
		_new_crit.crit_font = global.font_text;
		_new_crit.crit_scale = 2;
		_new_crit.life_remaining = 0.5;
		_new_crit.crit_text = string("GET\nREADY");
	}
	
	// Scale the player back down to 110%
	image_xscale = lerp(image_xscale, 1.1, 0.01);
	image_yscale = image_xscale;
}
// Checks if in phase 2 of spawning in
else if (curr_player_state == PLAYER_STATE.SPAWNING_2)
{
	// Locks players movement velocity
	velo_x = 0;
	velo_y += _delta_time *  2 * (max_y_speed * _delta_time) * clamp((430 - y) / 100, 0, 4) * -1;
	
	// Checks the position
	if (y < 395)
	{
		// Scales the player back to 100% at slow rate
		image_xscale = lerp(image_xscale, 1, 0.005);
	}
	else
	{
		// Scales the player back to 100% at faster rate
		image_xscale = lerp(image_xscale, 1, 0.015);
	}
	
	// Checks if player has passed position threshold to complete spawning in
	if (y > 415)
	{
		// Sets player state to playing
		curr_player_state = PLAYER_STATE.PLAYING;
		
		// Reverts player velocity to start from idle
		velo_y = 0;
		
		// Creates a new notfication for the player
		var _new_crit = instance_create_layer(135, 160, "Notifications", obj_crit_indicator);
		_new_crit.crit_font = global.font_text;
		_new_crit.crit_scale = 2;
		_new_crit.life_remaining = 0.5;
		_new_crit.crit_text = string("START!");
	}
	
	// Updates the player velocity from the new calculated values
	_nvx = velo_x;
	_nvy = velo_y;
	
	// Sets the players y scale from the xscale
	image_yscale = image_xscale;
}

// Applies the final momentum to the position
x += _nvx;
y -= _nvy;

// Adjust the firing rate timers
reload_timer += _delta_time;
bomb_timer += _delta_time;

// Checks if player is playing and ready to fire
if (reload_timer >= reload_cooldown && curr_player_state == PLAYER_STATE.PLAYING)
{
	// Checks for fire input
	if (keyboard_check_direct(vk_space) || keyboard_check_direct(ord("E")) || (mouse_check_button(mb_left) && !global.is_touch) || _gp_fire || touch_input_shot)
	{
		// Adds gamepad vibrations
		gamepad_vibration(0.2, 0.2, 0.2);
		
		// New left and right projectiles
		var _new_l_proj = -1;
		var _new_r_proj = -1;
		
		// Switch statement for players current shot type
		switch (curr_player_shot_style)
		{
			// Small shot
			case SHOT_STYLE.SHOT_SMALL:	
				
				// Plays firing sound
				audio_play_sound(snd_player_fire_1, 100, false);
			
				// Creates projectile and sets owner and type
				_new_l_proj = instance_create_layer(x - 14, y - 20, "Projectiles", obj_projectile_player);
				_new_l_proj.owner = self;
				_new_l_proj.current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;
	
				// Creates projectile and sets owner and type
				_new_r_proj = instance_create_layer(x + 12.5, y - 20, "Projectiles", obj_projectile_player);
				_new_r_proj.owner = self;
				_new_r_proj.current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;
				
				if (curr_shot_level >= 2)
				{
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x - 20, y - 18, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;
	
					// Creates projectile and sets owner and type
					_new_r_proj = instance_create_layer(x + 18.5, y - 18, "Projectiles", obj_projectile_player);
					_new_r_proj.owner = self;
					_new_r_proj.current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;
				}
				
				if (curr_shot_level >= 3)
				{					
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x - 24, y - 17, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;
					_new_l_proj.direction += 30;
					_new_l_proj.image_angle += 30;
	
					// Creates projectile and sets owner and type
					_new_r_proj = instance_create_layer(x + 22.5, y - 17, "Projectiles", obj_projectile_player);
					_new_r_proj.owner = self;
					_new_r_proj.current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;
					_new_r_proj.direction -= 30;
					_new_l_proj.image_angle -= 30;
					
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x - 28, y - 14, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;
					_new_l_proj.direction += 30;
					_new_l_proj.image_angle += 30;
	
					// Creates projectile and sets owner and type
					_new_r_proj = instance_create_layer(x + 26.5, y - 14, "Projectiles", obj_projectile_player);
					_new_r_proj.owner = self;
					_new_r_proj.current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;
					_new_r_proj.direction -= 30;
					_new_l_proj.image_angle -= 30;
				}
				
				break;
				
			// Big Shot
			case SHOT_STYLE.SHOT_BIG:
			
				// Plays firing sound
				audio_play_sound(snd_player_fire_2, 100, false);
			
				// Creates projectile and sets owner and type
				_new_l_proj = instance_create_layer(x - 12, y - 20, "Projectiles", obj_projectile_player);
				_new_l_proj.owner = self;
				_new_l_proj.current_shot_type = PROJECTILE_TYPE.SHOT_BIG;
	
				// Creates projectile and sets owner and type
				_new_r_proj = instance_create_layer(x + 10.5, y - 20, "Projectiles", obj_projectile_player);
				_new_r_proj.owner = self;
				_new_r_proj.current_shot_type = PROJECTILE_TYPE.SHOT_BIG;
				
				if (curr_shot_level >= 2)
				{
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x - 19, y - 18, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.SHOT_BIG;
	
					// Creates projectile and sets owner and type
					_new_r_proj = instance_create_layer(x + 17.5, y - 18, "Projectiles", obj_projectile_player);
					_new_r_proj.owner = self;
					_new_r_proj.current_shot_type = PROJECTILE_TYPE.SHOT_BIG;
				}
				
				if (curr_shot_level >= 3)
				{
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x - 26, y - 16, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.SHOT_BIG;
	
					// Creates projectile and sets owner and type
					_new_r_proj = instance_create_layer(x + 24.5, y - 16, "Projectiles", obj_projectile_player);
					_new_r_proj.owner = self;
					_new_r_proj.current_shot_type = PROJECTILE_TYPE.SHOT_BIG;
				}
				
				break;
			
			// Small Missile
			case SHOT_STYLE.MISSILE_SMALL:
			
				// Plays firing sound
				audio_play_sound(snd_player_fire_3, 100, false);
			
				// Creates projectile and sets owner and type
				_new_l_proj = instance_create_layer(x - 12, y - 22, "Projectiles", obj_projectile_player);
				_new_l_proj.owner = self;
				_new_l_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_SMALL;
	
				// Creates projectile and sets owner and type
				_new_r_proj = instance_create_layer(x + 10.5, y - 22, "Projectiles", obj_projectile_player);
				_new_r_proj.owner = self;
				_new_r_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_SMALL;
				
				if (curr_shot_level == 2)
				{
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x , y - 28, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_SMALL;
				}
				else if (curr_shot_level == 3)
				{
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x - 23, y - 19, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_SMALL;
	
					// Creates projectile and sets owner and type
					_new_r_proj = instance_create_layer(x + 21.5, y - 19, "Projectiles", obj_projectile_player);
					_new_r_proj.owner = self;
					_new_r_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_SMALL;
				}
				
				break;
			
			// Big Missile
			case SHOT_STYLE.MISSILE_BIG:
			
				// Plays firing sound
				audio_play_sound(snd_player_fire_4, 100, false);
			
				// Creates projectile and sets owner and type
				_new_l_proj = instance_create_layer(x - 12, y - 22, "Projectiles", obj_projectile_player);
				_new_l_proj.owner = self;
				_new_l_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_BIG;
	
				// Creates projectile and sets owner and type
				_new_r_proj = instance_create_layer(x + 10.5, y - 22, "Projectiles", obj_projectile_player);
				_new_r_proj.owner = self;
				_new_r_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_BIG;
				
				if (curr_shot_level == 2)
				{
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x , y - 28, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_BIG;
				}
				else if (curr_shot_level == 3)
				{
					// Creates projectile and sets owner and type
					_new_l_proj = instance_create_layer(x - 23, y - 19, "Projectiles", obj_projectile_player);
					_new_l_proj.owner = self;
					_new_l_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_BIG;
	
					// Creates projectile and sets owner and type
					_new_r_proj = instance_create_layer(x + 21.5, y - 19, "Projectiles", obj_projectile_player);
					_new_r_proj.owner = self;
					_new_r_proj.current_shot_type = PROJECTILE_TYPE.MISSILE_BIG;
				}
				
				break;
		}
		
		// Resets reload timer
		reload_timer = 0;
	}
}

// Checks if bomb is capable of being fired
if (bomb_timer >= reload_cooldown && curr_player_state == PLAYER_STATE.PLAYING)
{
	// Checks for bomb inputs
	if (keyboard_check_pressed(vk_control) || (mouse_check_button_pressed(mb_right) && !global.is_touch) || _gp_bomb || touch_input_bomb)
	{
		// Calls for gamepad vibrations
		gamepad_vibration(0.2, 0.2, 0.2);
		
		// Chooses bomb falling sounds
		var _bomb_sound = choose(snd_bomb_fall_1, snd_bomb_fall_2, snd_bomb_fall_3);
		// Plays bomb falling sound
		audio_play_sound(_bomb_sound, 100, false);
		
		// Creates bomb
		var _new_bomb = instance_create_layer(x, y - 20, "Projectiles", obj_player_bomb);
		// Sets owner
		_new_bomb.owner = self;
		
		// Checks if bomb was big
		if (is_bomb_big)
		{
			// Tells new bomb that its big and changes its sprite
			_new_bomb.is_big = is_bomb_big;
			_new_bomb.sprite_index = spr_projectile_bomb_big;
		}
		
		// Sets the new bombs level
		_new_bomb.set_level = curr_bomb_level;
		
		// Creates a shadow for the new bomb
		_new_bomb.shadow = instance_create_layer(x, y, "Shadows", obj_shadow);
		_new_bomb.shadow.owner = _new_bomb;
		_new_bomb.shadow.sprite_index = spr_projectile_bomb_shadow;
		_new_bomb.shadow.image_alpha = 0.9;
		
		// Resets firing rate timer
		bomb_timer = 0;
	}	
}

// Checks if the player is in a hurt state
if (is_hurt)
{
	// Adds to the hurt timer
	hurt_timer += _delta_time;
	
	// Checks if the player has supassed the hurt time needed
	if (hurt_timer >= hurt_cooldown)
	{
		// Resets the timer and state
		hurt_timer = 0;
		is_hurt = false;
	}
}