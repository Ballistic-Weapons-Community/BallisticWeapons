//=============================================================================
// AP_R78Clip.
//
// 2 x 7 round clip for the R78.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M99Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=5
     InventoryType=Class'BWBP_JCF_Pro.Ammo_50ECSRifle'
     PickupMessage="You got 3 rounds of .55 Cal Rifle ammo for the M99-ECS"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.R78Clip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
