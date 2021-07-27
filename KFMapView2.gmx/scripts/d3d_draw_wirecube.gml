///d3d_draw_wirecube(x, y, z);

draw_set_colour(c_red);
d3d_model_draw(global.MDLWIRECUBE, argument0, argument1, argument2, -1);
draw_set_colour(c_yellow);

draw_set_alpha(0.25);
d3d_draw_block(0, 0, 0, 2048, -4096, 2048, -1, 1, 1);
draw_set_alpha(1.0);

draw_set_colour(c_white);
