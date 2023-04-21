//=============================================================================
// ChaffPrimaryFire.
//
// MOA-C Chaff Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ChaffPrimaryFire extends BallisticHandGrenadeFire;

function PlayPreFire()
{
	Weapon.SetBoneScale (0, 1.0, ChaffGrenadeWeapon(Weapon).GrenadeBone);
	Weapon.PlayAnim(PreFireAnim, PreFireAnimRate, TweenTime);
}

defaultproperties
{
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassOffset=(X=10.000000)
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     FireRate=2.000000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_Chaff'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-7.00)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_SKC_Pro.ChaffGrenade'
}
