///obj_add_texcoord(obj, tu, tv);

//Create mormal as array for list
var Texcoord = array_create(3);
    Texcoord[0] = argument1;
    Texcoord[1] = argument2;
    
ds_list_add(argument0[@ 2], Texcoord);
