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
     AmmoAmount=90
     InventoryType=Class'BallisticProV55.Ammo_MRL'
     PickupMessage="You picked up 90 Peacemaker rockets."
     PickupSound=Sound'BallisticSounds2.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BWBP4-Hardware.MRL.JL21-Ammo'
     DrawScale=0.400000
     PrePivot=(Z=-10.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
