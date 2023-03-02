//=============================================================================
// M353PrimaryFire.
//
// Extremely automatic, bullet style instant hit. Shots are long ranged,
// powerful and sort of accurate when gun is mountued and used carefully.
// Accuracy decreases very quickly especially if player is moving and the
// ridiculous fire rate makes it even worse. Mounting the gun can solve the
// problem though.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TridentPrimaryFire extends BallisticProInstantFire;

var rotator OldLookDir, TurnVelocity;
var float	LastFireTime, MuzzleBTime, MuzzleCTime, OldFireRate;
var Actor	MuzzleFlashB, MuzzleFlashC;
var TridentMachinegun TridentWeapon;

var	int		TraceCount;
var float	NextTVUpdateTime;

// Returns the interpolated base aim with its offset, chaos, etc and view aim removed in the form of a single rotator
simulated function Rotator GetNewAimPivot(float ExtraTime, optional bool bIgnoreViewAim)
{
	return BW.CalcFutureAim(ExtraTime, bIgnoreViewAim);
}

event ModeTick(float DT)
{
	local float DesiredFireRate;
	local Rotator BasePlayerView;

	BasePlayerView = BW.GetPlayerAim();
	
	if (Instigator.IsLocallyControlled())
	{
		TurnVelocity = (BasePlayerView - OldLookDir) / DT;
		OldLookDir = BasePlayerView;
		if (level.NetMode == NM_Client && level.TimeSeconds > NextTVUpdateTime)
		{
			TridentWeapon.SetServerTurnVelocity(TurnVelocity.Yaw, TurnVelocity.Pitch);
			NextTVUpdateTime = level.TimeSeconds + 0.15;
		}
	}

	OldFireRate = FireRate;

	if (TridentWeapon.BarrelSpeed <= 0)
	{
		FireRate = 1.0;
		TraceCount = 1;
	}
	else
	{
		DesiredFireRate = (FMin(1.0 / (60*TridentWeapon.BarrelSpeed), 1));
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
		TridentAttachment(Weapon.ThirdPersonActor).UpdateTurnVelocity(TurnVelocity);
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

    if (Level.NetMode == NM_DedicatedServer)
        BW.RewindCollisions();

	for (i=0;i<TraceCount && ConsumedLoad < BW.MagAmmo ;i++)
	{
		ConsumedLoad += Load;
		Aim = GetNewFireAim(StartTrace, ExtraTime);
		Aim += ExtraAim;
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
		if (i == 1)
			MuzzleBTime = Level.TimeSeconds + ExtraTime;
		else if (i == 2)
			MuzzleCTime = Level.TimeSeconds + ExtraTime;
		ExtraTime += Interval;
		ExtraAim += AimInterval;
	}
	SetTimer(FMin(0.1, FireRate/2), false);

//	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(BallisticFire).DoFireEffect();
}

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

simulated function rotator GetNewFireAim(out Vector StartTrace, float ExtraTime)
{
	return Rotator(GetNewFireDir(StartTrace, ExtraTime));
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire()) 
		return;
	
	/*
	// won't fire if spinning slower than lowest rotation speed
	if (TridentWeapon.BarrelSpeed <  TridentWeapon.RotationSpeeds[0]) //TridentWeapon.DesiredSpeed)
        return;
	*/

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

simulated function vector GetFireDir(out Vector StartTrace)
{
    if (BallisticTurret(Instigator) != None)
    	StartTrace = Instigator.Location + Instigator.EyePosition() + Vector(Instigator.GetViewRotation()) * 64;
	return super.GetFireDir(StartTrace);
}

defaultproperties
{
	 DecayRange=(Min=2560,Max=4096)
	 RangeAtten=0.35
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WallPenetrationForce=24.000000
     
     Damage=20.000000
     HeadMult=1.5f
     LimbMult=0.8f
     
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTM353MG'
     DamageTypeHead=Class'BallisticProV55.DTM353MGHead'
     DamageTypeArm=Class'BallisticProV55.DTM353MG'
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
     FlashScaleFactor=0.700000
     BrassClass=Class'BallisticProV55.Brass_MG'
     BrassOffset=(X=6.000000,Y=10.000000)
     AimedFireAnim="SightFire"
     FireRecoil=96.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=16.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.08000
     AmmoClass=Class'BallisticProV55.Ammo_556mmBelt'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
