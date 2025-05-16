/// Sequence Manager Object 
// Handles sequences that need to be attached to objects

// Variable for storing the sequence used
set_sequence = -1;

// Variable that can be set if sequence object has owner
owner = noone;

// Flag that can be changed to prevent the sequences from being paused
can_pause = true;

// Flag that can be changed to stop the sequenece from being destroyed when finished
can_die = true;

// Flag for object to know if death functionality has been added to the objects sequence
has_death = false;

// Variable for storing the functionality for after a sequece has finished
stored_function = function(){}

// Sets the death flag to true and stores the new funtion to be used later
set_death = function(_new_function)
{
	// Sets death flag to true as function was called
	has_death = true;
	// Stores the passed in function
	stored_function = _new_function;
}

// Function called when creating new sequences attached to this manager object
create_seq = function(_new_seq, _new_layer)
{
	// Sets the variable to the set sequence on a specified layer
	set_sequence = layer_sequence_create(_new_layer, x, y, _new_seq);
}