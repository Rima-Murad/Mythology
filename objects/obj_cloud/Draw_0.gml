// Draws the cloud normally
draw_self();

// Checks if shaders are enabled
if (global.can_shader)
{
	// Disables blending
	gpu_set_blendenable(false);
	// Disables colour channels
	gpu_set_colorwriteenable(false, false, false, true);

	// Clears alpha channel
	draw_set_alpha(0);
	draw_rectangle(0,0,room_width, room_height, false);

	// Sets the mask transparency to 50%
	draw_set_alpha(0.5);
	// Draws the mask
	draw_sprite(sprite_index, image_index, x, y);

	// Re-enables blending
	gpu_set_blendenable(true);
	// Allows all colour channels
	gpu_set_colorwriteenable(true,true,true,true);

	// Sets blendmode to use destination alpha and inverse destination alpha
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	// Enables alpha testing for cuttoff alpha values
	gpu_set_alphatestenable(true);

	// Loops through the list of shadows
	for (var _i = 0; _i < ds_list_size(global.shadow_list); _i++)
	{
		// Sets current shadow from index
		var _shadow = ds_list_find_value(global.shadow_list, _i);
	
		// Checks the current shadow is not from a cloud
		if (_shadow.owner.object_index != obj_cloud)
		{
			// Calculates new scaler for cloud surface shadows
			var _new_sx	= _shadow.x_scaler / shadow.x_scaler;
			var _new_sy = _shadow.y_scaler / shadow.y_scaler;
		
			// Calculates new position for cloud surface shadows
			var _new_px = _shadow.owner.x + (_shadow.x_offset - shadow.x_offset);
			var _new_py = _shadow.owner.y + (_shadow.y_offset - shadow.y_offset);	
		
			// Checks if the shadow owner is actually a bomb
			if (_shadow.owner.object_index == obj_player_bomb)
			{
				// Checks if the layer owner is on is the projectiles one (airborne)
				if (_shadow.owner.layer == layer_get_id("Projectiles"))
				{
					// Draws the cloud surface shadow
					draw_sprite_ext(_shadow.sprite_index, _shadow.image_index, _new_px, _new_py, _shadow.image_xscale * _new_sx, _shadow.image_yscale * _new_sy, _shadow.image_angle, _shadow.image_blend, _shadow.image_alpha);
				}	
			}
			else
			{
				// Draws the cloud surface shadow
				draw_sprite_ext(_shadow.sprite_index, _shadow.image_index, _new_px, _new_py, _shadow.image_xscale * _new_sx, _shadow.image_yscale * _new_sy, _shadow.image_angle, _shadow.image_blend, _shadow.image_alpha);
			}
		}																				 
	}

	// Disables alpha testing
	gpu_set_alphatestenable(false);
	// Sets the blend mode back to normal
	gpu_set_blendmode(bm_normal);
	// Sets the draw alpha back to normal
	draw_set_alpha(1.0);
}