// Checks if the momentum above the threshold going left
if (velo_x > tilt_threshold)
{
	// Checks if the sprite is in tilted state
	if (is_titled)
	{
		// Sets current sprite to turning left
		sprite_index = left_sprite;
		// Reduces shadow scale slightly
		shadow.image_xscale = 0.9;
	}
	
	// Sets tilted to true
	is_titled = true;
}
// Checks if the momentum above the threshold going right
else if (velo_x < -tilt_threshold)
{
	// Checks if the sprite is in tilted state
	if (is_titled)
	{
		// Sets current sprite to turning right
		sprite_index = right_sprite;
		// Reduces shadow scale slightly
		shadow.image_xscale = 0.9;
	}
	
	// Sets tilted to true
	is_titled = true;
}
else
{
	// Sets current sprite to normal non turning sprite
	sprite_index = default_sprite;
	// Resets the shadow scale to normal
	shadow.image_xscale = 1.0;
	
	// Sets tilted to false
	is_titled = false;
}

// Checks if the hit timer is counting down
if (hit_timer > 0)
{
	// Reduces timer by passed time
	hit_timer -= delta_time * 0.000001;
	// Sets hit state to true
	is_hit = true;
}
else
{
	// Sets hit state to false
	is_hit = false;	
}