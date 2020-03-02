//=============================================================================
// AP_6Magnum.
//
// 12 .44 magnum rounds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_6MagnumScope extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=14
     InventoryType=Class'BWBPRecolorsPro.Ammo_44MagnumScope'
     PickupMessage="You picked up 14 .44 rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.D49.D49AmmoBox'
     DrawScale=0.250000
     PrePivot=(Z=70.000000)
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
