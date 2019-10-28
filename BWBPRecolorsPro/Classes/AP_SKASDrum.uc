//=============================================================================
// AP_SKASDrum
//
// Two ammunition drums for the SKAS-21
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SKASDrum extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=20
     InventoryType=Class'BWBPRecolorsPro.Ammo_SKASShells'
     PickupMessage="You picked up SKAS drums."
     PickupSound=Sound'BallisticSounds2.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.SKAS.SKASShotgunAmmo'
     DrawScale=0.600000
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
