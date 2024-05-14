//=============================================================================
// EKS43Attachment.
//
// Attachment for EKS43 sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BlackOpsWristBladeAttachment extends BallisticMeleeAttachment;

defaultproperties
{
	WeaponClass=class'BlackOpsWristBlade'
	ImpactManager=class'IM_Katana'
	BrassMode=MU_None
	InstantMode=MU_Both
	FlashMode=MU_None
	LightMode=MU_None
	TrackAnimMode=MU_Both
	bHeavy=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_BOB'
	RelativeLocation=(X=-12.000000,Y=-3.000000,Z=16.000000)
	DrawScale=0.500000
}
