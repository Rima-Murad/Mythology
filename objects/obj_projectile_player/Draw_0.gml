// Switch statement depending on the shot type
switch current_shot_type
{
	// Small shot
	case PROJECTILE_TYPE.SHOT_SMALL:
		// Sets the sprite
		sprite_index = spr_projectile_shot_small;
		break;
	
	// Big shot
	case PROJECTILE_TYPE.SHOT_BIG:
		// Sets the sprite
		sprite_index = spr_projectile_shot_big;
		break;
	
	// Small missile
	case PROJECTILE_TYPE.MISSILE_SMALL:
		// Sets the sprite
		sprite_index = spr_projectile_missile_small;
		break;
	
	// Big missile
	case PROJECTILE_TYPE.MISSILE_BIG:
		// Sets the sprite
		sprite_index = spr_projectile_missile_big;
		break;
}

image_angle = direction - 90;

// Draws the projectile
draw_self();