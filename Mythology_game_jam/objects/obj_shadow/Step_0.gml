// Checks if owner has been set or still exists
if (owner != noone)
{
	// Sets scale value for object based on the sprite dimensions of the shadow and the owner sprite
	x_scaler = 1 - (sprite_width / owner.sprite_width);
	y_scaler = 1 - (sprite_height / owner.sprite_height);
	
	// Uses the preset max offsets with the scale value created to setup the offset needed for the shadow
	x_offset = max_offset_x * x_scaler; 
	y_offset = max_offset_y * y_scaler;
	
	// Moves the object positions to follow the owners position
	x = owner.x;
	y = owner.y;
	
	// Sets a new draw handle function for calling the drawsprite call from
	draw_handle = function()
	{
		// Sets draw sprite call for shadow
		draw_sprite_ext(sprite_index, image_index, x + x_offset, y + y_offset, image_xscale * (global.shadow_mode_toggle? 1 : 2), image_yscale * (global.shadow_mode_toggle? 1 : 2), image_angle, image_blend, image_alpha);
	}
}
else
{
	// Destroys this shadow object
	instance_destroy();	
}