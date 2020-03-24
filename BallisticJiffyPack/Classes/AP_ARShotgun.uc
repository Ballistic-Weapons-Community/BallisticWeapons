//=============================================================================
// AP_8Gauge.
//
// Two boxes of 6 HE shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_ARShotgun extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=60
     InventoryType=Class'BallisticJiffyPack.Ammo_ARShotgun'
     PickupMessage="You picked up 3 magazines for the RCS-715 Shotgun."
     PickupSound=Sound'BallisticSounds2.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBPJiffyPackStatic.TacticalBuster.AA12AmmoPickup'
     DrawScale=2.000000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
