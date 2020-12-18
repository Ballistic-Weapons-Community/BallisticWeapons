//=============================================================================
// AP_XK2Clip.
//
// 2 40 round 9mm clips for the XK2.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_XK2Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=100
     InventoryType=Class'BallisticProV55.Ammo_9mm'
     PickupMessage="You picked up XK2 submachine gun rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.XK2Clip'
     DrawScale=0.250000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
