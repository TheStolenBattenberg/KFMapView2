///RTMDFree(rtmd);

for(var i = 0; i < ds_list_size(argument0); ++i)
{
    var OBJ = argument0[| i];
    
    ds_list_clear(OBJ[0]);
    ds_list_clear(OBJ[1]);
    ds_list_clear(OBJ[2]);
    ds_list_destroy(OBJ[0]);
    ds_list_destroy(OBJ[1]);
    ds_list_destroy(OBJ[2]);
}
ds_list_destroy(argument0);
