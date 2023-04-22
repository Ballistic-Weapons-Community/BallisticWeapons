//=============================================================================
// M58PrimaryFire.
//
// M58 Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M58PrimaryFire extends BallisticHandGrenadeFire;

function float CalculateDetonateDelay(float DetonateDelay)
{
	if (BallisticHandGrenade(Weapon).ClipReleaseTime == 666)
		return DetonateDelay - 3;
	else if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0.0)
		return DetonateDelay - (Level.TimeSeconds - BallisticHandGrenade(Weapon).ClipReleaseTime);
	else
		return DetonateDelay;
}

defaultproperties
{
     NoClipPreFireAnim="ThrowNoClip"
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassClass=Class'BallisticProV55.Brass_T10Clip'
     BrassBone="tip"
     BrassOffset=(X=-20.000000,Z=-2.000000)
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     AmmoClass=Class'BallisticProV55.Ammo_M58Grenades'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-8.00)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.M58Thrown'
}
