/// Shadow object
// Object that is attached to other objects within the game that require shadows

// Owner object of this shadow
owner = noone;

// Maxium off sets shadow can appear at
max_offset_x = 40;
max_offset_y = 50;

// Current offsets the shadow appears at
x_offset = 0;
y_offset = 0;

// Values that are used to scale the x and y offsets
x_scaler = 0;
y_scaler = 0;

// Handle function used to store shadows draw within
draw_handle = function(){}

// Adds this shadow to the global list of shadows
ds_list_add(global.shadow_list, self);