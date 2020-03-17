//=============================================================================
// D49PrimaryFire.
//
// BANG! You're dead!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class D49PrimaryFire extends BallisticRangeAttenFire;

var   bool			bSecondary;

simulated function FlashMuzzleFlash()
{
	if (bSecondary)
		D49SecondaryFire(Weapon.GetFireMode(1)).FlashSingleMuzzleFlash();
	else
		super.FlashMuzzleFlash();
}
simulated function PlayFiring()
{
//	D49Revolver(Weapon).RevolverFired(ThisModeNum);
	super.PlayFiring();
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	switch(D49Revolver(Weapon).GetBarrelMode())
	{
		case BM_Neither:
			D49Revolver(Weapon).RevolverFired(BM_Neither);
			BW.FireCount++;
	        NextFireTime += FireRate*0.5;
    	    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
			return;
		case BM_Primary:
			break;
		case BM_Secondary:
			bSecondary = true;
			break;
		default:
			break;
	}
	super.ModeDoFire();
	if (bSecondary)
		D49Revolver(Weapon).RevolverFired(BM_Secondary);
	else
		D49Revolver(Weapon).RevolverFired(BM_Primary);
	bSecondary = false;
}

defaultproperties
{
     CutOffDistance=2048.000000
     CutOffStartRange=768.000000
     TraceRange=(Min=8000.000000,Max=9000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=32.000000
     MaxWalls=2
     Damage=60.000000
     DamageHead=120.000000
     DamageLimb=60.000000
     RangeAtten=0.3500000
     WaterRangeAtten=0.200000
     DamageType=Class'BallisticProV55.DTD49Revolver'
     DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
     DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
     KickForce=2000
     PenetrateForce=200
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=1.200000
     RecoilPerShot=1024.000000
     FireChaos=0.400000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.D49.D49-FireSingle',Volume=1.200000)
     FireAnim="FireSingle"
     FireEndAnim=
     FireRate=0.400000
	 AimedFireAnim="SightFire"
     AmmoClass=Class'BallisticProV55.Ammo_44Magnum'
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
     WarnTargetPct=0.4
}
