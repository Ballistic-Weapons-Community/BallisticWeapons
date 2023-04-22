//=============================================================================
// PS9mSecondaryFire.
//
// A medical dart that can be attached to the muzzle of the gun
// Will heal and hurt at the same time! Stick it in your teammates eyes!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PS9mSecondaryFire extends BallisticProProjectileFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 2)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
		FireAnim = 'Dart_FireOpen';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		FireAnim = 'Dart_Fire';
	}
	super.PlayFiring();
}

simulated function bool CheckGrenade()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (!PS9mPistol(Weapon).bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == PS9mPistol(Weapon).GrenadeLoadAnim)
			return false;

		PS9mPistol(Weapon).LoadGrenade();
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
	PS9mPistol(Weapon).bLoaded = false;
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashBone="tip2"
     BrassOffset=(X=-20.000000,Y=1.000000)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-DartFire',Volume=1.350000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bUseWeaponMag=False
     bTossed=True
     FireAnim="Dart_Fire"
     FireForce="AssaultRifleAltFire"
     FireRate=0.600000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_MedDarts'
	 AmmoPerFire=0
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-8.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_SKC_Pro.PS9mMedDart'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
