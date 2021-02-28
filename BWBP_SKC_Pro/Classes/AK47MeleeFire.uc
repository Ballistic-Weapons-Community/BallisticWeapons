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
		BallisticFireSound.Sound=Sound'BW_Core_WeaponSound.A73.A73Stab';
		PreFireAnim='PrepPokies';
		FireAnim='Pokies';
		FireAnimRate=0.900000;
		Damage=default.Damage;
	}
	else
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		PreFireAnim='PrepBash';
		FireAnim='Bash';
		FireAnimRate=default.FireAnimRate;
		Damage=40;
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
     DamageType=Class'BWBP_SKC_Pro.DT_AK47Hit'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK47HitHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK47Hit'
     KickForce=100
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Melee',Volume=0.5,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepBash"
     FireAnim="Bash"
     PreFireAnimRate=2.000000
     FireAnimRate=1.300000
     TweenTime=0.000000
     FireRate=0.650000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_X8Knife'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}
