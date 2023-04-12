//=============================================================================
// BallisticFire.
//
// Extension of Engine.WeaponFire. Adds support for Spread, Rise, Penetration,
// Reloading, Weapon attachments and other Ballistic features.
//
// Azarael - enhanced Berserk support.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticFire extends WeaponFire
    DependsOn(FireEffectParams);

enum EScopeDownOn
{
	SDO_Never,	// Don't do anything for this fire
	SDO_Fire,	// Lower on fire
	SDO_PreFire // Lower on PreFire
};

//=============================================================================
// STATE VARIABLES
//=============================================================================
var   FireParams				Params;
var   BallisticWeapon			BW;					// Easy access to BallisticWeapon(Weapon)
var   int						ConsumedLoad;		// This is the amount of ammo to consume for delayed consume ammo.
//=============================================================================
// END STATE VARIABLES
//=============================================================================

//=============================================================================
// GENERAL WEAPON FIRE VARIABLES
//
// These variables are consistent for every instance of a fire mode and are 
// user-defined but generally not modified within the game. 
// Contains things like display offsets, icon coords etc
//=============================================================================
//-----------------------------------------------------------------------------
// Appearance
//-----------------------------------------------------------------------------
var() Name						FlashBone;			// Bone to attach muzzle flash to
var() class<actor>				BrassClass;			// Actor to spawn for ejecting brass
var() name						BrassBone;			// Bone where brass will be spawned
var() bool						bBrassOnCock;		// Eject brass when cocked
var() Vector					BrassOffset;		// Position offset for brass spawning
//-----------------------------------------------------------------------------
// Cocking/Reloading
//-----------------------------------------------------------------------------
var   bool						bPlayedDryFire;		// Has dry fire sound been played since ammo ran out
var() bool						bCockAfterFire;		// Cock the gun after each shot
var() bool						bCockAfterEmpty;	// Cock the gun if MagAmmo gets to 0
var() bool						bDryUncock;			// Can still uncock weapon by pressing fire when mag is empty
var() bool						bIgnoreReload;		// This firemode can stop the weapon reloading and fire
var() bool						bIgnoreCocking;		// This mode can cancel weapon cocking to fire
var() bool						bUseWeaponMag;		// Use ammo from gun. Uses ammo from weapon's mag is it has one
//-----------------------------------------------------------------------------
// Sighting
//-----------------------------------------------------------------------------
var() EScopeDownOn				ScopeDownOn;		// What can cause the the gun to be lowered out of scope/sight view
//-----------------------------------------------------------------------------
// Sound
//-----------------------------------------------------------------------------
var() BUtil.FullSound			ClipFinishSound;	// Sound to play when mag runs out
var() BUtil.FullSound			DryFireSound;		// Sound to play when dry firing
//=============================================================================
// END GENERAL WEAPON FIRE VARIABLES
//=============================================================================

