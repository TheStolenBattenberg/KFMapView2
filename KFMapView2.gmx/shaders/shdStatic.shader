//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec2 in_Texcoord;

varying vec2 vTexcoord;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    vTexcoord = in_Texcoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 vTexcoord;

uniform float uAlpha;

void main()
{
    gl_FragColor = vec4(texture2D(gm_BaseTexture, vTexcoord).rgb, uAlpha);
}

