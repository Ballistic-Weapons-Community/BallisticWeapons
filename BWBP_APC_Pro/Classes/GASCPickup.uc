//=============================================================================
// GASCPickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class GASCPickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.GASC.GASC_Pickup_Weapon'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_APC_Pro.GASCPistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the Gaucho and Stallion"
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.GASC.GASC_Pickup_Weapon'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
