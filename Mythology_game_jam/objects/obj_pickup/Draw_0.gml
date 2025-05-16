// Draws self (the outline highlight)
draw_self();

// Checks if the powerup should be displayed as flashed
if (is_flashed)
{
	// Checks if shaders are supported by current platform
	if (global.can_shader)
	{
		// Sets the draw to use the highlighted shader
		shader_set(sh_highlighted);

		// Draws the appropriate pickup sprite
		draw_sprite(spr_item, curr_pickup, x, y);
	
		// Resets the shader options
		shader_reset();
	}
	else
	{
		// Draws the pickup sprite blacked out
		draw_sprite_ext(spr_item, curr_pickup, x, y, image_xscale, image_yscale, image_angle, c_black, image_alpha);
	}
}
else
{
	// Draws the appropriate pickup sprite
	draw_sprite(spr_item, curr_pickup, x, y);
}