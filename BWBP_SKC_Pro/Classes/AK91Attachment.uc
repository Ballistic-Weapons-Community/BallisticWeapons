//=============================================================================
// AK91Attachment.
//
// 3rd person weapon attachment for AK91 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK91Attachment extends BallisticAttachment;

defaultproperties
{
	WeaponClass=class'AK91ChargeRifle'
	MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
	FlashScale=0.500000
	ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
	BrassClass=class'Brass_Rifle'
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	TracerMode=MU_Both      
	InstantMode=MU_Both
	FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FlyBy',Volume=0.300000)
	bRapidFire=True
	RelativeRotation=(Pitch=32768)
	ReloadAnimRate=1.000000
	CockAnimRate=0.500000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.AK91_TPm'
	DrawScale=0.250000
	TracerMix=1
}
