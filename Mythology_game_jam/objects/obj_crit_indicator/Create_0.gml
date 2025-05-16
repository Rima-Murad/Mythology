/// Critical/Damage Indicator Object
// Appears about enemys or players head when hit/destroyed

// Variable for the text of indicator
crit_text = "";

// Font used by text (can be changed if needed)
crit_font = global.font_score;

// Sets texts default colour (changed when player hit)
crit_colour = c_white;

// Scale value for crit text
crit_scale = 1.0;

// Sets the default alpha the text will draw at
crit_alpha = 1;

// Speed text will move vertically at
move_speed = 0;

// Life span on text before it fades out
life_remaining = 2;

// Special flag that can be used to call new waves when notifcation expires
can_call_wave = false;