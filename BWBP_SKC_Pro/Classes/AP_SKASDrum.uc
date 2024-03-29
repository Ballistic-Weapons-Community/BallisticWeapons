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
     AmmoAmount=72
     InventoryType=Class'BallisticProV55.Ammo_MRS138Shells'
     PickupMessage="You picked up a SKAS drum."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.SKAS.SKASShotgunAmmo'
     DrawScale=0.600000
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
