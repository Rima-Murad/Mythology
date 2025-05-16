/// Mute button for splash screen
// Toggles mute on and off

// Inherit the parent event
event_inherited();

// Sets icon sprite
icon_sprite = spr_icon_audio_on;

// Sets button alt
highlight_button_sprite = spr_button_over;

// Checks what the state is
if (global.is_muted)
{
	// Sets master gain to 0 and mutes all sounds
	audio_master_gain(0);
	// Shows muted icon
	icon_sprite = spr_icon_audio_off;
}
else
{
	// Sets master gain to 1 and allows sound to play normally
	audio_master_gain(1);
	// Shows unmuted icon
	icon_sprite = spr_icon_audio_on;
}

// Changes the triggered functionality of the button
button_triggered = function()
{
	// Button pushed vibration
	gamepad_vibration(0.1, 0.1, 0.1);
	// Button pushed sound effect
	audio_play_sound(snd_button_push, 100, false);
	
	// Toggles the current muted state
	global.is_muted = !global.is_muted;
	
	// Checks what the state is
	if (global.is_muted)
	{
		// Sets master gain to 0 and mutes all sounds
		audio_master_gain(0);
		// Shows muted icon
		icon_sprite = spr_icon_audio_off;
	}
	else
	{
		// Sets master gain to 1 and allows sound to play normally
		audio_master_gain(1);
		// Shows unmuted icon
		icon_sprite = spr_icon_audio_on;
	}
	
	// Sets buttons current state back to idle
	curr_button_state = BUTTON_STATE.IDLE;
}

// Set function for when selecting the previous option
prev_option = function()
{
	// Unsets all the other buttons
	with (obj_button_highlight)
	{
		// Changes state
		curr_button_state = BUTTON_STATE.IDLE;
	}
	
	// Sets the button to hovered
	obj_button_play.curr_button_state = BUTTON_STATE.HOVERED;
}

// Set function for when selecting the next option
next_option = function()
{
	// Unsets all the other buttons
	with (obj_button_highlight)
	{
		// Changes state
		curr_button_state = BUTTON_STATE.IDLE;
	}
	
	// Sets other button
	obj_button_controls.curr_button_state = BUTTON_STATE.HOVERED;
}