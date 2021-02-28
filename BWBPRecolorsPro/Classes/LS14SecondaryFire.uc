//=============================================================================
// M50SecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
// Good for scaring enemies out of dark corners and not much else
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LS14SecondaryFire extends BallisticProProjectileFire;

var() int ProjPerFire;

var   bool		bLoaded;

simulated function bool AllowFire()
{
	if (LS14Carbine(Weapon).bOverloaded || !super.AllowFire())
		return false;
	if (LS14Carbine(Weapon).Rockets < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	Super.ModeDoFire();
    	LS14Carbine(Weapon).Rockets--;

	LS14Carbine(Weapon).UpdateGLIndicator();
}

defaultproperties
{
     bLoaded=True
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashBone="tip3"
     FlashScaleFactor=2.600000
     FireRecoil=256.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Rocket-Launch')
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
     PreFireAnim="GrenadePrepFire"
     FireAnim="RLFire"
     FireForce="AssaultRifleAltFire"
     FireRate=0.600000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_LS14Rocket'
     AmmoPerFire=0
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPRecolorsPro.LS14Rocket'
     BotRefireRate=0.600000
     WarnTargetPct=0.300000
     SpreadStyle=SS_Random
}
