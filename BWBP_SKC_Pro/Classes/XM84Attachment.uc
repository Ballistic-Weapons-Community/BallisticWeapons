//=============================================================================
// XM84Attachment.
//
// 3rd person weapon attachment for XM84 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM84Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
	WeaponClass=class'XM84Flashbang'
	ExplodeManager=Class'BWBP_SKC_Pro.IM_XM84Grenade'
	GrenadeSmokeClass=Class'BWBP_SKC_Pro.XM84Trail'
	Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_XM84'
	DrawScale=0.500000
	RelativeRotation=(Pitch=32768)
	RelativeLocation=(Z=15)
}
