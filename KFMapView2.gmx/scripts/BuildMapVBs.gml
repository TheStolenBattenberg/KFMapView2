///BuildMapVBs();

//Each 10x10 section is turned into a chunk...
var TM = map1Data[0];

var offX = 0;
var offY = 0;
var tile;

var tileRot, tileX, tileY, tileZ;
var chunk = noone;

//CBA = 6

for(var j = 0; j < 8; ++j)
{
    for(var i = 0; i < 8; ++i)
    {
        chunkedMapDataO[# i, j] = vertex_create_buffer();
        chunkedMapDataT[# i, j] = vertex_create_buffer();
        
        chunkO = chunkedMapDataO[# i, j];
        chunkT = chunkedMapDataT[# i, j];
        chunk  = 0;
        transFound = false;
        opaqeFound = false;
        
        //Replace with Vertex Buffers...
        vertex_begin(chunkO, global.VF_MO);
        vertex_begin(chunkT, global.VF_MO);

        //Go through 10*10 tiles and chunk them
        for(var yy = 0; yy < 10; ++yy)
        {
            for(var xx = 0; xx < 10; ++xx)
            {
                //Calculate tilemap coordinates
                offX = (10 * i) + xx;
                offY = (10 * j) + yy;
                tile = TM[offX, offY];
                
                //Layer 2
                if(tile[0] < ds_list_size(rtmdData))
                {
                    //Calculate Rotation
                    tileRot = ((3 - tile[2]) * 90) - 90;
                    
                    //Calculate Position
                    tileX = (xx * 2048);
                    tileY = (tile[1] * -$80);
                    tileZ = (yy * 2048);
                    
                    //Build Chunk Data
                    var OBJ = rtmdData[| tile[0]];
                    var Vs = OBJ[0];
                    //var Ns = OBJ[1];
                    var Fs = OBJ[2];
                    
                    d3d_transform_add_rotation_y(tileRot);
                    d3d_transform_add_scaling(-1, 1, 1);
                    d3d_transform_add_translation(tileX, tileY, tileZ);
                    
                    for(var k = 0; k < ds_list_size(Fs); ++k)
                    {
                        var face = Fs[| k];
                        
                        //Calculate If this is a transparent or opaque face
                        chunk = chunkO;
                        if(((face[6] >> 15) & $1) == 1)
                        {
                            chunk = chunkT;
                            transFound = true;
                        }else{
                            opaqeFound = true;
                        }
                        
                        //Calculate Texcoord Factors
                        var TSBFN = (face[7] & $1F);
                        var TexOX = (256 * (TSBFN % 16)) / 4096;
                        var TexOY = (256 * floor(TSBFN/16)) / 512;
                        var TexSW = 0.0625;
                        var TexSH = 0.5;
                        
                        //Vertex 1
                        var VDAT = Vs[| face[11]];
                            VDAT = d3d_transform_vertex(VDAT[0], VDAT[1], VDAT[2]);
                            
                        vertex_position_3d(chunk, VDAT[0], VDAT[1], VDAT[2]);
                        vertex_texcoord(chunk, TexOX + (face[0] * TexSW), TexOY + (face[1] * TexSH));
                        
                        //Vertex 2
                        var VDAT = Vs[| face[12]];
                            VDAT = d3d_transform_vertex(VDAT[0], VDAT[1], VDAT[2]);

                        vertex_position_3d(chunk, VDAT[0], VDAT[1], VDAT[2]);
                        vertex_texcoord(chunk, TexOX + (face[2] * TexSW), TexOY + (face[3] * TexSH));
                        
                        //Vertex 3
                        var VDAT = Vs[| face[13]];
                            VDAT = d3d_transform_vertex(VDAT[0], VDAT[1], VDAT[2]);
                            
                        vertex_position_3d(chunk, VDAT[0], VDAT[1], VDAT[2]);
                        vertex_texcoord(chunk, TexOX + (face[4] * TexSW), TexOY + (face[5] * TexSH));
                    }     
                    d3d_transform_set_identity();
                }      
                
                //Layer 1
                if(tile[5] < ds_list_size(rtmdData))
                {
                    //Calculate Rotation
                    tileRot = ((3 - tile[7]) * 90) - 90;
                    
                    //Calculate Position
                    tileX = (xx * 2048);
                    tileY = (tile[6] * -$80);
                    tileZ = (yy * 2048);
                    
                    //Build Chunk Data
                    var OBJ = rtmdData[| tile[5]];
                    var Vs = OBJ[0];
                    //var Ns = OBJ[1];
                    var Fs = OBJ[2];
                    
                    d3d_transform_add_rotation_y(tileRot);
                    d3d_transform_add_scaling(-1, 1, 1);
                    d3d_transform_add_translation(tileX, tileY, tileZ);
                    
                    for(var k = 0; k < ds_list_size(Fs); ++k)
                    {
                        var face = Fs[| k];
                        
                        //Calculate If this is a transparent or opaque face
                        chunk = chunkO;
                        if(((face[6] >> 15) & $1) == 1)
                        {
                            chunk = chunkT;
                            transFound = true;
                        }else{
                            opaqeFound = true;
                        }
                        
                        //Calculate Texcoord Factors
                        var TSBFN = (face[7] & $1F);
                        var TexOX = (256 * (TSBFN % 16)) / 4096;
                        var TexOY = (256 * floor(TSBFN/16)) / 512;
                        var TexSW = 0.0625;
                        var TexSH = 0.5;
                        
                        //Vertex 1
                        var VDAT = Vs[| face[11]];
                            VDAT = d3d_transform_vertex(VDAT[0], VDAT[1], VDAT[2]);
                            
                        vertex_position_3d(chunk, VDAT[0], VDAT[1], VDAT[2]);
                        vertex_texcoord(chunk, TexOX + (face[0] * TexSW), TexOY + (face[1] * TexSH));
                        
                        //Vertex 2
                        var VDAT = Vs[| face[12]];
                            VDAT = d3d_transform_vertex(VDAT[0], VDAT[1], VDAT[2]);
                            
                        vertex_position_3d(chunk, VDAT[0], VDAT[1], VDAT[2]);
                        vertex_texcoord(chunk, TexOX + (face[2] * TexSW), TexOY + (face[3] * TexSH));
                        
                        //Vertex 3
                        var VDAT = Vs[| face[13]];
                            VDAT = d3d_transform_vertex(VDAT[0], VDAT[1], VDAT[2]);
                            
                        vertex_position_3d(chunk, VDAT[0], VDAT[1], VDAT[2]);
                        vertex_texcoord(chunk, TexOX + (face[4] * TexSW), TexOY + (face[5] * TexSH));
                    }     
                    d3d_transform_set_identity();
                }              
            }
        }
        
        if(!opaqeFound)
        {
            vertex_delete_buffer(chunkO);
            chunkedMapDataO[# i, j] = -1;        
        }else{
            vertex_end(chunkO);   
            //vertex_freeze(chunkO);     
        }
        
        if(!transFound)
        {
            vertex_delete_buffer(chunkT);
            chunkedMapDataT[# i, j] = -1;
        }else{        
            vertex_end(chunkT);
            //vertex_freeze(chunkT);
        }
    }
}
