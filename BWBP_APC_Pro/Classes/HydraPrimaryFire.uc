//=============================================================================
// HydraPrimaryFire.
//
// Rocket launching primary fire for Hydra
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HydraPrimaryFire extends BallisticProProjectileFire;

var() class<Actor>	HatchSmokeClass;
var   Actor			HatchSmoke;
var() Sound			SteamSound;

var int MinMortarRange;

simulated event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (class'BallisticReplicationInfo'.default.bNoReloading && BW.AmmoAmount(0) > 1)
		Weapon.SetBoneScale (0, 1.0, 'Rocket');
	else if (BW.MagAmmo < 2)
		Weapon.SetBoneScale (0, 0.0, 'Rocket');
	Super.ModeDoFire();
}

function DoFireEffect()
{	
    local Vector Start, End, X;
    local Rotator Aim;

	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);
	X = Normal(Vector(Aim));
	End = Start + X * MinMortarRange;
	
	Super.DoFireEffect();
}

simulated function InitEffects()
{
    if ((HatchSmokeClass != None) && ((HatchSmoke == None) || HatchSmoke.bDeleteMe) )
	{
		HatchSmoke = Spawn(HatchSmokeClass, Weapon);

		if ( HatchSmoke != None )
			Weapon.AttachToBone(HatchSmoke, 'tip');

		if (Emitter(HatchSmoke) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(HatchSmoke), Weapon.DrawScale*FlashScaleFactor);
		else
			HatchSmoke.SetDrawScale(HatchSmoke.DrawScale*Weapon.DrawScale*FlashScaleFactor);

		if (DGVEmitter(HatchSmoke) != None)
			DGVEmitter(HatchSmoke).InitDGV();
	}
	Super.InitEffects();
}

simulated function FlashHatchSmoke()
{
	if (Level.DetailMode < DM_High)
		return;
    if (HatchSmoke != None && Level.TimeSeconds < NextFireTime + 3.0)
	{
		Weapon.PlaySound(SteamSound, SLOT_Misc, 0.3);
		Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Min = Lerp(((NextFireTime+3.0) - Level.TimeSeconds) / 3.8, 10, 70);
		Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Max = Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Min;
        HatchSmoke.Trigger(Weapon, Instigator);
	}
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();

    if (HatchSmoke != None)
	{
		if (Emitter(HatchSmoke) != None)
			Emitter(HatchSmoke).Kill();
		else
			HatchSmoke.Destroy();
	}
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	super.SpawnProjectile(Start, Dir);
	
	if (HydraSeekerRocket(Proj) != None)
	{
		HydraSeekerRocket(Proj).Weapon = HydraBazooka(BW);
		HydraSeekerRocket(Proj).LastLoc = HydraBazooka(BW).GetRocketDir();
	}
}


defaultproperties
{
     HatchSmokeClass=Class'BWBP_APC_Pro.HydraHatchEmitter'
     SteamSound=Sound'BW_Core_WeaponSound.G5.G5-Steam'
     MinMortarRange=1024
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     bCockAfterFire=False
     MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
     FireRecoil=64.000000
     FireChaos=0.500000
     XInaccuracy=4.000000
     YInaccuracy=4.000000
     //BallisticFireSound=(SoundGroup=Sound'BWBP_APC_Sounds.Launcher.Launcher-Fire')
     FireEndAnim=
     FireRate=0.800000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_HRPG'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BWBP_APC_Pro.HydraRocket'
	 
	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=True
	 BotRefireRate=0.5
     WarnTargetPct=0.8
}
