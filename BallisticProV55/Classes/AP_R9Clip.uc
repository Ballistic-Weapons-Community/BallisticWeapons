//=============================================================================
// AP_R9Clip.
//
// 2 x 10 round clips for the R9 Rifle.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_R9Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=12
     InventoryType=Class'BallisticProV55.Ammo_348Rifle'
     PickupMessage="You picked up ranger rifle rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.R78Clip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
