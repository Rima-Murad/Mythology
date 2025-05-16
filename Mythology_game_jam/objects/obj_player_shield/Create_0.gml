/// Shield object
// Equips onto the player when in a protected state

// Sets up shield objects inital variables to attach to player
x = obj_player.x;
y = obj_player.y;
depth = obj_player.depth - 10;

// Adjusts the image properties of the shield
image_alpha = 0.5;
image_xscale = 1.2;
image_yscale = 1.2;

// Variable for the shields lifespan that will count down
shield_life = 5.0;

// Calls game pad vibration script as the shield is now equipped
gamepad_vibration(0.1, 0.1, 4.5);

// Fuction called when shield life renewed
add_life = function()
{
	// Checks for shield life vibration
	if (shield_life > 0.5)
	{
		// Removes existing vibration
		gamepad_vibration(-0.1, -0.1, shield_life - 0.5);
	}
	
	// Adds more life
	shield_life += 5;
	
	// Creates new vibration based on updated life
	gamepad_vibration(0.1, 0.1, shield_life - 0.5);
	
	// Sets alpha back to default
	image_alpha = 0.5;
}