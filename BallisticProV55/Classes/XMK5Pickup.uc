//=============================================================================
// XMK5Pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class XMK5Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Clip');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Dart');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Darter');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Shield');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Sight');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Sight_SI');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Main');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR_Grenade');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Clip');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Dart');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Darter');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Shield');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Sight');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Sight_SI');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.OA-SMG.OA-SMG_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR_Grenade');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR_Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR_PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-AR_PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BallisticProV55.XMK5SubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the XMk5 submachine gun."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_PickupHi'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.000000
}