//=============================================================================
// GAMEPLAY VARIABLES
//
// These variables are user-defined, and may additionally be modified either 
// by the game ruleset or by weapon modes and attachments.
//=============================================================================
//-----------------------------------------------------------------------------
// Appearance
//-----------------------------------------------------------------------------
var() class<Actor>			            MuzzleFlashClass;	// The actor class to use for this fire's muzzle flash
var() Actor					            MuzzleFlash;		// The muzzleflash actor
var() float					            FlashScaleFactor;	// MuzzleFlash scaling will be DrawScale * FlashScaleFactor
//-----------------------------------------------------------------------------
// Animation
//-----------------------------------------------------------------------------
var Name 					            AimedFireAnim;		// Fire anim to play when scoped
var Name					            EmptyFireAnim; 		// Fire anim to play when emptied
var Name 					            EmptyAimedFireAnim;
//-----------------------------------------------------------------------------
// Handling
//-----------------------------------------------------------------------------
var() bool					            bReleaseFireOnDie;	// If bFireOnRelease, mode will fire if holder died before release
//-----------------------------------------------------------------------------
// Burst Mode
//-----------------------------------------------------------------------------
var int                                 BurstCount;			// Number of shots fired in this burst thus far
var int                                 MaxBurst;			// Max shots per burst, set by Weapon
var bool                                bBurstMode;			// Weapon fires bursts
var float	                            BurstFireRateFactor;// Multiplies down fire rate in burst mode
//-----------------------------------------------------------------------------
// Dispersion
//-----------------------------------------------------------------------------
var() float					            FireRecoil;			// Amount of recoil added each shot
var() float					            FirePushbackForce;	// How much to jolt player back when they fire
var() float					            FireChaos;			// Chaos added to aim when fired. Will be auto calculated if < 0
var() InterpCurve			            FireChaosCurve;
var() float					            XInaccuracy;		// Set amount that bullets can yaw away from gun's aim
var() float					            YInaccuracy;		// Set amount that bullets can pitch away from gun's aim
var() FireEffectParams.FireSpreadMode	FireSpreadMode;		// The type of spread pattern to use for X and YInaccuracy
//-----------------------------------------------------------------------------
// Sound
//-----------------------------------------------------------------------------
var() BUtil.FullSound		            SilencedFireSound;	// Fire sound to play when silenced
var() BUtil.FullSound		            BallisticFireSound;	// Fire sound to play
var() bool					            bAISilent;			// Bots dont hear the fire
//-----------------------------------------------------------------------------
// Heat
//-----------------------------------------------------------------------------
var() float					            HeatPerShot;			// Amount of heat added each shot
//=============================================================================
// END GAMEPLAY VARIABLES
//=============================================================================

//=============================================================================
// JAMMING, that I don't care about
//=============================================================================
var(Jamming) enum EUnjamMethod
{
	UJM_ReloadAndCock,			            // Weapon must be reloaded, clip out, back in and cocked
	UJM_Reload,					            // Weapon must be reloaded, clip out and back in
	UJM_Cock,					            // Weapon must be cocked.
	UJM_FireNextRound,			            // Pressing fire will unjam, but not fire a bullet
	UJM_Fire					            // Press fire to unjam and fire the next round
}								            UnjamMethod;			// How to unjam this firemode
var(Jamming) float				            JamChance;				// Chance of weapon jamming each shot
var(Jamming) float				            WaterJamChance;			// Chance of weapon jamming each shot when under water
var(Jamming) float				            JamMoveMultiplier;		// JamChance multiplied by this when player is moving
var	bool						            bIsJammed;				// Is this firemode currently jammed
var(Jamming) BUtil.FullSound 	            JamSound;				// Sound to play when clip runs out
var bool						            bPendingTryJam;			// Try jam next Timer()
var(Jamming) bool				            bJamWastesAmmo;			// Jamming wastes the ammo that would have been fired
//=============================================================================
// END JAMMING
//=============================================================================

simulated final function ApplyFireParams()
{
    FireRate                		= Params.FireInterval;
	default.FireRate        		= Params.FireInterval;
	
    AmmoPerFire             		= Params.AmmoPerFire;
	default.AmmoPerFire    			= Params.AmmoPerFire;
	Load							= Params.AmmoPerFire;

    PreFireTime             		= Params.PreFireTime;
    MaxHoldTime             		= Params.MaxHoldTime;
	default.PreFireTime     		= Params.PreFireTime;
    default.MaxHoldTime     		= Params.MaxHoldTime;

    GoToState(Params.TargetState);

    BurstFireRateFactor     		= Params.BurstFireRateFactor;
    bCockAfterFire          		= Params.bCockAfterFire;
	default.BurstFireRateFactor     = Params.BurstFireRateFactor;
	default.bCockAfterFire          = Params.bCockAfterFire;

    PreFireAnim             		= Params.PreFireAnim; 
    FireAnim                		= Params.FireAnim;
    FireLoopAnim            		= Params.FireLoopAnim;
    FireEndAnim             		= Params.FireEndAnim;

    PreFireAnimRate         		= Params.PreFireAnimRate;
    FireAnimRate            		= Params.FireAnimRate;
    FireLoopAnimRate        		= Params.FireLoopAnimRate;
    FireEndAnimRate         		= Params.FireEndAnimRate;    
	default.PreFireAnimRate         = Params.PreFireAnimRate;
    default.FireAnimRate            = Params.FireAnimRate;
    default.FireLoopAnimRate        = Params.FireLoopAnimRate;
    default.FireEndAnimRate         = Params.FireEndAnimRate;

    AimedFireAnim           		= Params.AimedFireAnim;

	if (AimedFireAnim == '')
		AimedFireAnim = FireAnim;
}

