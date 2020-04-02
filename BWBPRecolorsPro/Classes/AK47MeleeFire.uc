//=============================================================================
// AK47SecondaryFire.
//
// Melee attack for the AK-490.
// Will do a bayonet stab if one is equipped.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AK47MeleeFire extends BallisticMeleeFire;

simulated function SwitchBladeMode (bool bLoaded)
{
	if (bLoaded)
	{
		BallisticFireSound.Sound=Sound'BallisticSounds3.A73.A73Stab';
		PreFireAnim='PrepPokies';
		FireAnim='Pokies';
		FireAnimRate=0.900000;
		Damage=default.Damage;
		DamageLimb=default.DamageLimb;
	}
	else
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		PreFireAnim='PrepBash';
		FireAnim='Bash';
		FireAnimRate=default.FireAnimRate;
		Damage=60;
		DamageLimb=60;
	}

	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
}

simulated function bool HasAmmo()
{
	return true;
}

simulated event ModeDoFire()
{
	super.ModeDoFire();
	BW.GunLength = BW.default.GunLength;
}
simulated event ModeHoldFire()
{
	super.ModeHoldFire();
	BW.GunLength=1;
}
//Check Sounds and damage types.

defaultproperties
{
     DamageHead=75.000000
     DamageLimb=75.000000
     DamageType=Class'BWBPRecolorsPro.DT_AK47Hit'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_AK47HitHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_AK47Hit'
     KickForce=2000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.Marlin.Mar-Melee',Volume=0.5,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepBash"
     FireAnim="Bash"
     PreFireAnimRate=2.000000
     FireAnimRate=1.300000
     TweenTime=0.000000
     FireRate=0.650000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_X8Knife'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}
