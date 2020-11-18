//=============================================================================
// AP_Laser.
//
// 2 20 round chargers for the LS-14
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_XM20Laser extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=60
     InventoryType=Class'BWBPOtherPackPro.Ammo_XM20Laser'
     PickupMessage="You got 60 XM-20 energy cells."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.LaserCarbine.LS14AmmoPickup'
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
