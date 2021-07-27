///MOBuild(MO);

var MOSTMD = argument0[0];
var MOSMDL = argument0[1];

if(MOSMDL != -1)
    return 0;

MOSMDL = vertex_create_buffer();
vertex_begin(MOSMDL, global.VF_MO);

for(var i = 0; i < ds_list_size(MOSTMD); ++i)
{
    var TMDOBJ = MOSTMD[| i];
    var TMDVCS = TMDOBJ[0];
    var TMDNCS = TMDOBJ[1];
    var TMDPRM = TMDOBJ[2];
    var FACE, VERTEX;
    
    //Build Faces
    for(var j = 0; j < ds_list_size(TMDPRM); ++j)
    {
        FACE = TMDPRM[| j];
        
        //Calculate Texcoord Factors
        var TSBFN = (FACE[7] & $1F);
        var TexOX = (256 * (TSBFN % 16)) / 4096;
        var TexOY = (256 * floor(TSBFN/16)) / 512;
        var TexSW = 0.0625;
        var TexSH = 0.5;
        
        //Vertex 1
        VERTEX = TMDVCS[| FACE[11]];
        vertex_position_3d(MOSMDL, VERTEX[0], VERTEX[1], VERTEX[2]);
        vertex_texcoord(MOSMDL, TexOX + (FACE[0] * TexSW), TexOY + (FACE[1] * TexSH));
        
        //Vertex 2
        VERTEX = TMDVCS[| FACE[12]];
        vertex_position_3d(MOSMDL, VERTEX[0], VERTEX[1], VERTEX[2]);
        vertex_texcoord(MOSMDL, TexOX + (FACE[2] * TexSW), TexOY + (FACE[3] * TexSH));
        
        //Vertex 3
        VERTEX = TMDVCS[| FACE[13]];
        vertex_position_3d(MOSMDL, VERTEX[0], VERTEX[1], VERTEX[2]);
        vertex_texcoord(MOSMDL, TexOX + (FACE[4] * TexSW), TexOY + (FACE[5] * TexSH));
    }
}

vertex_end(MOSMDL);
vertex_freeze(MOSMDL);

argument0[@ 1] = MOSMDL;
