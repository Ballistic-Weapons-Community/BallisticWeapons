//=============================================================================
// RCS715Slug_HE.
//
// 12 gauge frag round
//
// by Sarge, based on code by RS
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RCS715Slug_HE extends BallisticGrenade;


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

	ImpactDamage=30
	
	WeaponClass=class'BWBP_OP_Pro.RCS715Shotgun'
	ImpactManager=Class'BallisticProV55.IM_MRLRocket'
	ReflectImpactManager=Class'BallisticProV55.IM_BigBullet'
	AccelSpeed=50000.000000
	TrailClass=Class'BallisticProV55.TraceEmitter_Default'
	ImpactDamageType=Class'BWBP_OP_Pro.DT_RCS715Frag'
	MyRadiusDamageType=Class'BWBP_OP_Pro.DT_RCS715FragRadius'
	MotionBlurRadius=130.000000
	Speed=8000.000000
	MaxSpeed=10000.000000
	Damage=60.000000
	DamageRadius=150.000000
	MomentumTransfer=30000.000000
	MyDamageType=Class'BWBP_OP_Pro.DT_RCS715Frag'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
	DrawScale=1.000000
}
