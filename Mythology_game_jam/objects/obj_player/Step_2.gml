// Checks if the momentum above the threshold going right
if (velo_x > tilt_threshold)
{
	// Sets current sprite to turning right
	sprite_index = spr_plane_player_r_turn;
	// Reduces shadow scale slightly
	shadow.image_xscale = 0.9 * image_xscale;
}
// Checks if the momentum above the threshold going left
else if (velo_x < -tilt_threshold)
{
	// Sets current sprite to turning left
	sprite_index = spr_plane_player_l_turn;
	// Reduces shadow scale slightly
	shadow.image_xscale = 0.9 * image_xscale;
}
else
{
	// Sets current sprite to normal non turning sprite
	sprite_index = spr_plane_player;
	// Resets the shadow scale to normal
	shadow.image_xscale = image_xscale;
}

// Sets the shadows y scale
shadow.image_yscale = image_yscale;