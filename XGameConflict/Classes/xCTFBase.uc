//=============================================================================
// xCTFBase.
// For decoration only, this actor serves no game-related purpose!
//=============================================================================
class xCTFBase extends Decoration
	notplaceable;

defaultproperties
{   
	bCollideWhenPlacing=false
	bObsolete=true // temp - shouldn't be placed in levels
	RemoteRole=ROLE_None
    StaticMesh=XGame_rc.FlagBaseMesh
    DrawType=DT_StaticMesh
    DrawScale=0.400000
    bCollideWorld=false
    bCollideActors=false
    bStatic=false
    PrePivot=(X=-5.0,Y=0.0,Z=0.0)
}