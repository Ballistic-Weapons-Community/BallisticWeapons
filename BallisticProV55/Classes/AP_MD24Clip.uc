//=============================================================================
// AP_MD24Clip.
//
// Clips for the MD24.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MD24Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=24
     InventoryType=Class'BallisticProV55.Ammo_MD24Clip'
     PickupMessage="You picked up two MD24 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MD24.MD24_Ammo'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
