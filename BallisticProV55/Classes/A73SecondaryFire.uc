//=============================================================================
// A73PrimaryFire.
//
// A73 primary fire is a fast moving projectile that goes through enemies and
// isn't hard to spot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73SecondaryFire extends BallisticProProjectileFire;

var float HeatDeclineDelay;

simulated function bool AllowFire()
{
	if ((A73SkrithRifle(Weapon).HeatLevel >= 10) || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	A73SkrithRifle(BW).AddHeat(HeatPerShot, HeatDeclineDelay);
	//Weapon.SoundPitch = Min(150, Weapon.SoundPitch + 8);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		A73SkrithRifle(BW).AddHeat(HeatPerShot, HeatDeclineDelay);
}

defaultproperties
{
	HeatPerShot=3.40000
	HeatDeclineDelay=0.8
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
	bPawnRapidFireAnim=True
	AmmoClass=Class'BallisticProV55.Ammo_Cells'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=960.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-15.00)
	ShakeOffsetRate=(X=-300.000000)
	ShakeOffsetTime=2.000000

	// AI
	BotRefireRate=0.50000
	bInstantHit=True
}
