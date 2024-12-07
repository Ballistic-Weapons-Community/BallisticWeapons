//=============================================================================
// SPASSecondaryFire.
//
// Double shot or scope depending on layout.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SPASSecondaryFire extends BallisticProShotgunFire;

simulated state Scope
{
	simulated function ApplyFireEffectParams(FireEffectParams effect_params)
	{
		super(BallisticFire).ApplyFireEffectParams(effect_params);
		bUseWeaponMag=False;
		bFireOnRelease=True;
		bModeExclusive=False;
		if (bFireOnRelease)
			bWaitForRelease = true;

		if (bWaitForRelease)
			bNowWaiting = true;
	}
	
	// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
	simulated function bool AllowFire()
	{
		if (!CheckReloading())
			return false;		// Is weapon busy reloading
		if (!CheckWeaponMode())
			return false;		// Will weapon mode allow further firing

		if (!bUseWeaponMag || BW.bNoMag)
		{
			if(!Super(WeaponFire).AllowFire())
			{
				if (DryFireSound.Sound != None)
					Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
				return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
			}
		}
		else if (BW.MagAmmo < AmmoPerFire)
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
		else if (BW.bNeedCock)
			return false;		// Is gun cocked
		return true;
	}

	// Match ammo to other mode
	simulated function PostBeginPlay()
	{
		if (ThisModeNum == 0 && Weapon.AmmoClass[1] != None)
			AmmoClass = Weapon.AmmoClass[1];
		else if (Weapon.AmmoClass[0] != None)
			AmmoClass = Weapon.AmmoClass[0];
		super.PostBeginPlay();
	}

	// Allow scope down when cocking
	simulated function bool CheckReloading()
	{
		if (BW.bScopeView && BW.ReloadState == RS_Cocking)
			return true;
		return super.CheckReloading();
	}

	// Send sight key release event to weapon
	simulated event ModeDoFire()
	{
		if (Instigator.IsLocallyControlled() && BW != None)
			BW.ScopeViewRelease();
	}

	// Send sight key press event to weapon
	simulated function PlayPreFire()
	{
		if (Instigator.IsLocallyControlled() && BW != None)
		{
			BW.ScopeView();

			if(!BW.bNoTweenToScope)
				BW.TweenAnim(BW.IdleAnim, BW.SightingTime);
		}
	}
}

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     HipSpreadFactor=5
	 TraceCount=12
	 AmmoPerFire=2
	 DecayRange=(Min=1280,Max=2536)
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     Damage=9.000000
     RangeAtten=0.300000
     DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
     DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
     DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
     KickForce=5000
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     bBrassOnCock=True
     FireRecoil=900.000000
	 FirePushBackForce=180.000000
     FireChaos=0.500000
     XInaccuracy=190.000000
     YInaccuracy=270.000000
	 FlashScaleFactor=0.1
     BallisticFireSound=(Sound=Sound'BWBP_JCF_Sounds.SPAS.SPAS-FireCock',Volume=1.500000)
	 FireAnim="FireCock"
	 AimedFireAnim="SightFireCock"
	 FireEndAnim=
     FireRate=0.80000
     AmmoClass=Class'BallisticProV55.Ammo_12Gauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.500000
}
