//=============================================================================
// M46Pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46Pickup extends BallisticWeaponPickup
	placeable;
	
//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-AR.OA-AR_Clip');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-AR.OA-AR_Grenade');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-AR.OA-AR_GrenadeLauncher');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-AR.OA-AR_Scope');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR.OA-AR_Grenade');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-AR.OA-AR_Clip');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-AR.OA-AR_Grenade');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-AR.OA-AR_GrenadeLauncher');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-AR.OA-AR_Scope');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR.OA-AR_Grenade');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR.OA-AR_Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR.OA-AR_PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR.OA-AR_PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware_25.OA-AR.OA-AR_PickupLo'
     PickupDrawScale=0.400000
     InventoryType=Class'BallisticProV55.M46AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the M46A1 scoped combat rifle."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticHardware_25.OA-AR.OA-AR_PickupHi'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.000000
}
