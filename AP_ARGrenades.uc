//=============================================================================
// AP_M900Grenades.
//
// 3 grenades for the M900.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_ARGrenades extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=3
     InventoryType=Class'BallisticJiffyPack.Ammo_ARGrenades'
     PickupMessage="You picked up 3 grenades for the M900."
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.M900Grenades'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=10.000000
}
