/// Player Projectile Object
// Complex projectile that will be set depending on players upgrade state

// Projectile States
enum PROJECTILE_TYPE
{
	SHOT_SMALL,
	SHOT_BIG,
	MISSILE_SMALL,
	MISSILE_BIG,
	SIZE
}

// Sets the current projectile state to small single shot
current_shot_type = PROJECTILE_TYPE.SHOT_SMALL;

// Inherit the parent event
event_inherited();

// Sets default speed to 4 and direction to shoot up
set_speed = 4;
direction = 90;