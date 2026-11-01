//=============================================================================
// xDomRing.
//=============================================================================
class xDomRing extends Decoration;

var() Material  RedTeamShader;
var() Material  BlueTeamShader;
var() Material  NeutralShader;

defaultproperties
{   
    StaticMesh=XGame_rc.DOMRing
    Skins(0)=Shader'XGameTextures.SuperPickups.DomGreyS'
    DrawType=DT_StaticMesh
    DrawScale=0.250000
    bCollideWorld=false
    bCollideActors=false
    bStatic=false
    Physics=PHYS_Rotating
	bStasis=false
    RotationRate=(Yaw=-16000,Roll=48000)
    bFixedRotationDir=True
    RedTeamShader=Shader'XGameTextures.SuperPickups.DomRedS'
    BlueTeamShader=Shader'XGameTextures.SuperPickups.DomBlueS'
    NeutralShader=Shader'XGameTextures.SuperPickups.DomGreyS'
    bNetNotify=true
}