//=============================================================================
// AP_leMat.
//
// Ammo pickup includeing 18 .41 bullets and 5 16 guage shells for the Wilson DB.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_CYLOSG extends BallisticAmmoPickup;

simulated event PreBeginplay()
{
}

defaultproperties
{
     AmmoAmount=8
     InventoryType=Class'BWBPRecolorsPro.Ammo_CYLOSG'
     PickupMessage="You picked a CYLO shotgun tube."
     PickupSound=Sound'BallisticSounds2.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOPickupSG'
     DrawScale=1.250000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
