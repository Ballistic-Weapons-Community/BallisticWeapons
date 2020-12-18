//=============================================================================
// AP_SMRTGrenade.
//
// ONES boxes of 8 HE shells. Don't mess with texas.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SMRTGrenade extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=8
     InventoryType=Class'BWBPRecolorsPro.Ammo_Longhorn'
     PickupMessage="You picked up a box of Longhorn grenades."
     PickupSound=Sound'PackageSounds4ProExp.LAW.Law-TubeLock'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Longhorn.LonghornAmmo'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
