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
class BallisticFire extends WeaponFire;

// General Variables -----------------------------------------------------------
var   BallisticWeapon		BW;						// Easy access to BallisticWeapon(Weapon)
var() BUtil.FullSound		ClipFinishSound;		// Sound to play when mag runs out
var() BUtil.FullSound		DryFireSound;			// Sound to play when dry firing
var   bool						bPlayedDryFire;		// Has dry fire sound been played since ammo ran out
var() bool						bCockAfterFire;		// Cock the gun after each shot
var() bool						bCockAfterEmpty;	// Cock the gun if MagAmmo gets to 0
var() bool						bDryUncock;			// Can still uncock weapon by pressing fire when mag is empty
var() bool						bUseWeaponMag;	// Use ammo from gun. Uses ammo from weapon's mag is it has one
var() Actor						MuzzleFlash;			// The muzzleflash actor
var() class<Actor>			MuzzleFlashClass;	// The actor to use for this fire's muzzleflash
var() Name						FlashBone;				// Bone to attach muzzle flash to
var() float						FlashScaleFactor;	// MuzzleFlash scaling will be DrawScale * FlashScaleFactor
var() class<actor>			BrassClass;				// Actor to spawn for ejecting brass
var() name						BrassBone;				// Bone where brass will be spawned
var() bool						bBrassOnCock;		// Eject brass when cocked
var() Vector					BrassOffset;			// Position offset for brass spawning
var   int							ConsumedLoad;		// This is the amount of ammo to consume for delayed consume ammo.
var() bool						bReleaseFireOnDie;	// If bFireOnRelease, mode will fire if holder died before release
var() bool						bIgnoreReload;		// This firemode can stop the weapon reloading and fire
var() bool						bIgnoreCocking;		// This mode can cancel weapon cocking to fire
var Name 						AimedFireAnim;		// Fire anim to play when scoped
var Name						EmptyFireAnim, EmptyAimedFireAnim; //Fire anim to play when emptied
// Burst Mode -----------------------------------------------------------------
var int BurstCount;										// Number of shots fired in this burst thus far
var int MaxBurst;											// Max shots per burst, set by Weapon
var bool bBurstMode;									// Weapon fires bursts
var float	BurstFireRateFactor;						// Multiplies down fire rate in burst mode

var() enum EScopeDownOn
{
	SDO_Never,	// Don't do anything for this fire
	SDO_Fire,	// Lower on fire
	SDO_PreFire // Lower on PreFire
}								ScopeDownOn;		// What can cause the the gun to be lowered out of scope/sight view
//-----------------------------------------------------------------------------

//Bullet spread variables------------------------------------------------------
var() float				FireRecoil;				// Amount of recoil added each shot
var() float				FirePushbackForce;		// How much to jolt player back when they fire
var() float				FireChaos;				// Chaos added to aim when fired. Will be auto calculated if < 0
var() InterpCurve		FireChaosCurve;
var() float				XInaccuracy;			// Set amount that bullets can Yaw away from gun's aim
var() float				YInaccuracy;			// Set amount that bullets can Pitch away from gun's aim
enum EFireSpreadMode
{
	FSM_Rectangle,	// Standard random rectangular box.
	FSM_Scatter,	// An eliptical spread pattern with higher concentratrion towards the center.
	FSM_Circle		// More evenly spread eliptical pattern.
};
var() EFireSpreadMode	FireSpreadMode;		// The type of spread pattern to use for X and YInaccuracy
//-----------------------------------------------------------------------------

//Weapon Jamming---------------------------------------------------------------
//This is gonna annoy some people. Weapons can have a chance that each shot will jam.
//Weapons have to be unjammed before firing may resume.
var(Jamming) enum EUnjamMethod
{
	UJM_ReloadAndCock,	// Weapon must be reloaded, clip out, back in and cocked
	UJM_Reload,				// Weapon must be reloaded, clip out and back in
	UJM_Cock,					// Weapon must be cocked.
	UJM_FireNextRound,		// Pressing fire will unjam, but not fire a bullet
	UJM_Fire					// Press fire to unjam and fire the next round
}							UnjamMethod;					// How to unjam this firemode
var(Jamming) float	JamChance;					// Chance of weapon jamming each shot
var(Jamming) float	WaterJamChance;			// Chance of weapon jamming each shot when under water
var(Jamming) float	JamMoveMultiplier;			// JamChance multiplied by this when player is moving
var	bool				bIsJammed;					// Is this firemode currently jammed
var(Jamming) BUtil.FullSound JamSound;			// Sound to play when clip runs out
var bool					bPendingTryJam;				// Try jam next Timer()
var(Jamming) bool	bJamWastesAmmo;			// Jamming wastes the ammo that would have been fired
//-----------------------------------------------------------------------------

