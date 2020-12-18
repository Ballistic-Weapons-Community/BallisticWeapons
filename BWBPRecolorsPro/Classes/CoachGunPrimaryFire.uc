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
class CoachGunPrimaryFire extends BallisticProShotgunFire;

var() Actor						MuzzleFlash2;		// The muzzleflash actor
var() sound						SlugFireSound;
var() class<BCTraceEmitter>		AltTracerClass;	
var() class<BCImpactManager>	AltImpactManager;	
var Name						AimedFireEmptyAnim, FireEmptyAnim, AimedFireSingleAnim, FireSingleAnim;
var() float						ChargeTime, DecayCharge;

var() int   					SlugDamage, SlugDoubleDamage;

var bool                        FlashSide;

struct Point2
{
	var int X;
	var int Y;
};

var() Point2					SlugInaccuracy, SlugDoubleInaccuracy, ShotInaccuracy, ShotDoubleInaccuracy;

//======================================================================
// AnimateFiring
//
// Select different animation depending on ammo and charge
//======================================================================
function AnimateFiring()
{
	if (BW.HasNonMagAmmo(0))
	{        
		if (Load >= BW.MagAmmo)
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

//======================================================================
// SendFireEffect
//
// Send information about double shots to attachment
//======================================================================
simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, ConsumedLoad == 2, WaterHitLoc);
}

//======================================================================
// ImpactEffect
//
// Spawns effects on listen and standalone servers
//======================================================================
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;
	
	//DebugMessage("ImpactEffect: Hit actor:"@Other);

	if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);

	if (!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None || level.NetMode == NM_Client)
		return false;

    if (Vehicle(Other) != None)
        Surf = 3;
    else if (HitMat == None)
        Surf = int(Other.SurfaceType);
    else
        Surf = int(HitMat.SurfaceType);

    ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, instigator);
	
	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation(), Rotator(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()));
	
	return true;
}

simulated function SwitchWeaponMode (byte newMode)
{
	if (newMode == 1) //Slug Mode
	{
        Damage = SlugDamage;
        HeadMult=1.5f;
        LimbMult=0.8f;
        TraceCount = 1;

        PenetrateForce=500;
		bPenetrate=True;

        BallisticFireSound.Sound=SlugFireSound;
		BallisticFireSound.Volume=7.1;

        TracerClass=AltTracerClass;
		ImpactManager=AltImpactManager;

        DamageType=Class'DTCoachSlug';
		DamageTypeArm=Class'DTCoachSlug';
		DamageTypeHead=Class'DTCoachSlug';

        RangeAtten=0.250000;
		CutOffStartRange=1536;
		CutOffDistance=4096;

		TraceRange.Min=9000;
		TraceRange.Max=9000;

        KickForce = 30000;
		
     	FlashScaleFactor=3.000000;

		CoachGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(1);
	}
	else //Shot Mode
	{
        Damage = default.Damage;
        HeadMult= default.HeadMult;
        LimbMult=default.LimbMult;
        
		TraceCount=default.TraceCount;

        PenetrateForce=0;
		bPenetrate=False;
	
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;

        TracerClass=default.TracerClass;
		ImpactManager=default.ImpactManager;

        DamageType=Class'DTCoachShot';
		DamageTypeArm=Class'DTCoachShot';
		DamageTypeHead=Class'DTCoachShot';

        CutOffDistance=default.CutOffDistance;
        CutOffStartRange=default.CutOffStartRange;
		RangeAtten=default.RangeAtten;

		
		TraceRange.Min=default.TraceRange.Min;
		TraceRange.Max=default.TraceRange.Max;
		
		FlashScaleFactor=default.FlashScaleFactor;		
		KickForce=default.KickForce;
		FireRecoil=default.FireRecoil;

		CoachGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(0);
	}

    SwitchShotParams();
}

simulated function ModeTick(float DeltaTime)
{
	Super.ModeTick(DeltaTime);
	
	if (!bIsFiring && DecayCharge > 0)
	{
		DecayCharge -= DeltaTime * 2.5;
		
		if (DecayCharge < 0)
			DecayCharge = 0;
	}
}

//======================================================================
// ModeDoFire
//
// Handle Load and ConsumedLoad, as well as empty fire integrated reload
//======================================================================
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
			if (Weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

	if (HoldTime >= ChargeTime && BW.MagAmmo == 2)
	{
		Load = 2;
		SwitchShotParams();
	}

	ConsumedLoad += Load;
	
	SetTimer(FMin(0.1, FireRate/2), false);
	
    // server
    if (Weapon.Role == ROLE_Authority)
    {
		//DebugMessage("DoFireEffect: Load:"$Load$" ConsumedLoad:"$ConsumedLoad);
	
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	else if (!BW.bUseNetAim && !BW.bScopeView)
    	ApplyRecoil();
    
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

	if (Load == 2)
	{    
		Load = AmmoPerFire;
		SwitchShotParams();
	}
	
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
	}
}

