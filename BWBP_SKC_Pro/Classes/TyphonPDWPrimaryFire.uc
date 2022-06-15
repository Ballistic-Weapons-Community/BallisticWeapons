//=============================================================================
// TyphonPDWPrimaryFire.
//
// Potent and accurate SMG fire with a pre-fire delay
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TyphonPDWPrimaryFire extends BallisticRangeAttenFire;

var   float		StopFireTime;
var   bool		bLaserFiring;
var   Actor		MuzzleFlashBlue;

var() name		PreFireAnimCharged;
var() name		FireLoopAnimCharged;
var() name		FireEndAnimCharged;

var() float	OverChargedFireRate;
var   int SoundAdjust;
var float		LaserCharge, MaxCharge;
var()   sound	ChargeSound;
var() sound		PowerFireSound;
var() sound		RegularFireSound;

var	int		TraceCount;

// Charge Beam Code
simulated function bool AllowFire()
{
	if (LaserCharge > 0 && LaserCharge < MaxCharge || TyphonPDW(BW).bShieldUp)
		return false;

	if (!super.AllowFire())
	{
		if (bLaserFiring)
			StopFiring();

		return false;
	}
	return true;
}

/*//Intent is for the laser to begin firing once it has spooled up
simulated event ModeDoFire()
{
	
    if (LaserCharge < MaxCharge || AIController(Instigator.Controller) != None ) //Fire at max charge, bots ignore charging
    {
       return;
    }
	super.ModeDoFire();
}*/

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire()) 
		return;
	
	// won't fire if spinning slower than lowest rotation speed
	if (LaserCharge <  MaxCharge)
        return;

	BW.bPreventReload=true;
	BW.FireCount++;
	
	if (BW.FireCount == 1)
		NextFireTime = Level.TimeSeconds;

	if (BW.ReloadState != RS_None)
		BW.ReloadState = RS_None;

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
        if(BallisticTurret(Weapon.Owner) == None  && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }
	
	BW.LastFireTime = Level.TimeSeconds;

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
		TyphonPDW(BW).UpdateScreen();
    }
    else // server
        ServerPlayFiring();

	NextFireTime += FireRate;
	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
}

// Get aim then run several individual traces using different spread for each one
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator Aim;
	local int i;

	if (!bAISilent)
		Instigator.MakeNoise(1.0);

	if (Level.NetMode == NM_DedicatedServer)
		BW.RewindCollisions();
		
	for (i=0;i<TraceCount && ConsumedLoad < BW.MagAmmo ;i++)
	{
		ConsumedLoad += Load;
		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);

		DoTrace(StartTrace, Aim);
	}
	
	if (Level.NetMode == NM_DedicatedServer)
		BW.RestoreCollisions();
	
	SetTimer(FMin(0.1, FireRate/2), false);

	Super(BallisticFire).DoFireEffect();
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

	if ( TyphonPDW(BW).Heat > 0 || !bIsFiring || TyphonPDW(BW).MagAmmo == 0 )
	{
		LaserCharge = FMax(0.0, LaserCharge - TyphonPDW(BW).CoolRate*DT*(1 + 2*int(BW.bBerserk)));
		return;
	}
	LaserCharge = FMin(LaserCharge + TyphonPDW(BW).ChargeRate*DT*(1 + 2*int(BW.bBerserk)), MaxCharge);
}

simulated function PlayPreFire()
{    
    Instigator.AmbientSound = ChargeSound;
    Instigator.SoundVolume = 255;
	super.PlayPreFire();
}

simulated function SwitchCannonMode (byte NewMode)
{
	if (NewMode == 1) //overcharged
    {
		TyphonPDW(BW).ChargeRate=TyphonPDW(BW).default.ChargeRateOvercharge;
	}
    else
    {
		TyphonPDW(BW).ChargeRate=TyphonPDW(BW).default.ChargeRate;
    }
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
}

//effects code

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if (MuzzleFlashBlue == None || MuzzleFlashBlue.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashBlue, class'HMCFlashEmitter', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	MuzzleFlash = MuzzleFlashBlue;
}

// Remove effects
simulated function DestroyEffects()
{
	Super(WeaponFire).DestroyEffects();
}

function StopFiring()
{
    Instigator.AmbientSound = TyphonPDW(BW).UsedAmbientSound;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;

	StopFireTime = level.TimeSeconds;
}	


defaultproperties
{
	 ChargeSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Ambient'
	 TraceCount=1
	 MaxCharge=1.000000
     WaterRangeAtten=0.500000
	 DryFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Empty',Volume=1.200000)
     BrassClass=Class'BWBP_SKC_Pro.Brass_PUMA'
     BrassOffset=(X=-30.000000,Y=1.000000)
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_Laser'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
}
