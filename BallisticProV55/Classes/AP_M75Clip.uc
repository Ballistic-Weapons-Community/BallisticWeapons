//=============================================================================
// AP_M75Clip.
//
// 2 x 7 round clip for the M75.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M75Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=14
     InventoryType=Class'BallisticProV55.Ammo_20mmRailgun'
     PickupMessage="You picked up railgun slugs."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.M75Clip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
