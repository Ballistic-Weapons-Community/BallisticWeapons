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

simulated function InitEffects()
{
    if ((HatchSmokeClass != None) && ((HatchSmoke == None) || HatchSmoke.bDeleteMe) )
	{
		HatchSmoke = Spawn(HatchSmokeClass, Weapon);

		if ( HatchSmoke != None )
			Weapon.AttachToBone(HatchSmoke, 'tip');

		if (Emitter(HatchSmoke) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(HatchSmoke), Weapon.DrawScale*FlashScaleFactor);
		else
			HatchSmoke.SetDrawScale(HatchSmoke.DrawScale*Weapon.DrawScale*FlashScaleFactor);

		if (DGVEmitter(HatchSmoke) != None)
			DGVEmitter(HatchSmoke).InitDGV();
	}
	Super.InitEffects();
}

simulated function FlashHatchSmoke()
{
	if (Level.DetailMode < DM_High)
		return;
    if (HatchSmoke != None && Level.TimeSeconds < NextFireTime + 3.0)
	{
		Weapon.PlaySound(SteamSound, SLOT_Misc, 0.3);
		Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Min = Lerp(((NextFireTime+3.0) - Level.TimeSeconds) / 3.8, 10, 70);
		Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Max = Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Min;
        HatchSmoke.Trigger(Weapon, Instigator);
	}
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();

    if (HatchSmoke != None)
	{
		if (Emitter(HatchSmoke) != None)
			Emitter(HatchSmoke).Kill();
		else
			HatchSmoke.Destroy();
	}
}

defaultproperties
{
     HatchSmokeClass=Class'BallisticProV55.G5HatchEmitter'
     SteamSound=Sound'BW_Core_WeaponSound.G5.G5-Steam'
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     bCockAfterFire=False
     MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
     //RecoilPerShot=1024.000000
     XInaccuracy=5.000000
     YInaccuracy=5.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-Fire',Volume=9.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.050000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_SMAT'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-50.000000)
     ShakeOffsetRate=(X=-1600.000000)
     ShakeOffsetTime=5.000000
     ProjectileClass=Class'BWBP_SKC_Pro.SMATRocket'
     BotRefireRate=0.500000
     WarnTargetPct=0.300000
}
