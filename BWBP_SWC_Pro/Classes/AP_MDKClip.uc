//=============================================================================
// AP_XK2Clip.
//
// 2 40 round 9mm clips for the XK2.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MDKClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=52
     InventoryType=Class'BWBP_SWC_Pro.Ammo_MDK9mm'
     PickupMessage="You picked up MDK SubMachine gun rounds."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SWC_Static.MDK.MDK_SM_Ammo'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
