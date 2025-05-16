// Checks if shaders are enabled
if (global.can_shader)
{
	// Sets the player to use the motion blur shader
	shader_set(sh_blur);

	// Sets the player velosity values for the shader
	shader_set_uniform_f(uni_velo, (x - prev_x) / sprite_width, (y - prev_y) / sprite_height);
}

// Draws the player
draw_self();

// Resets the shader
shader_reset();