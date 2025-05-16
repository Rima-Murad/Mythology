// Checks if the game is current paused
if (global.is_paused)
{
	// Pauses the sprite animation
	image_speed = 0;	
}
else
{
	// Plays the sprite animation at normal speed
	image_speed = 1;
}

if (is_hurt)
{
	image_blend = c_grey;	
}
else
{
	image_blend = c_white;	
}