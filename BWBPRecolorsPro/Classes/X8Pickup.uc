//=============================================================================
// X8 Ballistic Knife pickup.
//=============================================================================
class X8Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.AK490.Knife-Misc');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.AK490.AK490-Misc');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.X8.X8Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.AK490.Knife-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.AK490.AK490-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.X8.X8Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.X8.X8Proj');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.X8.X8Pickup'
     PickupDrawScale=0.270000
     InventoryType=Class'BWBPRecolorsPro.X8Knife'
     RespawnTime=10.000000
     PickupMessage="You picked up the X8 ballistic knife."
     PickupSound=Sound'BallisticSounds2.Knife.KnifePutaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.X8.X8Pickup'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.000000
}
