///buffer_load_ns(fileAbsolutePath);

var size = external_call(global.filesize, argument0);
var buff = buffer_create(size, buffer_fixed, 1);

external_call(global.bufLoadNS, buffer_get_address(buff), size, argument0);

return buff;