// Sound Stuff  ---------------------------------------------
var() BUtil.FullSound		SilencedFireSound;	// Fire sound to play when silenced
var() BUtil.FullSound		BallisticFireSound;	// Fire sound to play
var() bool						bAISilent;				// Bots dont hear the fire
//-----------------------------------------------------------

//===========================================================================
//Statistics variables
//===========================================================================
struct FireModeStats
{
	var	String	Damage;
	var	int			DamageInt;
	var	int			DPS;
	var	float		TTK;
	var	String	RPM;
	var	int			RPShot;
	var	int			RPS;
	var	float		FCPShot;
	var	float		FCPS;
	var	String	Range;
};

var	String		ShotTypeString, EffectString;

simulated function PreBeginPlay()
{
	super.PreBeginPlay();
	BW = BallisticWeapon(Weapon);
}

function StartBerserk()
{
    FireRate = default.FireRate * 0.75;
    FireAnimRate = default.FireAnimRate/0.75;
    FireRecoil = default.FireRecoil * 0.75;
    FireChaos = default.FireChaos * 0.75;
}

function StopBerserk()
{
    FireRate = default.FireRate;
    FireAnimRate = default.FireAnimRate;
    FireRecoil = default.FireRecoil;
    FireChaos = default.FireChaos;
}

function StartSuperBerserk()
{
    FireRate = default.FireRate/Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    FireRecoil = default.FireRecoil * Level.GRI.WeaponBerserk;
}

//Stub called by the weapon mode when its FireMode changes if bNotifyModeSwitch is set to true
simulated function SwitchWeaponMode (byte NewMode);

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

simulated function ApplyRecoil ()
{
	local Vector VelRecoilVect;
	if (BW != None)
	{
		if (!BW.bReaiming)
			BW.Reaim(level.TimeSeconds-Weapon.LastRenderTime, , , , , FireChaos);
		BW.AddRecoil(FireRecoil, ThisModeNum);
	}
	if (FirePushbackForce != 0 && Instigator!= None)
	{
		VelRecoilVect = Vector(Instigator.GetViewRotation()) * FirePushbackForce;
		VelRecoilVect.Z *= 0.25;
		
		if (Instigator.Physics != PHYS_Falling)
			Instigator.Velocity -= VelRecoilVect;
	}
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

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
	
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
    else if (!BW.bUseNetAim && !BW.bScopeView)
    	ApplyRecoil();
	
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

function StopFiring()
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
	//Force noobs to scope.
	if ((BW.BCRepClass.default.bSightFireOnly || class'BallisticWeapon'.default.SightsRestrictionLevel > 0) && BW.bUseSights && BW.SightingState != SS_Active && !BW.bScopeHeld && Instigator.IsLocallyControlled() && PlayerController(Instigator.Controller) != None)
		BW.ScopeView();
	if (!BW.bScopeView && (class'BallisticWeapon'.default.SightsRestrictionLevel > 1 || (class'BallisticWeapon'.default.SightsRestrictionLevel > 0 && BW.ZoomType != ZT_Irons)))
		return false;
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

//Accessor stub for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
	FS.Damage=default.EffectString;
	if (default.FireRate < 0.5)
		FS.RPM = String(int((1 / default.FireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/default.FireRate@"times/second";
	FS.RPShot = default.FireRecoil;
	FS.RPS = default.FireRecoil / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	
	return FS;
}

defaultproperties
{
     ClipFinishSound=(Volume=0.500000,Radius=32.000000,Pitch=1.000000)
     DryFireSound=(Volume=0.500000,Radius=32.000000,Pitch=1.000000)
     bUseWeaponMag=True
     FlashBone="tip"
     FlashScaleFactor=1.000000
     BrassBone="ejector"
	 bReleaseFireOnDie=True
	 FireChaos=0
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))
     FireSpreadMode=FSM_Circle
     UnjamMethod=UJM_Cock
     JamSound=(Volume=0.800000,Radius=32.000000,Pitch=1.000000,bAtten=True)
     bJamWastesAmmo=True
     SilencedFireSound=(Volume=0.500000,Pitch=1.000000,bNoOverride=True)
     BallisticFireSound=(Volume=1.000000,Radius=512.000000,Pitch=1.000000,bNoOverride=True)
     ShotTypeString="rounds"
     EffectString="Unknown"
     TransientSoundVolume=1.000000
     TweenTime=0.000000
     AmmoPerFire=1
	 BurstFireRateFactor=0.66
}
