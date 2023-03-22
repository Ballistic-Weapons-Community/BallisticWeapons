//=============================================================================
// KF8XToxicBolt.
//
// Bolt fired by the KF8X crossbow
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class KF8XToxicBolt extends BallisticProjectile;

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.KF8XCrossbow'
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BallisticProV55.PineappleTrail'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DT_KF8XBolt'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     Speed=10000.000000
     Damage=30.000000
     MyDamageType=Class'BWBP_OP_Pro.DT_KF8XBolt'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart'
     LifeSpan=1.500000
     bIgnoreTerminalVelocity=True
}
