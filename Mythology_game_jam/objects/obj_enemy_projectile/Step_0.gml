// Inherit the parent event
event_inherited();

// Checks if game is paused
if (global.is_paused)
{
	// Exits out of event since paused
	exit;	
}

// Scales the projectile towards 100% using lerp function
image_xscale = lerp(image_xscale, 1.0, 0.05);
image_yscale = image_xscale;

// Checks if the scale is greater than 50% and projectile is still on "Bombs" layer
if (image_xscale >= 0.5 && layer == layer_get_id("Bombs"))
{
	// Sets the layer to the projetiles layer to draw above the clouds
	layer = layer_get_id("Projectiles");
}

// Checks if the projectile is airbound yet
if (!is_airbound)
{
	// Checks if the scale is above 75%
	if (image_xscale >= 0.75)
	{
		// Sets airbound to true meaning it can be used for collisions
		is_airbound = true;
	}
}