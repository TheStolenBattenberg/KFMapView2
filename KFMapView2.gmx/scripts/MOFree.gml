///MOFree(MO);

var MOSTMD = argument0[0];
var MOSMDL = argument0[1];

//Destroy TMD shit
for(var i = 0; i < ds_list_size(MOSTMD); ++i)
{
    var OBJ = MOSTMD[| i];
    
    ds_list_clear(OBJ[0]);
    ds_list_clear(OBJ[1]);
    ds_list_clear(OBJ[2]);
    ds_list_destroy(OBJ[0]);
    ds_list_destroy(OBJ[1]);
    ds_list_destroy(OBJ[2]);
}
ds_list_destroy(MOSTMD);
d3d_model_destroy(argument0[1]);

argument0 = -1;
