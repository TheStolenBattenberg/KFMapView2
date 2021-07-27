///RTIMSave(rtim, outName);

//First, we need to render all RTIM data to a surface
var tempSurf = surface_create(4096, 512);

surface_set_target(tempSurf);
draw_clear_alpha(c_black, 0.0);

//Draw RTIM data
for(var i = 0; i < ds_list_size(argument0); ++i)
{
    var BG = rtimFdat[| i];    
    draw_background(BG[0], BG[1] << 2, BG[2]);
}

surface_reset_target();

//Now we save the surface
surface_save(tempSurf, argument1);

//Cleanup
surface_free(tempSurf);
