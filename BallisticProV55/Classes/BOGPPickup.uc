//=============================================================================
// BOGPPickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPPickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BallisticTextures_25.BOGP.BOGP_Main');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.BOGP.BOGP_Grenade');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticTextures_25.BOGP.BOGP_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.BOGP.BOGP_PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.BOGP.BOGP_PickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.BOGP.BOGP_AmmoPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.BOGP.BOGP_Grenade');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware_25.BOGP.BOGP_PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BallisticProV55.BOGPPistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the BORT-85 grenade pistol."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BallisticHardware_25.BOGP.BOGP_PickupHi'
     Physics=PHYS_None
     DrawScale=0.500000
     CollisionHeight=4.000000
}
