//=============================================================================
// AP_42MachineGun
//
// A 42 round .42 magazine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_42MachineGun extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=30
     InventoryType=Class'BWBPRecolorsPro.Ammo_42HVG'
     PickupMessage="You got three Gauss magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.M50Magazine'
     DrawScale=0.400000
     Skins(0)=Texture'BWBP_SKC_Tex.M30A2.M30A2-SB'
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
