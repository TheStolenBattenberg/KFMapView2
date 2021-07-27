///obj_begin();

/**
** Creates and returns a structure to store OBJ model information
**/

var objRef = array_create(4);
    objRef[0] = ds_list_create();  //Vertices
    objRef[1] = ds_list_create();  //Normals
    objRef[2] = ds_list_create();  //Texcoords
    objRef[3] = ds_list_create();  //Triangles
    
return objRef;
