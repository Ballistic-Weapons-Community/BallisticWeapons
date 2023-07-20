//=============================================================================
// NRP57Attachment.
//
// 3rd person weapon attachment for NRP57 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class NRP57Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
	WeaponClass=class'NRP57Grenade'
     ExplodeManager=class'IM_NRP57Grenade'
     GrenadeSmokeClass=class'NRP57Trail'
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.NRPGrenade_TPm'
     DrawScale=0.100000
}
