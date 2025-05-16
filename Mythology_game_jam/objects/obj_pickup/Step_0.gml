// Checks if the game is paused
if (global.is_paused)
{
	// Stops the highlight from animating
	image_speed = 0;
	// Exits the step event
	exit;	
}

// Sets the animation speed to play
image_speed = 1;

// Calculates delta time for movements
var _delta_time = delta_time * 0.000001;

// Adjusts the y position by the movespeed set and time passed
y += _delta_time * move_speed;

// Checks if the pickup has left the bottom of the screen
if (y > room_height + sprite_height)
{
	// Destroys the pickup
	instance_destroy();	
}

// Adds time to the swap timer
swap_timer += _delta_time;

// Checks if the swao timer has met its threshold
if (swap_timer >= swap_cooldown)
{
	// Resets the timer
	swap_timer = 0;
	
	// Creates temp variables for the new type of pickup and if its possible
	var _new_type = curr_pickup;
	var _choose_new = true;
	
	// Loops while pickup needs to pick a new type
	while (_choose_new)
	{
		// Sets the requirement flag to false
		_choose_new = false;
		
		// Ups the type as the type of powerup cycles
		_new_type++;
		
		// Checks if the type has exceeded available choices
		if (_new_type > 8)
		{
			// Loops back to the start
			_new_type = 0;	
		}
		
		// Skips these pickups as no longer valid
		if (_new_type == 2 || _new_type == 4 || _new_type == 5 || _new_type == 7)
		{
			// Skips type (later change in design but original code still exists if you wish)
			_choose_new = true;
		}
		
	}
	
	// Calls the swap pickup function to set its state and highlight
	swap_pickup(_new_type);
	
	// Sets the flashed state to true
	is_flashed = true;
}

// Checks if the swap timer has passed enough time
if (swap_timer > 0.1)
{
	// Sets the flashed state to false
	is_flashed = false;	
}