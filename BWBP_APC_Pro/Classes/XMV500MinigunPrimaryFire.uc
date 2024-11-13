//=============================================================================
// XMV500MinigunPrimaryFire.
//
// Home to the minigun's power and the things that allow its ridiculous RoF. Must
// charge to a firing speed before firing.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV500MinigunPrimaryFire extends BallisticInstantFire;

var rotator OldLookDir, TurnVelocity;
var float	LastFireTime, MuzzleBTime, MuzzleCTime, OldFireRate;
var Actor	MuzzleFlashB, MuzzleFlashC;
var XMV500Minigun Minigun;
var() int SplashDamage;
var() int SplashDamageRadius;

var float	LagTime;

var	int		TraceCount;

var bool	bStarted;

var float	NextTVUpdateTime;

// Sound'BWBP_SKC_Sounds.550.Mini-Fire'
// SoundGroup'BWBP_SKC_Sounds.550.Mini_Fire-2'
// SoundGroup'BWBP_SKC_Sounds.550.Mini_Fire-3'
// Sound'BW_Core_WeaponSound.XMV-850.XMV-ClipIn'
// Sound'BW_Core_WeaponSound.XMV-850.XMV-ClipOut'
// Sound'BWBP_SKC_Sounds.550.Mini_Rotor'
// Sound'BWBP_SKC_Sounds.550.Mini_Down'
// Sound'BWBP_SKC_Sounds.550.Mini_Up'
// Sound'BW_Core_WeaponSound.XMV-850.XMV-Deploy'
// Sound'BW_Core_WeaponSound.XMV-850.XMV-UnDeploy'

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

// Returns the interpolated base aim with its offset, chaos, etc and view aim removed in the form of a single rotator
simulated function Rotator GetNewAimPivot(float ExtraTime, optional bool bIgnoreViewAim)
{
	return BW.CalcFutureAim(ExtraTime, bIgnoreViewAim);
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

event ModeTick(float DT)
{
	local float DesiredFireRate;
	local Rotator BasePlayerView;

	BasePlayerView = BW.GetBasePlayerView();
	if (!Instigator.IsLocallyControlled())
	{
/*		if (abs(BasePlayerView.Yaw - OldLookDir.Yaw) < 16 && abs(BasePlayerView.Pitch - OldLookDir.Pitch) < 16)
			LagTime += DT;
		else
		{
			TurnVelocity = (BasePlayerView - OldLookDir) / (DT+LagTime);
			OldLookDir = BasePlayerView;
			LagTime=0;
		}
*/	}
	else
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
		XMV500MinigunAttachment(Weapon.ThirdPersonActor).UpdateTurnVelocity(TurnVelocity);
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
		ApplyRecoil();
		if (i == 1)
			MuzzleBTime = Level.TimeSeconds + ExtraTime;
		else if (i == 2)
			MuzzleCTime = Level.TimeSeconds + ExtraTime;
		ExtraTime += Interval;
		ExtraAim += AimInterval;
	}
	SetTimer(FMin(0.1, FireRate/2), false);

	Super(WeaponFire).DoFireEffect();

	if (!AllowFire() || XMV500Minigun(Weapon).bRunOffsetting)
	{
		if (Instigator != None)
			Instigator.TakeDamage(Rand(2), Instigator, Instigator.Location, -Vector(Instigator.GetViewRotation())*4000, class'DTXMVCHEAT');
	}

}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire() || /*BW.AimComponent.GetAimOffsets() != rot(0,0,0) || */XMV500Minigun(BW).BarrelSpeed < XMV500Minigun(BW).DesiredSpeed)
        return;

	BW.bPreventReload=true;
	BW.FireCount++;

	if (BW.ReloadState != RS_None)
		BW.ReloadState = RS_None;

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
//		ConsumedLoad += Load;
//		SetTimer(FMin(0.1, FireRate/2), false);
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	if (!BW.bScopeView)
		BW.AddFireChaos(FireChaos);

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

	if (!AllowFire() || XMV500Minigun(Weapon).bRunOffsetting)
	{
	if (Instigator != None)
		Instigator.TakeDamage(2, Instigator, Instigator.Location, -Vector(Instigator.GetViewRotation())*4000, class'DTXMVCHEAT');
	}

	BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
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
	TraceCount=3
	TraceRange=(Min=12000.000000,Max=15000.000000)
	Damage=35
	//SplashDamage=2
	//SplashDamageRadius=64
	RangeAtten=0.500000
	WaterRangeAtten=0.300000
	DamageType=Class'BWBP_APC_Pro.DTXMV500MG'
	DamageTypeHead=Class'BWBP_APC_Pro.DTXMV500MGHead'
	DamageTypeArm=Class'BWBP_APC_Pro.DTXMV500MG'
	KickForce=2500
	PenetrateForce=125
	bPenetrate=True
	FlashScaleFactor=0.800000
	BrassClass=Class'BallisticProV55.Brass_Minigun'
	BrassOffset=(X=-50.000000,Y=-8.000000,Z=5.000000)
	BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.550.Mini-Fire',Slot=SLOT_Interact,bNoOverride=False)
	bPawnRapidFireAnim=True
	TweenTime=0.000000
	FireRate=0.050000
	AmmoClass=Class'BWBP_APC_Pro.Ammo_MinigunInc'
	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-8.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=1.500000
	WarnTargetPct=0.200000
	aimerror=900.000000
}
