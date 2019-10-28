//=============================================================================
// LAWPrimaryFire.
//
// Almost-Instant LAW Rocket
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LAWPrimaryFire extends BallisticProProjectileFire;

var() class<Actor>	HatchSmokeClass;
var   Actor			HatchSmoke;
var() Sound			SteamSound;
var   float RailPower;


simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	if (BW.bScopeView)
		return super.GetFireSpread();
	else
	{
		fX = frand();
		R.Yaw =  1024 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
		R.Pitch = 1024 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
		return Vector(R);
	}
}

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
     RecoilPerShot=3072.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.LAW.LAW-FireLoud',Volume=4.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     FireEndAnim=
     FireRate=0.950000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_LAW'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-50.000000)
     ShakeOffsetRate=(X=-2000.000000)
     ShakeOffsetTime=5.000000
     ProjectileClass=Class'BWBPRecolorsPro.LAWRocket'
     BotRefireRate=0.500000
     WarnTargetPct=0.300000
}
