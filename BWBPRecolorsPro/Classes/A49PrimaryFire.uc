//=============================================================================
// A49 Skrith Blaster Primary.
//
// Craps out deadly projectiles.
//=============================================================================
class A49PrimaryFire extends BallisticProProjectileFire;

var float StopFireTime;
var float HeatPerShot;

simulated function bool AllowFire()
{
	if ((A49SkrithBlaster(Weapon).HeatLevel >= 12) || !super.AllowFire())
		return false;
	return true;
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
}

function PlayFiring()
{
	Super.PlayFiring();
	A49SkrithBlaster(BW).AddHeat(HeatPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		A49SkrithBlaster(BW).AddHeat(HeatPerShot);
}

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
     FlashBone="MuzzleTip"
     FlashScaleFactor=0.150000
     RecoilPerShot=108.000000
     FireChaos=0.070000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.A49.A49-Fire',Volume=0.700000,Pitch=1.200000)
     bPawnRapidFireAnim=True
     FireEndAnim=
	 HeatPerShot=1.2
     FireRate=0.135000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPRecolorsPro.A49Projectile'
     WarnTargetPct=0.300000
}
