///OBJWriteTexcoord(file, face);

//Calculate texcoord factors
var TSBFN = (argument1[7] & $1F);
var TexOX = (256 * (TSBFN % 16)) / 4096;
var TexOY = (256 * floor(TSBFN/16)) / 512;
var TexSW = 0.0625;
var TexSH = 0.5;          

file_text_write_string(argument0, "vt ");
file_text_write_real(argument0, TexOX + (argument1[0] * TexSW));
file_text_write_real(argument0, 1 - (TexOY + (argument1[1] * TexSH)));
file_text_writeln(argument0);

file_text_write_string(argument0, "vt ");
file_text_write_real(argument0, TexOX + (argument1[2] * TexSW));
file_text_write_real(argument0, 1 - (TexOY + (argument1[3] * TexSH)));
file_text_writeln(argument0);

file_text_write_string(argument0, "vt ");
file_text_write_real(argument0, TexOX + (argument1[4] * TexSW));
file_text_write_real(argument0, 1 - (TexOY + (argument1[5] * TexSH)));
file_text_writeln(argument0);
