// Checks if shaders are enabled
if (global.can_shader)
{
	// Sets the shader depending on if hit or not
	shader_set(is_hit? sh_highlighted : sh_blur);

	// Checks if not hit
	if (!is_hit)
	{
		// Sets shader variables for the velocity
		shader_set_uniform_f(uni_velo, (x - prev_x) / sprite_width, (y - prev_y) / sprite_height);
	}
}

// Draws the plane
draw_self();
// Resets the shader used
shader_reset();