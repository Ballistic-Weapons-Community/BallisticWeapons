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

simulated event ModeDoFire()
{
	local int Avail, PriCL, AltCL, Inv;

	if (BW != None)
	{
		if (BW.BFireMode[0] != None) PriCL = BW.BFireMode[0].ConsumedLoad;
		if (BW.BFireMode[1] != None) AltCL = BW.BFireMode[1].ConsumedLoad;
		Inv = Weapon.AmmoAmount(ThisModeNum);

		if (BW.bNoMag || !bUseWeaponMag)
		{
			Avail = Inv - PriCL - AltCL;
		}
		else
		{
			Avail = BW.MagAmmo - PriCL - AltCL;
		}

		Load = Max(1, Min(4, Avail));
	}
	else
		Load = 1;

	super.ModeDoFire();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local int i, j;
	local rotator R;

	j = Load;
	if (j < 1)
		j = 1;
	for (i=0;i<j;i++)
	{
		R.Roll = (65536.0 / j) * i;

		Proj = Spawn (ProjectileClass,,, Start, rotator((Vector(rot(400,400,0)) >> R) >> Dir) );
		if (Proj != None)
			Proj.Instigator = Instigator;
	}
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
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_FLASH'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-50.000000)
     ShakeOffsetRate=(X=-1600.000000)
     ShakeOffsetTime=5.000000
     ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
     BotRefireRate=0.300000
     WarnTargetPct=1
}
