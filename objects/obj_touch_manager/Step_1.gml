/// Touch manager object
// Tracks where touches take place and tells the compatable buttons whats touching them

// Checks state of it touches are needed
if (global.is_paused || instance_exists(obj_game_win_screen) || instance_exists(obj_game_over_screen))
{
	// Exits event
	exit;	
}

// Checks for a maximum of 10 touches
var _max_devices = 10;

// Loops for the max times
for (var _i = 0; _i < _max_devices; _i++)
{
	// Sets the touch position to temporary variables from ID
	var _touch_x = device_mouse_x(_i);
    var _touch_y = device_mouse_y(_i);
    
	// Checks if a button is at that touched position
    var _button = instance_position(_touch_x, _touch_y, obj_touch_base);
	
	// Checks if the touch positions is actively being pressed (can be released)
    var _held = device_mouse_check_button(_i, mb_left);
    
	// Checks if both the button exists at the position and is being held
    if (_button != noone && _held)
    {
		// Sets the button to read input from that touch ID
		_button.touch_id = _i;
    }
	// Checks if held and no joystick exists
	else if (_held && !instance_exists(obj_touch_joystick))
	{
		// Creates a new joystick
		var _joystick = instance_create_layer(_touch_x, _touch_y, "Instances", obj_touch_joystick);
		// Sets the joystick to the new id
		_joystick.touch_id = _i;
	}
}