//=============================================================================
// UDamageCharger.
//=============================================================================
class UDamageCharger extends xPickupBase;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetLocation(Location + vect(0,0,-1)); // adjust because reduced drawscale
}

defaultproperties
{
	bDelayedSpawn=true
    DrawScale=0.8
    DrawType=DT_StaticMesh
    StaticMesh=XGame_rc.ShieldChargerMesh
    Texture=None
    PowerUp=UDamagePack
    SpawnHeight=+60.0000
}
