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

var float HeatPerShot, HeatDeclineDelay;

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

     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000

	 // AI
     BotRefireRate=0.50000
	 bInstantHit=True
}
