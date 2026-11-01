//=============================================================================
// ShieldCharger.
//=============================================================================
class ShieldCharger extends xPickupBase;

function PostbeginPlay()
{
	if ( (Level.Title ~= "IronDeity") && (Name == 'ShieldCharger0') )
	{	
		SpawnHeight = 130.0;
		Super.PostBeginPlay();
		if ( myPickup != None )
			myPickup.PrePivot.Z = 85.0; 
		return;
	}
	
	Super.PostBeginPlay();
	SetLocation(Location + vect(0,0,-2)); // adjust because reduced drawscale
}

defaultproperties
{
	bDelayedSpawn=true
    DrawScale=0.7
    DrawType=DT_StaticMesh
    StaticMesh=XGame_rc.ShieldChargerMesh
    Texture=None
    PowerUp=ShieldPack
    SpawnHeight=+45.0000
}
