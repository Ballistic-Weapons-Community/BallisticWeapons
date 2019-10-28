//=============================================================================
// AP_R78Clip.
//
// 2 x 7 round clip for the R78.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_R78Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=14
     InventoryType=Class'BallisticProV55.Ammo_42Rifle'
     PickupMessage="You picked up .42 sniper rifle rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.R78Clip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
