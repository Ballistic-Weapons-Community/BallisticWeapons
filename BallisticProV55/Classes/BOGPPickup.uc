//=============================================================================
// BOGPPickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPPickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.BOGP.BOGP_Main');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_Grenade');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.BOGP.BOGP_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_PickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_AmmoPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_Grenade');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BallisticProV55.BOGPPistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the BORT-85 grenade pistol."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_PickupHi'
     Physics=PHYS_None
     DrawScale=0.500000
     CollisionHeight=4.000000
}
