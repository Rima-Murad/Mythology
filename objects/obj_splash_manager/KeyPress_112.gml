// Checks if game is in full screen
if (window_get_fullscreen())
{
	// Toggles fullscreen off
    window_set_fullscreen(false);
}
else
{
	// Toggles fullscreen on
    window_set_fullscreen(true);
}