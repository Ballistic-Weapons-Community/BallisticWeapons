//=============================================================================
// AP_SARClip.
//
// 2 x 40 round clips for the SAR 12.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SARClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=80
     InventoryType=Class'BallisticProV55.Ammo_556mm'
     PickupMessage="You picked up two S-AR 12 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.SAR.SARClips'
     DrawScale=0.150000
     PrePivot=(Z=10.000000)
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
