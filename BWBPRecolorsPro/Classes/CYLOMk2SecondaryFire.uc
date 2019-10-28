//=============================================================================
// CYLOSecondaryFire.
//
// A semi-auto shotgun that uses its own magazine.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOMk2SecondaryFire extends BallisticProProjectileFire;

simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (CYLOUAW(Weapon).SGShells < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			CYLOUAW(BW).bAltNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (CYLOUAW(BW).bAltNeedCock)
		return false;
    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	Super.ModeDoFire();
    CYLOUAW(Weapon).SGShells--;
	if (Weapon.Role == ROLE_Authority && CYLOUAW(Weapon).SGShells == 0)
		CYLOUAW(BW).bAltNeedCock = true;
}

simulated function vector GetFireSpread()
{
	local float fX;
	local Rotator R;

	if (BW.bScopeView)
		return super.GetFireSpread();

	fX = frand();
	R.Yaw =  1024 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	R.Pitch = 1024 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
	return Vector(R);
}

defaultproperties
{
     SpawnOffset=(Y=20.000000,Z=-20.000000)
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashBone="Muzzle2"
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     bBrassOnCock=True
     BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
     RecoilPerShot=512.000000
     VelocityRecoil=200.000000
     FireChaos=0.500000
     JamSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-1',Volume=0.900000)
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.CYLO.CYLO-FireSG',Volume=1.300000,Radius=256.000000)
     FireAnim="FireSG"
     FireEndAnim=
     FireRate=1.000000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_CYLOSG'
     AmmoPerFire=0
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPRecolorsPro.CYLOMk2HEProjectile'
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
