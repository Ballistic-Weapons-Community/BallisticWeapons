//=============================================================================
// MRDRPrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNSecondaryFire extends BallisticProInstantFire;

simulated state Gauss
{
	simulated function bool AllowFire()
	{
		if (!T9CNMachinePistol(BW).bGaussCharged)
			return false;
		else
			return super.AllowFire();
	}
	
	simulated event ModeDoFire()
	{
		if (!AllowFire())
			return;
		super.ModeDoFire();
		T9CNMachinePistol(BW).GaussLevel = 0;	
		T9CNMachinePistol(BW).bGaussCharged=False;	
	}

	//Do the spread on the client side
	function PlayFiring()
	{
		if (BW.MagAmmo - ConsumedLoad < 1)
		{
			BW.IdleAnim = 'IdleOpen';
			BW.ReloadAnim = 'ReloadOpen';
			FireAnim = 'FireOpen';
			AimedFireAnim = 'SightFireOpen';
		}
		else
		{
			BW.IdleAnim = 'Idle';
			BW.ReloadAnim = 'Reload';
			FireAnim = 'Fire';
			AimedFireAnim = 'SightFire';
		}
		super.PlayFiring();
	}
}

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

defaultproperties
{
	DamageType=Class'BWBP_SKC_Pro.DTT9CN'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
	PenetrateForce=0
	bPenetrate=False
	ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryPistol',Volume=0.700000)
	MuzzleFlashClass=Class'BWBP_SKC_Pro.T9CNFlashEmitter'
	FlashScaleFactor=0.600000
	BrassClass=Class'BallisticProV55.Brass_GRSNine'
	BrassOffset=(X=-25.000000,Z=-5.000000)
	FireRecoil=64.000000
	FireChaos=0.100000
	XInaccuracy=48.000000
	YInaccuracy=48.000000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-QFire',Volume=1.800000)
	bPawnRapidFireAnim=True
	FireRate=0.820000
	AmmoClass=Class'BallisticProV55.Ammo_GRSNine'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000
}
