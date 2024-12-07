//=============================================================================
// SMATPickup.
//=============================================================================
class SMATPickup extends BallisticWeaponPickup
	placeable;

simulated function UpdatePrecacheMaterials()
{
// todo: add this stuff
}
simulated function UpdatePrecacheStaticMeshes()
{
// todo: add this stuff
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.SMAT.SMATPickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_SKC_Pro.SMATLauncher'
     RespawnTime=20.000000
     PickupMessage="You picked up the SM-AT/AA Recoilless Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.SMAT.SMATPickupHi'
     Physics=PHYS_None
     DrawScale=0.440000
     CollisionHeight=6.000000
}
