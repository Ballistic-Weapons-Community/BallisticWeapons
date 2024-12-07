//=============================================================================
// X4Pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class X4Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.X3.KnifeA1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.X4.X4_PickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.X4.X4_PickupHi');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.X4.X4_PickupLo'
     PickupDrawScale=0.300000
     InventoryType=Class'BallisticProV55.X4Knife'
     RespawnTime=10.000000
     PickupMessage="You picked up the X4 knife."
     PickupSound=Sound'BW_Core_WeaponSound.Knife.KnifePutaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.X4.X4_PickupHi'
     Physics=PHYS_None
     DrawScale=0.200000
     CollisionHeight=4.000000
}
