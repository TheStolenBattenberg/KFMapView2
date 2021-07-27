///OBJWriteNormal(file, vertex);

file_text_write_string(argument0, "vn ");
file_text_write_real(argument0, argument1[0]);
file_text_write_real(argument0, argument1[1]);
file_text_write_real(argument0, argument1[2]);
file_text_writeln(argument0);

