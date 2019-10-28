//=============================================================================
// AP_GRS9Clip.
//
// Clips for the GRS9.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_GRS9Clip extends BallisticAmmoPickup;

defaultproperties
{
     InventoryType=Class'BallisticProV55.Ammo_GRSNine'
     PickupMessage="You picked up GRS-9 rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP4-Hardware.Glock.Glock-Ammo'
     DrawScale=0.160000
     PrePivot=(Z=50.000000)
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
