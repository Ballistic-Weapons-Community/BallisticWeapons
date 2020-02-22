//=============================================================================
// CoachGunPrimaryFire.
//
// Individual barrel fire for Coach Gun. Uses 10-gauge shells and has a longer
// barrel than the MRS138 and SKAS-21. Deals superior damage with good range.
// Lengthy reload after each shot balances the gun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TrenchGunPrimaryFire extends BallisticProShotgunFire;

var() Actor			MuzzleFlash2;		// The muzzleflash actor
var() sound		SlugFireSound;
var() class<BCTraceEmitter>	AltTracerClass;	
var() class<BCImpactManager>	AltImpactManager;	
var	bool	bFreezeMode;
var Name			AimedFireEmptyAnim, FireEmptyAnim, AimedFireSingleAnim, FireSingleAnim;
var() float		ChargeTime, DecayCharge;

simulated function DebugMessage(coerce string message)
{
	if (PlayerController(BW.Instigator.Controller) != None)
	{
		if (BW.Role == ROLE_Authority)
			PlayerController(BW.Instigator.Controller).ClientMessage("SERVER:"@message);
		else
			PlayerController(BW.Instigator.Controller).ClientMessage("CLIENT:"@message);
	}
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	//Force noobs to scope.
	if ((BW.BCRepClass.default.bSightFireOnly || class'BallisticWeapon'.default.SightsRestrictionLevel > 0) && BW.bUseSights && BW.SightingState != SS_Active && !BW.bScopeHeld && Instigator.IsLocallyControlled() && PlayerController(Instigator.Controller) != None)
		BW.ScopeView();
	if (!BW.bScopeView && (class'BallisticWeapon'.default.SightsRestrictionLevel > 1 || (class'BallisticWeapon'.default.SightsRestrictionLevel > 0 && BW.ZoomType != ZT_Irons)))
		return false;
	if (!CheckReloading())
	{
		//DebugMessage("AllowFire: CheckReloading FAIL");
		return false;		// Is weapon busy reloading
	}
	if (!CheckWeaponMode())
	{
		//DebugMessage("AllowFire: CheckWeaponMode FAIL");
		return false;		// Will weapon allow further firing
	}
	if (!bUseWeaponMag || BW.bNoMag)
	{
		if(!Super.AllowFire())
		{
			//DebugMessage("AllowFire: Engine.WeaponFire AllowFire FAIL");
			if (DryFireSound.Sound != None)
				Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
		}
	}
	else if (BW.MagAmmo < AmmoPerFire)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			BW.bNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		
		//DebugMessage("AllowFire: Ammunition remaining FAIL");
		
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
	{
		//DebugMessage("AllowFire: bNeedReload FAIL");
		return false;
	}
	else if (BW.bNeedCock)
	{
		//DebugMessage("AllowFire: bNeedCock FAIL");
		return false;
	}
    return true;
}

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity, ForceDir, BoneTestLocation, ClosestLocation;
	local Inv_Slowdown Slow;
	local float SlowDuration;
	
	
	//Locational damage code from Mr Evil under test here
	if(Other.IsA('xPawn') && !Other.IsA('Monster'))
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the shot along its direction to a point where it is closest to the victim's Z axis.
		BoneTestLocation = Dir;
		BoneTestLocation *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(HitLocation - TraceStart);
		BoneTestLocation += HitLocation;
		
		Dmg = GetDamage(Other, BoneTestLocation, Dir, Victim, HitDT);
	}
	
	else Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	//End locational damage code test
	
	if (RangeAtten != 1.0 && VSize(HitLocation - TraceStart) > CutOffStartRange)
		{
		//Range = VSize(HitLocation-TraceStart);
                //Range -= CutOffStartRange;
                //Range = FClamp(Range, 0, CutOffDistance)/CutOffDistance;
		//Dmg *= Lerp(Range, 1, RangeAtten);
		Dmg *= Lerp (FClamp(VSize(HitLocation - TraceStart) - CutOffStartRange, 0, CutOffDistance)/CutOffDistance, 1, RangeAtten);
		}
	//if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0) && !((VSize(HitLocation-TraceStart)-CutOffStartRange) < 0))
		Dmg *= Lerp (FClamp(VSize(HitLocation - TraceStart) - CutOffStartRange, 0, CutOffDistance)/CutOffDistance, 1, WaterRangeAtten);
	if (PenetrateCount > 0)
		Dmg *= PDamageFactor ** PenetrateCount;
	if (WallCount > 0)
		Dmg *= WallPDamageFactor ** WallCount;
	if (bUseRunningDamage)
	{
		RelativeVelocity = Instigator.Velocity - Other.Velocity;
		Dmg += Dmg * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
	}
	if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None)
	{
		ForceDir = Normal(Other.Location-TraceStart);
		ForceDir.Z *= 0.3;

		Pawn(Victim).AddVelocity( Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
	}

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
//	Victim.TakeDamage(Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
	SlowDuration=Dmg / (Damage * TraceCount) * 0.6;

	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None && bFreezeMode)
	{
		Slow = Inv_Slowdown(Pawn(Other).FindInventoryType(class'Inv_Slowdown'));
	
		if (Slow == None)
		{
			Pawn(Other).CreateInventory("BallisticProV55.Inv_Slowdown");
			Slow = Inv_Slowdown(Pawn(Other).FindInventoryType(class'Inv_Slowdown'));
		}
		/*if (bDoubleShot)
		Slow.AddSlow(0.7, 1.2);
		else
		Slow.AddSlow(0.7, 0.6);*/
		Slow.AddSlow(0.7, SlowDuration);
	}
}

