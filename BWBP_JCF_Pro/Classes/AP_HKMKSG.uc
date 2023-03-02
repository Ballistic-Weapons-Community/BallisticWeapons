//=============================================================================
// AP_leMat.
//
// Ammo pickup includeing 18 .41 bullets and 5 16 guage shells for the Wilson DB.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_HKMKSG extends BallisticAmmoPickup;

simulated event PreBeginplay()
{
}

defaultproperties
{
     AmmoAmount=12
     InventoryType=Class'BWBP_JCF_Pro.Ammo_HKMKSG'
     PickupMessage="You picked up two HKMK shotgun shell sets."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOPickupSG'
     DrawScale=1.250000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
