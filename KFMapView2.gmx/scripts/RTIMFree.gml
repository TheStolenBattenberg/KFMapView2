///RTIMFree(rtim);

for(var i = 0; i < ds_list_size(argument0); ++i)
{
    var TEX = argument0[| i];
    
    background_delete(TEX[0]);
    argument0[| i] = -1;
}
ds_list_destroy(argument0);