function AnimateFiring()
{
	if (BW.HasNonMagAmmo(0))
	{
		if (Load == BW.MagAmmo)
		{
			BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
			
			if (BW.BlendFire())
				BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
		}
		else
		{
			BW.SafePlayAnim(FireSingleAnim, FireAnimRate, TweenTime, ,"FIRE");
			
			if (BW.BlendFire())
				BW.SafePlayAnim(AimedFireSingleAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");			
		}	
	}
	else
	{
		BW.SafePlayAnim(FireEmptyAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())
			BW.SafePlayAnim(AimedFireEmptyAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");			
	}
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	//DebugMessage("ServerPlayFiring");
		
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	AnimateFiring();
}

//Do the spread on the client side
function PlayFiring()
{
	//DebugMessage("PlayFiring");
		
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	AnimateFiring();

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, (BW.CurrentWeaponMode > 0), WaterHitLoc);
}

simulated function SwitchWeaponMode (byte newMode)
{
	if (newMode == 1) // Electroshot mode
	{
		PenetrateForce=500;
		bPenetrate=True;
		
		BallisticFireSound.Sound=SlugFireSound;
		
		TracerClass=AltTracerClass;
		ImpactManager=AltImpactManager;
		
		DamageType=Class'DT_TrenchGunElectro';
		DamageTypeArm=Class'DT_TrenchGunElectro';
		DamageTypeHead=Class'DT_TrenchGunElectro';
		
		Damage=default.damage * 0.75;
		DamageHead=default.damageHead * 0.75;
		DamageLimb=default.damageLimb * 0.75;
		
		bFreezeMode=False;
		KickForce=10000;
		//Instigator.ClientMessage("Freezing = "@bFreezeMode);
	}
	else //Shot Mode
	{
		PenetrateForce=0;
		bPenetrate=False;
		
		RecoilPerShot=Default.RecoilPerShot;
		
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		
		TracerClass=default.TracerClass;
		ImpactManager=default.ImpactManager;
		
		DamageType=Class'DT_TrenchGunFreeze';
		DamageTypeArm=Class'DT_TrenchGunFreeze';
		DamageTypeHead=Class'DT_TrenchGunFreeze';
		
		Damage=default.damage;
		DamageHead=default.damageHead;
		DamageLimb=default.damageLimb;
		
		bFreezeMode=True;
		KickForce=default.KickForce;
		
		GotoState('');
	}
}

simulated event Timer()
{
	if (Weapon.Role == ROLE_Authority)
	{
		if (BW != None)
			BW.ConsumeMagAmmo(ThisModeNum,ConsumedLoad);
		else
			Weapon.ConsumeAmmo(ThisModeNum,ConsumedLoad);
			
		if (BW.MagAmmo == 0 && BW.HasNonMagAmmo(0))
			BW.bServerReloading = true;
	}
	ConsumedLoad=0;
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
	//DebugMessage("ModeDoFire: Load:"$Load$" ConsumedLoad:"$ConsumedLoad);
	
	if (!AllowFire())
	{
		HoldTime = 0;	
        return;
	}	

	if (BW != None)
	{
		BW.bPreventReload=true;
		BW.FireCount++;

		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

	if (HoldTime >= ChargeTime && BW.MagAmmo == 2)
		Load = 2;

	ConsumedLoad += Load;
	SetTimer(FMin(0.1, FireRate/2), false);
    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	else if (!BW.bUseNetAim && !BW.bScopeView)
    	FireRecoil();
    
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
    {
        ServerPlayFiring();
    }

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
	HoldTime = 0;
	
    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	if (BW != None)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
		
		if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
			BW.bNeedCock=true;
			
		if (BW.HasNonMagAmmo(0) && ConsumedLoad == 2)
		{
			//DebugMessage("EmptyFire reload");

			BW.ReloadState = RS_PreClipOut;
		}
	}
}

// Get aim then run several individual traces using different spread for each one
function DoFireEffect()
{
	local Vector StartTrace;
	local Rotator R, Aim;
	local int i;

	Aim = GetFireAim(StartTrace);
	
	for (i=0;i<TraceCount * ConsumedLoad;i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
	}
	
	// Tell the attachment the aim. It will calculate the rest for the clients
	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);
	if (ConsumedLoad == 2)
		SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(BallisticFire).DoFireEffect();
}

