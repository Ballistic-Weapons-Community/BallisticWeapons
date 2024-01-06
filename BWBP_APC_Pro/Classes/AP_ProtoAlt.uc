//=============================================================================
// AP_leMat.
//
// Ammo pickup includeing 18 .41 bullets and 5 16 guage shells for the Wilson DB.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_ProtoAlt extends BallisticAmmoPickup;

simulated event PreBeginplay()
{
}

defaultproperties
{
     AmmoAmount=40
     InventoryType=Class'BWBP_APC_Pro.Ammo_ProtoAlt'
     PickupMessage="You picked up a S1W Photon Round Case."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.ProtoLMG.ProtoLMG_SM_Ammo'
     DrawScale=0.10000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
