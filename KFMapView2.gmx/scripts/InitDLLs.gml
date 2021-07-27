///InitDLLs();

if(os_type == os_windows)
{
    show_debug_message("Initializing BufferExt for Windows...");
    global.bufLoadNS = external_define("BufferExt.dll", "buffer_load_nosandbox", dll_cdecl, ty_real, 3, ty_string, ty_real, ty_string);
    global.filesize = external_define("BufferExt.dll", "file_size", dll_cdecl, ty_real, 1, ty_string);
}else
if(os_type == os_linux) {
    show_debug_message("Initializing BufferExt for Linux...");
    global.bufLoadNS = external_define("BufferExt.so", "buffer_load_nosandbox", dll_cdecl, ty_real, 3, ty_string, ty_real, ty_string);
    global.filesize = external_define("BufferExt.so", "file_size", dll_cdecl, ty_real, 1, ty_string);
}else{
    show_error("Unknown Operating System! How the fuck is this running here!? :D", true);
}

show_debug_message("Done!");
