//=============================================================================
// AP_MRDRClip.
//
// 2 36 round 9mm clips for the MRDR.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MRDRClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=72
     InventoryType=Class'BallisticProV55.Ammo_9mm'
     PickupMessage="You picked up a MR-DR magazine."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.MRDR.MRDR88AmmoPickup'
     DrawScale=1.250000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
