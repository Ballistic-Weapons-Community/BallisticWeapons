//=============================================================================
// AP_50IncDrum.
//
// 50 Rounds of 50 cal incendiary ammo for the FSSG-50 and FG50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_50IncDrum extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=40
     InventoryType=Class'BWBPRecolorsPro.Ammo_50IncDrum'
     PickupMessage="You picked up an FG50 drum."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.MGBoxPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.FG50.FG50AmmoPickup'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=5.500000
}
