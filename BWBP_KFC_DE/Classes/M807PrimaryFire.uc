//=============================================================================
// M807PrimaryFire.
//
// A73 primary fire is a fast moving projectile that goes through enemies and
// isn't hard to spot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M807PrimaryFire extends BallisticProProjectileFire;

defaultproperties
{

	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
	bPawnRapidFireAnim=True

     AmmoClass=Class'BallisticDE.Ammo_45HV'
	ShakeRotMag=(X=32.000000,Y=8.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=1.500000
	ShakeOffsetMag=(X=-3.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=1.500000

	//AI info - bot aid for close-range A73 - it's fast and they won't dodge it if it's too close
    bLeadTarget=True
    bInstantHit=True
	AimError=600
}
