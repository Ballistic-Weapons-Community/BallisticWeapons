//=============================================================================
// PlayerLight.
//=============================================================================
class PlayerLight extends ScaledSprite;

var() float ExtinguishTime;

singular function BaseChange();

defaultproperties
{
	bHardAttach=true
    bHidden=false
    DrawType=DT_Sprite
    Style=STY_Additive
    bStatic=false
    DrawScale=0.15
	RemoteRole=ROLE_None

    bStasis=false
    bShouldBaseAtStartup=false
    Mass=0.0
    bCollideActors=false
    
    ExtinguishTime=1.5
}
