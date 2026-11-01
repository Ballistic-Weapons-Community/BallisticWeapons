//=============================================================================
// xRedFlagBase.
//=============================================================================
class xRedFlagBase extends xRealCTFBase
	placeable;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    
    if ( Level.NetMode != NM_DedicatedServer )
    {
        Spawn(class'XGame.xCTFBase',self,,Location-BaseOffset,rot(0,0,0));
    }
}

defaultproperties
{
	DefenseScriptTags=DefendRedFlag
    DefenderTeamIndex=0    
    ObjectiveName="Red Flag"
    FlagType=class'XGame.xRedFlag'
	Skins(0)=XGameShaders2004.CTFShaders.RedFlagShader_F
}