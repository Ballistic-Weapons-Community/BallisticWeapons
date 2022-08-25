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
var   bool 		bPreventFire;	//prevent fire/recharging when laser is cooling
var   Actor		MuzzleFlashBlue;

var() name		PreFireAnimCharged;
var() name		FireLoopAnimCharged;
var() name		FireEndAnimCharged;

var	int		TraceCount;

var() float	OverChargedFireRate;
var   int SoundAdjust;
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

simulated function ModeTick(float DT)
{	
	if (bIsFiring && !bPreventFire && BW.MagAmmo > 0)
		XM20BCarbine(BW).SetLaserCharge(FMin(XM20BCarbine(BW).LaserCharge + XM20BCarbine(BW).ChargeRate * DT * (1 + 2*int(BW.bBerserk)), XM20BCarbine(BW).MaxCharge));
	else if (XM20BCarbine(BW).LaserCharge > 0)
	{
		if (level.TimeSeconds > StopFireTime)
			StopFiring();
			
		bPreventFire=true;
		XM20BCarbine(BW).SetLaserCharge(FMax(0.0, XM20BCarbine(BW).LaserCharge - XM20BCarbine(BW).CoolRate * DT * (1 + 2*int(BW.bBerserk))));
		
		if (XM20BCarbine(BW).LaserCharge <= 0)
			bPreventFire=false;
	}
		
	Super.ModeTick(DT);
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire() || XM20BCarbine(BW).LaserCharge < XM20BCarbine(BW).MaxCharge || TyphonPDW(BW).bShieldUp || bPreventFire)
        return;

	if (BW != None)
	{
		BW.bPreventReload=true;
		BW.FireCount++;

		if (BW.FireCount == 1)
			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

    Load = AmmoPerFire;
    HoldTime = 0;

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
	if (!BW.bScopeView)
		BW.AddFireChaos(FireChaos);
	
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

	XM20BCarbine(Weapon).ServerSwitchLaser(true);
	if (!bLaserFiring)
	{
		if (XM20BCarbine(BW).bOvercharged)
			Weapon.PlayOwnedSound(PowerFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		else
			Weapon.PlayOwnedSound(RegularFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	bLaserFiring=true;

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
		ApplyRecoil();
	}

    if (Level.NetMode == NM_DedicatedServer)
        BW.RestoreCollisions();

	SetTimer(FMin(0.1, FireRate/2), false);

	Super(WeaponFire).DoFireEffect();
}

simulated function SwitchLaserMode (byte NewMode)
{
	if (NewMode == 2) //overcharged
    {
		XM20BCarbine(BW).bOvercharged=true;
		XM20BCarbine(BW).ChargeRate=XM20BCarbine(BW).default.ChargeRateOvercharge;
	}
    else
    {
		XM20BCarbine(BW).bOvercharged=false;
		XM20BCarbine(BW).ChargeRate=XM20BCarbine(BW).default.ChargeRate;
    }
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
}

//effects code

simulated function PlayPreFire()
{    
    Instigator.AmbientSound = ChargeSound;
    //Weapon.ThirdPersonActor.AmbientSound = ChargeSound;
    Instigator.SoundVolume = 255;
	super.PlayPreFire();
}

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

//Client fire
function PlayFiring()
{
	super.PlayFiring();
	if (FireSoundLoop != None)
	{
		Instigator.AmbientSound = FireSoundLoop;
        Instigator.SoundVolume = 255;
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
        Instigator.SoundVolume = 255;
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
    Instigator.SoundVolume = Instigator.Default.SoundVolume;
	bLaserFiring=false;
	XM20BCarbine(Weapon).ServerSwitchLaser(false);
	StopFireTime = level.TimeSeconds;
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
	 FireSoundLoop=Sound'BWBP_SKC_Sounds.XM20.XM20-Lase'
     ChargeSound=Sound'BWBP_SKC_Sounds.XM20.XM20-SpartanChargeSound'
     PowerFireSound=Sound'BWBP_SKC_Sounds.XM20.XM20-Overcharge'
     RegularFireSound=Sound'BWBP_SKC_Sounds.XM20.XM20-LaserStart'
	 TraceCount=1

     MaxWaterTraceRange=5000
	 
	 Damage=16
	 HeadMult=1.5f
     LimbMult=0.5f

     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBP_SKC_Pro.DT_XM20B_Body'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20B_Head'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20B_Body'
     PenetrateForce=300
     bPenetrate=True
     FlashBone="tip"
     FlashScaleFactor=0.300000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.XM20.XM20-LaserStart',Volume=1.200000)
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
	 OverChargedFireRate=0.045
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_Laser'
     AmmoPerFire=1
     BotRefireRate=0.999000
     WarnTargetPct=0.010000
     aimerror=1.000000
}
