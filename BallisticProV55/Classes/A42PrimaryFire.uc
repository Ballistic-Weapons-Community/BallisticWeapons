//=============================================================================
// A42PrimaryFire.
//
// Rapid fire projectiles. Ammo regen timer is also here.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42PrimaryFire extends BallisticProProjectileFire;

var byte Shots;
var byte Cycle;
var() int FireSpread;

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

simulated state SpreadShot
{

	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		local int i;
		local rotator R;

		Shots = FMin(default.Shots, BW.MagAmmo);

		ConsumedLoad = (AmmoPerFire * Shots);
		for (i=0;i<Shots;i++)
		{
			R.Roll = (65536.0 / 3) * Cycle + (65536.0 / 12);
			Dir = Rotator(GetFireSpread() >> Dir);

			Proj = Spawn (ProjectileClass,,, Start, rotator((Vector(rot(0,1,0)*FireSpread) >> R) >> Dir) );
			Proj.Instigator = Instigator;

			//log("SkrithPistol PrimaryFire: isSlave: "$BallisticHandgun(BW).IsSlave()$" Cycle: "$Cycle$" Shot: "$i$" Heat Added: "$(HeatPerShot*ConsumedLoad)$" Current Heat: "$A48SkrithPistolBal(BW).Heat);
			Cycle++;
			if (Cycle > 3)
				Cycle = 1;
		}
	}
}

defaultproperties
{
	Cycle=1
	Shots=3
	HeatPerShot=0.081000
	FireSpread=120
	bPawnRapidFireAnim=True
	AmmoClass=Class'BallisticProV55.Ammo_A42Charge'
	
	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-70.000000)
	ShakeOffsetTime=2.000000
	 
	// AI
	AimError=600
}
