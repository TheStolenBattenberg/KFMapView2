///obj_add_normal(obj, nx, ny, nz);

//Create mormal as array for list
var Normal = array_create(3);
    Normal[0] = argument1;
    Normal[1] = argument2;
    Normal[2] = argument3;

ds_list_add(argument0[@ 1], Normal);
