//=============================================================================
// XMV850MinigunPrimaryFire.
//
// Home to the minigun's power and the things that allow its ridiculous RoF
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV850MinigunPrimaryFire extends BallisticRangeAttenFire;

var rotator OldLookDir, TurnVelocity;
var float	LastFireTime, MuzzleBTime, MuzzleCTime, OldFireRate;
var Actor	MuzzleFlashB, MuzzleFlashC;
var XMV850Minigun Minigun;

var float	LagTime;

var	int		TraceCount;

var bool	bStarted;

var float	NextTVUpdateTime;

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);

	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlaySound(Minigun.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}

	ClientPlayForceFeedback(FireForce);  // jdf
	FireCount++;

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
}

function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlayOwnedSound(Minigun.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}
}

function StopFiring()
{
	bStarted = false;
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
	super.InitEffects();
	if ((MuzzleFlashClass != None) && ((MuzzleFlashB == None) || MuzzleFlashB.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashB, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	if ((MuzzleFlashClass != None) && ((MuzzleFlashC == None) || MuzzleFlashC.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashC, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlashB);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashC);
}

simulated function rotator GetNewAim(float ExtraTime)
{
	return class'BUtil'.static.RSmerp(FMin((BW.ReaimPhase+ExtraTime)/BW.ReaimTime, 1.0), BW.OldAim, BW.NewAim);
}

simulated function rotator GetNewAimOffset(float ExtraTime)
{
	return class'BUtil'.static.RSmerp(FMax(0.0,(BW.AimOffsetTime-(level.TimeSeconds+ExtraTime))/BW.AimAdjustTime), BW.NewAimOffset, BW.OldAimOffset);
}
// Returns the interpolated base aim with its offset, chaos, etc and view aim removed in the form of a single rotator
simulated function Rotator GetNewAimPivot(float ExtraTime, optional bool bIgnoreViewAim)
{
	if (bIgnoreViewAim || Instigator.Controller == None || PlayerController(Instigator.Controller) == None || PlayerController(Instigator.Controller).bBehindView)
		return GetNewAimOffset(ExtraTime) + GetNewAim(ExtraTime) + BW.AimOffset + BW.LongGunPivot * BW.LongGunFactor;
	return GetNewAimOffset(ExtraTime) + GetNewAim(ExtraTime) * (1-BW.ViewAimFactor) + BW.AimOffset + BW.LongGunPivot * BW.LongGunFactor;
}

//FIXME, maybe lets not use adjust aim, cause it does some traces and target selecting!!!
simulated function vector GetNewFireDir(out Vector StartTrace, float ExtraTime)
{
    // the to-hit trace always starts right in front of the eye
    if (BallisticTurret(Instigator) != None)
    	StartTrace = Instigator.Location + Instigator.EyePosition() + Vector(Instigator.GetViewRotation()) * 64;
//    	StartTrace = Instigator.Location + BallisticTurret(Instigator).CameraElevation * vect(0,0,1);
	else if (StartTrace == vect(0,0,0))
		StartTrace = Instigator.Location + Instigator.EyePosition();
	if (AIController(Instigator.Controller) != None && BallisticTurret(Instigator) == None)
		return Vector(GetNewAimPivot(ExtraTime) + BW.GetRecoilPivot()) >> AdjustAim(StartTrace, AimError);
	else
		return Vector(GetNewAimPivot(ExtraTime) + BW.GetRecoilPivot()) >> BW.GetPlayerAim(true);
}

// Like GetFireDir, but returns a rotator instead
simulated function rotator GetNewFireAim(out Vector StartTrace, float ExtraTime)
{
	return Rotator(GetNewFireDir(StartTrace, ExtraTime));
}

event PostBeginPlay()
{
	OldLookDir = BW.GetPlayerAim();
	OldFireRate = FireRate;
	super.PostBeginPlay();
}

// Fire TraceCount each DoFireEvent
// FireRate = DesiredFireRate / TraceCount
// TraceCount
/*
DesiredFireRate = 1 / (60*BarrelSpeed);

DesiredFireRate = 60 * BarrelSpeed;
if  (1 / (60*BarrelSpeed))

FireRate = DesiredRate / TraceCount


DesiredFireRate = (FMin(1 / (60*BarrelSpeed), 1));

TraceCount = Ceil((level.TimeSeconds - level.LastRenderTime) / DesiredFireRate);

FireRate = DesiredFireRate / TraceCount;
*/

event ModeTick(float DT)
{
	local float DesiredFireRate;
	local Rotator BasePlayerView;

	BasePlayerView = BW.GetPlayerAim() - BW.Aim * (BW.ViewAimFactor) - BW.GetRecoilPivot(true) * (BW.ViewRecoilFactor);
	if (Instigator.IsLocallyControlled())
	{
		TurnVelocity = (BasePlayerView - OldLookDir) / DT;
		OldLookDir = BasePlayerView;
		if (level.NetMode == NM_Client && level.TimeSeconds > NextTVUpdateTime)
		{
			Minigun.SetServerTurnVelocity(TurnVelocity.Yaw, TurnVelocity.Pitch);
			NextTVUpdateTime = level.TimeSeconds + 0.15;
		}
	}

	OldFireRate = FireRate;

	if (Minigun.BarrelSpeed <= 0)
	{
		FireRate = 1.0;
		TraceCount = 1;
	}
	else
	{
		DesiredFireRate = (FMin(1.0 / (60*Minigun.BarrelSpeed), 1));
		if (BW.CurrentWeaponMode == 0)
			TraceCount = 1;
		else
			TraceCount = Ceil((DT*1.5) / DesiredFireRate);
		FireRate = DesiredFireRate * TraceCount;
	}
	NextFireTime += FireRate - OldFireRate;

	if (MuzzleBTime != 0)
	{
		MuzzleBTime += FireRate / TraceCount - OldFireRate / TraceCount;
		if (level.TimeSeconds >= MuzzleBTime)
		{
			MuzzleBTime = 0;
		    if (MuzzleFlashB != None)
    		    MuzzleFlashB.Trigger(Weapon, Instigator);
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
			EjectBrass();
		}
	}
	if (MuzzleCTime != 0)
	{
		MuzzleCTime += FireRate / TraceCount - OldFireRate / TraceCount;
		if (level.TimeSeconds >= MuzzleCTime)
		{
			MuzzleCTime = 0;
		    if (MuzzleFlashC != None)
    		    MuzzleFlashC.Trigger(Weapon, Instigator);
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
			EjectBrass();
		}
	}

	super.ModeTick(DT);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (level.NetMode != NM_StandAlone)
		XMV850MinigunAttachment(Weapon.ThirdPersonActor).UpdateTurnVelocity(TurnVelocity);
}

// Get aim then run several individual traces using different spread for each one
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator R, Aim, ExtraAim, AimInterval;
	local int i;
	local float Interval, ExtraTime;

	if (!bAISilent)
		Instigator.MakeNoise(1.0);

	if (TraceCount > 1)
	{
		Interval = FireRate / TraceCount;
		AimInterval = TurnVelocity * Interval;
	}

	for (i=0;i<TraceCount && ConsumedLoad < BW.MagAmmo ;i++)
	{
		ConsumedLoad += Load;
		Aim = GetNewFireAim(StartTrace, ExtraTime);
		Aim += ExtraAim;
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
		FireRecoil();
		if (i == 1)
			MuzzleBTime = Level.TimeSeconds + ExtraTime;
		else if (i == 2)
			MuzzleCTime = Level.TimeSeconds + ExtraTime;
		ExtraTime += Interval;
		ExtraAim += AimInterval;
	}
	SetTimer(FMin(0.1, FireRate/2), false);

//	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(WeaponFire).DoFireEffect();
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire() || XMV850Minigun(BW).BarrelSpeed < XMV850Minigun(BW).DesiredSpeed)
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
	if (!BW.bScopeView)
		BW.FireChaos = FClamp(BW.FireChaos + FireChaos, 0, 1);
	
	BW.LastFireTime = Level.TimeSeconds;

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
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

defaultproperties
{
	 CutOffStartRange=3072
	 CutOffDistance=6144
	 RangeAtten=0.35
     TraceCount=1
     TraceRange=(Min=12000.000000,Max=12000.000000)
     WaterRangeFactor=0.800000
     WallPenetrationForce=16.000000
     
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTXMV850MG'
     DamageTypeHead=Class'BallisticProV55.DTXMV850MGHead'
     DamageTypeArm=Class'BallisticProV55.DTXMV850MG'
     KickForce=1000
     PenetrateForce=150
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
     FlashScaleFactor=0.800000
     BrassClass=Class'BallisticProV55.Brass_Minigun'
     BrassOffset=(X=-50.000000,Y=-8.000000,Z=5.000000)
     RecoilPerShot=72.000000
     VelocityRecoil=48.000000
     FireChaos=0.120000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.XMV-850.XMV-Fire-1',Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireRate=0.050000
     AmmoClass=Class'BallisticProV55.Ammo_MinigunRounds'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
