//=============================================================================
// FM13FlakProjectile.
//
// An explody boy pooped out by a bigger explody boy
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class FM13FlakProjectile extends BallisticProjectile;

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.FM13Shotgun'
	ModeIndex=1
	ImpactManager=Class'BWBP_SKC_Pro.IM_LonghornCluster'
	TrailClass=Class'BallisticProV55.MRLTrailEmitter'
	MyRadiusDamageType=Class'BWBP_OP_Pro.DT_FM13GrenadeRadius'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=0.000000
	MotionBlurRadius=0.000000
	MotionBlurFactor=0.000000
	MotionBlurTime=0.000000
	Speed=10000.000000
	Damage=25.000000
	DamageRadius=250.000000
	MyDamageType=Class'BWBP_OP_Pro.DT_FM13Grenade'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart'
	LifeSpan=1.500000
	bIgnoreTerminalVelocity=True
}
