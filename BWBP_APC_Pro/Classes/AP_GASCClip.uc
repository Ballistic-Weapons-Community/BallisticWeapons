//=============================================================================
// AP_GASCClip.
//
// Clips for the GASC.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_GASCClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=80
     InventoryType=Class'BWBP_APC_Pro.Ammo_GASCClip'
     PickupMessage="You picked up two Gaucho magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_APC_Static.GASC.GASCClip'
     DrawScale=0.800000
     PrePivot=(Z=20.150000)
     CollisionRadius=15.000000
     CollisionHeight=16.000000
}