simulated function ApplyFireEffectParams(FireEffectParams effect_params)
{
    // must check on existing muzzle flash for replacement
    MuzzleFlashClass        		= effect_params.MuzzleFlashClass;
    FlashScaleFactor        		= effect_params.FlashScaleFactor;
	FlashBone						= effect_params.FlashBone;
    BallisticFireSound     	 		= effect_params.FireSound;
    FireRecoil            			= effect_params.Recoil;
    FirePushbackForce	     	 	= effect_params.PushbackForce;
    FireChaos        		       	= effect_params.Chaos;
    XInaccuracy      		       	= effect_params.Inaccuracy.X;
    YInaccuracy       	     		= effect_params.Inaccuracy.Y;
    FireSpreadMode    		      	= effect_params.SpreadMode;
	HeatPerShot						= effect_params.Heat;
	
	default.MuzzleFlashClass        = effect_params.MuzzleFlashClass;
    default.FlashScaleFactor        = effect_params.FlashScaleFactor;
    default.BallisticFireSound      = effect_params.FireSound;
    default.FireRecoil              = effect_params.Recoil;
    default.FirePushbackForce       = effect_params.PushbackForce;
    default.FireChaos               = effect_params.Chaos;
    default.XInaccuracy             = effect_params.Inaccuracy.X;
    default.YInaccuracy             = effect_params.Inaccuracy.Y;
    default.FireSpreadMode          = effect_params.SpreadMode;
	default.HeatPerShot						= effect_params.Heat;

    bSplashDamage           			= effect_params.SplashDamage;
    bRecommendSplashDamage  			= effect_params.RecommendSplashDamage;
    BotRefireRate           			= effect_params.BotRefireRate;
    WarnTargetPct           			= effect_params.WarnTargetPct;
	
	default.bSplashDamage           	= effect_params.SplashDamage;
    default.bRecommendSplashDamage  	= effect_params.RecommendSplashDamage;
    default.BotRefireRate           	= effect_params.BotRefireRate;
    default.WarnTargetPct           	= effect_params.WarnTargetPct;
}

simulated function PreBeginPlay()
{
	super.PreBeginPlay();
	BW = BallisticWeapon(Weapon);
}

function StartBerserk()
{
    if (Params == None || Params.FireEffectParams.Length == 0)
    {
        FireRate = default.FireRate * 0.8f;
        FireAnimRate = default.FireAnimRate * 1.25f;
        FireRecoil = default.FireRecoil * 0.8f;
        FireChaos = default.FireChaos * 0.8f;
    }

    else 
    {
        FireRate = Params.FireInterval * 0.8f;
        FireAnimRate = Params.FireAnimRate * 1.25f;
        FireRecoil = Params.FireEffectParams[BW.AmmoIndex].Recoil * 0.8f;
        FireChaos = Params.FireEffectParams[BW.AmmoIndex].Chaos* 0.8f; 
    }
}

function StopBerserk()
{
    if (Params == None || Params.FireEffectParams.Length == 0)
    {
        FireRate = default.FireRate;
        FireAnimRate = default.FireAnimRate;
        FireRecoil = default.FireRecoil;
        FireChaos = default.FireChaos;
    }

    else 
    {
        FireRate = Params.FireInterval;
        FireAnimRate = Params.FireAnimRate;
        FireRecoil = Params.FireEffectParams[BW.AmmoIndex].Recoil;
        FireChaos = Params.FireEffectParams[BW.AmmoIndex].Chaos;
    }
}

