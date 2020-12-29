//=============================================================================
// AP_FlamerGas.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_FlamerGas extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=75
     InventoryType=Class'BallisticProV55.Ammo_FlamerGas'
     PickupMessage="You picked up a tank of flamethrower gas."
     PickupSound=Sound'BW_Core_WeaponSound.RX22A.RX22A-AmmoPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.RX22A.FlamerAmmo'
     DrawScale=0.300000
     PrePivot=(Z=4.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
