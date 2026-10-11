//=============================================================================
// Fifty9PrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Fifty9PrimaryFire extends BallisticProInstantFire;

defaultproperties
{   
	ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=24.000000,batten=false)
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryPistol',Volume=0.700000)
	bDryUncock=True
	BrassClass=Class'BallisticProV55.Brass_Uzi'
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
	bPawnRapidFireAnim=True
	AmmoClass=Class'BallisticProV55.Ammo_FiftyNine'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000
		 
	// AI
	bInstantHit=True
	bLeadTarget=False
	bTossed=False
}
