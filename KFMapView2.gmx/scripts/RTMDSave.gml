///RTMDSave(rtmd, path);

//Name Format:
//tile_0000

var VList = noone, NList = noone, FList = noone, File = -1;
var Object;

//We save each object to it's own file
for(var i = 0; i < ds_list_size(argument0); ++i)
{
    //Get TMD Object Data
    Object = argument0[| i];
    
    VList = Object[0];
    NList = Object[1];
    FList = Object[2];
    
    //Begin Writing to OBJ file
    File = file_text_open_write(argument1 + "tile_" + numPad(i, "0", 4) + ".obj");
    
    //
    // Write Obj Title
    //
    file_text_write_string(File, "# Wavefront OBJ Exported by KFMapView2"); file_text_writeln(File);
    file_text_write_string(File, "# Happy Hacking - TSB"); file_text_writeln(File);
    file_text_writeln(File);
    
    //
    // Write Obj Vertices
    //
    for(var j = 0; j < ds_list_size(VList); ++j)
        OBJWriteVertex(File, VList[| j]);
    
    file_text_write_string(File, "# Vertex Count = " + string(ds_list_size(VList)));
    file_text_writeln(File);
    file_text_writeln(File);
    
    //
    // Write Obj Texcoords
    //
    for(var j = 0; j < ds_list_size(FList); ++j)
        OBJWriteTexcoord(File, FList[| j]);
        
    file_text_write_string(File, "# Texcoord Count = " + string(ds_list_size(FList) * 3));
    file_text_writeln(File);
    file_text_writeln(File);    
    
    //  
    // Write Obj Normals
    //
    for(var j = 0; j < ds_list_size(NList); ++j)
        OBJWriteNormal(File, NList[| j]);
        
    file_text_write_string(File, "# Normal Count = " + string(ds_list_size(NList)));
    file_text_writeln(File);
    file_text_writeln(File);
    
    //
    // Write Obj Faces
    //
    var numOpaque = 0;
    
    //Pass 01... Opaque Faces
    file_text_write_string(File, "g OpaqueBatch");
    file_text_writeln(File);
    var Face;
    
    for(var j = 0; j < ds_list_size(FList); ++j)
    {
        //Get Face from List
        var Face = FList[| j];
        
        //Is this face transparent?
        if(((Face[6] >> 15) & 1) == 1)
            continue;
            
        //Write the face...
        file_text_write_string(File, "f ");
        file_text_write_string(File, string(1 + Face[11])+"/"+string(1 + (j*3)+0)+"/"+string(1 + Face[08]) + " ");
        file_text_write_string(File, string(1 + Face[12])+"/"+string(1 + (j*3)+1)+"/"+string(1 + Face[09]) + " ");
        file_text_write_string(File, string(1 + Face[13])+"/"+string(1 + (j*3)+2)+"/"+string(1 + Face[10]) + " ");
        file_text_writeln(File);
        
        numOpaque++;
    }
    
    //Pass 02... Transparent Faces
    if(numOpaque != ds_list_size(FList))
    {
        file_text_write_string(File, "g TranslucentBatch");
        file_text_writeln(File);
        var Face;
        
        for(var j = 0; j < ds_list_size(FList); ++j)
        {
            //Get Face from List
            var Face = FList[| j];
            
            //Is this face transparent?
            if(((Face[6] >> 15) & 1) == 0)
                continue;
                
            //Write the face...
            file_text_write_string(File, "f ");
            file_text_write_string(File, string(1 + Face[11])+"/"+string(1 + (j*3)+0)+"/"+string(1 + Face[08]) + " ");
            file_text_write_string(File, string(1 + Face[12])+"/"+string(1 + (j*3)+1)+"/"+string(1 + Face[09]) + " ");
            file_text_write_string(File, string(1 + Face[13])+"/"+string(1 + (j*3)+2)+"/"+string(1 + Face[10]) + " ");
            file_text_writeln(File);
        }    
    }
    file_text_close(File);
}
