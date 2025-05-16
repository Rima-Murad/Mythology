/// Highlighting button object
// Buttons made using this parent will swap sprites

// Sets enumerator states for button
enum BUTTON_STATE
{
	IDLE,
	HOVERED,
	PRESSED,
	RELEASED,
	SIZE
}

// Sets variable for the buttons current state
curr_button_state = BUTTON_STATE.IDLE;
last_button_state = curr_button_state;

// Sets the default icon
icon_sprite = sprite_index;

// Sets the button sprites
default_button_sprite = sprite_index;
highlight_button_sprite = default_button_sprite;

// Event function for when button is triggered, set by functionality of button
button_triggered = function(){}

// Blank function for when selecting the previous option
prev_option = function(){}

// Blank function for when selecting the next option
next_option = function(){}