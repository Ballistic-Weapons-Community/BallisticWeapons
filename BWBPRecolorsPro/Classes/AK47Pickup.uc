//=============================================================================
// AK47Pickup.
//=============================================================================
class AK47Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AK490.AK490-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AK490.AK490-Misc');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AK490.AK490-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AK490.AK490-Misc');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.AK490.AK490Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.AK490.AK490AmmoPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.AK490.AK490Pickup'
     PickupDrawScale=0.140000
     InventoryType=Class'BWBPRecolorsPro.AK47AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the AK-490 battle rifle."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.AK490.AK490Pickup'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.000000
}
