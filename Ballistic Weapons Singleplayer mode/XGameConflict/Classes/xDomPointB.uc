//=============================================================================
// xDomPointB.
// For Double Domination (xDoubleDom) matches.
//=============================================================================
class xDomPointB extends xDomPoint
	placeable;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

    if (Level.NetMode != NM_Client)
    {
        DomLetter = Spawn(class'XGame.xDomB',self,,Location+EffectOffset,Rotation);
        DomRing = Spawn(class'XGame.xDomRing',self,,Location+EffectOffset,Rotation);    
    }
        
    SetShaderStatus(CNeutralState[0],SNeutralState,CNeutralState[1]);
}

defaultproperties
{
	PrimaryTeam=0
	ObjectiveName="Point B"
    PointName="B"
    ControlEvent=xDomMonitorB
    Skins(1)=Combiner'XGameShaders.DomShaders.DomPointBCombiner'
    DomCombiner(0)=Combiner'XGameShaders.DomShaders.DomBCombiner'
    DomShader=Shader'XGameShaders.DomShaders.PulseBShader'
}
