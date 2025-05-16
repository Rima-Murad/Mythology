// Checks the the game is not paused
if (global.is_paused)
{
	// Stops event updating
	exit;	
}

// Checks game is not in gameover state
if (instance_exists(obj_game_over_screen) || instance_exists(obj_game_win_screen))
{
	// Stops event updating
	exit;
}

// Checks player still exists
if (instance_exists(obj_player))
{
	// Checks the player is still in playing state
	if (obj_player.curr_player_state != PLAYER_STATE.PLAYING)
	{
		// Stops event updating
		exit;
	}
}

// Ands change in time to the levels timer
level_time += delta_time * 0.000001;

// Checks if the level time has gone over allowed threshold
if (level_time >= level_time_threshold)
{
	// Increments the level and resets the time
	level++;
	level_time = 0;
	
	// Switch statement for level times (map segments)
	switch(level)
	{
		case 1: // Simple tutorial plane (ocean - island)
			level_time_threshold = 30;
			break;
		case 2: // Pathed enemies small (up to the river)
			level_time_threshold = 45;
			break;
		case 3: // Pathed enemies medium (jagged cities)
			level_time_threshold = 45;
			break;
		case 4: // Pathed enemies large (up to jungle before strips)
			level_time_threshold = 45;
			break;
		case 5: // Pathed enemies mixed easy (strips)
			level_time_threshold = 40;
			break;
		case 6: // Pathed enemies mixed hard (up to island)
			level_time_threshold = 40;
			break;
		case 7: // BOSS (inital island, ocean and beyond)
			level_time_threshold = 126;
			break;
	}
	
	// Sets stage to zero and signals new stage flag to trigger
	stage = 0;
	is_new_stage = true;
}

