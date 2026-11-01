//=============================================================================
// xRedFlag.
//=============================================================================
class xRedFlag extends CTFFlag;

#exec OBJ LOAD FILE=XGameShaders.utx
#exec OBJ LOAD FILE=XGameShaders2004.utx
#exec OBJ LOAD FILE=TeamSymbols_UT2003.utx

simulated function PostBeginPlay()
{    
    Super.PostBeginPlay();    

    LoopAnim('flag',0.8);
    SimAnim.bAnimLoop = true;  
}

defaultproperties
{
    Mesh=Mesh'XGame_rc.FlagMesh'
    Skins(0)=XGameShaders2004.CTFShaders.RedFlagShader_F
    DrawScale=0.9
    LightHue=0
    TeamNum=0
}
