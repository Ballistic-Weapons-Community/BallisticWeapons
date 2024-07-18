//=============================================================================
// AP_R78Clip.
//
// 2 x 7 round clip for the R78.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_R9000EClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=24
     InventoryType=Class'BWBP_APC_Pro.Ammo_42ERifle'
     PickupMessage="You picked up .42E sniper rifle rounds."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_CC_Static.R9000E.R9000EClip'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
