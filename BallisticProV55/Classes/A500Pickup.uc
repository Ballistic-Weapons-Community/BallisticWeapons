//=============================================================================
// A500Pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500Pickup extends BallisticWeaponPickup
	placeable;
	
#exec OBJ LOAD File=BallisticTextures_25.utx
	
//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidBlast01');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidDrops01');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidSplash01');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidSplat_Large');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidSplat_Small');
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.Reptile_Main');

	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.Reptile.Reptile_MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidBlast01');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidDrops01');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidSplash01');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidSplat_Large');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.AcidSplat_Small');
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.Reptile.Reptile_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.Reptile.Reptile_MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.Reptile.Reptile_Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.Reptile.Reptile_PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.Reptile.Reptile_PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware_25.Reptile.Reptile_PickupLo'
     PickupDrawScale=0.250000
     InventoryType=Class'BallisticProV55.A500Reptile'
     RespawnTime=20.000000
     PickupMessage="You picked up the A500 'Reptile' acid gun."
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BallisticHardware_25.Reptile.Reptile_PickupHi'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.500000
}
