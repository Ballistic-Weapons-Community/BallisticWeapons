//=============================================================================
// AP_MRLRockets.
//
// Ammo pickup for MRL
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MRLRockets extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=54
     InventoryType=Class'BallisticProV55.Ammo_MRL'
     PickupMessage="You picked up 54 Peacemaker rockets."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.JL21-Ammo'
     DrawScale=0.400000
     PrePivot=(Z=-10.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
