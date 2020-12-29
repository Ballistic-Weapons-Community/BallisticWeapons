//=============================================================================
// AP_E23Clip
//
// Pickup for E23 clips
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_E23Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=84
     InventoryType=Class'BallisticProV55.Ammo_E23Cells'
     PickupMessage="You picked up two ViPeR energy cells."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.A73CellPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.VPR.VPR-Ammo'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
