 ///TFileOpen(path);

//T Struct
var tfile = array_create(4);

//T Buffer
var buff = buffer_load_ns(argument0);

//Read Offsets
var oNum = buffer_read(buff, buffer_u16);
var offs = ds_list_create();
var sOfF = 0;
var eOfF = 0;

var off;
for(var i = 0; i < oNum; ++i)
{   
    ds_list_add(offs, (buffer_read(buff, buffer_u16) << $b));
}
eOfF = buffer_read(buff, buffer_u16) << $b;
ds_list_add(offs, eOfF);

//Fill T Struct
tfile[0] = offs;
tfile[1] = buff;
tfile[2] = sOfF;
tfile[3] = eOfF;

return tfile;
