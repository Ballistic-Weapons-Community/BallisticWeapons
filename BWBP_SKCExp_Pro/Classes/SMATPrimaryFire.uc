//=============================================================================
// SMATPrimaryFire.
//
// Almost-Instant SMAT Rocket
//
// by SK, based on DC
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATPrimaryFire extends BallisticProjectileFire;

var() class<Actor>	HatchSmokeClass;
var   Actor			HatchSmoke;
var() Sound			SteamSound;
var   float RailPower;


simulated function bool AllowFire()
{
//    if (Instigator.Base != none && VSize(Instigator.velocity - Instigator.base.velocity) > 220)
//    	return false;
//  if (BW.AimOffset!=rot(0,0,0))
//	{
//	bFireOnRelease=true;
//	return false;
//	}

    return super.AllowFire();
}

simulated event ModeDoFire()
{
    	if (!AllowFire())
        	return;

//	if (BW.AimOffset!=rot(0,0,0))
//	{
//		if (Instigator.PhysicsVolume.bWaterVolume)
//			Super.ModeDoFire();
//		else
// 			return;
//	}
	Super.ModeDoFire();
}

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
     //RecoilPerShot=1024.000000
     XInaccuracy=5.000000
     YInaccuracy=5.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_SoundsExp.SMAA.SMAT-Fire',Volume=9.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.050000
     AmmoClass=Class'BWBP_SKCExp_Pro.Ammo_SMAT'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-50.000000)
     ShakeOffsetRate=(X=-2000.000000)
     ShakeOffsetTime=5.000000
     ProjectileClass=Class'BWBP_SKCExp_Pro.SMATRocket'
     BotRefireRate=0.500000
     WarnTargetPct=0.300000
}
