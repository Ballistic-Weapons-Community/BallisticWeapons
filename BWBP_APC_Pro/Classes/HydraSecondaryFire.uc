//=============================================================================
// HydraSecondaryFire.
//
// Rocket launching secondary fire for Hydra
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HydraSecondaryFire extends BallisticProProjectileFire;

var()	Name					ChargeAnim;		//Animation to use when charging
var		float					ChargeGainPerSecond, ChargeDecayPerSecond, ChargeOvertime, MaxChargeOvertime;
var		int						SpawnCount;	//Number of rockets to spawn upon releasing
var		bool 					AmmoHasBeenCalculated;

var()	Sound					RocketCountSound;	//Sound to play when another rocket is to be fired.
var		float					NextBeepTime;	//naming variables is not my strong suit
var		int						BeepCount;	//seriously?

// ModeDoFire from WeaponFire.uc, but with a few changes
// to think that all I need is to rearrange for LastFireTime to be placed before projectiles are spawned
simulated event ModeDoFire()
{
	Load = CalculateAmmoUse();
	SpawnCount = Load;
	AmmoHasBeenCalculated = true;

    super.ModeDoFire();
}

simulated function PlayStartHold()
{	
	BW.bPreventReload=True;
	BW.SafeLoopAnim(ChargeAnim, 1.0, TweenTime, ,"IDLE");
}

simulated function int CalculateAmmoUse()
{	
	if (HydraBazooka(BW).MultiRockets >= BW.MagAmmo)
		return BW.MagAmmo;

	return Max(1, int(HydraBazooka(BW).MultiRockets));
}

simulated function ModeTick(float DeltaTime)
{	
	if (bIsFiring)
	{
		if (level.TimeSeconds >= NextBeepTime && BeepCount <= Min(BW.MagAmmo, class'HydraBazooka'.default.MaxMultiRockets))
		{
			if (BeepCount > 0)
				Weapon.PlaySound(RocketCountSound,,0.7,,32);
				
			NextBeepTime = level.TimeSeconds + (1 / (ChargeGainPerSecond));
			BeepCount++;
		}
	
		//Scale charge
		HydraBazooka(BW).MultiRockets = FMin(Min(BW.MagAmmo, class'HydraBazooka'.default.MaxMultiRockets), HydraBazooka(BW).MultiRockets + ChargeGainPerSecond * DeltaTime);
		
		if (HydraBazooka(BW).MultiRockets >= Min(BW.MagAmmo, class'HydraBazooka'.default.MaxMultiRockets))
			ChargeOvertime += DeltaTime;
		
		if (ChargeOvertime >= MaxChargeOvertime)
			bIsFiring = false;
	}

	else if (HydraBazooka(BW).MultiRockets > 0 && AmmoHasBeenCalculated)
	{
		HydraBazooka(BW).MultiRockets = FMax(0.0, HydraBazooka(BW).MultiRockets - ChargeDecayPerSecond * DeltaTime);			
		ChargeOvertime = 0;
		BeepCount = 0;
		
		if (HydraBazooka(BW).MultiRockets == 0)
			AmmoHasBeenCalculated = false;
	}
		
	Super.ModeTick(DeltaTime);
}

function DoFireEffect()
{
    local Vector Start, X, Y, Z, End, HitLocation, HitNormal, StartTrace, FireLocation;
    local Rotator Aim, FireDirection;
	local actor Other;
	local int i;

	if (SpawnCount < 2)
	{
		super.DoFireEffect();
		return;
	}

    Weapon.GetViewAxes(X,Y,Z);
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();
    
    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if ( !Weapon.WeaponCentered() )
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);
	
	//wall check
	End = Start + (Vector(Aim) * SpawnOffset.X);
	Other = Weapon.Trace(HitLocation, HitNormal, End, Start, false);
	if (Other != None)
		StartTrace = HitLocation;
	//end wall check

	End = Start + (Vector(Aim)*MaxRange());
	Other = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other != None)
		Aim = Rotator(HitLocation-StartTrace);
		
	//multi-rocket code - based on UT2004 rocket launcher multi fire
	for (i=1; i <= SpawnCount; i++)
    {
 		//FireLocation = StartTrace - 2*((Sin(i*2*PI/SpawnCount)*8 - 7)*Y - (Cos(i*2*PI/SpawnCount)*8 - 7)*Z) - X * 8;
		FireDirection = Aim;
		FireDirection.Pitch += 3584*Sin(i*2*PI/SpawnCount);
		FireDirection.Yaw += 3584*Cos(i*2*PI/SpawnCount);
        SpawnProjectile(StartTrace, FireDirection);
    }

	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	super.SpawnProjectile(Start, Dir);
	
	if (HydraSwoopRocket(Proj) != None)
	{
		HydraSwoopRocket(Proj).LaunchTime = level.TimeSeconds;
		HydraSwoopRocket(Proj).Weapon = HydraBazooka(BW);
		HydraSwoopRocket(Proj).StartLoc = Start;
		HydraSwoopRocket(Proj).EndLoc = HydraBazooka(BW).GetRocketDir();
		HydraSwoopRocket(Proj).LastLoc = HydraSwoopRocket(Proj).EndLoc;
		HydraSwoopRocket(Proj).LaunchTime = level.TimeSeconds;
	}
	else if (HydraSeekerRocket(Proj) != None)
	{
		HydraSeekerRocket(Proj).Weapon = HydraBazooka(BW);
		HydraSeekerRocket(Proj).LastLoc = HydraBazooka(BW).GetRocketDir();
	}
}

defaultproperties
{
	 RocketCountSound=Sound'BWBP_CC_Sounds.Launcher.Launcher-Beep'
	 MaxChargeOvertime=3.0f
	 ChargeGainPerSecond=3.6f
	 ChargeDecayPerSecond=18.0f
	 ChargeAnim="ChargeUp"
     bFireOnRelease=True
	 //ChargingSound=Sound'GeneralAmbience.texture22'
	 SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     bCockAfterFire=False
     MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
     FireRecoil=64.000000
     FireChaos=0.500000
     XInaccuracy=4.000000
     YInaccuracy=4.000000
     //BallisticFireSound=(SoundGroup=Sound'BWBP_CC_Sounds.Launcher.Launcher-Fire')
     FireEndAnim=
     FireRate=1.200000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_HRPG'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BWBP_APC_Pro.HydraSwoopRocket'
	 
	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=True
	 BotRefireRate=0.5
     WarnTargetPct=0.8
}
