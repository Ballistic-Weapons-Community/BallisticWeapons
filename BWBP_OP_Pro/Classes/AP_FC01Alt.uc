//=============================================================================
// AP_FC01Alt.
//
// Ammo pickup of zaps or trackers or something funky
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_FC01Alt extends BallisticAmmoPickup;

simulated event PreBeginplay()
{
}

defaultproperties
{
     AmmoAmount=40
     InventoryType=Class'BWBP_OP_Pro.Ammo_FC01Alt'
     PickupMessage="You picked up an FC01 Power Pack."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.ProtoLMG.ProtoLMG_SM_Ammo'
     DrawScale=0.10000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
