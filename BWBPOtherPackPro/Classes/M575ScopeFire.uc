//=============================================================================
// M50SecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
// Good for scaring enemies out of dark corners and not much else
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M575ScopeFire extends BallisticFire;

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
	if (AllowFire() && Instigator.IsLocallyControlled() && BW != None)
    	M575Machinegun(BW).ScopeViewTwoRelease();
}

// Send sight key press event to weapon
simulated function PlayPreFire()
{
	if (Instigator.IsLocallyControlled() && BW != None)
	{
		M575Machinegun(BW).ScopeViewTwo();
	}
}

defaultproperties
{
     bUseWeaponMag=False
     EffectString="Scope/Iron Sights"
     bFireOnRelease=True
     FireAnim=
     FireRate=0.020000
     AmmoClass=Class'BallisticProV55.Ammo_556mmBelt'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
