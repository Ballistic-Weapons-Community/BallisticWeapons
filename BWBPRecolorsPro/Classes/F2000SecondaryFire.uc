//=============================================================================
// F2000SecondaryFire.
//
// A 40mm shockwave grenade that does damage over time
// Will deonate after 3 shockwaves.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class F2000SecondaryFire extends BallisticProProjectileFire;

var   bool		bLoaded;

simulated function bool CheckGrenade()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if(!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if(seq == F2000AssaultRifle(Weapon).GrenadeLoadAnim)
			return false;

		F2000AssaultRifle(Weapon).LoadGrenade();
		bIsFiring=false;
		return false;
	}
	return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (!CheckGrenade())
		return;
	Super.ModeDoFire();
	bLoaded = false;
}

defaultproperties
{
     bLoaded=True
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashBone="tip3"
     RecoilPerShot=1024.000000
     FireChaos=0.500000
     XInaccuracy=8.000000
     YInaccuracy=8.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
     FireAnim="GrenadeFire"
     FireForce="AssaultRifleAltFire"
     FireRate=2.000000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_F2000Grenades'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPRecolorsPro.F2000Grenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
