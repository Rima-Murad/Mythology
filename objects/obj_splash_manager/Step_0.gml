// Calls the script for updating the gamepad controllers
gp_vibration_update();

// Checks if in browser
if (os_browser != browser_not_a_browser)
{
	// Sets the window size to the browser
	window_set_size(browser_width, browser_height);
	// Sets the window to its center
	window_center();
}

// Checks if the stick cooldown is greater than zero
if (global.stick_cooldown > 0)
{
	// Decreases the cooldown
	global.stick_cooldown -= delta_time * 0.000001;
}