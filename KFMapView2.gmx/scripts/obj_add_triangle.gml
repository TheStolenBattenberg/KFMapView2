///obj_add_triangle(obj, vind1, nind1, tind1, vind2, nind2, tind2, vind3, nind3, tind3);

//Create mormal as array for list
var Triangle = array_create(9);

    //Face Vertex 1
    Triangle[0] = argument1;
    Triangle[1] = argument2;
    Triangle[2] = argument3;
    
    //Face Vertex 2
    Triangle[3] = argument4;
    Triangle[4] = argument5;
    Triangle[5] = argument6;
    
    //Face Vertex 3
    Triangle[6] = argument7;
    Triangle[7] = argument8;
    Triangle[8] = argument9;
    
    
ds_list_add(argument0[@ 3], Triangle);