function StartSuperBerserk()
{
    if (Params == None || Params.FireEffectParams.Length == 0)
    {
        FireRate = default.FireRate/Level.GRI.WeaponBerserk;
        FireAnimRate = default.FireAnimRate*Level.GRI.WeaponBerserk;
        FireRecoil = default.FireRecoil/Level.GRI.WeaponBerserk;
        FireChaos = default.FireChaos/Level.GRI.WeaponBerserk;
    }

    else 
    {
        FireRate = Params.FireInterval/Level.GRI.WeaponBerserk;
        FireAnimRate = Params.FireAnimRate*Level.GRI.WeaponBerserk;
        FireRecoil = Params.FireEffectParams[BW.AmmoIndex].Recoil/Level.GRI.WeaponBerserk;
        FireChaos = Params.FireEffectParams[BW.AmmoIndex].Chaos/Level.GRI.WeaponBerserk; 
    }
}

//Stub called by the weapon mode when its FireMode changes
simulated function SwitchWeaponMode (byte NewMode);

//================================================================
// OnFireParamsChanged
//
// Called from:
// - BallisticWeaponParams on weapon initialization 
// - BallisticWeapon when mode is changed
//================================================================
simulated function OnFireParamsChanged(int EffectIndex)
{
    ApplyFireParams();
    OnEffectParamsChanged(EffectIndex);
}

//================================================================
// OnEffectParamsChanged
//
// Called from:
// - OnFireParamsChanged when initialized or mode is changed
// - BallisticWeapon when ammo is changed
//================================================================
simulated function OnEffectParamsChanged(int EffectIndex)
{
    ApplyFireEffectParams(Params.FireEffectParams[EffectIndex]);
    
    if (BW.bBerserk)
        StartBerserk();
}

// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

//Spawn shell casing for first person
function EjectBrass()
{
	local vector Start, X, Y, Z;
	local Coords C;

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (BrassClass == None)
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
	if (AIController(Instigator.Controller) != None)
		return;
	C = Weapon.GetBoneCoords(BrassBone);
//	Start = C.Origin + C.XAxis * BrassOffset.X + C.YAxis * BrassOffset.Y + C.ZAxis * BrassOffset.Z;
    Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * BrassOffset.X + Y * BrassOffset.Y + Z * BrassOffset.Z;
	Spawn(BrassClass, weapon,, Start, Rotator(C.XAxis));
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	MuzzleFlash = None;
}
// End effect functions ----------------------------------------------------

// Aim and Spread getting functions ---------------------------------------------
function Rotator AdjustAim(Vector Start, float InAimError)
{
	if (BW.bUseSpecialAim)
		return BW.GetPlayerAim(true);
    return super.AdjustAim(Start, InAimError);
}
// Returns the normal of the player's aim with weapon aim/pitch applied. Also sets StartTrace vector
simulated function vector GetFireDir(out Vector StartTrace)
{
    // the to-hit trace always starts right in front of the eye
	if (StartTrace == vect(0,0,0))
		StartTrace = Instigator.Location + Instigator.EyePosition();
	return BW.GetFireDir() >> AdjustAim(StartTrace, AimError);
}
// Like GetFireDir, but returns a rotator instead
simulated function rotator GetFireAim(out Vector StartTrace)
{
	return Rotator(GetFireDir(StartTrace));
}
// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	switch (FireSpreadMode)
	{
		case FSM_Scatter:
			fX = frand();
			R.Yaw =   XInaccuracy * (frand()*2-1) * sin(fX*1.5707963267948966);
			R.Pitch = YInaccuracy * (frand()*2-1) * cos(fX*1.5707963267948966);
			break;
		case FSM_Circle:
			fX = frand();
			R.Yaw =   XInaccuracy * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
			R.Pitch = YInaccuracy * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
			break;
		default:
			R.Yaw =   XInaccuracy * (frand()*2-1);
			R.Pitch = YInaccuracy * (frand()*2-1);
			break;
	}
	return Vector(R);
}

