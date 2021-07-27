///MOLoad(tfile, id);

//Get T Data
var offs = argument0[@ 0];
var data = argument0[@ 1];

//Get F Data
var fOff = offs[| argument1];
buffer_seek(data, buffer_seek_start, fOff);

//Read MO Header
buffer_read(data, buffer_u32);
buffer_read(data, buffer_u32);
var tmdOff = buffer_read(data, buffer_u32);

buffer_seek(data, buffer_seek_start, fOff + tmdOff);

//MO Struct
var MOS = array_create(2);
    MOS[0] = TMDLoadFromBuffer(data);
    MOS[1] = -1;
    
return MOS;


