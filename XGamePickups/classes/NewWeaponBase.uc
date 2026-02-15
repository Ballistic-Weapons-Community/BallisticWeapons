//UT2004 weapon base with new staticmesh
//to automatically convert all xWeaponBases in a level to have this mesh, use the editor console command "NewPickupBases"
class NewWeaponBase extends xWeaponBase;

defaultproperties
{
	StaticMesh=2k4chargerMESHES.WeaponChargerMESH-DS
	PrePivot=(Z=3.7)
	DrawScale=0.5
}
