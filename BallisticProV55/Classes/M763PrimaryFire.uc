//=============================================================================
// M763PrimaryFire.
//
// Powerful, ranged shotgun blast.
// Now automatic, due to inability to balance it any other way.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M763PrimaryFire extends BallisticProShotgunFire;

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	
	if (BW.MagAmmo < AmmoPerFire)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			BW.bNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
	else if (BW.bNeedCock || M763Shotgun(BW).bAltLoaded)
		return false;		// Alt's loaded or needs cocking
    return true;
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'FireSight';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='FireCombinedSight';
		FireAnim = 'FireCombined';
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'FireSight';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='FireCombinedSight';
		FireAnim = 'FireCombined';
	}
	super.ServerPlayFiring();
}

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     HipSpreadFactor=4.000000
     CutOffDistance=2048.000000
     CutOffStartRange=1024.000000
     TraceCount=10
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=3072.000000,Max=3072.000000)
     Damage=10.000000

     RangeAtten=0.15000
     DamageType=Class'BallisticProV55.DTM763Shotgun'
     DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
     DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
     KickForce=500
     PenetrateForce=0
	 bPenetrate=False
	 WallPenetrationForce=0
     MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
     FlashScaleFactor=1.000000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="FireCombinedSight"
     FireRecoil=768.000000
     FireChaos=0.30000
     XInaccuracy=150.000000
     YInaccuracy=150.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
     FireAnim="FireCombined"
     FireEndAnim=
     FireAnimRate=0.9
     FireRate=0.85
     AmmoClass=Class'BallisticProV55.Ammo_12Gauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
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
