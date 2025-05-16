// Checks if the game win screen exists
if (instance_exists(obj_game_win_screen))
{
	// Stops the event as the player cannot collect pickups once the game is over
	exit;	
}

// Creates a temp variable for if the player only collects a standard score
var _can_score = false;

// Calls the gamepad vibration function for a short medium vibration when the pickup is collected
gamepad_vibration(0.5, 0.5, 0.1);

// Switch statement for the current pickup
switch(curr_pickup)
{
	// Small shot
	case PICKUP_TYPE.SHOT_SMALL:
	
		// Checks if the player is already using small shots
		if (other.curr_player_shot_style == SHOT_STYLE.SHOT_SMALL)
		{
			// Checks the ammo types level isnt maxed out
			if (other.curr_shot_level < 3)
			{
				// Ups the ammo level
				other.curr_shot_level++;
				// Creates level up text pop up
				pickup_popup("LVL UP");
				// Plays upgrade sound effect
				audio_play_sound(snd_shot_up, 100, false);
			}
			else
			{
				// Sets the can score flag to true
				_can_score = true;	
			}
		}
		else
		{
			// Sets the players shot style to small shot
			other.curr_player_shot_style = SHOT_STYLE.SHOT_SMALL;
			// Sets the ammo type level to 1
			other.curr_shot_level = 1;
			
			// Displays the ammo types name 
			pickup_popup("10 MM");
			// Plays the ammo changes sound effect
			audio_play_sound(snd_shot_change, 100, false);
		}
		
		// Breaks the case
		break;
	
	// Big shot
	case PICKUP_TYPE.SHOT_BIG:
	
		// Checks if the player is already using big shots
		if (other.curr_player_shot_style == SHOT_STYLE.SHOT_BIG)
		{
			// Checks the ammo types level isnt maxed out
			if (other.curr_shot_level < 3)
			{
				// Ups the ammo level
				other.curr_shot_level++;
				// Creates level up text pop up
				pickup_popup("LVL UP");
				// Plays upgrade sound effect
				audio_play_sound(snd_shot_up, 100, false);
			}
			else
			{
				// Sets the can score flag to true
				_can_score = true;	
			}
		}
		else
		{
			// Sets the players shot style to big shot
			other.curr_player_shot_style = SHOT_STYLE.SHOT_BIG;
			// Sets the ammo type level to 1
			other.curr_shot_level = 1;
			
			// Displays the ammo types name 
			pickup_popup("30 MM");
			// Plays the ammo changes sound effect
			audio_play_sound(snd_shot_change, 100, false);
		}
		
		// Breaks the case
		break;
	
	// Small missile
	case PICKUP_TYPE.MISSILE_SMALL:
	
		// Checks if the player is already using small missiles
		if (other.curr_player_shot_style == SHOT_STYLE.MISSILE_SMALL)
		{
			// Checks the ammo types level isnt maxed out
			if (other.curr_shot_level < 3)
			{
				// Ups the ammo level
				other.curr_shot_level++;
				// Creates level up text pop up
				pickup_popup("LVL UP");
				// Plays upgrade sound effect
				audio_play_sound(snd_shot_up, 100, false);
			}
			else
			{
				// Sets the can score flag to true
				_can_score = true;	
			}
		}
		else
		{
			// Sets the players shot style to small missiles
			other.curr_player_shot_style = SHOT_STYLE.MISSILE_SMALL;
			// Sets the ammo type level to 1
			other.curr_shot_level = 1;
			
			// Displays the ammo types name 
			pickup_popup("LOW EX");
			// Plays the ammo changes sound effect
			audio_play_sound(snd_shot_change, 100, false);
		}
		
		// Breaks the case
		break;
	
	// Big missile
	case PICKUP_TYPE.MISSILE_BIG:
	
		// Checks if the player is already using big missiles
		if (other.curr_player_shot_style == SHOT_STYLE.MISSILE_BIG)
		{
			// Checks the ammo types level isnt maxed out
			if (other.curr_shot_level < 3)
			{
				// Ups the ammo level
				other.curr_shot_level++;
				// Creates level up text pop up
				pickup_popup("LVL UP");
				// Plays upgrade sound effect
				audio_play_sound(snd_shot_up, 100, false);
			}
			else
			{
				// Sets the can score flag to true
				_can_score = true;	
			}
		}
		else
		{
			// Sets the players shot style to big missiles
			other.curr_player_shot_style = SHOT_STYLE.MISSILE_BIG;
			// Sets the ammo type level to 1
			other.curr_shot_level = 1;
			
			// Displays the ammo types name 
			pickup_popup("HIGH EX");
			// Plays the ammo changes sound effect
			audio_play_sound(snd_shot_change, 100, false);
		}
		
		// Breaks the case
		break;
	
	// Small bomb
	case PICKUP_TYPE.BOMB_SMALL:
	
		// Checks if the player is already using small bombs
		if (!other.is_bomb_big)
		{
			// Checks the bombs level isnt maxed out
			if (other.curr_bomb_level < 3)
			{
				// Ups the bomb level
				other.curr_bomb_level++;
				// Creates level up text pop up
				pickup_popup("LVL UP");
				// Plays the bomb upgrade sound effect
				audio_play_sound(snd_bomb_up, 100, false);
			}
			else
			{
				// Sets the can score flag to true
				_can_score = true;	
			}
		}
		else
		{
			// Sets the bomb type to small
			other.is_bomb_big = false;
			// Sets the bomb level to 1
			other.curr_bomb_level = 1;
			
			// Displays the bomb types name 
			pickup_popup("50 KG");
			// Plays the bomb upgrade sound effect
			audio_play_sound(snd_bomb_change, 100, false);
		}
		
		// Breaks the case
		break;
	
	// Big bomb
	case PICKUP_TYPE.BOMB_BIG:
	
		// Checks if the player is already using big bombs
		if (other.is_bomb_big)
		{
			// Checks the bombs level isnt maxed out
			if (other.curr_bomb_level < 3)
			{
				// Ups the bomb level
				other.curr_bomb_level++;
				// Creates level up text pop up
				pickup_popup("LVL UP");
				// Plays the bomb upgrade sound effect
				audio_play_sound(snd_bomb_up, 100, false);				
			}
			else
			{
				// Sets the can score flag to true
				_can_score = true;	
			}
		}
		else
		{
			// Sets the bomb type to big
			other.is_bomb_big = true;
			// Sets the bomb level to 1
			other.curr_bomb_level = 1;
			
			// Displays the bomb types name 
			pickup_popup("100 KG");
			// Plays the bomb upgrade sound effect
			audio_play_sound(snd_bomb_change, 100, false);
		}
		
		// Breaks the case
		break;
	
	// Health
	case PICKUP_TYPE.HEALTH:
	
		// Checks the players health isnt maxed out
		if (other.hp < 3)
		{
			// Displays the 1 up text
			pickup_popup("+1 UP");
			// Plays 1 up sound effect
			audio_play_sound(snd_life_up, 100, false);
			
			// Ups the players health
			other.hp++;
		}
		else
		{
			// Sets the can score flag to true
			_can_score = true;	
		}
		
		// Breaks the case
		break;
	
	// Fire rate
	case PICKUP_TYPE.FIRE_RATE:
	
		// Checks the ammo reload rate isnt maxed (bottomed) out
		if (other.reload_cooldown > 0.1)
		{
			// Creates level up text pop up
			pickup_popup("LVL UP");
			// Plays the upgrade sound effect
			audio_play_sound(snd_rate_up, 100, false);
			
			// Reduces the players cooldown timer
			other.reload_cooldown *= 0.9;
		}
		else
		{
			// Sets the can score flag to true
			_can_score = true;	
		}
		
		// Breaks the case
		break;
	
	// Shield
	case PICKUP_TYPE.SHIELD:
	
		// Checks if a shield already exists
		if (!instance_exists(obj_player_shield))
		{
			// Displays shield pickup text
			pickup_popup("SHIELD");
			// Plays shield sound
			audio_play_sound(snd_shield_up, 100, false);

			// Creates a player shield
			instance_create_layer(x, y, "Shield", obj_player_shield);
		}
		else
		{
			// Calls the add life fuction to the shield
			obj_player_shield.add_life();
			// Displays shield pickup text
			pickup_popup("SHIELD");
			// Plays shield sound
			audio_play_sound(snd_shield_up, 100, false);
		}
		
		// Breaks the case
		break;
}

// Checks if can score flag has been set
if (_can_score)
{
	// Plays standard pickup sound
	audio_play_sound(snd_points, 100, false);
	
	// Adds 500 points to players total
	obj_game_manager.current_points += 500;
	
	// Creates a new yellow points floating crit text
	var _new_crit = instance_create_layer(x, y, "UI", obj_crit_indicator);
	_new_crit.crit_text = "500";
	_new_crit.crit_font = global.font_text_white;
	_new_crit.crit_colour = c_yellow;
}

// Destroys the pickup
instance_destroy();