//======================================================================
// GetTraceCount
//======================================================================
function int GetTraceCount(int load)
{
	switch(load)
	{
		case 2: return TraceCount * 2;
		case 1: return TraceCount;
		default: return TraceCount;
	}
}

//======================================================================
// DoFireEffect
//
// Send twice if double shot
//======================================================================
function DoFireEffect()
{
	local Vector StartTrace;
	local Rotator R, Aim;
	local int i;

	Aim = GetFireAim(StartTrace);

    if (Level.NetMode == NM_DedicatedServer)
        BW.RewindCollisions();
	
	for (i=0; i < GetTraceCount(Load); i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
	}

    if (Level.NetMode == NM_DedicatedServer)
        BW.RestoreCollisions();

	ApplyHits();
	
	// Tell the attachment the aim. It will calculate the rest for the clients
	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(BallisticFire).DoFireEffect();
}

//======================================================================
// InitEffects
//
// Flash the second barrel as well
//======================================================================
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
    local int i;

    if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    for (i = 0; i < Load; ++i)
    {
	    if (FlashSide)
        {
            C = Weapon.GetBoneCoords('tip2');
            MuzzleFlash2.Trigger(Weapon, Instigator);
        }

        else
        {
            C = Weapon.GetBoneCoords('tip');
            MuzzleFlash.Trigger(Weapon, Instigator);
        }

        FlashSide = !FlashSide;

        if (class'BallisticMod'.default.bMuzzleSmoke)
        {
            Weapon.GetViewAxes(X,Y,Z);
            Start = C.Origin + X * -180 + Y * 3;
            MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));
        }
    }

	if (!bBrassOnCock)
		EjectBrass();
}

//======================================================================
// SwitchShotParams
//
// Manage double shot parameters
//======================================================================
function SwitchShotParams()
{
	if (Load == 2)
	{
		BallisticFireSound.Volume = 2.0;
		
		if (BW.CurrentWeaponMode == 0)
		{
			XInaccuracy = ShotDoubleInaccuracy.X;
			YInaccuracy = ShotDoubleInaccuracy.Y;
		}

		else
		{
			XInaccuracy = SlugDoubleInaccuracy.X;
			YInaccuracy = SlugDoubleInaccuracy.Y;

            Damage = SlugDoubleDamage;
		}
	}
	else
	{
		BallisticFireSound.Volume = 1.0;
		
		if (BW.CurrentWeaponMode == 0)
		{
			XInaccuracy = ShotInaccuracy.X;
			YInaccuracy = ShotInaccuracy.Y;
		}
		
		if (BW.CurrentWeaponMode == 1)
		{		
			XInaccuracy = SlugInaccuracy.X;
			YInaccuracy = SlugInaccuracy.Y;

            Damage = SlugDamage;
		}
	}
}

defaultproperties
{
	SlugFireSound=Sound'PackageSounds4ProExp.Redwood.SuperMagnum-Fire'

	AimedFireEmptyAnim="Fire"
	FireEmptyAnim="Fire"

    AimedFireAnim="Fire"
    FireAnim="Fire"

    AimedFireSingleAnim="SightFire"
    FireSingleAnim="SightFire"

    ChargeTime=0.35
	MaxHoldTime=0.0
	HipSpreadFactor=2.5

	CutOffDistance=2048.000000
	CutOffStartRange=1024.000000

	TraceCount=10
	TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
	ImpactManager=Class'BallisticProV55.IM_Shell'
	AltTracerClass=Class'BWBPRecolorsPro.TraceEmitter_X83AM'
	AltImpactManager=Class'BWBPRecolorsPro.IM_ExpBullet'

	TraceRange=(Min=2560.000000,Max=3072.000000)

	WallPenetrationForce=0

	Damage=11.000000
    MaxHits=13 // inflict maximum of 140 damage to a single target
    SlugDamage=75
    SlugDoubleDamage=62
	RangeAtten=0.250000
    PenetrateForce=0
	bPenetrate=False
	bFireOnRelease=True
	DamageType=Class'BWBPRecolorsPro.DTCoachShot'
	DamageTypeHead=Class'BWBPRecolorsPro.DTCoachShot'
	DamageTypeArm=Class'BWBPRecolorsPro.DTCoachShot'
	KickForce=8000
	MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
	FlashScaleFactor=1.500000
	BrassBone="EjectorR"
	BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
	FireRecoil=768.000000
	FirePushbackForce=250.000000
	FireChaos=1.000000

	XInaccuracy=220.000000
	YInaccuracy=220.000000

	ShotInaccuracy=(X=220,Y=220)
	ShotDoubleInaccuracy=(X=768,Y=378)

	SlugInaccuracy=(X=16,Y=0)
	SlugDoubleInaccuracy=(X=48,Y=0)

	BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.Redwood.Redwood-Fire',Volume=1.200000)
	FireAnimRate=1.35
	FireRate=0.400000
	AmmoClass=Class'BWBPRecolorsPro.Ammo_CoachShells'
	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-30.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	BotRefireRate=0.60000
	WarnTargetPct=0.500000
}