function InitEffects()
{
	super.InitEffects();
    if ((MuzzleFlashClass != None) && ((MuzzleFlash2 == None) || MuzzleFlash2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash2, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
	local Coords C;
	local Actor MuzzleSmoke;
	local vector Start, X, Y, Z;
	local bool Side;

    if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
		
	Side = TrenchGunAttachment(Weapon.ThirdPersonActor).Side;

	if (Load == 2 || Side)
	{
		C = Weapon.GetBoneCoords('tip2');
		MuzzleFlash2.Trigger(Weapon, Instigator);
	}
	
	if (Load == 2 || !Side)
	{
		C = Weapon.GetBoneCoords('tip');
		MuzzleFlash.Trigger(Weapon, Instigator);
	}

    if (!class'BallisticMod'.default.bMuzzleSmoke)
    	return;
    Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * -180 + Y * 3;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));

	if (!bBrassOnCock)
		EjectBrass();
}

//Check Sounds and damage types.

simulated function ModeTick(float DeltaTime)
{
	Super.ModeTick(DeltaTime);
	
	if (bIsFiring)
	{
		if (HoldTime >= ChargeTime)
		{
			Load = 2;
			BallisticFireSound.Volume=2.0;
			XInaccuracy=default.XInaccuracy * 2.5;
			YInaccuracy=default.YInaccuracy * 1.5;
		
			if (ThisModeNum == 1)
			{
				DamageType=Class'DT_TrenchGunElectroDouble';
				DamageTypeArm=Class'DT_TrenchGunElectroDouble';
				DamageTypeHead=Class'DT_TrenchGunElectroDouble';	
			}
		}
		else
		{
				Load = 1;
				BallisticFireSound.Volume=1.0;
				XInaccuracy=default.XInaccuracy;
				YInaccuracy=default.YInaccuracy;
		}
	}
	else if (DecayCharge > 0)
	{
		DecayCharge -= DeltaTime * 2.5;
		Load = 1;
		if (DecayCharge < 0)
			DecayCharge = 0;
	}
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	local float AdjustedFireRate;
	
	AdjustedFireRate=0.6;
	
	FS.DamageInt = int(default.Damage * default.TraceCount * 2);
	FS.Damage = String(FS.DamageInt);
	FS.DPS = (default.Damage * default.TraceCount) / AdjustedFireRate;
	FS.TTK = 0.6 * (Ceil(175/FS.DamageInt) - 1);
	if (AdjustedFireRate < 0.5)
		FS.RPM = String(int((1 / AdjustedFireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/AdjustedFireRate@"times/second";
	FS.RPShot = default.RecoilPerShot;
	FS.RPS = default.RecoilPerShot / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.Range = "Max:"@(default.TraceRange.Max / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
	SlugFireSound=Sound'BWBPSomeOtherPackSounds.TechGun.electro_Shot'
	AimedFireEmptyAnim="SightFire"
	FireEmptyAnim="Fire"	
	AimedFireSingleAnim="SightFire"
	FireSingleAnim="Fire"
	ChargeTime=0.35
	MaxHoldTime=0.0
	HipSpreadFactor=3.000000
    CutOffDistance=1536.000000
    CutOffStartRange=1024.000000
	MaxSpreadFactor=2
	TraceCount=8
	TracerClass=Class'BallisticProV55.TraceEmitter_Freeze'
	AltTracerClass=Class'BWBPRecolorsPro.TraceEmitter_Supercharge'
	AltImpactManager=Class'BWBPRecolorsPro.IM_Supercharge'
	ImpactManager=Class'BallisticProV55.IM_FreezeHit'
	TraceRange=(Min=2000.000000,Max=4000.000000)
	MaxWalls=1
	Damage=13.000000
	DamageHead=20.000000
	DamageLimb=13.000000
	RangeAtten=0.250000
	PenetrateForce=100
	bPenetrate=False
	bFireOnRelease=True
	DamageType=Class'BWBPSomeOtherPack.DT_TrenchGunFreeze'
	DamageTypeHead=Class'BWBPSomeOtherPack.DT_TrenchGunFreeze'
	DamageTypeArm=Class'BWBPSomeOtherPack.DT_TrenchGunFreeze'
	KickForce=3000
	MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
	FlashScaleFactor=1.500000
	BrassBone="EjectorR"
	BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
	AimedFireAnim="SightFireCombined"
	RecoilPerShot=512.000000
	VelocityRecoil=1200.000000
	FireChaos=1.000000
	XInaccuracy=200.000000
	YInaccuracy=150.000000
	BallisticFireSound=(Sound=Sound'BWBPSomeOtherPackSounds.TechGun.frost_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)
	FireAnim="FireCombined"
	FireAnimRate=0.800000
	FireRate=0.100000
	AmmoClass=Class'BWBPSomeOtherPack.Ammo_TrenchgunShells'
	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-30.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	BotRefireRate=0.60000
	WarnTargetPct=0.500000
}
