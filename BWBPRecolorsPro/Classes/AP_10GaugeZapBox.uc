//=============================================================================
// AP_10GaugeZapBox.
//
// A box of 18 10 gauge dartshotgun shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_10GaugeZapBox extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=6
     InventoryType=Class'BWBPRecolorsPro.Ammo_10GaugeZap'
     PickupMessage="You picked up 6 electroshock MK781 shells."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.M763ShellBox'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
