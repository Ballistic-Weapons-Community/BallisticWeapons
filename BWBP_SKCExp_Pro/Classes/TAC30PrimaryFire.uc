//=============================================================================
// M763PrimaryFire.
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TAC30PrimaryFire extends BallisticProjectileFire;

var() sound		SuperFireSound;
var() sound		FabulousFireSound;

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{          
     SuperFireSound=Sound'BWBP_SKC_SoundsExp.SRAC.SRAC-Fire'
	 FabulousFireSound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire2'
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_SoundsExp.SRAC.SRAC-Fire',Volume=1.750000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     FireAnim="Fire"
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashScaleFactor=1.000000
     BrassClass=Class'BWBP_SKC_Pro.Brass_FRAGSpent'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.800000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_20mmGrenade'
     ProjectileClass=Class'BWBP_SKCExp_Pro.TAC30Projectile'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
