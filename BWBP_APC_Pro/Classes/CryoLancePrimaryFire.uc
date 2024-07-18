//=============================================================================
// CryoLancePrimaryFire.
//
// Very automatic, bullet style instant hit. Shots have medium range and good
// power. Accuracy and ammo goes quickly with its faster than normal rate of fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CryoLancePrimaryFire extends BallisticProInstantFire;

var() sound		FireSoundLoop;
var   float		StopFireTime;
var   bool		bLaserFiring;

var float		LaserCharge, MaxCharge;
var()   sound	ChargeSound;

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
		Instigator.AmbientSound = CryoLanceLauncher(BW).UsedAmbientSound;
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
        CryoLanceLauncher(BW).CoolRate = CryoLanceLauncher(BW).default.CoolRate * (1 + 0.2*int(BW.bBerserk));
    }
    else
    {
        CryoLanceLauncher(BW).CoolRate = CryoLanceLauncher(BW).default.CoolRate * 3 * (1 + 0.2*int(BW.bBerserk));
    }
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);
	if ( CryoLanceLauncher(BW).Heat > 0 || !bIsFiring || CryoLanceLauncher(BW).MagAmmo == 0 )
	{
		LaserCharge = FMax(0.0, LaserCharge - CryoLanceLauncher(BW).CoolRate*DT*(1 + 2*int(BW.bBerserk)));
		return;
	}
	LaserCharge = FMin(LaserCharge + CryoLanceLauncher(BW).ChargeRate*DT*(1 + 2*int(BW.bBerserk)), MaxCharge);
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
    Instigator.AmbientSound = CryoLanceLauncher(BW).UsedAmbientSound;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;
	bLaserFiring=true;
}

//Server fire
function ServerPlayFiring()
{
	super.ServerPlayFiring();
    Instigator.AmbientSound = CryoLanceLauncher(BW).UsedAmbientSound;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;
	bLaserFiring=true;
}

function StopFiring()
{
    Instigator.AmbientSound = CryoLanceLauncher(BW).UsedAmbientSound;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;
	StopFireTime = level.TimeSeconds;
	bLaserFiring=false;
}	

defaultproperties
{
     MaxCharge=1.000000
	 FireSoundLoop=Sound'BWBP_SKC_Sounds.XM20B.XM20-Lase'
     ChargeSound=Sound'BWBP_SKC_Sounds.LS440.LS440-SpinUp'
	 PreFireAnim="LoopStart"
	 FireLoopAnim="LoopFire"
	 FireEndAnim="LoopEnd"
	 DecayRange=(Min=2048,Max=5120)
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WallPenetrationForce=16.000000
     Damage=20.000000
     RangeAtten=0.350000
     DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
     PenetrateForce=150
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=False
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_MG'
     BrassOffset=(X=-80.000000,Y=1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=140.000000
     FireChaos=0.02000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     SilencedFireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.F2000-SilFire2',Volume=1.100000,Radius=192.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-RapidFire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FlashBone="tip"
	 FireRate=0.080000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_545mmSTANAG'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
