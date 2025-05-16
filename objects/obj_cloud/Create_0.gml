/// Cloud object
// Background environment that is drawn betwen the main play area and the ground

// Chooses a random cloud iteration from the sprites available frames
image_index = irandom(sprite_get_number(sprite_index));

// Creates new shadow and sets it up based on the cloud set
shadow = instance_create_layer(x, y, "Shadows", obj_shadow);
shadow.owner = self;
shadow.sprite_index = (global.shadow_mode_toggle? spr_clouds_shadows : spr_clouds_shadows_old);
shadow.image_index = image_index;

// Sets move speed from the ground speed at a sped up rate
move_speed = obj_game_manager.ground_move_speed * 2;