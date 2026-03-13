//=============================================================================
// SuperHealthCharger.
//=============================================================================
class SuperHealthCharger extends xPickupBase;

#exec OBJ LOAD FILE=2k4ChargerMeshes.usx

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
    StaticMesh=XGame_rc.HealthChargerMesh
    Texture=None
    PowerUp=SuperHealthPack
    SpawnHeight=+60.0000

    NewStaticMesh=2k4chargerMESHES.HealthChargerMESH-DS
    NewPrePivot=(Z=2.75)
    NewDrawScale=0.7
}
