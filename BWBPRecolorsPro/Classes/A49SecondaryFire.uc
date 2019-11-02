//=============================================================================
// A49 Secondary Fire.
//
// Reworked. Blasts enemies away in a cone. Can no longer be used as a mobility enhancer.
//
// - Azarael
//=============================================================================

class A49SecondaryFire extends BallisticFire;

var float	ForceMag;
var float	Damage;
var float HeatPerShot;

simulated function bool AllowFire()
{
	if ((A49SkrithBlaster(Weapon).HeatLevel >= 12) || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	A49SkrithBlaster(BW).AddHeat(HeatPerShot);
}

function DoFireEffect()
{
	local Vector Start;
	local Rotator Aim;
	
	Start = Instigator.Location + Instigator.EyePosition();
	
	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);
	
	A49SkrithBlaster(BW).ConicalBlast(Damage, 512, Vector(Aim));
	
	if (Level.NetMode == NM_DedicatedServer)
		A49SkrithBlaster(BW).AddHeat(HeatPerShot);
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
	FS.DamageInt = default.Damage;
	FS.Damage = String(FS.DamageInt);
	FS.DPS = default.Damage / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/default.Damage) - 1);
	FS.RPM = 1/default.FireRate@"blasts/second";
	FS.Range = "Max:"@(512/ 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
     forceMag=1000.000000
     Damage=35.000000
	 HeatPerShot=10
     MuzzleFlashClass=Class'BWBPRecolorsPro.A49FlashEmitter'
     FlashBone="MuzzleTip"
     FlashScaleFactor=1.200000
     BrassOffset=(X=15.000000,Y=-13.000000,Z=7.000000)
     RecoilPerShot=512.000000
     VelocityRecoil=1500.000000
     FireChaos=0.500000
	 FireRate=1.25
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.A49.A49-ShockWave',Volume=2.000000)
     FireAnim="AltFire"
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     AmmoPerFire=9
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
