// Checks if mouse is over the current button
if (position_meeting(mouse_x, mouse_y, self))
{
	// Checks the button is currently idle
	if (curr_button_state == BUTTON_STATE.IDLE)
	{
		// Unsets all the other buttons
		with (obj_button_highlight)
		{
			// Changes state
			curr_button_state = BUTTON_STATE.IDLE;
		}
		
		// Sets the button to hovered
		curr_button_state = BUTTON_STATE.HOVERED;
	}
}