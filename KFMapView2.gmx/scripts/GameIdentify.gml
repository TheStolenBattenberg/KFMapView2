///GameIdentify();

enum KFVersion
{
    KFIIJpRev0,
    KFIIJpRev1,
    KFIIJpRev2,
    KFIIEuRev0,
    KFIIUsRev0,
       
    KFIIIJpRev0,
    KFIIIJpRev1,
    KFIIIUsRev0,
    KFIIIPilotStyle
}

show_message("Please Select your King's Field (II, III or Pilot Style) GAME.EXE file");

var f = "";
while(f == "")
{
    f = get_open_filename_ext("King's Field II/III/Pilot Style exe|GAME.exe", "GAME.exe", "", "Select GAME.EXE");
}

show_debug_message(f);

//Generate MD5
var tB = buffer_load_ns(f);
var MD5 = buffer_md5(tB, 0, buffer_get_size(tB));

buffer_delete(tB);

switch(MD5)
{
    //KFII
    case "5a1cf7c708182ba9fde0b3986447b2e9":    //EU
    case "bcc3c0b9f837f34e63002c79106c9fa7":    //US
    case "20e673906133201fded29b3af6d7b6cd":    //Rev0
    case "980cec1d5d9e06e104e9a4bfe72296cf":    //Best Of Rev1
        show_debug_message("King's Field II");
        GameReadyKFIIJpRev0(f);
    break;
    
    //KFIII
    case "adae8cdccc6607eaad5016a891e08bfb":    //PILOT STYLE!!! (English Translation)
        show_debug_message("King's Field III");
        GameReadyKFIIIJpRev0(f);
        GameVersion = KFVersion.KFIIIPilotStyle;
    break;
    
    case "34aef4017b8641c43212ba9b02b608af":    //US
    case "a7d8c8722502d6e85604d8d11e01f579":    //Rev1
    case "7eb60d9cb9d4c172e7d91032d5304374":    //Rev0
        show_debug_message("King's Field III");
        GameReadyKFIIIJpRev0(f);
    break;
    
    default:
        show_error("Unsupported King's Field Version! Please report to TheStolenBattenberg with info!", true);
    break;
}
