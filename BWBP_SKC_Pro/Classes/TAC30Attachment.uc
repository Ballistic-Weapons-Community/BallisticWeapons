//=============================================================================
// TAC30Attachment.
//
// 3rd person weapon attachment for the TAC-30 Autocannon
//
// by Sarge, based on code by RS
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TAC30Attachment extends BallisticAttachment;

defaultproperties
{
	WeaponClass=class'TAC30Cannon'
	MuzzleFlashClass=class'MRT6FlashEmitter'
	FlashScale=1.800000
	BrassMode=MU_Primary
	InstantMode=MU_None
	FlashMode=MU_Primary
	LightMode=MU_Primary
	BrassClass=Class'BWBP_SKC_Pro.Brass_FRAGSpent'
	//Mesh=SkeletalMesh'BWBP_SKC_Anim.SKAS_TPm'
	DrawScale=0.130000
	RelativeLocation=(X=-2.000000,Z=7.000000)
	RelativeRotation=(Pitch=32768)
}
