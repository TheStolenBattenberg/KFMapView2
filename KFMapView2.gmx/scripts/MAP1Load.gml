///MAP1Load(tfile, id);

//Get T Data
var offs = argument0[@ 0];
var data = argument0[@ 1];

//Get F Data
var fOff = offs[| argument1];
buffer_seek(data, buffer_seek_start, fOff);

//MAP1 Struct
var map1 = array_create(2);

//Read MAP1 Tilemap
var tileDataSize = buffer_read(data, buffer_u32);
var tileMap = array_create(80);

for(var yy = 0; yy < 80; ++yy)
{
    for(var xx = 0; xx < 80; ++xx)
    {
        //Read Struct
        var tile = array_create(10);
        tile[0] = buffer_read(data, buffer_u8); //Tile ID
        tile[1] = buffer_read(data, buffer_u8); //Collision ID
        tile[2] = buffer_read(data, buffer_u8); //Rotation
        tile[3] = buffer_read(data, buffer_u8); //Layer Flags
        tile[4] = buffer_read(data, buffer_u8);
        
        tile[5] = buffer_read(data, buffer_u8);
        tile[6] = buffer_read(data, buffer_u8);
        tile[7] = buffer_read(data, buffer_u8);
        tile[8] = buffer_read(data, buffer_u8);
        tile[9] = buffer_read(data, buffer_u8);
        
        //Set tileMap tile
        tileMap[xx, 79 - yy] = tile;
    }
}

//Read MAP1 Collision Blob
var blobSize = buffer_read(data, buffer_u32);
var collData = buffer_create(blobSize, buffer_fixed, 1);
buffer_copy(data, buffer_tell(data), blobSize, collData, 0);

//Set MAP1 struct
map1[0] = tileMap;
map1[1] = collData;

//Finish
return map1;
