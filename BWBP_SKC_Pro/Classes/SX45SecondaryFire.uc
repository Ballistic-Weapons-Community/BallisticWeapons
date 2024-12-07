//=============================================================================
// RS8SecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SX45SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (AllowFire())
		SX45Pistol(Weapon).ToggleAmplifier();
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
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_45HV'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
