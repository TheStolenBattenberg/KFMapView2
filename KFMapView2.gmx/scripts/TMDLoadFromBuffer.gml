///LoadTMDFromBuffer(buffer);

var BaseOffset = buffer_tell(argument0);
var data = argument0;

buffer_read(data, buffer_u32);
buffer_read(data, buffer_u32);
var nObj = buffer_read(data, buffer_u32);

var MODEL = ds_list_create();

var vOff, vNum, nOff, nNum, pOff, pNum;
repeat(nObj)
{
    var OBJ = array_create(3);
    
    //Read OBJ Values
    vOff = (BaseOffset + $C) + buffer_read(data, buffer_u32);
    vNum = buffer_read(data, buffer_u32);
    nOff = (BaseOffset + $C) + buffer_read(data, buffer_u32);
    nNum = buffer_read(data, buffer_u32);
    pOff = (BaseOffset + $C) + buffer_read(data, buffer_u32);
    pNum = buffer_read(data, buffer_u32);
    buffer_read(data, buffer_s32);
    
    //Read Object Data    
    var objOff = buffer_tell(data);
    
    //Vertices
    buffer_seek(data, buffer_seek_start, vOff);
    {
        var Vertices = ds_list_create();
        
        repeat(vNum)
        {
            var V = array_create(3);
            V[0] = buffer_read(data, buffer_s16);
            V[1] = buffer_read(data, buffer_s16);
            V[2] = buffer_read(data, buffer_s16);
            buffer_read(data, buffer_s16);
            
            ds_list_add(Vertices, V);
        }
    }
    
    //Normals
    buffer_seek(data, buffer_seek_start, nOff);
    {
        var Normals = ds_list_create();
        
        repeat(nNum)
        {
            var N = array_create(3);
            N[0] = buffer_read(data, buffer_s16) / 4096;
            N[1] = buffer_read(data, buffer_s16) / 4096;
            N[2] = buffer_read(data, buffer_s16) / 4096;
            buffer_read(data, buffer_s16);
            
            ds_list_add(Normals, N);
        }
    }
    
    //Primitives
    buffer_seek(data, buffer_seek_start, pOff);
    {
        var Faces = ds_list_create();
        
        repeat(pNum)
        {
            //Main Prim ID
            var ID = buffer_read(data, buffer_u32);
            
            var oLen  = (ID & $FF);
            var iLen  = (ID >> 8) & $FF;
            var flag  = (ID >> 16) & $FF;
            var mode  = (ID >> 24) & $FF;
            var alpha = 0;
            
            //Load Primitives
            switch(ID)
            {
                //
                // Tri, Colour, Flat
                //
                case $20000304:
                    buffer_read(data, buffer_u32);
                    
                    var NId0 = buffer_read(data, buffer_u16);
                    var VId0 = buffer_read(data, buffer_u16);
                    var VId1 = buffer_read(data, buffer_u16);
                    var VId2 = buffer_read(data, buffer_u16); 
                    
                    //Build Face
                    var face = array_create(12);
                        //TC
                        face[0]  = 0;
                        face[1]  = 0;
                        face[2]  = 0;
                        face[3]  = 0;
                        face[4]  = 0;
                        face[5]  = 0;
                        face[6]  = -1;
                        face[7]  = -1;
                        
                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId0;
                        face[10] = NId0;
                        
                        //Vertex
                        face[11] = VId0;
                        face[12] = VId1;
                        face[13] = VId2;   
                                             
                    ds_list_add(Faces, face);                      
                                        
                break;
                
                case $30000406:
                    buffer_read(data, buffer_u32);
                    
                    var NId0 = buffer_read(data, buffer_u16);
                    var VId0 = buffer_read(data, buffer_u16);
                    var NId1 = buffer_read(data, buffer_u16);
                    var VId1 = buffer_read(data, buffer_u16);
                    var NId2 = buffer_read(data, buffer_u16);
                    var VId2 = buffer_read(data, buffer_u16); 
                    
                    //Build Face
                    var face = array_create(12);
                        //TC
                        face[0]  = 0;
                        face[1]  = 0;
                        face[2]  = 0;
                        face[3]  = 0;
                        face[4]  = 0;
                        face[5]  = 0;
                        face[6]  = -1;
                        face[7]  = -1;
                        
                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId1;
                        face[10] = NId2;
                        
                        //Vertex
                        face[11] = VId0;
                        face[12] = VId1;
                        face[13] = VId2;   
                                             
                    ds_list_add(Faces, face);   
                break;
                
                //
                // Tri, Textured, Flat
                //
                case $26000507: alpha = 1;
                case $24000507:
                    //Load Data 
                    var TCu0 = buffer_read(data, buffer_u8) / 255;
                    var TCv0 = buffer_read(data, buffer_u8) / 255;
                    var CBA  = buffer_read(data, buffer_u16);
                    
                    var TCu1 = buffer_read(data, buffer_u8) / 255;
                    var TCv1 = buffer_read(data, buffer_u8) / 255;
                    var TSB  = buffer_read(data, buffer_u16);
                    
                    var TCu2 = buffer_read(data, buffer_u8) / 255;
                    var TCv2 = buffer_read(data, buffer_u8) / 255;
                    buffer_read(data, buffer_u16);                
                
                    var NId0 = buffer_read(data, buffer_u16);
                    var VId0 = buffer_read(data, buffer_u16);
                    var VId1 = buffer_read(data, buffer_u16);
                    var VId2 = buffer_read(data, buffer_u16);    
                    
                    //Build Face
                    var face = array_create(12);
                        //TC
                        face[0]  = TCu0;
                        face[1]  = TCv0;
                        face[2]  = TCu1;
                        face[3]  = TCv1;
                        face[4]  = TCu2;
                        face[5]  = TCv2;
                        face[6]  = CBA | (alpha << 15);
                        face[7]  = TSB;
                        
                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId0;
                        face[10] = NId0;
                        
                        //Vertex
                        face[11] = VId0;
                        face[12] = VId1;
                        face[13] = VId2;   
                                             
                    ds_list_add(Faces, face);            
                break;
                
                //
                // Quad, Colour, Flat
                //
                case $28000405:
                    //Load Data 
                    buffer_read(data, buffer_u32);
                       
                    var NId0 = buffer_read(data, buffer_u16);
                    var VId0 = buffer_read(data, buffer_u16);
                    var VId1 = buffer_read(data, buffer_u16);
                    var VId2 = buffer_read(data, buffer_u16);
                    var VId3 = buffer_read(data, buffer_u16);
                    buffer_read(data, buffer_u16);
                    
                    //Build Face 1
                    var face = array_create(12);
                        //TC
                        face[0]  = 0;
                        face[1]  = 0;
                        face[2]  = 0;
                        face[3]  = 0;
                        face[4]  = 0;
                        face[5]  = 0;
                        face[6]  = -1;
                        face[7]  = -1;

                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId0;
                        face[10] = NId0;
                        
                        //Vertex
                        face[11] = VId0;
                        face[12] = VId1;
                        face[13] = VId2;
                        
                    ds_list_add(Faces, face);
                    
                    //Build Face 2
                    var face = array_create(12);
                        //TC
                        face[0]  = 0;
                        face[1]  = 0;
                        face[2]  = 0;
                        face[3]  = 0;
                        face[4]  = 0;
                        face[5]  = 0;
                        face[6]  = -1;
                        face[7]  = -1;
                        
                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId0;
                        face[10] = NId0;
                        
                        //Vertex
                        face[11] = VId1;
                        face[12] = VId2;
                        face[13] = VId3;
                        
                    ds_list_add(Faces, face);
                break;   
                
                //
                // Quad, Colour, Smooth
                //
                case $38000508:
                    //Load Data 
                    buffer_read(data, buffer_u32);
                       
                    var NId0 = buffer_read(data, buffer_u16);
                    var VId0 = buffer_read(data, buffer_u16);
                    var NId1 = buffer_read(data, buffer_u16);
                    var VId1 = buffer_read(data, buffer_u16);
                    var NId2 = buffer_read(data, buffer_u16);
                    var VId2 = buffer_read(data, buffer_u16);
                    var NId3 = buffer_read(data, buffer_u16);
                    var VId3 = buffer_read(data, buffer_u16);
                    
                    //Build Face 1
                    var face = array_create(12);
                        //TC
                        face[0]  = 0;
                        face[1]  = 0;
                        face[2]  = 0;
                        face[3]  = 0;
                        face[4]  = 0;
                        face[5]  = 0;
                        face[6]  = -1;
                        face[7]  = -1;

                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId1;
                        face[10] = NId2;
                        
                        //Vertex
                        face[11] = VId0;
                        face[12] = VId1;
                        face[13] = VId2;
                        
                    ds_list_add(Faces, face);
                    
                    //Build Face 2
                    var face = array_create(12);
                        //TC
                        face[0]  = 0;
                        face[1]  = 0;
                        face[2]  = 0;
                        face[3]  = 0;
                        face[4]  = 0;
                        face[5]  = 0;
                        face[6]  = -1;
                        face[7]  = -1;
                        
                        //Normal
                        face[8]  = NId1;
                        face[9]  = NId2;
                        face[10] = NId3;
                        
                        //Vertex
                        face[11] = VId1;
                        face[12] = VId2;
                        face[13] = VId3;
                        
                    ds_list_add(Faces, face);
                break;                
                
                //
                // Tri, Textured, Smooth
                //
                case $36000609: alpha = 1;
                case $34000609:
                    //Load Data 
                    var TCu0 = buffer_read(data, buffer_u8) / 255;
                    var TCv0 = buffer_read(data, buffer_u8) / 255;
                    var CBA  = buffer_read(data, buffer_u16);
                    
                    var TCu1 = buffer_read(data, buffer_u8) / 255;
                    var TCv1 = buffer_read(data, buffer_u8) / 255;
                    var TSB  = buffer_read(data, buffer_u16);
                    
                    var TCu2 = buffer_read(data, buffer_u8) / 255;
                    var TCv2 = buffer_read(data, buffer_u8) / 255;
                    buffer_read(data, buffer_u16);                
                
                    var NId0 = buffer_read(data, buffer_u16);
                    var VId0 = buffer_read(data, buffer_u16);
                    var NId1 = buffer_read(data, buffer_u16);
                    var VId1 = buffer_read(data, buffer_u16);
                    var NId2 = buffer_read(data, buffer_u16);
                    var VId2 = buffer_read(data, buffer_u16);    
                    
                    //Build Face
                    var face = array_create(12);
                        //TC
                        face[0]  = TCu0;
                        face[1]  = TCv0;
                        face[2]  = TCu1;
                        face[3]  = TCv1;
                        face[4]  = TCu2;
                        face[5]  = TCv2;
                        face[6]  = CBA | (alpha << 15);
                        face[7]  = TSB;
                        
                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId1;
                        face[10] = NId2;
                        
                        //Vertex
                        face[11] = VId0;
                        face[12] = VId1;
                        face[13] = VId2;   
                                             
                    ds_list_add(Faces, face);            
                break;                
                                
                //
                // Quad, Textured, Flat
                //
                case $2E000709: alpha = 1;
                case $2C000709:
                    //Load Data 
                    var TCu0 = buffer_read(data, buffer_u8) / 255;
                    var TCv0 = buffer_read(data, buffer_u8) / 255;
                    var CBA  = buffer_read(data, buffer_u16);
                    
                    var TCu1 = buffer_read(data, buffer_u8) / 255;
                    var TCv1 = buffer_read(data, buffer_u8) / 255;
                    var TSB  = buffer_read(data, buffer_u16);
                    
                    var TCu2 = buffer_read(data, buffer_u8) / 255;
                    var TCv2 = buffer_read(data, buffer_u8) / 255;
                    buffer_read(data, buffer_u16);
                    
                    var TCu3 = buffer_read(data, buffer_u8) / 255;
                    var TCv3 = buffer_read(data, buffer_u8) / 255;
                    buffer_read(data, buffer_u16);   
                       
                    var NId0 = buffer_read(data, buffer_u16);
                    var VId0 = buffer_read(data, buffer_u16);
                    var VId1 = buffer_read(data, buffer_u16);
                    var VId2 = buffer_read(data, buffer_u16);
                    var VId3 = buffer_read(data, buffer_u16);
                    buffer_read(data, buffer_u16);
                    
                    //Build Face 1
                    var face = array_create(12);
                        //TC
                        face[0]  = TCu0;
                        face[1]  = TCv0;
                        face[2]  = TCu1;
                        face[3]  = TCv1;
                        face[4]  = TCu2;
                        face[5]  = TCv2;
                        face[6]  = CBA | (alpha << 15);
                        face[7]  = TSB;
                        
                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId0;
                        face[10] = NId0;
                        
                        //Vertex
                        face[11] = VId0;
                        face[12] = VId1;
                        face[13] = VId2;
                        
                    ds_list_add(Faces, face);
                    
                    //Build Face 2
                    var face = array_create(12);
                        //TC
                        face[0]  = TCu1;
                        face[1]  = TCv1;
                        face[2]  = TCu2;
                        face[3]  = TCv2;
                        face[4]  = TCu3;
                        face[5]  = TCv3;
                        face[6]  = CBA | (alpha << 15);
                        face[7]  = TSB;
                        
                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId0;
                        face[10] = NId0;
                        
                        //Vertex
                        face[11] = VId1;
                        face[12] = VId2;
                        face[13] = VId3;
                        
                    ds_list_add(Faces, face);
                break;
                
                //
                // Quad, Textured, Smooth
                //
                case $3E00080C: alpha = 1;
                case $3C00080C:
                    //Load Data 
                    var TCu0 = buffer_read(data, buffer_u8) / 255;
                    var TCv0 = buffer_read(data, buffer_u8) / 255;
                    var CBA  = buffer_read(data, buffer_u16);
                    
                    var TCu1 = buffer_read(data, buffer_u8) / 255;
                    var TCv1 = buffer_read(data, buffer_u8) / 255;
                    var TSB  = buffer_read(data, buffer_u16);
                    
                    var TCu2 = buffer_read(data, buffer_u8) / 255;
                    var TCv2 = buffer_read(data, buffer_u8) / 255;
                    buffer_read(data, buffer_u16);
                    
                    var TCu3 = buffer_read(data, buffer_u8) / 255;
                    var TCv3 = buffer_read(data, buffer_u8) / 255;
                    buffer_read(data, buffer_u16);   
                       
                    var NId0 = buffer_read(data, buffer_u16);
                    var VId0 = buffer_read(data, buffer_u16);
                    var NId1 = buffer_read(data, buffer_u16);
                    var VId1 = buffer_read(data, buffer_u16);
                    var NId2 = buffer_read(data, buffer_u16);
                    var VId2 = buffer_read(data, buffer_u16);
                    var NId3 = buffer_read(data, buffer_u16);
                    var VId3 = buffer_read(data, buffer_u16);
                    
                    //Build Face 1
                    var face = array_create(12);
                        //TC
                        face[0]  = TCu0;
                        face[1]  = TCv0;
                        face[2]  = TCu1;
                        face[3]  = TCv1;
                        face[4]  = TCu2;
                        face[5]  = TCv2;
                        face[6]  = CBA | (alpha << 15);
                        face[7]  = TSB;
                        
                        //Normal
                        face[8]  = NId0;
                        face[9]  = NId1;
                        face[10] = NId2;
                        
                        //Vertex
                        face[11] = VId0;
                        face[12] = VId1;
                        face[13] = VId2;
                        
                    ds_list_add(Faces, face);
                    
                    //Build Face 2
                    var face = array_create(12);
                        //TC
                        face[0]  = TCu1;
                        face[1]  = TCv1;
                        face[2]  = TCu2;
                        face[3]  = TCv2;
                        face[4]  = TCu3;
                        face[5]  = TCv3;
                        face[6]  = CBA | (alpha << 15);
                        face[7]  = TSB;
                        
                        //Normal
                        face[8]  = NId1;
                        face[9]  = NId2;
                        face[10] = NId3;
                        
                        //Vertex
                        face[11] = VId1;
                        face[12] = VId2;
                        face[13] = VId3;
                        
                    ds_list_add(Faces, face);
                break;
                                                                        
                default:
                    show_debug_message("Unknown Primitive ID: " + dec_to_hex(ID, 8));
                    buffer_seek(data, buffer_seek_relative, 4 * iLen);
                break;
            }
            
        }
    }
    
    OBJ[0] = Vertices;
    OBJ[1] = Normals;
    OBJ[2] = Faces;
    
    ds_list_add(MODEL, OBJ);
    
    buffer_seek(data, buffer_seek_start, objOff);
}

return MODEL;


