//=============================================================================
// RecoilComponent.
//
// Represents the recoil system component of a Ballistic Weapon.
//
// by Azarael 2020
// adapting code written by DarkCarnivour, whose comments are below:
//
// Recoil is added each shot and declines each tick(). Recoil is seperate from the base aim and makes the weapon inaccurate
// from firing. Crouching reduces the rate of increase of recoil. How recoil affects the weapon depends on 3 factors:
// Recoil Path Curves:
// 		Yaw and Pitch are applied to the gun through two curves that give the Yaw and Pitch value depending
// 		the amount of recoil. These curves can be altered to steer the gun along winding, curved paths when recoil is applied.
//		At (In=0,Out=0),(In=1,Out=1) these will do nothing and the Scaling Factors will set a straight recoil path.
// Recoil Scaling:
//		RecoilYawFactor and RecoilPitchFactor * Recoil add Yaw and Pitch to the gun. At 1.0, these do nothing and the curves
//		set how the gun moves with recoil. These can be set to give general scaling to the curves.
// Recoil Randomness:
//		RecoilRand(X and Y) * Recoil add Yaw and Pitch randomness to the gun.
//=============================================================================
class RecoilComponent extends Object;

//=============================================================================
// ACTOR/OBJECT REFERENCES
//
// MUST BE CLEANED UP FROM THE WEAPON CODE
//=============================================================================
var 				BallisticWeapon		BW;
var 				LevelInfo			Level;
var() editinline 	RecoilParams		Params;

// UnrealScript's shitty object handling necessitates copying most of the RecoilParams fields we might want to modify
// and exposing them as public so that we can apply modifiers from the weapon
//
// The nice modifier-based / delegate-based solution to this crashes for no good reason, so whatever :) :) :) :) :) :)
//=============================================================================
// MUTABLES
//=============================================================================
var float						PitchFactor;				// Recoil is multiplied by this and added to Aim Pitch.
var float						YawFactor;					// Recoil is multiplied by this and added to Aim Yaw.
var float						XRandFactor;				// Recoil multiplied by this for recoil Yaw randomness
var float						YRandFactor;				// Recoil multiplied by this for recoil Pitch randomness
var float						MinRandFactor;				// Bias for calculation of recoil random factor
var int							MaxRecoil;					// The maximum recoil amount
var float						ClimbTime;					// Time taken to interpolate between positions
var float						DeclineTime;				// Time it takes for Recoil to decline maximum to zero
var float						DeclineDelay;				// The time between firing and when recoil should start decaying
var float             			HipMultiplier;            	// Hipfire recoil is scaled up by this value
var float						MaxMoveMultiplier;			// Recoil while moving is scaled by this value - maximum is applied when player is moving at full basic run speed
var float             			CrouchMultiplier;         	// Crouch recoil is scaled by this value
var bool                        bViewDecline;               // Weapon will move back down through its recoil path when recoil is declining
var bool						bUseAltSightCurve;			// Weapon will use a different recoil curve when in sights - danger, this will break under certain conditions (see note)

//=============================================================================
// STATE
//=============================================================================
struct StateData
{
	var int Recoil;			// Current recoil amount. Determines position on the recoil path.
	var float XRand;		// Current X random factor for recoil. Determines additional offset on the recoil path.
	var float YRand;		// Current Y random factor for recoil. Determines additional offset on the recoil path.
};

var private StateData           Current;					// Current recoil state.	
var private StateData			Start;						// Start recoil state for last shot.
var private StateData			Target;						// Destination recoil for last shot.

var private float				AdjustmentPhase;			// Progression from Start to Target, 0-1
var private float				AdjustmentTime;				// Time to adjust from Start to Target

// View application
var private Rotator             LastViewPivot;   		    // Pivot saved between GetViewPivotDelta calls, used to find delta recoil  

