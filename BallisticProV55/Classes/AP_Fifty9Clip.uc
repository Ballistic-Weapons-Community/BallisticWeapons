//=============================================================================
// AP_Fifty9Clip.
//
// 2 45 round 9mm clips for the Fifty-9.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_Fifty9Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=90
     InventoryType=Class'BallisticProV55.Ammo_FiftyNine'
     PickupMessage="You picked up two Fifty-9 magazines."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Fifty9.Fifty9Clips'
     DrawScale=0.350000
     PrePivot=(Z=8.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
