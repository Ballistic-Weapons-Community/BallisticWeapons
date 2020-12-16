//=============================================================================
// FLASHSecondaryFire.
//
// 4 (four) rockets!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FLASHSecondaryFire extends BallisticProProjectileFire;

var() class<Actor>	HatchSmokeClass;
var   Actor			HatchSmoke;
var() Sound			SteamSound;


	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		local int i, j;
		local rotator R;

		j = Min(4, BW.MagAmmo);
		ConsumedLoad += j-1;
		for (i=0;i<j;i++)
		{
			R.Roll = (65536.0 / j) * i;

			Proj = Spawn (ProjectileClass,,, Start, rotator((Vector(rot(400,400,0)) >> R) >> Dir) );
			Proj.Instigator = Instigator;
		}
	}

// Used to delay ammo consumtion
simulated event Timer()
{
	super.Timer();
	if (Weapon.Role == ROLE_Authority && ConsumedLoad > 0)
	{
		if (BW != None)
			BW.ConsumeMagAmmo(ThisModeNum,ConsumedLoad);
		else
			Weapon.ConsumeAmmo(ThisModeNum,ConsumedLoad);
	}
	ConsumedLoad=0;
}

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
     FireRecoil=1024.000000
     XInaccuracy=400.000000
     YInaccuracy=400.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Flash.M202-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     FireAnim="Fireall"
     FireEndAnim=
     FireRate=3.500000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_FLASH'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-50.000000)
     ShakeOffsetRate=(X=-2000.000000)
     ShakeOffsetTime=5.000000
     ProjectileClass=Class'BWBPRecolorsPro.FLASHProjectile'
     BotRefireRate=0.300000
     WarnTargetPct=1
}