/* 
notes on ViewBindFactor/ADSViewBindFactor - Azarael

because the server is authoritative on recoil (due to a timing fault in UT's netcode), and the client's reception of recoil is delayed,
values other than 1.0 (hard bind to view) will cause varying degrees of desynchronization between the client and server,
because the recoil offset on the server will not match the recoil offset on the client,
which is what is used to visually offset the weapon, and thus the sights that the player is aiming with

this is very severe with weapons which are single shot with high recoil and a fast reset, such as power pistols -
the client may fire again before the weapon has fully reset on their end,
but on the server, the resetting process started before the client, and will continue while the client's request to shoot is being sent over the wire
so, by the time the server calculates the shot, the weapon has already reset, so the weapon appears to fire far below the aim position the client saw

for this reason I strongly advise using full recoil binds for these weapons in whichever modes are considered accurate, 
at least until a fix can be added (recoil application and modification needs to be delayed on the server by 1/2 of the player's observed ping)

if gametype uses ADS for precision, Params.ADSViewBindFactor is the value, otherwise, it's Params.ViewBindFactor
we accept a degree of desynchronization on hipfire if the gametype isn't intended to be played primarily from hipfire

this problem does not affect weapons using a value of 1 
because the server will only use the recoil value to calculate shot trajectory for the component of recoil that is _not_ bound to the player's view
if all recoil is bound to the view, the server will simply use the player's look direction for aim, which is a client input value with no server adjustment
and thus will be updated at the same time as the request to shoot is received by the server
*/
var private float               ViewBindFactor;            	// Amount to bind recoil offsetting to view.

// State
var private float               LastRecoilTime;             // Last time at which recoil was added

// Replication
// var private bool                bForceUpdate;               // Forces ApplyAimToView call to recalculate recoil (set after ReceiveNetRecoil)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ACCESSORS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

final simulated function float GetTargetRecoil()
{
    return Target.Recoil;
}

final simulated function float GetTargetXRand()
{
    return Target.XRand;
}

