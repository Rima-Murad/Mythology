/// Player Bomb Object
// Bomb that player can launch towards ground to destroy trains and turrets

// Inherit the parent event
event_inherited();

// Flags for bombs setup
is_big = false;
set_level = 0;

// Sets the inital move distance to zero
move_distance = 0;

// Sets the direction for bombs to travel up
direction = 90;

// Creates empty variable for the bombs shadow object to be assigned to
shadow = -1;