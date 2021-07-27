///obj_add_vertex(obj, x, y, z);

//Get Vertex List from OBJ
var Vertex = array_create(3);
    Vertex[0] = argument1;
    Vertex[1] = argument2;
    Vertex[2] = argument3;

ds_list_add(argument0[@ 0], Vertex);
