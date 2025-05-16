// Checks if the list of shadow objects exists
if (ds_exists(global.shadow_list, ds_type_list))
{
	// Deletes this shadow object from the list
	ds_list_delete(global.shadow_list, ds_list_find_index(global.shadow_list, self));	
}