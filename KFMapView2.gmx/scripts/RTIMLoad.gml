///RTIMLoad(tfile, id);

//Get T Data
var offs = argument0[@ 0];
var data = argument0[@ 1];

//Get F Data
var fOff = offs[| argument1];
var fEnd = offs[| argument1+1];

buffer_seek(data, buffer_seek_start, fOff);

var IMAGE = ds_list_create();

while(buffer_tell(data) < (fEnd-64))
{
    //
    // Read Clut Header
    //
    var clutX = buffer_read(data, buffer_u16);
    var clutY = buffer_read(data, buffer_u16);
    var clutW = buffer_read(data, buffer_u16);
    var clutH = buffer_read(data, buffer_u16);
    var dupl1 = buffer_read(data, buffer_u16);
    var dupl2 = buffer_read(data, buffer_u16);
    var dupl3 = buffer_read(data, buffer_u16);
    var dupl4 = buffer_read(data, buffer_u16);
    
    //Skip Bad Data
    if(clutX != dupl1 || clutY != dupl2 || clutW != dupl3 || clutH != dupl4)
        continue;
        
    if(clutX >= 1024 || clutY >= 512)
        continue;
    
    //    
    // Read Clut Data
    //
    var CLUT = array_create(16);
    for(var i = 0; i < 16; ++i)
    {
        var C = buffer_read(data, buffer_u16);
        var R = ((C >> 0) & $1F)  << 3;
        var G = ((C >> 5) & $1F)  << 3;
        var B = ((C >> 10) & $1F) << 3;
        
        CLUT[i, 0] = make_colour_rgb(R, G, B);
        //CLUT[i, 1] = (C >> 11) & 1;
    }
    
    //
    // Read Image Header
    //
    var imageX = buffer_read(data, buffer_u16);
    var imageY = buffer_read(data, buffer_u16);
    var imageW = buffer_read(data, buffer_u16);
    var imageH = buffer_read(data, buffer_u16);
    var dupl1 = buffer_read(data, buffer_u16);
    var dupl2 = buffer_read(data, buffer_u16);
    var dupl3 = buffer_read(data, buffer_u16);
    var dupl4 = buffer_read(data, buffer_u16);

    //Skip Bad Data
    if(imageX != dupl1 || imageY != dupl2 || imageW != dupl3 || imageH != dupl4)
        continue;
        
    if(imageX >= 1024 || imageY >= 512 || imageW == 0 || imageH == 0)
        continue;    
        
    //
    // Read Image Data
    //
    var SURF = surface_create(imageW << 2, imageH);
    
    surface_set_target(SURF);    
    for(var yy = 0; yy < imageH; ++yy)
    {
        for(var xx = 0; xx < imageW; ++xx)
        {
            var pix = buffer_read(data, buffer_u16);
            
            //draw_set_alpha(CLUT[(pix >> 12) & $F, 1]);
            draw_point_colour((4 * xx) + 3, yy, CLUT[(pix >> 12) & $F, 0]);
            
            //draw_set_alpha(CLUT[(pix >> 8) & $F, 1]);
            draw_point_colour((4 * xx) + 2, yy, CLUT[(pix >> 8) & $F, 0]);
            
            //draw_set_alpha(CLUT[(pix >> 4) & $F, 1]);
            draw_point_colour((4 * xx) + 1, yy, CLUT[(pix >> 4) & $F, 0]);
            
            //draw_set_alpha(CLUT[(pix >> 0) & $F, 1]);
            draw_point_colour((4 * xx) + 0, yy, CLUT[(pix >> 0) & $F, 0]);
        }
    }
    surface_reset_target();
    draw_set_alpha(1);
    
    
    //
    //Get BG from Surface
    //
    var BACK = background_create_from_surface(SURF, 0, 0, imageW << 2, imageH, false, false);
    
    surface_free(SURF);
    CLUT = -1;
    
    //
    // Make TIM struct
    //
    var TIMS = array_create(3);
    TIMS[0] = BACK;
    TIMS[1] = imageX;
    TIMS[2] = imageY;
    
    ds_list_add(IMAGE, TIMS);
}

return IMAGE;
