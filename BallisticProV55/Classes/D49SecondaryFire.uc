//=============================================================================
// D49SecondaryFire.
//
// Big double barreled revolver shot. Won't fire both bullets if one of
// two chambers is empty
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class D49SecondaryFire extends BallisticRangeAttenFire;

simulated function PlayFiring()
{
	super.PlayFiring();
}
simulated function FlashSingleMuzzleFlash()
{
	super.FlashMuzzleFlash();
}
simulated function FlashMuzzleFlash()
{
	super.FlashMuzzleFlash();
	Weapon.GetFireMode(0).FlashMuzzleFlash();
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckWeaponMode())
		return false;
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (BW.MagAmmo < 1)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);
		bIsFiring = false;
		return false;		// Is there ammo in weapon's mag
	}
    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	switch (D49Revolver(Weapon).GetBarrelMode())
	{
		case BM_Neither:
			D49Revolver(Weapon).RevolverFired(BM_Neither);
			BW.FireCount++;
	        NextFireTime += FireRate*0.5;
    	    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
			return;
		case BM_Primary:
//			D49PrimaryFire(Weapon.GetFireMode(0)).bSecondary = false;
			Weapon.GetFireMode(0).ModeDoFire();
			return;
		case BM_Secondary:
//			D49PrimaryFire(Weapon.GetFireMode(0)).bSecondary = true;
			Weapon.GetFireMode(0).ModeDoFire();
			return;
		default /*BM_Both*/	:
			break;
	}
	D49Revolver(Weapon).RevolverFired(BM_Both);
	super.ModeDoFire();
}

defaultproperties
{
     CutOffDistance=2536.000000
     CutOffStartRange=1024.000000
     TraceRange=(Min=8000.000000,Max=9000.000000)
     WallPenetrationForce=8.000000
     
     Damage=120.000000
     DamageHead=180.000000
     DamageLimb=120.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTD49Revolver'
     DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
     DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
     KickForce=4000
     PenetrateForce=200
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashBone="tip2"
     FlashScaleFactor=1.200000
     FireRecoil=2048.000000
     FireChaos=0.800000
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.D49.D49-Fire',Volume=1.300000)
     FireEndAnim=
     FireRate=0.9
     AmmoClass=Class'BallisticProV55.Ammo_44Magnum'
     AmmoPerFire=2
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.7
     WarnTargetPct=0.5
}
