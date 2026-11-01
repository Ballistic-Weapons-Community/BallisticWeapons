//UT2004 health base with new staticmesh
//to automatically convert all HealthChargers in a level to have this mesh, use the editor console command "NewPickupBases"
class NewHealthCharger extends HealthCharger;

defaultproperties
{
	StaticMesh=2k4chargerMESHES.HealthChargerMESH-DS
	PrePivot=(Z=2.5)
	DrawScale=0.45
}
