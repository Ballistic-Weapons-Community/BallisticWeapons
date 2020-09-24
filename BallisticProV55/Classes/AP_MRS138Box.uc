//=============================================================================
// AP_MRS138Box.
//
// A box owith 15 MRS138 shells
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MRS138Box extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=18
     InventoryType=Class'BallisticProV55.Ammo_MRS138Shells'
     PickupMessage="You picked up a box of 18 MRS-138 shells."
     PickupSound=Sound'BallisticSounds2.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWAddPack-RS-Hardware.MRS138.MRS138ShellBox'
     DrawScale=0.250000
     PrePivot=(Z=32.000000)
     CollisionRadius=8.000000
     CollisionHeight=6.000000
}
