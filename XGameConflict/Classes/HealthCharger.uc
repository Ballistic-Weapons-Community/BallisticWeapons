//=============================================================================
// HealthCharger.
//=============================================================================
class HealthCharger extends xPickupBase;

#exec OBJ LOAD FILE=2k4ChargerMeshes.usx

function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetLocation(Location + vect(0,0,-4)); // adjust because reduced drawscale
}

defaultproperties
{
    DrawScale=0.5
    DrawType=DT_StaticMesh
    StaticMesh=XGame_rc.HealthChargerMesh
    Texture=None
    PowerUp=HealthPack
    SpawnHeight=+45.0000

    NewStaticMesh=2k4chargerMESHES.HealthChargerMESH-DS
    NewPrePivot=(Z=2.5)
    NewDrawScale=0.45
}
