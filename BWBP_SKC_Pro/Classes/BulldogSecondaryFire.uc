//=============================================================================
// Bulldog Secondary Fire.
//
//	Loads and fires a FRAG-12 grenade. These grenades are powerful, but are
//  affected by gravity and must be loaded before they may be used.
//
// by Azarael
//=============================================================================
class BulldogSecondaryFire extends BallisticProProjectileFire;

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (BulldogAssaultCannon(BW).Grenades < 1)
		return false;
	if (BulldogAssaultCannon(BW).bAltNeedCock)
		return false;
		
	if (!bUseWeaponMag || BW.bNoMag)
	{
		if(!Super.AllowFire())
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

    return true;
}

simulated function ModeDoFire()
{
	Super.ModeDoFire();
	BulldogAssaultCannon(BW).FragFired();
}

// Hip FRAG-12s deviate horribly.
simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	if (BW.bScopeView)
		return super(BallisticProjectileFire).GetFireSpread();

	fX = frand();
	R.Yaw =  512 * sin (FMin(sqrt(frand()), 1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Yaw = -R.Yaw;
	R.Pitch = 512 * sin (FMin(sqrt(frand()), 1)  * 1.5707963267948966) * cos(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Pitch = -R.Pitch;
	return Vector(R);
}
	

defaultproperties
{
	SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
	bUseWeaponMag=False
	MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
	BrassClass=Class'BWBP_SKC_Pro.Brass_FRAGSpent'
	BrassOffset=(X=-30.000000,Y=1.000000)
	FireRecoil=2048.000000
	FirePushbackForce=100.000000
	FireChaos=1.000000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-FireTest',Volume=2.500000)
	bWaitForRelease=True
	FireAnim="SGFire"
	FireForce="AssaultRifleAltFire"
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_20mmGrenade'
	AmmoPerFire=0
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-25.000000)
	ShakeOffsetRate=(X=-500.000000)
	ShakeOffsetTime=2.000000
	ProjectileClass=Class'BWBP_SKC_Pro.BulldogRocket'

	FireRate=0.8

	// AI
	bInstantHit=False
	bLeadTarget=True
	bTossed=False
	bSplashDamage=True
	bRecommendSplashDamage=True
	BotRefireRate=0.5
	WarnTargetPct=0.75
}
