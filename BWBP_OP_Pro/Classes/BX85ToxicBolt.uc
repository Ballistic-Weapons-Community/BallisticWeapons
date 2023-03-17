//=============================================================================
// BX85ToxicBolt.
//
// Bolt fired by the BX85 crossbow
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BX85ToxicBolt extends BallisticProjectile;

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.BX85Crossbow'
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BallisticProV55.PineappleTrail'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DT_BX85Bolt'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     Speed=10000.000000
     Damage=30.000000
     MyDamageType=Class'BWBP_OP_Pro.DT_BX85Bolt'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart'
     LifeSpan=1.500000
     bIgnoreTerminalVelocity=True
}
