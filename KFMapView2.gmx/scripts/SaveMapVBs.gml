///SaveMapVBs();

/**
** In order to better utilize modern GPUs, we chunk the tiles to reduce drawcall overhead
**/

//Each 10x10 section is turned into a chunk...
var Tilemap = map1Data[0];
var TileOffX = 0;
var TileOffY = 0;
var Tile;
var TMD;

var ChunkOffX = 0;
var ChunkOffY = 0;
var ChunkO, ChunkT;

var TileRotation, TileX, TileY, TileZ;
var File = noone;

//Begin Chunking... KF Maps are 80x80, so we need to do 64 chunks (8x8)
for(var cY = 0; cY < 8; ++cY)
{
    for(var cX = 0; cX < 8; ++cX)
    {
        //
        //Calculate Chunk Offsets
        //
        ChunkOffX = -$14000 + ($28000 / 8) * cX;
        ChunkOffY = -$14000 + ($28000 / 8) * cY;    

        //
        //Open OBJ File Stream
        //
        File = file_text_open_write(GameName+"\"+MapName+"\chunks\chunk_"+ string(ChunkOffX) + "x" + string(ChunkOffY)+".obj");    
        
        file_text_write_string(File, "# Wavefront OBJ Exported by KFMapView2"); file_text_writeln(File);
        file_text_write_string(File, "# Happy Hacking - TSB"); file_text_writeln(File);
        file_text_writeln(File);
        
        //Convert VBs into regular buffers
        ChunkO = -1;
        ChunkOTNum = 0;
        ChunkOVNum = 0;
        
        if(chunkedMapDataO[# cX, cY] != -1)
        {
            ChunkO = buffer_create_from_vertex_buffer(chunkedMapDataO[# cX, cY], buffer_fixed, 1);
            ChunkOTNum = vertex_get_number(chunkedMapDataO[# cX, cY]) / 3;
            ChunkOVNum = vertex_get_number(chunkedMapDataO[# cX, cY]);            
        }

        ChunkT = -1;
        ChunkTTNum = 0;
        ChunkTVNum = 0;
        
        if(chunkedMapDataT[# cX, cY] != -1)
        {
            ChunkT = buffer_create_from_vertex_buffer(chunkedMapDataT[# cX, cY], buffer_fixed, 1);
            ChunkTTNum = vertex_get_number(chunkedMapDataT[# cX, cY]) / 3;
            ChunkTVNum = vertex_get_number(chunkedMapDataT[# cX, cY]);
        }
                
        //
        // Write Chunk Vertices
        //
        if(ChunkO != -1)
        {
            buffer_seek(ChunkO, buffer_seek_start, 0);
            
            repeat(ChunkOVNum)
            {
                file_text_write_string(File, "v ");
                file_text_write_real(File, buffer_read(ChunkO, buffer_f32)/1024);
                file_text_write_real(File, buffer_read(ChunkO, buffer_f32)/1024);
                file_text_write_real(File, buffer_read(ChunkO, buffer_f32)/1024);
                file_text_writeln(File);
                
                buffer_seek(ChunkO, buffer_seek_relative, 8);
            }
        }
        
        if(ChunkT != -1)
        {
            buffer_seek(ChunkT, buffer_seek_start, 0);
            
            repeat(ChunkTVNum)
            {
                file_text_write_string(File, "v ");
                file_text_write_real(File, buffer_read(ChunkT, buffer_f32)/1024);
                file_text_write_real(File, buffer_read(ChunkT, buffer_f32)/1024);
                file_text_write_real(File, buffer_read(ChunkT, buffer_f32)/1024);
                file_text_writeln(File);
                
                buffer_seek(ChunkT, buffer_seek_relative, 8);
            }
        }
        
        file_text_write_string(File, "# Vertex Count = " + string(ChunkOVNum + ChunkTVNum));
        file_text_writeln(File);
        file_text_writeln(File);
        
        //
        // Write Chunk Texcoords
        //
        if(ChunkO != -1)
        {
            buffer_seek(ChunkO, buffer_seek_start, 0);
            
            repeat(ChunkOVNum)
            {
                buffer_seek(ChunkO, buffer_seek_relative, 12);
                
                file_text_write_string(File, "vt ");
                file_text_write_real(File, buffer_read(ChunkO, buffer_f32));
                file_text_write_real(File, buffer_read(ChunkO, buffer_f32));
                file_text_writeln(File);
            }
        }
        
        if(ChunkT != -1)
        {
            buffer_seek(ChunkT, buffer_seek_start, 0);
            
            repeat(ChunkTVNum)
            {
                buffer_seek(ChunkT, buffer_seek_relative, 12);
                
                file_text_write_string(File, "vt ");
                file_text_write_real(File, buffer_read(ChunkT, buffer_f32));
                file_text_write_real(File, buffer_read(ChunkT, buffer_f32));
                file_text_writeln(File);
            }
        }
        
        file_text_write_string(File, "# Texcoord Count = " + string(ChunkOVNum + ChunkTVNum));
        file_text_writeln(File);
        file_text_writeln(File);
                
        //
        // Write Chunk Normals
        //
        if(ChunkO != -1)
        {           
            repeat(ChunkOVNum)
            {
                file_text_write_string(File, "vn ");
                file_text_write_real(File, 0);
                file_text_write_real(File, 0);
                file_text_write_real(File, 0);
                file_text_writeln(File);
            }
        }
        
        if(ChunkT != -1)
        {
            repeat(ChunkTVNum)
            {
                file_text_write_string(File, "vn ");
                file_text_write_real(File, 0);
                file_text_write_real(File, 0);
                file_text_write_real(File, 0);
                file_text_writeln(File);
            }
        }
        
        file_text_write_string(File, "# Normal Count = " + string(ChunkOVNum + ChunkTVNum));
        file_text_writeln(File);
        file_text_writeln(File);
        
        //
        // Write Opaque Group
        //
        file_text_write_string(File, "g OpaqueBatch"); file_text_writeln(File);
        
        for(var j = 0; j < ChunkOTNum; ++j)
        {
            file_text_write_string(File, "f " );
            file_text_write_string(File, string((3 * j) + 1)+"/"+string((3 * j) + 1)+"/"+string((3 * j) + 1)+" ");
            file_text_write_string(File, string((3 * j) + 2)+"/"+string((3 * j) + 2)+"/"+string((3 * j) + 2)+" ");
            file_text_write_string(File, string((3 * j) + 3)+"/"+string((3 * j) + 3)+"/"+string((3 * j) + 3)+" ");
            file_text_writeln(File);
        }
        
        //
        // Write Translucent Group
        //
        if(ChunkTTNum > 0)
        {
            file_text_write_string(File, "g TranslucentBatch"); file_text_writeln(File);
            
            for(var j = 0; j < ChunkTTNum; ++j)
            {
                file_text_write_string(File, "f " );
                file_text_write_string(File, string(ChunkOVNum + (3 * j) + 1)+"/"+string(ChunkOVNum + (3 * j) + 1)+"/"+string(ChunkOVNum + (3 * j) + 1)+" ");
                file_text_write_string(File, string(ChunkOVNum + (3 * j) + 2)+"/"+string(ChunkOVNum + (3 * j) + 2)+"/"+string(ChunkOVNum + (3 * j) + 2)+" ");
                file_text_write_string(File, string(ChunkOVNum + (3 * j) + 3)+"/"+string(ChunkOVNum + (3 * j) + 3)+"/"+string(ChunkOVNum + (3 * j) + 3)+" ");
                file_text_writeln(File);
            }        
        }
        
        file_text_close(File);
    }
}
