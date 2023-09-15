//=============================================================================
// MRS138Slug_HE.
//
// 10 gauge frag round
//
// by Sarge, based on code by RS
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138Slug_HE extends BallisticGrenade;


defaultproperties
{
	bAlignToVelocity=true
	bNoInitialSpin=true
	DampenFactor=1
	DampenFactorParallel=1
	bBounce=false
	
	ArmingDelay=0.03
	UnarmedDetonateOn=DT_Disarm
	UnarmedPlayerImpactType=PIT_Bounce
	ArmedDetonateOn=DT_Impact
	ArmedPlayerImpactType=PIT_Detonate

	ImpactDamage=50
	
	WeaponClass=class'BallisticProV55.MRS138Shotgun'
	ImpactManager=Class'BallisticProV55.IM_MRLRocket'
	ReflectImpactManager=Class'BallisticProV55.IM_BigBullet'
	AccelSpeed=50000.000000
	TrailClass=Class'BallisticProV55.TraceEmitter_Default'
	ImpactDamageType=Class'BallisticProV55.DTMRS138ShotgunFrag'
	MyRadiusDamageType=Class'BallisticProV55.DTMRS138ShotgunFragRadius'
	MotionBlurRadius=130.000000
	Speed=8000.000000
	MaxSpeed=10000.000000
	Damage=110.000000
	DamageRadius=180.000000
	MomentumTransfer=30000.000000
	MyDamageType=Class'BallisticProV55.DTMRS138ShotgunFrag'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
	DrawScale=1.000000
}
