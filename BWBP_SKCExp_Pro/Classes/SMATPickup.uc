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
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_SKCExp_Pro.SMATLauncher'
     RespawnTime=20.000000
     PickupMessage="You picked up the SM-AT/AA Recoilless Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5PickupHi'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=6.000000
}