// Checks if no planes exist or a new wave is triggered as well as the game is not currently spawning enemies
if ((instance_number(obj_enemy_plane_base) == 0 || is_new_stage) && !is_spawning)
{
	// Increment the stage counter
	stage++;
	// Set flags again
	is_new_stage = false;
	is_spawning = true;
	
	// Goes through all the active planes
	with (obj_enemy_plane_base)
	{
		// Finishes them so they leave the screen
		is_finished = true;
		// Removes current planes as leader
		is_leader = false;
	}
	
	var _plane = -1;
	var _wave = -1;
	var _death_handle = -1;
	
	switch(level)
	{
		case 1: // Tutorial
		switch(stage)
		{
			case 1: // Tutorial plane
				_plane = instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_basic);
				is_spawning = false;
			break;
			case 2: // Skips to next level
				level_time = level_time_threshold;
				level = 1;
				is_spawning = false;
			break;
		}
		break;
		
		case 2: // Small
		switch(stage)
		{
			case 1:
				_plane = instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_small_double);
				_plane.set_movement_curve(ac_diagonal, "l_to_r");
				is_spawning = false;
			break;
			case 2:
				_plane = instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_small_rapid);
				_plane.set_movement_curve(ac_diagonal, "r_to_l");
				is_spawning = false;
			break;
			case 3:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_small_double);
				_plane.set_movement_curve(ac_slow, "l_to_r");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_small_double);
				_plane.set_movement_curve(ac_slow, "r_to_l");
				is_spawning = false;
			break;
			case 4:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_small_rapid);
				_plane.set_movement_curve(ac_slow, "l_to_r");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_small_rapid);
				_plane.set_movement_curve(ac_slow, "r_to_l");
				is_spawning = false;
			break;
			case 5:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_small_double);
				_plane.set_movement_curve(ac_hook, "l_to_l");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_small_double);
				_plane.set_movement_curve(ac_hook, "r_to_r");
				_plane = instance_create_layer(room_width * 0.33, -100, "Enemy_Planes", obj_enemy_small_rapid);
				_plane.set_movement_curve(ac_hook, "l_to_l");
				_plane = instance_create_layer(room_width * 0.67, -100, "Enemy_Planes", obj_enemy_small_rapid);
				_plane.set_movement_curve(ac_hook, "r_to_r");
				is_spawning = false;
			break;
			case 6: // Restarts level
				stage = 2;
				is_spawning = false;
			break;
			
			// Catches unexpected stages
			default:
				stage = 5;
				is_spawning = false;
			break;
		}
		break;
		
		case 3: // Medium
		switch(stage)
		{
			case 1:
				_plane = instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_medium_single);
				_plane.set_movement_curve(ac_diagonal, "straight");
				is_spawning = false;
			break;
			case 2:
				_plane = instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_medium_double);
				_plane.set_movement_curve(ac_diagonal, "l_to_r");
				is_spawning = false;
			break;
			case 3:
				_plane = instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_medium_rapid);
				_plane.set_movement_curve(ac_diagonal, "r_to_l");
				is_spawning = false;
			break;
			case 4:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_medium_single);
				_plane.set_movement_curve(ac_slow, "l_to_r");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_medium_single);
				_plane.set_movement_curve(ac_slow, "r_to_l");
				is_spawning = false;
			break;
			case 5:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_medium_double);
				_plane.set_movement_curve(ac_slow, "l_to_r");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_medium_double);
				_plane.set_movement_curve(ac_slow, "r_to_l");
				is_spawning = false;
			break;
			case 6:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_medium_rapid);
				_plane.set_movement_curve(ac_slow, "l_to_r");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_medium_rapid);
				_plane.set_movement_curve(ac_slow, "r_to_l");
				is_spawning = false;
			break;
			case 7:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_medium_single);
				_plane.set_movement_curve(ac_hook, "l_to_l");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_medium_single);
				_plane.set_movement_curve(ac_hook, "r_to_r");
				_plane = instance_create_layer(room_width * 0.33, -100, "Enemy_Planes", obj_enemy_medium_double);
				_plane.set_movement_curve(ac_hook, "l_to_l");
				_plane = instance_create_layer(room_width * 0.67, -100, "Enemy_Planes", obj_enemy_medium_double);
				_plane.set_movement_curve(ac_hook, "r_to_r");
				_plane = instance_create_layer(room_width * 0.33, -150, "Enemy_Planes", obj_enemy_medium_rapid);
				_plane.set_movement_curve(ac_hook, "l_to_l");
				_plane = instance_create_layer(room_width * 0.67, -150, "Enemy_Planes", obj_enemy_medium_rapid);
				_plane.set_movement_curve(ac_hook, "r_to_r");
				is_spawning = false;
			break;
			case 8: // Restarts level
				stage = 3;
				is_spawning = false;
			break;
			
			// Catches unexpected stages
			default:
				stage = 7;
				is_spawning = false;
			break;
		}
		break;
		
		case 4: // Big
		switch(stage)
		{
			case 1:
				_plane = instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_big_single);
				_plane.set_movement_curve(ac_diagonal, "l_to_r");
				is_spawning = false;
			break;
			case 2:
				_plane = instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_big_double);
				_plane.set_movement_curve(ac_diagonal, "r_to_l");
				is_spawning = false;
			break;
			case 3:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_big_single);
				_plane.set_movement_curve(ac_slow, "l_to_r");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_big_single);
				_plane.set_movement_curve(ac_slow, "r_to_l");
				is_spawning = false;
			break;
			case 4:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_big_double);
				_plane.set_movement_curve(ac_slow, "l_to_r");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_big_double);
				_plane.set_movement_curve(ac_slow, "r_to_l");
				is_spawning = false;
			break;
			case 5:
				_plane = instance_create_layer(room_width * 0.33, -50, "Enemy_Planes", obj_enemy_big_single);
				_plane.set_movement_curve(ac_hook, "l_to_l");
				_plane = instance_create_layer(room_width * 0.67, -50, "Enemy_Planes", obj_enemy_big_single);
				_plane.set_movement_curve(ac_hook, "r_to_r");
				_plane = instance_create_layer(room_width * 0.33, -100, "Enemy_Planes", obj_enemy_big_double);
				_plane.set_movement_curve(ac_hook, "l_to_l");
				_plane = instance_create_layer(room_width * 0.67, -100, "Enemy_Planes", obj_enemy_big_double);
				_plane.set_movement_curve(ac_hook, "r_to_r");
				is_spawning = false;
			break;
			case 6: // Restarts level
				stage = 2;
				is_spawning = false;
			break;
			
			// Catches unexpected stages
			default:
				stage = 5;
				is_spawning = false;
			break;
		}
		break;
		
		case 5: // Easy mix
			switch(stage)
			{
				case 1: // Left small double slow
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_small_double_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_small_double)
						{
							set_movement_curve(ac_slow, "l_to_r");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 2: // Right small double slow
					_wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_small_double_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_small_double)
						{
							set_movement_curve(ac_slow, "r_to_l");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 3: // Both small double slow
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_small_double_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_small_double)
						{
							set_movement_curve(ac_slow, "l_to_r");
						}
						
						var _wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
						_wave.create_seq(seq_small_double_3, "Enemy_Planes");
						_wave.can_die = false;
					
						var _death_handle = function()
						{
							with (obj_enemy_small_double)
							{
								set_movement_curve(ac_slow, "r_to_l");
								
								obj_wave_manager.stage = 9;
								obj_wave_manager.is_spawning = false;
							}
						}
					
						_wave.set_death(_death_handle);
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 4: // Left medium single slow
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_single_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_single)
						{
							set_movement_curve(ac_slow, "l_to_r");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 5: // Right medium single slow
					_wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_single_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_single)
						{
							set_movement_curve(ac_slow, "r_to_l");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 6: // Both medium single slow
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_single_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_single)
						{
							set_movement_curve(ac_slow, "l_to_r");
						}
						
						var _wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
						_wave.create_seq(seq_med_single_3, "Enemy_Planes");
						_wave.can_die = false;
					
						var _death_handle = function()
						{
							with (obj_enemy_medium_single)
							{
								set_movement_curve(ac_slow, "r_to_l");
								
								obj_wave_manager.stage = 9;
								obj_wave_manager.is_spawning = false;
							}
						}
					
						_wave.set_death(_death_handle);
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 7: // Left medium double hook
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_double_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_double)
						{
							set_movement_curve(ac_hook, "l_to_l");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 8: // Right medium double hook
					_wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_double_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_double)
						{
							set_movement_curve(ac_hook, "r_to_r");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 9: // Both medium double hook
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_double_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_double)
						{
							set_movement_curve(ac_hook, "l_to_l");
						}
						
						var _wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
						_wave.create_seq(seq_med_double_3, "Enemy_Planes");
						_wave.can_die = false;
					
						var _death_handle = function()
						{
							with (obj_enemy_medium_double)
							{
								set_movement_curve(ac_hook, "r_to_r");
								
								obj_wave_manager.stage = 9;
								obj_wave_manager.is_spawning = false;
							}
						}
					
						_wave.set_death(_death_handle);
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 10: // Restarts level
					stage = irandom(8);
					is_spawning = false;
				break;
				
				// Catches unexpected stages
				default:
					stage = 9;
					is_spawning = false;
				break;
			}
		break;
		
		case 6: // Hard mix
			switch(stage)
			{
				case 1: // Left small rapid seesaw
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_small_rapid_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_small_rapid)
						{
							set_movement_curve(ac_seesaw, "l_to_r");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 2: // Right small rapid seesaw
					_wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_small_rapid_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_small_rapid)
						{
							set_movement_curve(ac_seesaw, "r_to_l");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 3: // Both small rapid seesaw
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_small_rapid_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_small_rapid)
						{
							set_movement_curve(ac_seesaw, "l_to_r");
						}
						
						var _wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
						_wave.create_seq(seq_small_rapid_3, "Enemy_Planes");
						_wave.can_die = false;
					
						var _death_handle = function()
						{
							with (obj_enemy_small_rapid)
							{
								set_movement_curve(ac_seesaw, "r_to_l");
								
								obj_wave_manager.stage = 9;
								obj_wave_manager.is_spawning = false;
							}
						}
					
						_wave.set_death(_death_handle);
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 4: // Left medium rapid seesaw
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_rapid_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_rapid)
						{
							set_movement_curve(ac_seesaw, "l_to_r");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 5: // Right medium rapid seesaw
					_wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_rapid_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_rapid)
						{
							set_movement_curve(ac_seesaw, "r_to_l");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 6: // Both medium rapid seesaw
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_med_rapid_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_medium_rapid)
						{
							set_movement_curve(ac_seesaw, "l_to_r");
						}
						
						var _wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
						_wave.create_seq(seq_med_rapid_3, "Enemy_Planes");
						_wave.can_die = false;
					
						var _death_handle = function()
						{
							with (obj_enemy_medium_rapid)
							{
								set_movement_curve(ac_seesaw, "r_to_l");
								
								obj_wave_manager.stage = 9;
								obj_wave_manager.is_spawning = false;
							}
						}
					
						_wave.set_death(_death_handle);
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 7: // Left large single hook
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_big_single_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_big_single)
						{
							set_movement_curve(ac_hook, "l_to_l");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 8: // Right large single hook
					_wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_big_single_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_big_single)
						{
							set_movement_curve(ac_hook, "r_to_r");
						}
						
						obj_wave_manager.stage = 9;
						obj_wave_manager.is_spawning = false;
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 9: // Both large double seesaw
					_wave = instance_create_layer(0 - 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
					_wave.create_seq(seq_big_double_3, "Enemy_Planes");
					_wave.can_die = false;
					
					_death_handle = function()
					{
						with (obj_enemy_big_double)
						{
							set_movement_curve(ac_seesaw, "l_to_r");
						}
						
						var _wave = instance_create_layer(0 + 67.5 , 0, "Enemy_Planes", obj_sequence_manager);
						_wave.create_seq(seq_big_double_3, "Enemy_Planes");
						_wave.can_die = false;
					
						var _death_handle = function()
						{
							with (obj_enemy_big_double)
							{
								set_movement_curve(ac_seesaw, "r_to_l");
								
								obj_wave_manager.stage = 9;
								obj_wave_manager.is_spawning = false;
							}
						}
					
						_wave.set_death(_death_handle);
					}
					
					_wave.set_death(_death_handle);
					
				break;
				
				case 10: // Restarts level
					stage = irandom(8);
					is_spawning = false;
				break;
				
				// Catches unexpected stages
				default:
					stage = 9;
					is_spawning = false;
				break;
					
			}
		break;
		
		case 7: // Boss
			
			// Catches unexpected waves
			if (!has_bossed)
			{
				stage = 1;
				has_bossed = true;
			}
		
			switch(stage)
			{
				case 1: // Incoming boss message
					is_spawning = false;	
				break;
				
				case 2: // Incoming boss message
					level_time = 0;
					
					var _new_crit = instance_create_layer(135, 160, "Notifications", obj_crit_indicator);
					_new_crit.crit_font = global.font_text_white;
					_new_crit.crit_scale = 2;
					_new_crit.crit_colour = c_red;
					_new_crit.life_remaining *= 0.75;
					_new_crit.crit_text = string("BOSS INCOMING!");
					_new_crit.can_call_wave = true;
				break;
				
				case 3: // Spawn Boss
					level_time = 0;
					instance_create_layer(room_width * 0.5, -50, "Enemy_Planes", obj_enemy_boss);
					is_spawning = false;
				break;
			
				case 4: // Spawns in game win menu
					var _new_menu_seq = instance_create_layer(0,0, "Menus", obj_sequence_manager);
					_new_menu_seq.create_seq(seq_game_win_menu, "Menus");
					_new_menu_seq.can_die = false;
					_new_menu_seq.can_pause = false;
				break;
				
				default: // Catches unexpected stage
					stage = 1;
					is_spawning = false;	
				break;
			}
		break;
		
		case 8: // GAME WIN
			var _new_menu_seq = instance_create_layer(0,0, "Menus", obj_sequence_manager);
			_new_menu_seq.create_seq(seq_game_win_menu, "Menus");
			_new_menu_seq.can_die = false;
			_new_menu_seq.can_pause = false;	
		break;
	}
}