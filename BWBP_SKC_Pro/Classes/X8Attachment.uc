//=============================================================================
// X8 Attachment.
//
// 3rd person weapon attachment for the X8 knife.
//=============================================================================
class X8Attachment extends BallisticMeleeAttachment;

defaultproperties
{
	WeaponClass=class'X8Knife'
	ImpactManager=class'IM_Knife'
	BrassMode=MU_None
	InstantMode=MU_Both
	FlashMode=MU_None
	LightMode=MU_None
	TrackAnimMode=MU_Primary
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	bRapidFire=True
	RelativeLocation=(X=-2.000000,Y=-3.500000,Z=5.000000)
	RelativeRotation=(Pitch=32768,Roll=34000)	
	Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_X8Knife'
	DrawScale=0.500000
}
