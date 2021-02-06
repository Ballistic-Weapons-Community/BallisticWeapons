//=============================================================================
// XM20SecondaryFire.
//
// Burning laser fire that fires while altfire is held. Uses a special recharging
// ammo counter with a small limiting delay after releasing fire.
// Switches on weapon's laser sight when firing for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20BSecondaryFire extends BallisticProInstantFire;

var() sound		FireSoundLoop;
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

function StartBerserk()
{
	super.StopBerserk();
	if (XM20BCarbine(BW).bOvercharged)
		FireRate=default.OverChargedFireRate*0.75;
}

function StopBerserk()
{
	super.StopBerserk();
	if (XM20BCarbine(BW).bOvercharged)
		FireRate=default.OverChargedFireRate;
}

function StartSuperBerserk()
{
	super.StartSuperBerserk();
	if (XM20BCarbine(BW).bOvercharged)
		FireRate = default.OverChargedFireRate/Level.GRI.WeaponBerserk;
}

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
		class'BUtil'.static.KillEmitterEffect (MuzzleFlashBlue);
		MuzzleFlashBlue=None;
		bLaserFiring=false;
		Instigator.AmbientSound = None;
	}
}


simulated function PlayPreFire()
{    
    Instigator.AmbientSound = ChargeSound;
    Weapon.ThirdPersonActor.AmbientSound = ChargeSound;
	super.PlayPreFire();
}

//Intent is for the laser to begin firing once it has spooled up
simulated event ModeDoFire()
{
    if (!AllowFire())
        return;
		
	BallisticFireSound.Sound = None;
	
    if (LaserCharge + 0.01 >= MaxCharge || AIController(Instigator.Controller) != None ) //Fire at max charge, bots ignore charging
    {
		super.ModeDoFire();
        XM20BCarbine(BW).CoolRate = XM20BCarbine(BW).default.CoolRate * (1 + 0.2*int(BW.bBerserk));
    }
    else
    {
        XM20BCarbine(BW).CoolRate = XM20BCarbine(BW).default.CoolRate * 3 * (1 + 0.2*int(BW.bBerserk));
    }

	//Overheat and lock the gun for a bit
    //XM20BCarbine(BW).Overheat(LaserCharge);
    //LaserCharge = 0;
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

	if ( XM20BCarbine(BW).Heat > 0 || !bIsFiring || XM20BCarbine(BW).MagAmmo == 0 )
	{
		LaserCharge = FMax(0.0, LaserCharge - XM20BCarbine(BW).CoolRate*DT*(1 + 2*int(BW.bBerserk)));
		return;
	}
	LaserCharge = FMin(LaserCharge + XM20BCarbine(BW).ChargeRate*DT*(1 + 2*int(BW.bBerserk)), MaxCharge);

}

