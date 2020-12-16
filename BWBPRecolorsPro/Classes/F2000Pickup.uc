class F2000Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-IronArctic');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-EOTech-RDS');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M900.M900MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-IronArctic');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-EOTech-RDS');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M900.M900MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MARS.MARS3_Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARS3_Pickup'
     InventoryType=Class'BWBPRecolorsPro.F2000AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the MARS-3 'Snowstorm' XII."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARS3_Pickup'
     Physics=PHYS_None
     DrawScale=0.2
     CollisionHeight=4.000000
}
