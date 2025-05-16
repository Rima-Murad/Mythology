// Inherit the parent event
event_inherited();

// Checks if the game is paused
if (global.is_paused)
{
	// Exits out of the event
	exit;	
}

// Stores delta time to be used for the object
var _delta_time = delta_time * 0.000001;

// Adds the move distance from bombs current speed and the time passed
move_distance += speed * _delta_time;

// Stores the scalar value calulated from its set level
var _scaler = 1 - _delta_time / (set_level * 0.5);

// Scales the image from this calulated value
image_xscale *= _scaler;
image_yscale = image_xscale;

// Checks if the image is below 60% scale and still above clouds
if (image_xscale < 0.6 && layer == layer_get_id("Projectiles"))
{
	// Sets layer to bomb layer (under clouds)
	layer = layer_get_id("Bombs");
	
	// Checks if the clouds are where the bomb passed through
	if (place_meeting(x, y, obj_cloud))
	{
		// Creates a shadow like explosion where bomb passed through cloud
		var _new_explosion = instance_create_layer(x, y, "Projectiles", obj_sprite_animation_manager);
		_new_explosion.image_blend = c_black;
		_new_explosion.image_alpha = 0.25;
		_new_explosion.image_xscale = 0.25;
		_new_explosion.image_yscale = 0.25;
		_new_explosion.move_speed =  obj_game_manager.ground_move_speed * 2;
	}
}

// Sets the speed to be effected by the scale change
set_speed *= _scaler;

// Adjust the bombs shadows image scale
shadow.image_xscale = image_xscale * 0.2;
shadow.image_yscale = image_yscale * 0.2;

// Change the shadows max offset to vary on the scaled value
shadow.max_offset_x *= _scaler;
shadow.max_offset_y *= _scaler;

// Checks if the bombs scale is less than 20%
if (image_xscale < 0.2)
{
	// Looks for land via tilemap
	var _land_id = layer_tilemap_get_id("Land");
	
	// Checks if land collision is true
	if (collision_point(x, y, _land_id, false, true) == _land_id)
	{		
		// Creates ground explosion
		var _new_explosion = instance_create_layer(x, y, "Ground_Explosions", obj_sprite_animation_manager);
		_new_explosion.sprite_index = spr_explosion_big;
		_new_explosion.image_xscale = 0.4;
		_new_explosion.image_yscale = 0.4;
		_new_explosion.move_speed = obj_game_manager.ground_move_speed;
		
		// Plays ground explosion sound
		audio_play_sound(snd_explosion_small, 100, false);
		
		// Checks for trains
		var _collision_train = collision_circle(x, y, 12, obj_enemy_train, true, true);
		
		// If train is found and set
		if (_collision_train != noone)
		{
			// Blow up trains owner using function
			_collision_train.owner.blow_up();
		}
		
		// Creates list of buildings
		var _collision_buildings = ds_list_create();
		
		// Checks for buildings
		var _collision_building_count = collision_circle_list(x, y, 12, obj_building__base, true, true, _collision_buildings, false);
		
		// Loop through found buildings
		for (var _i = 0; _i < _collision_building_count; _i++)
		{
			// Blow up building using function
			_collision_buildings[|_i].blow_up();
		}
		
		// Destroy list
		ds_list_destroy(_collision_buildings);
	}
	else
	{
		// Creates a smaller water coloured ground explosion with no sound
		var _new_explosion = instance_create_layer(x, y, "Ground_Explosions", obj_sprite_animation_manager);
		_new_explosion.image_blend = c_blue;
		_new_explosion.image_alpha = 0.25;
		_new_explosion.image_xscale = 0.15;
		_new_explosion.image_yscale = 0.15;
		_new_explosion.move_speed = obj_game_manager.ground_move_speed;
	}
	
	// Destroys this bomb
	instance_destroy();
}