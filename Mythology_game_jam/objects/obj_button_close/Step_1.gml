// Stores self as variable
var _self = self;

// Loops though buttons
with (obj_button_highlight)
{
	// Checks button is not same
	if (self != _self)
	{
		// Sets to idle state
		curr_button_state = BUTTON_STATE.IDLE;	
	}
}

// Inherit the parent event
event_inherited();

