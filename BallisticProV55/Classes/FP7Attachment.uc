//=============================================================================
// FP7Attachment.
//
// 3rd person weapon attachment for FP7 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
	WeaponClass=class'FP7Grenade'
	ExplodeManager=class'IM_Grenade'
	GrenadeSmokeClass=class'NRP57Trail'
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FP7_TPm'
	DrawScale=0.250000
}
