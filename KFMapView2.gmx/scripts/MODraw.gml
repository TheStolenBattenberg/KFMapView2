///MODraw(MO);

var MOFile = moModelMap[argument0];
if(MOFile == -1)
{
    if(GameVersion == KFVersion.KFIIJpRev0)
    {
        MOFile = MOLoad(MO, argument0);
    }
    else
    {
        if(argument0 > 409)
        {
            MOFile = MOLoad(MOF, (argument0 - 410) + 48); //MOFOffset
        }else{
            MOFile = MOLoad(MO, argument0);
        }
    }
}

if(MOFile[1] == -1)
    MOBuild(MOFile);

vertex_submit(MOFile[1], pr_trianglelist, psxVRAMTex);    
    

moModelMap[@ argument0] = MOFile;
