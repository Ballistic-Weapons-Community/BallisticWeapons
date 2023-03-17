//=============================================================================
// AP_XK2Clip.
//
// 2 40 round 9mm clips for the XK2.
//
// by Nolan "Dark Carnivour" Richert. Uses Sarge's CYLO ammo pickup.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_T9CNClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=36
     InventoryType=Class'BallisticProV55.Ammo_GRSNine'
     PickupMessage="You got 2 18 round 9mm clips"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Glock.Glock-Ammo'
     DrawScale=0.160000
	 PrePivot=(Z=50.000000)
     CollisionRadius=8.000000
     CollisionHeight=16.00000
}
