//=============================================================================
// AP_8Gauge.
//
// Two boxes of 6 HE shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_8Gauge extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=12
     InventoryType=Class'BWBPRecolorsPro.Ammo_8GaugeHE'
     PickupMessage="You picked up 12 rounds of HE shotgun shells"
     PickupSound=Sound'BallisticSounds2.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.SK410.SK410Ammo'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
