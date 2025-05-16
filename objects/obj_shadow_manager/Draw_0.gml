// Checks if shaders are enabled
if (global.can_shader)
{
	// Checks if the surface already exists 
	// Surfaces are known to be quite volatile and can stop exisiting when the games target is lost
	if (!surface_exists(shadow_surface))
	{
		// Creates a surface with the rooms dimensions
	    shadow_surface = surface_create(room_width, room_height); 
	}

	// Sets the surface as the current draw target
	surface_set_target(shadow_surface);
	// Clears the curface so it is fully transparent
	draw_clear_alpha(c_black, 0);

	// Turn alpha testing on to change the cut off for alpha values
	gpu_set_alphatestenable(true);
	// Set the current blendmode to inverse destination alpha and standard destination alpha
	// This is done so that the shadows when drawn onto each other will stick to a level of alpha to stop intense layered shadows appearing.
	gpu_set_blendmode_ext(bm_inv_dest_alpha, bm_dest_alpha);
}

// Loops though the shadows
for (var _i = 0; _i < ds_list_size(global.shadow_list); _i++)
{	
	// Calls the draw handle set inside the shadows
	ds_list_find_value(global.shadow_list, _i).draw_handle();
}

// Checks if shaders are enabled
if (global.can_shader)
{
	// Set the blendmode back to normal
	gpu_set_blendmode(bm_normal);
	// Disables alpha testing
	gpu_set_alphatestenable(false);
	// Resets the drawing target
	surface_reset_target();

	// Draws the created surface
	draw_surface(shadow_surface, 0, 0);
}