// Return random number between Input and -Input
simulated function float GetSpreadRand(float RSpread)
{
	return ((FRand()*RSpread*2)-RSpread);
}

// End Aim stuff ----------------------------------------------------------------

// Core Firing functions --------------------------------------------------------
// Server side fire stuff. Spawn projectiles/Traces from here
function DoFireEffect()
{
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	ApplyRecoil();
	bPendingTryJam=true;
	Super.DoFireEffect();
}

function TryJam()
{
	bPendingTryJam = false;
	if (Instigator != None && Instigator.PhysicsVolume.bWaterVolume)
	{
		if (WaterJamChance > 0 && FRand() <= WaterJamChance)
		{
			DoJam();
			BW.ClientJamMode(ThisModeNum);
		}
	}
	else if (JamChance > 0 && FRand() <= JamChance)
	{
		DoJam();
		BW.ClientJamMode(ThisModeNum);
	}
}

simulated function DoJam()
{
	if (bIsJammed)
		return;
	switch(UnjamMethod)
	{
	case UJM_ReloadAndCock	: BW.bNeedReload = true; BW.bNeedCock = true; break;
	case UJM_Reload			: BW.bNeedReload = true; break;
	case UJM_Cock			: BW.bNeedCock = true; break;
//	case UJM_FireNextRound	: bIsJammed = true;	break;
//	case UJM_Fire			: bIsJammed = true;	break;
	}
	Weapon.PlaySound(JamSound.Sound,JamSound.Slot,JamSound.Volume,JamSound.bNoOverride,JamSound.Radius,JamSound.Pitch,JamSound.bAtten);
	bIsJammed = true;
}

simulated function CockingGun(optional byte Type)
{
	if (bIsJammed && UnjamMethod == UJM_Cock)
	{
		bIsJammed = false;
		if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
		{
			ConsumedLoad += Load;
			Timer();
		}
	}
}
simulated function ReloadingGun(optional byte i)
{
	if (bIsJammed && (UnjamMethod == UJM_Reload || UnjamMethod == UJM_ReloadAndCock ))
	{
		bIsJammed = false;
		if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
		{
			ConsumedLoad += Load;
			Timer();
		}
	}
}

simulated function ApplyRecoil()
{
	local Vector VelRecoilVect;

	if (BW != None)
		BW.AddRecoil(FireRecoil, FireChaos, ThisModeNum);

	if (FirePushbackForce != 0 && Instigator!= None)
	{
		VelRecoilVect = Vector(Instigator.GetViewRotation()) * FirePushbackForce;
		VelRecoilVect.Z *= 0.25;
		
		if (Instigator.Physics != PHYS_Falling)
			Instigator.Velocity -= VelRecoilVect;
	}
}
	
simulated event ModeTick(float dt)
{
	if (Instigator == None)
		Log("BallisticFire: ModeTick: No Instigator");
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, (ThisModeNum > 0), WaterHitLoc);
}

function PlayPreFire()
{
	if (ScopeDownOn == SDO_PreFire)
		BW.TemporaryScopeDown(0.5, 0.9);
	super.PlayPreFire();
}

