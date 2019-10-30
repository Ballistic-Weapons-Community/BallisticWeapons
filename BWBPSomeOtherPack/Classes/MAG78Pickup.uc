//=============================================================================
// EKS43Pickup.
//=============================================================================
class MAG78Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.EKS43.Katana');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.EKS43.Katana');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.EKS43.KatanaPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.EKS43.KatanaPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.EKS43.KatanaPickupLo'
     PickupDrawScale=0.200000
     InventoryType=Class'BWBPSomeOtherPack.MAG78Longsword'
     RespawnTime=10.000000
     PickupMessage="You picked up the MAG-SAW longsword."
     PickupSound=Sound'BallisticSounds2.EKS43.EKS-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.EKS43.KatanaPickupHi'
     Physics=PHYS_None
     DrawScale=0.200000
     CollisionHeight=4.000000
}
