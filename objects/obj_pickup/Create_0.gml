/// Pickup object
// Object dropped when enemies are destroyed and when collected by the player can supply them with an upgrade

// Enum states for the type of pickups that can occur
enum PICKUP_TYPE
{
	SHOT_SMALL,
	SHOT_BIG,
	MISSILE_SMALL,
	MISSILE_BIG,
	BOMB_SMALL,
	BOMB_BIG,
	HEALTH,
	FIRE_RATE,
	SHIELD,
	SIZE	
}

// Sets default pickup type
curr_pickup = PICKUP_TYPE.SHOT_SMALL;

// Function for swapping the pickups state and outline colour 
swap_pickup = function(_type)
{		
	// Switch statment of type input
	switch (_type)
	{
		case 0: // Small shot
			curr_pickup = PICKUP_TYPE.SHOT_SMALL;
			image_blend = make_color_rgb(255, 222, 0);
		break;
		case 1: // Big shot
			curr_pickup = PICKUP_TYPE.SHOT_BIG;
			image_blend = make_color_rgb(48, 97, 255);
		break;
		case 2: // Small missile
			curr_pickup = PICKUP_TYPE.MISSILE_SMALL;
			image_blend = make_color_rgb(48, 97, 255);
		break;
		case 3: // Big missile
			curr_pickup = PICKUP_TYPE.MISSILE_BIG;
			image_blend = make_color_rgb(189, 76, 255);
		break;
		case 4: // Small bomb
			curr_pickup = PICKUP_TYPE.BOMB_SMALL;
			image_blend = make_color_rgb(66, 112, 54);
		break;
		case 5: // Big bomb
			curr_pickup = PICKUP_TYPE.BOMB_BIG;
			image_blend = make_color_rgb(2255, 48, 48);
		break;
		case 6: // Health
			curr_pickup = PICKUP_TYPE.HEALTH;
			image_blend = make_color_rgb(2255, 48, 48);
		break;
		case 7: // Fire rate
			curr_pickup = PICKUP_TYPE.FIRE_RATE;
			image_blend = make_color_rgb(201, 122, 30);
		break;
		case 8: // Shield
			curr_pickup = PICKUP_TYPE.SHIELD;
			image_blend = make_color_rgb(21, 230, 255);
		break;
	}
}

// Picks a random powerup initally (using choose as some options no longer wanted)
swap_pickup(choose(0, 1, 3, 6, 8));

// Swap cooldown is the cooldown time before a pickup swaps state
swap_cooldown = 3.0;

// Timer keeps track of how much time pickup has left before next swap
swap_timer = swap_cooldown;

// State the flags if the powerup should be in a flashed state or not
is_flashed = true;

// Creates and sets up new shadow for the pickup
shadow = instance_create_layer(x, y, "Shadows", obj_shadow);
shadow.owner = self;
shadow.sprite_index = spr_item_shadow;
shadow.image_alpha = 0.9;

// Sets the pickups move speed to a rate based off of the ground speed
move_speed = obj_game_manager.ground_move_speed * 3;

// Function used to call the popup text that appears when player collects a pickup
pickup_popup = function(_input)
{
	// Creates a new floating text object
	var _new_crit = instance_create_layer(x, y, "UI", obj_crit_indicator);
	// Sets the text to the input
	_new_crit.crit_text = string(_input);
	// Sets the font
	_new_crit.crit_font = global.font_text_white;
	// Sets the colour
	_new_crit.crit_colour = c_green;	
}