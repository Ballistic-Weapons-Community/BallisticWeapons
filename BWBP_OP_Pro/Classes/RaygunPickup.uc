class RaygunPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{

}

simulated function UpdatePrecacheMaterials()
{

}
simulated function UpdatePrecacheStaticMeshes()
{

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Raygun.RaygunPickupLo'
     InventoryType=Class'BWBP_OP_Pro.Raygun'
     RespawnTime=20.000000
     PickupMessage="You picked up the E58 Raygun."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Raygun.RaygunPickupHi'
     Physics=PHYS_None
     DrawScale=1.250000
     CollisionHeight=4.500000
}
