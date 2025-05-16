/// Base building object
// Parent object for buildings to be destroyed by the player with bomb projectiles

// Variable for knowing if building is still alive
is_alive = true;

// Function called when bomb interacts with building
blow_up = function()
{
	// Checks buidling is still alive
	if (is_alive)
	{
		// Changes buildings state
		is_alive = false;
		
		// Creates a small explosion
		var _new_explosion_small = instance_create_layer(x, y, "Ground_Explosions", obj_sprite_animation_manager);
		_new_explosion_small.sprite_index = spr_explosion_small;
		// Set the animation size to 75%
		_new_explosion_small.image_xscale = 0.75;
		_new_explosion_small.image_yscale = 0.75;
		
		// Sets explosion to retain ground move speed
		_new_explosion_small.move_speed = obj_game_manager.ground_move_speed;
		
		// Adds the score to the current player points
		obj_game_manager.current_points += 100;
		
		// Adds gamepad vibration for the explosion effects
		gamepad_vibration(1.0, 0.5, 0.4);
		
		// Swaps the buildings image to the broken verison
		image_index = 1;
	}
}