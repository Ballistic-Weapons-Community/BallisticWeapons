//=============================================================================
// M50SecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ARSecondaryFire extends BallisticProProjectileFire;

var   bool		bLoaded;

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
	local Rotator R;

	if (BW.bScopeView)
		return super.GetFireSpread();

	fX = frand();
	R.Yaw =  600 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	R.Pitch = 600 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
	return Vector(R);
}

// Check if there is ammo in mag if we use it or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (BW.BCRepClass.default.bSightFireOnly && !BW.bScopeView)
	{
		if (PlayerController(Instigator.Controller) != None)
			PlayerController(Instigator.Controller).ClientMessage("You can only fire from sights.");
		return false;
	}
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (ARShotgun(BW).Grenades == 0 && !ARShotgun(BW).bReady)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			BW.bNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		ARShotgun(BW).EmptyAltFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	if (!ARShotgun(Weapon).bReady)
	{
		ARShotgun(Weapon).PrepAltFire();
		return;
	}
	else
	{
		super.ModeDoFire();
		ARShotgun(Weapon).bReady = false;
	}
}

defaultproperties
{
     SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticJiffyPack.ARHeatEmitter'
     FlashBone="tip2"
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticJiffyPack.Brass_ShotgunHE'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     RecoilPerShot=650.000000
     VelocityRecoil=180.000000
     FireChaos=0.450000
     XInaccuracy=384.000000
     YInaccuracy=384.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.Misc.GL-Fire',Volume=1.300000)
	 //ScopeDownOn=SDO_PreFire
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bFireOnRelease=True
     bWaitForRelease=True
     PreFireTime=0.050000
     PreFireAnim=
     FireAnim="GLFire"
     FireAnimRate=1.250000
     FireForce="GLFire"
     FireRate=0.650000
     AmmoClass=Class'BallisticJiffyPack.Ammo_ARGrenades'
     AmmoPerFire=0
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BallisticJiffyPack.ARProjectile'
     BotRefireRate=0.600000
     WarnTargetPct=0.400000
}
