//=============================================================================
// A42PrimaryFire.
//
// Rapid fire projectiles. Ammo regen timer is also here.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42PrimaryFire extends BallisticProProjectileFire;

simulated event ModeDoFire()
{
	if (Weapon.GetFireMode(1).IsFiring())
		return;
	if (FRand() > 0.5)
		FireAnim = 'Fire1';
	else
		FireAnim = 'Fire2';
	A42SkrithPistol(Weapon).NextAmmoTickTime = Level.TimeSeconds + 2;
	super.ModeDoFire();
}

defaultproperties
{
	bPawnRapidFireAnim=True
	AmmoClass=Class'BallisticProV55.Ammo_A42Charge'
	ShakeRotMag=(X=32.000000,Y=8.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=1.500000
	ShakeOffsetMag=(X=-3.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=1.500000
	 
	// AI
	AimError=600
}
