//=============================================================================
// AP_LS14Rockets
//
// 2 rocket packs for the LS14 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_LS14Rockets extends BallisticAmmoPickup;

simulated event PreBeginplay()
{
}

defaultproperties
{
     AmmoAmount=6
     InventoryType=Class'BWBP_SKC_Pro.Ammo_LS14Rocket'
     PickupMessage="You picked up 6 LS-14 rockets."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.M900Grenades'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=10.000000
}