simulated function PlayFireAnimations()
{
	if (FireCount == 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else 
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())	
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	PlayFireAnimations();
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	PlayFireAnimations();
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated function CheckClipFinished()
{
	if (ClipFinishSound.Sound != None && ( (bUseWeaponMag && BW.MagAmmo - Load < 1) || (BW.bNoMag && BW.AmmoAmount(ThisModenum) - Load < 1) ))
		Weapon.PlayOwnedSound(ClipFinishSound.Sound,ClipFinishSound.Slot,ClipFinishSound.Volume,ClipFinishSound.bNoOverride,ClipFinishSound.Radius,ClipFinishSound.Pitch,ClipFinishSound.bAtten);
}

// Used to delay ammo consumtion
simulated event Timer()
{
	if (Weapon.Role == ROLE_Authority)
	{
		if (BW != None)
			BW.ConsumeMagAmmo(ThisModeNum,ConsumedLoad);
		else
			Weapon.ConsumeAmmo(ThisModeNum,ConsumedLoad);
		if (bPendingTryJam)
			TryJam();
	}
	ConsumedLoad=0;
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire())
        return;
    if (bIsJammed)
    {
    	if (BW.FireCount == 0)
    	{
    		bIsJammed=false;
			if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
			{
				ConsumedLoad += Load;
				Timer();
			}
	   		if (UnjamMethod == UJM_FireNextRound)
	   		{
		        NextFireTime += FireRate;
   			    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
				BW.FireCount++;
    			return;
    		}
    		if (!AllowFire())
    			return;
    	}
    	else
    	{
	        NextFireTime += FireRate;
   		    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		return;
   		}
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

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

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
	
    else if (bBurstMode)
    {
		BurstCount++;
    	if (BurstCount >= MaxBurst)
    	{
    		NextFireTime += FireRate * (1 + (MaxBurst * (1.0f - BurstFireRateFactor)));
    		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		BurstCount = 0;
    	}
    	else
    	{
    		NextFireTime += FireRate * BurstFireRateFactor;
  			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
  		}
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
	}
}

simulated function StopFiring()
{	
	if (bBurstMode && BurstCount != 0)
	{
		NextFireTime = Level.TimeSeconds + FireRate * (1 + (MaxBurst * (1.0f - BurstFireRateFactor)));
		BurstCount = 0;
	}
}

// End firing stuff -------------------------------------------------------------

simulated function WeaponReloaded()
{
	bPlayedDryFire=false;
}

// Checks if gun has fired too much for weapon mode. (e.g. more than one shot for single fire
// or more than the amount allowed in a burst) Returns false if it has
simulated function bool CheckWeaponMode()
{
	if (Instigator != None && AIController(Instigator.Controller) != None)
		return true;
	return BW.CheckWeaponMode(ThisModeNum);
}

// Check if gun is reloading or otherwise handling something
simulated function bool CheckReloading()
{
	if (BW.MeleeState > MS_Pending)
		return false;
	if (BW.ReloadState == RS_Cocking && !bIgnoreCocking)
		return false;
	if ((BW.ReloadState != RS_None || BW.bServerReloading) && !bIgnoreReload)
		return false;		// Is weapon busy reloading
	return true;
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing

	if (!bUseWeaponMag || BW.bNoMag)
	{
		if(!Super.AllowFire())
		{
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
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
	else if (BW.bNeedCock)
		return false;		// Is gun cocked
    return true;
}

defaultproperties
{
     ClipFinishSound=(Volume=0.500000,Radius=24.000000,Pitch=1.000000)
     DryFireSound=(Volume=0.500000,Radius=24.000000,Pitch=1.000000)
     bUseWeaponMag=True
     FlashBone="tip"
     FlashScaleFactor=1.000000
     BrassBone="ejector"
	 bReleaseFireOnDie=True
	 FireChaos=0
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))
     FireSpreadMode=FSM_Circle
     UnjamMethod=UJM_Cock
     JamSound=(Volume=0.800000,Radius=24.000000,Pitch=1.000000,bAtten=True)
     bJamWastesAmmo=True
     SilencedFireSound=(Volume=0.7,Radius=48.000000,Pitch=1.000000,bNoOverride=True)
     BallisticFireSound=(Volume=1.000000,Radius=512.000000,Pitch=1.000000,bNoOverride=True)
     TransientSoundVolume=1.000000
     TweenTime=0.000000
     AmmoPerFire=1
	 BurstFireRateFactor=0.66
}
