// Checks if train is facing up
if (facing == 1)
{
	// Draws the train first
	draw_self();
	
	// Loops through the train cars normally
	for (var _i = 0; _i < cars_count; _i++)
	{
		// Draws the sprites for the train cars
		draw_sprite_ext(spr_enemy_train_car, ((cars[_i][2] * 2) % 4) + is_alt_frame, cars[_i][0], cars[_i][1], 1.0, 1.0, 0, c_white, 1.0);	
	}
}
else
{
	// Loops through the train cars in reverse
	for (var _i = cars_count - 1; _i >= 0; _i--)
	{
		// Draws the sprites for the train cars
		draw_sprite_ext(spr_enemy_train_car, ((cars[_i][2] * 2) % 4) + is_alt_frame, cars[_i][0], cars[_i][1], 1.0, 1.0, 0, c_white, 1.0);	
	}
	
	// Draws the train last
	draw_self();
}