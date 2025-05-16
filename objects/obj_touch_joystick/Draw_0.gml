// Draws the background sprite
draw_self();

// Draws the head sprite
draw_sprite(spr_controls_joystick, 0, clamp(device_mouse_x(touch_id) , x - sprite_width * 0.5, x + sprite_width * 0.5), clamp(device_mouse_y(touch_id) , y - sprite_height * 0.5, y + sprite_height * 0.5));
