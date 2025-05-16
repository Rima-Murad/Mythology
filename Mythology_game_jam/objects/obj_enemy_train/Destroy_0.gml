// Checks if the train sound variable exists
if (variable_instance_exists(self.id, "train_sound"))
{
	// Stops the train sound from playing
	audio_stop_sound(train_sound);
	
	// Destroys the trains movement list
	ds_list_destroy(movement_list);
}