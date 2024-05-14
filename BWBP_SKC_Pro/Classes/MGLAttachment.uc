class MGLAttachment extends BallisticAttachment;

defaultproperties
{
	WeaponClass=class'MGLauncher'
	MuzzleFlashClass=class'M50FlashEmitter'
	AltMuzzleFlashClass=class'M50FlashEmitter'
	ImpactManager=class'IM_Bullet'
	BrassClass=Class'BWBP_SKC_Pro.Brass_Longhorn'
	BrassMode=MU_None
	InstantMode=MU_Both
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=class'TraceEmitter_Default'
	TracerMix=-3
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	ReloadAnimRate=0.500000
	bRapidFire=True
	bAltRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_MGL'
	RelativeRotation=(Pitch=32768)
	DrawScale=0.300000
}
