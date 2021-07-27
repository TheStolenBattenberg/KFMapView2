///BuildMapVRAM();

var surf = surface_create(4096, 512);

if(background_exists(psxVRAM))
{
    background_delete(psxVRAM);
}

surface_set_target(surf);
//draw_clear_alpha(c_black, 1.0);
draw_clear(c_lime);

//FDAT Textures
for(var i = 0; i < ds_list_size(rtimFdat); ++i)
{
    var BG = rtimFdat[| i];    
    draw_background(BG[0], BG[1] << 2, BG[2]);
}

//RTIM Textures
for(var i = 0; i < ds_list_size(rtimData); ++i)
{
    var BG = rtimData[| i];    
    draw_background(BG[0], BG[1] << 2, BG[2]);
}

//RTIM Textures from trigger
/*
if(rtimFromTrigger != noone)
{
    for(var i = 0; i < ds_list_size(rtimFromTrigger); ++i)
    {
        var BG = rtimFromTrigger[| i];    
        draw_background(BG[0], BG[1] << 2, BG[2]);
    }    
}
*/
surface_reset_target();


//Create VRAM Background
psxVRAM = background_create_from_surface(surf, 0, 0, 4096, 512, false, false);

//Free Surface
surface_free(surf);


psxVRAMTex = background_get_texture(psxVRAM);