simulated function SwitchLaserMode (byte NewMode)
{
	if (NewMode == 2) //overcharged
    {
		XM20BCarbine(BW).bOvercharged=true;
		FireRate=default.OverChargedFireRate;
		Damage=15.000000;
		XM20BCarbine(BW).ChargeRate=0.600000;
		PreFireAnim=PreFireAnimCharged;
		FireLoopAnim=FireLoopAnimCharged;
		FireEndAnim=FireEndAnimCharged;
		FlashScaleFactor=0.5;
	}
    else
    {
		XM20BCarbine(BW).bOvercharged=false;
		FireRate=default.FireRate;				
		Damage=default.Damage;
		XM20BCarbine(BW).ChargeRate=XM20BCarbine(BW).default.ChargeRate;
		PreFireAnim=default.PreFireAnim;
		FireLoopAnim=default.FireLoopAnim;
		FireEndAnim=default.FireEndAnim;
		FlashScaleFactor=default.FlashScaleFactor;
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
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashBlue, class'HMCRedEmitter', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	MuzzleFlash = MuzzleFlashBlue;
}

// Remove effects
simulated function DestroyEffects()
{
	Super(WeaponFire).DestroyEffects();

//	class'BUtil'.static.KillEmitterEffect (MuzzleFlashRed);
//	class'BUtil'.static.KillEmitterEffect (MuzzleFlashBlue);
}


//Server fire
function DoFireEffect()
{
	XM20BCarbine(Weapon).ServerSwitchLaser(true);
	if (!bLaserFiring)
	{
		if (XM20BCarbine(BW).bOvercharged)
			Weapon.PlayOwnedSound(PowerFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		else
			Weapon.PlayOwnedSound(RegularFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	bLaserFiring=true;
	super.DoFireEffect();
}

//Client fire
function PlayFiring()
{
	super.PlayFiring();
	if (FireSoundLoop != None)
	{
		Instigator.AmbientSound = FireSoundLoop;
		Weapon.ThirdPersonActor.AmbientSound = FireSoundLoop;
	}
	if (!bLaserFiring)
	{
		if (XM20BCarbine(BW).bOvercharged)
			Weapon.PlayOwnedSound(PowerFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		else
			Weapon.PlayOwnedSound(RegularFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	bLaserFiring=true;
}

//Server fire
function ServerPlayFiring()
{
	super.ServerPlayFiring();
	if (FireSoundLoop != None)
	{
		Instigator.AmbientSound = FireSoundLoop;
		Weapon.ThirdPersonActor.AmbientSound = FireSoundLoop;
	}
	if (!bLaserFiring)
	{
		if (XM20BCarbine(BW).bOvercharged)
			Weapon.PlayOwnedSound(PowerFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		else
			Weapon.PlayOwnedSound(RegularFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	bLaserFiring=true;
}

function StopFiring()
{
    Instigator.AmbientSound = XM20BCarbine(BW).UsedAmbientSound;
	Weapon.ThirdPersonActor.AmbientSound = None;
//    HoldTime = 0;
	bLaserFiring=false;
	XM20BCarbine(Weapon).ServerSwitchLaser(false);
	StopFireTime = level.TimeSeconds;
//	LaserCharge = 0;
}	

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	TargetedHurtRadius(7, 20, class'DT_XM20B_Body', 0, HitLocation, Other);
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( Weapon.bHurtEntry )
		return;

	Weapon.bHurtEntry = true;
	foreach Weapon.VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && UnrealPawn(Victim)==None && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim)
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	Weapon.bHurtEntry = false;
}

defaultproperties
{
	 MaxCharge=1.000000
	 FireSoundLoop=Sound'BWBP_SKC_Sounds.XM20B.XM20-Lase'
     ChargeSound=Sound'BWBP_SKC_Sounds.XM20B.XM20-SpartanChargeSound'
//	 ChargeSound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Charge'
     PowerFireSound=Sound'BWBP_SKC_Sounds.XM20B.XM20-Overcharge'
     RegularFireSound=Sound'BWBP_SKC_Sounds.XM20B.XM20-LaserStart'
	 
	 Damage=16
	 HeadMult=1.5f
     LimbMult=0.5f

     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPOtherPackPro.DT_XM20B_Body'
     DamageTypeHead=Class'BWBPOtherPackPro.DT_XM20B_Head'
     DamageTypeArm=Class'BWBPOtherPackPro.DT_XM20B_Body'
     PenetrateForce=300
     bPenetrate=True
     FlashBone="tip"
     FlashScaleFactor=0.300000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.XM20B.XM20-LaserStart',Volume=1.200000)
	 bModeExclusive=False
	 FireChaos=0
	 FireRecoil=32
     FireAnim="Fire"
     PreFireAnim="LoopStart"
	 FireLoopAnim="LoopFire"
	 FireEndAnim="LoopEnd"
	 PreFireAnimCharged="LoopOpenStart"
	 FireLoopAnimCharged="LoopOpenFire"
	 FireEndAnimCharged="LoopOpenEnd"
     TweenTime=0.000000
	 PreFireTime=0.100000
     FireRate=0.070000
	 OverChargedFireRate=0.0350000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_XM20B'
     AmmoPerFire=1
     BotRefireRate=0.999000
     WarnTargetPct=0.010000
     aimerror=1.000000
}
