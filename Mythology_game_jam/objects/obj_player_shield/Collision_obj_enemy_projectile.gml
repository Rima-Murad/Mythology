// Creates a new explosion
var _new_explosion = instance_create_layer(other.x, other.y, "Explosions", obj_sprite_animation_manager);
_new_explosion.sprite_index = spr_explosion_small;

// Destroys the projectile that hits
instance_destroy(other);