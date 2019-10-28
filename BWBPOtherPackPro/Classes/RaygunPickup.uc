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
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.Raygun.RaygunPickupLow'
     InventoryType=Class'BWBPOtherPackPro.Raygun'
     RespawnTime=20.000000
     PickupMessage="You picked up the E58 Raygun."
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.Raygun.RaygunPickup'
     Physics=PHYS_None
     DrawScale=1.250000
     CollisionHeight=4.500000
}
