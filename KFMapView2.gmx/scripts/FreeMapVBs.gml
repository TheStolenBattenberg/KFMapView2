///FreeMapVBs();

for(var i = 0; i < 8; ++i)
{
    for(var j = 0; j < 8; ++j)
    {
        if(chunkedMapDataO[# i, j] != -1)
            vertex_delete_buffer(chunkedMapDataO[# i, j]);
            
        if(chunkedMapDataT[# i, j] != -1)
            vertex_delete_buffer(chunkedMapDataT[# i, j]);
    }
}
