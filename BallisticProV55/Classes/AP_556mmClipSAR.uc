//=============================================================================
// AP_556mmClip.
//
// A 30 round 5.56mm magazine. Duplicate exists for the SAR12 ammo count
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_556mmClipSAR extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=64
     InventoryType=Class'BallisticProV55.Ammo_556mmSAR'
     PickupMessage="You got two 5.56mm magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.M50Magazine'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
