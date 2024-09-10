//=============================================================================
// A42Attachment.
//
// 3rd person weapon attachment for A42 Skrith Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A49Attachment extends HandgunAttachment;

#EXEC OBJ LOAD FILE=BWBP_SKC_Anim.ukx

defaultproperties
{
	WeaponClass=class'A49SkrithBlaster'
	MuzzleFlashClass=class'A42FlashEmitter'
	AltMuzzleFlashClass=class'A42FlashEmitter'
	FlashScale=0.500000
	ImpactManager=Class'BWBP_SKC_Pro.IM_GRSXXLaser'
	BrassMode=MU_None
	TracerMode=MU_Secondary
	InstantMode=MU_Secondary
	FlashMode=MU_Both
	LightMode=MU_Both
	ReloadAnim="Reload_AR"
	ReloadAnimRate=1.200000
	bRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_A49'
	RelativeLocation=(X=-5.000000,Y=-3.000000,Z=10.000000)
	RelativeRotation=(Pitch=32768)
	DrawScale=0.250000
}
