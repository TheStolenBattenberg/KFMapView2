///D3DModelCreateWirecube();

//
// Vertex Format
//
vertex_format_begin() {
    vertex_format_add_position_3d();
    vertex_format_add_textcoord();
}
global.VF_MO = vertex_format_end();

global.MDLWIRECUBE = d3d_model_create();

d3d_model_primitive_begin(global.MDLWIRECUBE, pr_linelist);

//Bottom
d3d_model_vertex(global.MDLWIRECUBE, 0, 0, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, 0, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, 0, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, 0, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 2048, 0, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 0, 0, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 0, 0, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 0, 0, 0);

//Top
d3d_model_vertex(global.MDLWIRECUBE, 0, -4096, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, -4096, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, -4096, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, -4096, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 2048, -4096, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 0, -4096, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 0, -4096, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 0, -4096, 0);

//Sides
d3d_model_vertex(global.MDLWIRECUBE, 0, -4096, 0);
d3d_model_vertex(global.MDLWIRECUBE, 0, 0, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, -4096, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, 0, 0);
d3d_model_vertex(global.MDLWIRECUBE, 2048, -4096, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 2048, 0, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 0, -4096, 2048);
d3d_model_vertex(global.MDLWIRECUBE, 0, 0, 2048);

d3d_model_primitive_end(global.MDLWIRECUBE);

return global.MDLWIRECUBE;
