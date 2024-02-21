//=============================================================================
// T10Attachment.
//
// 3rd person weapon attachment for T10 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class T10Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
	WeaponClass=class'T10Grenade'
     ExplodeManager=class'IM_Grenade'
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_T10'
     DrawScale=0.175000
}
