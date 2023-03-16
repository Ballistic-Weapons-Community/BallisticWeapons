//=============================================================================
// LS440PrimaryFire.
//
// Full auto lasers.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LS440PrimaryFire extends BallisticInstantFire;

var() sound		FireSoundLoop;
var   float		StopFireTime;
var   bool		bLaserFiring;

var float		LaserCharge, MaxCharge;
var()   sound	ChargeSound;


var() Actor						MuzzleFlash2;		// The muzzleflash actor
var   bool			bSecondBarrel;
var() int SplashDamage;
var() int SplashDamageRadius;

// Charge Beam Code
simulated function bool AllowFire()
{
	if (LaserCharge > 0 && LaserCharge < MaxCharge)
		return false;

	if (!super.AllowFire())
	{
		if (bLaserFiring)
			StopFiring();

		return false;
	}
	return true;
}

// Used to delay ammo consumtion
simulated event Timer()
{
	super.Timer();

	if (bLaserFiring && !IsFiring())
	{
		bLaserFiring=false;
		Instigator.AmbientSound = LS440Instagib(BW).UsedAmbientSound;
        Instigator.SoundVolume = Instigator.Default.SoundVolume;
	}
}

simulated function PlayPreFire()
{    
    Instigator.AmbientSound = ChargeSound;
    Instigator.SoundVolume = 255;
	super.PlayPreFire();
}

//Intent is for the laser to begin firing once it has spooled up
simulated event ModeDoFire()
{
    if (!AllowFire())
        return;
	
    if (LaserCharge + 0.01 >= MaxCharge || AIController(Instigator.Controller) != None ) //Fire at max charge, bots ignore charging
    {
		super.ModeDoFire();
        LS440Instagib(BW).CoolRate = LS440Instagib(BW).default.CoolRate * (1 + 0.2*int(BW.bBerserk));
    }
    else
    {
        LS440Instagib(BW).CoolRate = LS440Instagib(BW).default.CoolRate * 3 * (1 + 0.2*int(BW.bBerserk));
    }
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

	if ( LS440Instagib(BW).Heat > 0 || !bIsFiring || LS440Instagib(BW).MagAmmo == 0 )
	{
		LaserCharge = FMax(0.0, LaserCharge - LS440Instagib(BW).CoolRate*DT*(1 + 2*int(BW.bBerserk)));
		return;
	}
	LaserCharge = FMin(LaserCharge + LS440Instagib(BW).ChargeRate*DT*(1 + 2*int(BW.bBerserk)), MaxCharge);
}

//Server fire
function DoFireEffect()
{
	bLaserFiring=true;
	super.DoFireEffect();
}

//Client fire
function PlayFiring()
{
	super.PlayFiring();
    Instigator.AmbientSound = LS440Instagib(BW).UsedAmbientSound;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;
	bLaserFiring=true;
}

//Server fire
function ServerPlayFiring()
{
	super.ServerPlayFiring();
    Instigator.AmbientSound = LS440Instagib(BW).UsedAmbientSound;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;
	bLaserFiring=true;
}

function StopFiring()
{
    Instigator.AmbientSound = LS440Instagib(BW).UsedAmbientSound;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;
	StopFireTime = level.TimeSeconds;
	bLaserFiring=false;
}	

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget)
	{
		BW.TargetedHurtRadius(SplashDamage, SplashDamageRadius, class'DT_AH104Pistol', 200, HitLocation, Pawn(Victim));
	}
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	if (Other == None || Other.bWorldGeometry)
		BW.TargetedHurtRadius(SplashDamage, SplashDamageRadius, DamageType, 0, HitLocation);
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}


defaultproperties
{
	 MaxCharge=1.000000
	 FireSoundLoop=Sound'BWBP_SKC_Sounds.XM20B.XM20-Lase'
     ChargeSound=Sound'BWBP_SKC_Sounds.LS440.LS440-SpinUp'
     TraceRange=(Min=1500000.000000,Max=1500000.000000)
     Damage=45
     HeadMult=2.0
     LimbMult=1.0
	 SplashDamage=10
	 SplashDamageRadius=32
     DamageType=Class'BWBP_SKC_Pro.DT_LS440Body'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_LS440Head'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_LS440Body'
     KickForce=25000
     PenetrateForce=500
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
//     MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXLaserFlashEmitter'
//     MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
     FlashScaleFactor=0.400000
     //RecoilPerShot=20.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS440.LS440-Fire',Volume=0.900000)
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.150000
	AmmoPerFire=2
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     ShakeRotMag=(X=200.000000,Y=16.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-2.500000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=1.050000
     WarnTargetPct=0.050000
     aimerror=800.000000
}
