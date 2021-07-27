///obj_save(obj, pathAndName);

//Get data from OBJ structure
var VList = argument0[| 0];
var NList = argument0[| 1];
var TList = argument0[| 2];
var FList = argument0[| 3];

//Open new text file
var objF = file_text_open_write(argument1);

//Write simple heading comment
file_text_write_string(objF, "# OBJ Exported by KFMapView2");
file_text_writeln(objF);
file_text_writeln(objF);

//Write Vertices to OBJ
for(var i = 0; i < ds_list_size(VList); ++i)
{
    var V = VList[| i];
    
    file_text_write_string(objF, "v " + string(V[0]) + " " + string(V[1]) + " " + string(V[2]));
    file_text_writeln(objF);
}
file_text_write_string(objF, "# Vertex Count : " + string(ds_list_size(VList))); 
file_text_writeln(objF);
file_text_writeln(objF);

//Write Texture Coordinates to OBJ
for(var i = 0; i < ds_list_size(TList); ++i)
{
    var T = NList[| i];
    
    file_text_write_string(objF, "vt " + string(T[0]) + " " + string(T[1]) + " " + string(T[2]));
    file_text_writeln(objF);
}
file_text_write_string(objF, "# Texture Coordinate Count : " + string(ds_list_size(TList))); 
file_text_writeln(objF);
file_text_writeln(objF);

//Write Normals to OBJ
for(var i = 0; i < ds_list_size(NList); ++i)
{
    var N = NList[| i];
    
    file_text_write_string(objF, "vn " + string(N[0]) + " " + string(N[1]) + " " + string(N[2]));
    file_text_writeln(objF);
}
file_text_write_string(objF, "# Normal Count : " + string(ds_list_size(NList))); 
file_text_writeln(objF);
file_text_writeln(objF);

//Write Faces to OBJ
file_text_write_string(objF, "g ObjExport");
file_text_writeln(objF);

for(var i = 0; i < ds_list_size(FList); ++i)
{
    var F = FList[| i];
    
    file_text_write_string(objF, "f ");
    file_text_write_string(objF, string(F[0])+"/"+string(F[1])+"/"+string(F[2]) + " ");
    file_text_write_string(objF, string(F[3])+"/"+string(F[4])+"/"+string(F[5]) + " ");
    file_text_write_string(objF, string(F[6])+"/"+string(F[7])+"/"+string(F[8]));
    file_text_writeln(objF);
}
file_text_write_string(objF, "# Face (3-Point) Count : " + string(ds_list_size(NList))); 
file_text_writeln(objF);
file_text_writeln(objF);