final simulated function float GetTargetYRand()
{
    return Target.YRand;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// UTILITY
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//===========================================================
// HoldingRecoil
//
// True if recoil is not declining
//===========================================================
final simulated function bool HoldingRecoil()
{
    return LastRecoilTime + DeclineDelay >= Level.TimeSeconds;
}

//===========================================================
// ShouldUpdateView
//
// Called by weapon to determine if delta recoil 
// should be added to the view rotation on this tick
//===========================================================
final simulated function bool ShouldUpdateView()
{
	// apply if recoil is climbing
	if (Current.Recoil > 0 && HoldingRecoil())
		return true;

	// apply if forced (classic snake behaviour)
	if (bViewDecline)
		return true;

	return false;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLEANUP (hello where are the RAII?)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//===========================================================
// Cleanup
//
// Resets state variables before this object is released 
// to the pool
//===========================================================

final simulated function Cleanup()
{
	BW = None;
	Level = None;

	Params = None;

	Current.Recoil = 0;
	Current.XRand = 0;
	Current.YRand = 0;

	Start.Recoil = 0;
	Start.XRand = 0;
	Start.YRand = 0;

	Target.Recoil = 0;
	Target.XRand = 0;
	Target.YRand = 0;

	LastViewPivot = rot(0,0,0);
	ViewBindFactor = 0;

	LastRecoilTime = 0;

	//bForceUpdate = false;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// GAMEPLAY
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//===========================================================
// Recalculate
//
// Called when parameters are change to assign internal 
// state variables
//===========================================================
final simulated function Recalculate()
{
    assert(Params != None);
    
	PitchFactor 		= Params.PitchFactor;
	YawFactor 			= Params.YawFactor;
	XRandFactor 		= Params.XRandFactor;
	YRandFactor 		= Params.YRandFactor;
	MinRandFactor 		= Params.MinRandFactor;
	MaxRecoil 			= Params.MaxRecoil;
	ClimbTime			= Params.ClimbTime;
	DeclineTime 		= Params.DeclineTime;
	DeclineDelay		= Params.DeclineDelay;
	HipMultiplier 		= Params.HipMultiplier;
	MaxMoveMultiplier 	= Params.MaxMoveMultiplier;
	CrouchMultiplier 	= Params.CrouchMultiplier;
    bViewDecline        = Params.bViewDecline;
    bUseAltSightCurve   = Params.bUseAltSightCurve;

	if (ViewBindFactor == 0)
		ViewBindFactor = Params.ViewBindFactor;

	BW.OnRecoilParamsChanged();
}

//=============================================================
// UpdateRecoil
//
// Interpolates the recoil between start and end.
// Initiates view decline if needed.
//=============================================================
final simulated function UpdateRecoil(float dt)
{
	// update shift to desired target value
	if (Current.Recoil != Target.Recoil || Current.XRand != Target.XRand || Current.YRand != Target.YRand)
	{
		// prevent div0
		if (AdjustmentTime == 0)
			AdjustmentPhase = 1;
		else 
			AdjustmentPhase = FMin(1, AdjustmentPhase + (dt / AdjustmentTime));
		
		Current.Recoil = Lerp(AdjustmentPhase, Start.Recoil, Target.Recoil);
		Current.XRand = Lerp(AdjustmentPhase, Start.XRand, Target.XRand);
		Current.YRand = Lerp(AdjustmentPhase, Start.YRand, Target.YRand);
	}

	// initiate view decline if past recoil decline delay
	else if (Current.Recoil > 0 && !HoldingRecoil())
	{
		Start = Current;

		Target.Recoil = 0;
		Target.XRand = 0;
		Target.YRand = 0;

		AdjustmentPhase = 0;
		AdjustmentTime = DeclineTime * Start.Recoil / MaxRecoil;
	}
}

final simulated function float ModifyRecoil(float amount)
{
	if (VSize(BW.Instigator.Velocity) >= 30) // moving modifiers
	{
		// increase recoil when moving by function of current move speed
		if (MaxMoveMultiplier > 1.0f)
			amount *= 1f + ((MaxMoveMultiplier - 1f) * FMin(1f, VSize(BW.Instigator.Velocity) / class'BallisticReplicationInfo'.default.PlayerGroundSpeed));
	}
	else // stationary modifiers
	{
		// reduce recoil when stationary crouched by desired factor
		if (BW.Instigator.bIsCrouched)
		amount *= CrouchMultiplier;
	}
		
	// increase recoil when not in ADS
	if (!BW.bScopeView)
		amount *= HipMultiplier;

	// scale by game style
	amount *= class'BallisticReplicationInfo'.default.RecoilShotScale;

	return amount;
}

//===========================================================
// AddRecoil
//
// Called authoritatively to add recoil
//===========================================================
final simulated function AddRecoil (float Amount, optional byte Mode)
{
	if (BW.bAimDisabled || Amount == 0 || (BW.bUseNetAim && BW.Role < ROLE_Authority))
		return;

	Amount = ModifyRecoil(Amount);

	Start = Current;
	
	Target.Recoil = FMin(MaxRecoil, FMax(Current.Recoil, Target.Recoil) + Amount);
	Target.XRand = FRand();
	Target.YRand = FRand();
	
	if (Target.Recoil == MaxRecoil)
	{
		if (Amount < 260)
		{
			Target.XRand *= 5 * (400 - Amount) / 400;
			Target.YRand *= 5 * (400 - Amount) / 400;
		}
		else
		{
			Target.XRand *= 3;
			Target.YRand *= 3;
		}
	}

	AdjustmentPhase = 0;
	AdjustmentTime = ClimbTime;

	LastRecoilTime = BW.Level.TimeSeconds;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Display
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
final simulated function UpdateADSTransition(float delta)
{
    ViewBindFactor = Smerp(delta, Params.ViewBindFactor, Params.ADSViewBindFactor);
}

final simulated function OnADSViewStart()
{
    ViewBindFactor = Params.ADSViewBindFactor;
}

final simulated function OnADSViewEnd()
{
    // BallisticWeapon's PositionSights will handle this for clients
    if (Level.NetMode == NM_DedicatedServer)
        ViewBindFactor = Params.ViewBindFactor;
}

//===========================================================
// GetWeaponPivot
//
// Returns the total recoil offset of the weapon.
//===========================================================
final simulated function Rotator GetWeaponPivot()
{
    return GetRecoilPivot(false);
}

//===========================================================
// GetViewPivot
//
// Returns the recoil offsetting applied to the view.
//===========================================================
final simulated function Rotator GetViewPivot()
{
    return GetRecoilPivot(true) * ViewBindFactor;
}

//===========================================================
// CalcViewPivotDelta
//
// Calculates the change in view offsetting.
//===========================================================
final simulated function Rotator CalcViewPivotDelta()
{
    local Rotator CurViewPivot, DeltaPivot;

    CurViewPivot = GetRecoilPivot(true) * ViewBindFactor;

    DeltaPivot = CurViewPivot - LastViewPivot;

    LastViewPivot = CurViewPivot;

    return DeltaPivot;
}

//===========================================================
// GetRecoilPivot
//
// If bIgnoreViewAim is set, returns the absolute recoil pivot.
//
// If bIgnoreViewAim is not set, returns the relative recoil pivot
// to the player's current view aim.
//===========================================================
private final simulated function Rotator GetRecoilPivot(bool bIgnoreViewAim)
{
	local Rotator R;
	local float AdjustedRecoil;

	if (!bIgnoreViewAim && ViewBindFactor == 1)
        return R;
        
	// Randomness
    if (Params.MinRandFactor > 0)
	{
		AdjustedRecoil = Params.MaxRecoil * Params.MinRandFactor + Current.Recoil * (1 - Params.MinRandFactor);
		R.Yaw = ((-AdjustedRecoil * Params.XRandFactor + AdjustedRecoil * Params.XRandFactor *2 * Current.XRand) * 0.3);
		R.Pitch = ((-AdjustedRecoil * Params.YRandFactor + AdjustedRecoil * Params.YRandFactor * 2 * Current.YRand) * 0.3);
	}
	else
	{
		R.Yaw = ((-Current.Recoil * Params.XRandFactor + Current.Recoil * Params.XRandFactor * 2 * Current.XRand) * 0.3);
		R.Pitch = ((-Current.Recoil * Params.YRandFactor + Current.Recoil * Params.YRandFactor * 2 * Current.YRand) * 0.3);
    }
        
	// Pitching/Yawing

	// Azarael notes:
	// This will work, but ONLY if you have 100% view binding of recoil.
	// If there is any escape factor, you will get a visual jump where the evaluation of the two curves differs.
	if (BW.bScopeView && bUseAltSightCurve)
	{
		R.Yaw += Params.EvaluateXRecoilAlt(Current.Recoil);
		R.Pitch += Params.EvaluateYRecoilAlt(Current.Recoil);
	}
	else
	{
		R.Yaw += Params.EvaluateXRecoil(Current.Recoil);
		R.Pitch += Params.EvaluateYRecoil(Current.Recoil);
	}

	if (BW.Handedness() < 0) // held in left hand - reverse recoil curve
		R.Yaw = -R.Yaw;

    R *= class'BallisticReplicationInfo'.default.RecoilScale;
	
	if (bIgnoreViewAim || BW.Instigator.Controller == None || PlayerController(BW.Instigator.Controller) == None || PlayerController(BW.Instigator.Controller).bBehindView)
        return R;
        
	return R*(1-ViewBindFactor);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AI
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
final function bool BotShouldFire(float Dist)
{
    if (Current.Recoil * Params.YawFactor > 100 * (1+4000/Dist) || (Current.Recoil * Params.PitchFactor > 100 * (1+4000/Dist)))
        return false;

    return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Replication
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
final simulated function ReceiveNetRecoil(byte NetXRand, byte NetYRand, float NetRecoil)
{
	Start = Current;

	Target.Recoil = NetRecoil;
	Target.XRand = float(NetXRand)/255;
	Target.YRand = float(NetYRand)/255;

	AdjustmentPhase = 0;
	AdjustmentTime = ClimbTime;

	LastRecoilTime = Level.TimeSeconds;
	//bForceUpdate = true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Debug
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
final simulated function DrawDebug(Canvas Canvas)
{
    Canvas.DrawText("Recoil: "$ Current.Recoil $"/"$ MaxRecoil $", XRand "$ Current.XRand $", YRand "$ Current.YRand $" (Lerp "$ Start.Recoil $"-"$Target.Recoil $", XRand "$ Start.XRand $"-"$Target.XRand $", YRand "$ Start.YRand $"-"$Target.YRand $", Phase "$AdjustmentPhase$"), ViewBindFactor: Cur " $ ViewBindFactor $ ", Hip "$ Params.ViewBindFactor $ ", ADS " $ Params.ADSViewBindFactor);
}