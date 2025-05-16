// Wont let button select when close button exists
if (!instance_exists(obj_button_close))
{
	// Inherit the parent event
	event_inherited();
}