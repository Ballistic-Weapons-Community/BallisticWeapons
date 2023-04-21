//=============================================================================
// A49 Skrith Blaster Primary.
//
// Craps out deadly projectiles.
//=============================================================================
class A49PrimaryFire extends BallisticProProjectileFire;

var	bool  bVariableHeatProps; //Gun heat changes accuracy and RoF
var float StopFireTime;
var float HeatPerShot;

simulated function bool AllowFire()
{
	if ((A49SkrithBlaster(Weapon).HeatLevel >= 10) || !super.AllowFire())
		return false;
	return true;
}


simulated event ModeDoFire()
{
	if (level.Netmode == NM_Standalone && bVariableHeatProps)
	{
		if (A49SkrithBlaster(BW).HeatLevel >= 5)
			FireRate = default.FireRate - FRand()/20 - (0.1/A49SkrithBlaster(BW).HeatLevel);
		else
			FireRate = default.FireRate - FRand()/8 + (A49SkrithBlaster(BW).HeatLevel/25);
	}
	Super.ModeDoFire();

}

simulated event ModeTick(float DT)
{
	Super.ModeTick(DT);

	if (Weapon.SoundPitch != 56)
	{
		if (Instigator.DrivenVehicle!=None)
			Weapon.SoundPitch = 56;
		else
			Weapon.SoundPitch = Max(56, Weapon.SoundPitch - 8*DT);
	}
	if (bVariableHeatProps)
	{
		XInaccuracy=FMax(16,A49SkrithBlaster(BW).HeatLevel*100);
		YInaccuracy=FMax(16,A49SkrithBlaster(BW).HeatLevel*100);
	}
}

function PlayFiring()
{
	Super.PlayFiring();
	if (bVariableHeatProps && A49SkrithBlaster(BW).HeatLevel < 5)
	{
		A49SkrithBlaster(BW).AddHeat(HeatPerShot*1.6);
	}
	A49SkrithBlaster(BW).AddHeat(HeatPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
	{
		if (bVariableHeatProps && A49SkrithBlaster(BW).HeatLevel < 5)
		{
			A49SkrithBlaster(BW).AddHeat(HeatPerShot*1.6);
		}
		A49SkrithBlaster(BW).AddHeat(HeatPerShot);
	}
}

defaultproperties
{
    FlashBone="MuzzleTip"
    FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
    bPawnRapidFireAnim=True
	HeatPerShot=0.5
    AmmoClass=Class'BallisticProV55.Ammo_Cells'
	
	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-70.000000)
	ShakeOffsetTime=2.000000
     
	//AI
	bInstantHit=True
	bLeadTarget=True
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.99
}
