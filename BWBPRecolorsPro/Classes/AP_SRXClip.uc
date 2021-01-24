//=============================================================================
// AP_RS8Clip.
//
// 2 clips for th RS8.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SRXClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=60
     InventoryType=Class'BWBPRecolorsPro.Ammo_SRXBullets'
     PickupMessage="You picked up two SRX magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.RS8.RS8Clips'
     DrawScale=0.300000
     PrePivot=(Z=-12.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
