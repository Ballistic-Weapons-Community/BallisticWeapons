//=============================================================================
// CX61Flechette.
//
// Rapid spike that deals impact damage and causes bleed.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CX61Flechette extends BallisticProjectile;

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BallisticProV55.PineappleTrail'
     //bRandomStartRotaion=False
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=10000.000000
    AccelSpeed=1000.000000
     MaxSpeed=20000.000000
     Damage=85.000000
     DamageRadius=192.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
     AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
     SoundVolume=64
     //Physics=PHYS_Falling
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
