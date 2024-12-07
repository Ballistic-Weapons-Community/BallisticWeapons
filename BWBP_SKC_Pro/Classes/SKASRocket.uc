//=============================================================================
// SKASRocket.
//
// The one! The Only! The skasrocket
//
// by Sarge, based on code by RS
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SKASRocket extends BallisticProjectile;


defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.SKASShotgun'
	ImpactManager=Class'BWBP_SKC_Pro.IM_BulldogFRAG'
	AccelSpeed=50000.000000
	TrailClass=Class'BWBP_SKC_Pro.TraceEmitter_Incendiary'
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTTAC30FRAGRadius'
	MotionBlurRadius=130.000000
	Speed=8000.000000
	MaxSpeed=10000.000000
	Damage=110.000000
	DamageRadius=180.000000
	MomentumTransfer=30000.000000
	MyDamageType=Class'BWBP_SKC_Pro.DTTAC30FRAG'
	StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.BulldogFRAG'
}
