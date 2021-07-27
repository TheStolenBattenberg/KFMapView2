///MAP2Load(tfile, id);

//Get T Data
var offs = argument0[@ 0];
var data = argument0[@ 1];

//Get F Data
var fOff = offs[| argument1];

buffer_seek(data, buffer_seek_start, fOff);


//Read Entity Class
var EntityClass = ds_list_create();
var ECEnd = (fOff + buffer_read(data, buffer_u32)) + 4;

repeat(40)
{
    var EC = buffer_read(data, buffer_u8);
        
    //Skip nearly all data
    buffer_seek(data, buffer_seek_relative, 119);
        
    ds_list_add(EntityClass, EC);
}

buffer_seek(data, buffer_seek_start, ECEnd);

//Read Entity Instance
var EntityInstance = ds_list_create();
var EIEnd = (ECEnd + buffer_read(data, buffer_u32)) + 4;

repeat(200)
{
    var EI = array_create(12);
    
    EI[0] = buffer_read(data, buffer_u8);   //Respawn Mode
    EI[1] = buffer_read(data, buffer_u8);   //Entity Class
    EI[2] = buffer_read(data, buffer_u8);   //Non Random Z
    EI[3] = 79 - buffer_read(data, buffer_u8);   //Tile X
    EI[4] = buffer_read(data, buffer_u8);   //Tile Y
    EI[5] = buffer_read(data, buffer_u8);   //Respawn Chance
    EI[6] = buffer_read(data, buffer_u8);   //Drop ID
    EI[7] = clamp(buffer_read(data, buffer_u8) -1, 0, 1);   //Layer
    EI[8] = 360 - (360 * (buffer_read(data, buffer_s16) / 4096));  //Rotation
    EI[9] = buffer_read(data, buffer_s16);  //Fine X
    EI[10] = buffer_read(data, buffer_s16); //Fine Y
    EI[11] = buffer_read(data, buffer_s16); //Fine Z
        
    if(EI[3] < 0 || EI[4] > 79)
    {
        EI = -1;
        continue;
    }
    
    ds_list_add(EntityInstance, EI);
}

buffer_seek(data, buffer_seek_start, EIEnd);

//Read Object Instance
var ObjectInstance = ds_list_create();
var TriggerInstance = ds_list_create();

//
// HACK !!!
//  Skip unknown struct in KFIII games
//
if(GameVersion >= KFVersion.KFIIIJpRev0)
{
    EIEnd = (EIEnd + buffer_read(data, buffer_u32)) + 4;
    buffer_seek(data, buffer_seek_start, EIEnd);
}
var OIEnd = (EIEnd + buffer_read(data, buffer_u32)) + 4;

repeat(350)
{
    var OI = array_create(9);
    
    OI[0] = clamp(buffer_read(data, buffer_u8) -1, 0, 1);   //Layer ID
    OI[1] = 79 - buffer_read(data, buffer_u8);    //X
    OI[2] = buffer_read(data, buffer_u8);         //Y
    OI[3] = buffer_read(data, buffer_u8);         //???
    OI[4] = buffer_read(data, buffer_u16);        //Object ID
    OI[5] = 360 - (360 * (buffer_read(data, buffer_s16) / 4096)); //Rotation
    OI[6] = buffer_read(data, buffer_s16);        //Fine X
    OI[7] = buffer_read(data, buffer_s16);        //Fine Y
    OI[8] = buffer_read(data, buffer_s16);        //Fine Z
    
    for(var i = 0; i < 10; ++i)
        OI[9 + i] = buffer_read(data, buffer_u8);
    
    if(OI[0] == $FF || OI[1] < 0 || OI[2] > 79 || OI[0] > 1 || OI[0] < 0)
    {
        OI = -1;
        continue;    
    }
    
    //
    // Double Hack:
    //  Move Trigger OBJs to a different list
    //  KFIII Triggers have a different ID
    //
    if(GameVersion < KFVersion.KFIIIJpRev0)
    {
        if(OI[4] == 240)
        {
            OI[20] = false;
            ds_list_add(TriggerInstance, OI);
        }else{
            ds_list_add(ObjectInstance, OI);    
        }   
    }else{
        if(OI[4] == 280)
        {
            OI[20] = false;
            ds_list_add(TriggerInstance, OI);
        }else{
            ds_list_add(ObjectInstance, OI);    
        }      
    }
}

//
// HACK:
//  Move OBJ ID 247 to the start, as it is the sky box...
//
for(var i = 0; i < ds_list_size(ObjectInstance); ++i)
{
    var OI = ObjectInstance[| i];
    
    if(OI[4] == 247)
    {
        var T = ObjectInstance[| 0];
        ObjectInstance[| 0] = OI;
        ObjectInstance[| i] = T;
    }
    
    if(OI[4] == 248)
    {
        var T = ObjectInstance[| 1];
        ObjectInstance[| 1] = OI;
        ObjectInstance[| i] = T;
    }
}

buffer_seek(data, buffer_seek_start, OIEnd);

//Read SFX Instance
var SFXInstance = ds_list_create();
var SXEnd = (OIEnd + buffer_read(data, buffer_u32)) + 4;

buffer_seek(data, buffer_seek_start, SXEnd);

//Build MAP2 struct
var Mp2 = array_create(4);
    Mp2[0] = EntityClass;
    Mp2[1] = EntityInstance;
    Mp2[2] = ObjectInstance;
    Mp2[3] = SFXInstance;
    Mp2[4] = TriggerInstance;
    
return Mp2;

