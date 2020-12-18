//=============================================================================
// AK47Pickup.
//=============================================================================
class AK47Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.AK490.AK490-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.AK490.AK490-Misc');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.AK490.AK490-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.AK490.AK490-Misc');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.AK490.AK490Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.AK490.AK490AmmoPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.AK490.AK490Pickup'
     PickupDrawScale=0.140000
     InventoryType=Class'BWBPRecolorsPro.AK47AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the AK-490 battle rifle."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.AK490.AK490Pickup'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.000000
}
