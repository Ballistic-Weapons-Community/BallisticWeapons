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

enum ERecoilState
{
	Holding,
	Climbing,
	Declining
};

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
var float						MaxMoveMultiplier;			// Recoil while moving is scaled by this value - maximum is applied when player is moving at or above walk speed
var float             			CrouchMultiplier;         	// Crouch recoil is scaled by this value
var bool                        bViewDecline;               // Weapon will move back down through its recoil path when recoil is declining
var bool						bUseAltSightCurve;			// Weapon will use a different recoil curve when in sights - danger, this will break under certain conditions (see note)

//=============================================================================
// SERVER STATE
//=============================================================================
struct StateData
{
	var int Recoil;			// Current recoil amount. Determines position on the recoil path.
	var float XRand;		// Current X random factor for recoil. Determines additional offset on the recoil path.
	var float YRand;		// Current Y random factor for recoil. Determines additional offset on the recoil path.
};

var private StateData			Start;						// Start recoil state for last shot.
var private StateData           Current;					// Current recoil state. Interpolated using AdjustmentPhase/Time.
var private StateData			Target;						// Destination recoil for last shot.

//=============================================================================
// INTERPOLATIVE STATE
//=============================================================================
var private Rotator				StartPivot;					// Pivot for the start position of this recoil interpolation.
var private Rotator				CurrentPivot;				// Pivot for the current position on this recoil interpolation.
var private Rotator				LastPivot;					// Pivot for the last calculated position on this recoil interpolation. Used to find deltas for view shift.
var private Rotator				TargetPivot;				// Pivot for the end position on this recoil interpolation.

var private float				AdjustmentPhase;			// Progression from start pivot to target pivot, 0-1
var private float				AdjustmentTime;				// Time to adjust from Start to Target

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
var private ERecoilState		MoveState;

// Replication
// var private bool                bForceUpdate;               // Forces ApplyAimToView call to recalculate recoil (set after ReceiveNetRecoil)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ACCESSORS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// UTILITY
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//===========================================================
// CanDeclineRecoil
//
// True if recoil can decline
//===========================================================
final simulated function bool CanDeclineRecoil()
{
    return LastRecoilTime + DeclineDelay < Level.TimeSeconds;
}

final simulated function bool ShouldShift()
{
	return MoveState != ERecoilState.Holding;
}

//===========================================================
// ShouldUpdateView
//
// Called by weapon to determine if delta recoil 
// should be added to the view rotation on this tick
//===========================================================
final simulated function bool ShouldUpdateView()
{
	return bViewDecline || MoveState != ERecoilState.Declining;
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

	ViewBindFactor = 0;

	LastRecoilTime = 0;

	MoveState = ERecoilState.Holding;

	StartPivot = rot(0,0,0);
	CurrentPivot = rot(0,0,0);
	LastPivot = rot(0,0,0);
	TargetPivot = rot(0,0,0);

	AdjustmentPhase = 0;
	AdjustmentTime = 0;

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
	LastPivot = CurrentPivot;

	// update shift to desired target value
	if (ShouldShift())
	{
		// prevent div0
		if (AdjustmentTime == 0)
			AdjustmentPhase = 1f;

		AdjustmentPhase = FMin(1, AdjustmentPhase + (dt / AdjustmentTime));

		//Log("Adjust: Time "$AdjustmentTime$", Phase "$AdjustmentPhase);

		// x64 fix for bad Lerp handling
		if (AdjustmentPhase < 1f)
		{
			if (BW.Role == ROLE_Authority)
			{
				Current.Recoil = Lerp(AdjustmentPhase, Start.Recoil, Target.Recoil);
				Current.XRand = Lerp(AdjustmentPhase, Start.XRand, Target.XRand);
				Current.YRand = Lerp(AdjustmentPhase, Start.YRand, Target.YRand);
			}

			CurrentPivot.Pitch = Lerp(AdjustmentPhase, StartPivot.Pitch, TargetPivot.Pitch);
			CurrentPivot.Yaw = Lerp(AdjustmentPhase, StartPivot.Yaw, TargetPivot.Yaw);
		}

		else 
		{
			if (BW.Role == ROLE_Authority)
				Current = Target;

			CurrentPivot = TargetPivot;

			MoveState = ERecoilState.Holding;
		}
	}

	// initiate view decline if past recoil decline delay
	else if (BW.Role == ROLE_Authority && Current.Recoil > 0 && CanDeclineRecoil())
	{
		StartRecoilDecline();
	}
}

//===========================================================
// AddRecoil
//
// Called authoritatively to add recoil
//===========================================================
final function AddRecoil (float Amount, optional byte Mode)
{
	local StateData NewTarget;
	local Rotator NewTargetDeltaPivot;

	if (BW.bAimDisabled || Amount == 0 || BW.Role < ROLE_Authority)
		return;

	Amount = ScaleRecoilAmount(Amount);

	// always interpolate from our current position on the path when the shot was fired
	Start = Current;
	StartPivot = CurrentPivot;

	// if declining, target position will be at (0,0), so use current position instead
	if (MoveState == ERecoilState.Declining)
	{
		Target = Current;
		TargetPivot = CurrentPivot;
	}

	// create new recoil state for this shot
	NewTarget.Recoil = FMin(MaxRecoil, Target.Recoil + Amount);
	NewTarget.XRand = FRand();
	NewTarget.YRand = FRand();
	
	if (NewTarget.Recoil == MaxRecoil)
	{
		if (Amount < 260)
		{
			NewTarget.XRand *= 5 * (400 - Amount) / 400;
			NewTarget.YRand *= 5 * (400 - Amount) / 400;
		}
		else
		{
			NewTarget.XRand *= 3;
			NewTarget.YRand *= 3;
		}
	}

	// evaluate the recoil pivots for the last and current target states to determine the delta rotation
	NewTargetDeltaPivot = CalculateRecoil(NewTarget) - CalculateRecoil(Target);

	// shift the target pivot by this new delta, derived from the recoil pattern
	Target = NewTarget;
	TargetPivot += NewTargetDeltaPivot;

	AdjustmentPhase = 0;
	AdjustmentTime = ClimbTime;

	MoveState = ERecoilState.Climbing;

	LastRecoilTime = BW.Level.TimeSeconds;

	if (BW.Role == ROLE_Authority)
		BW.SendNetRecoil(TargetPivot.Pitch, TargetPivot.Yaw, ClimbTime);
}

final function StartRecoilDecline()
{
	MoveState = ERecoilState.Declining;

	Start = Current;
	StartPivot = CurrentPivot;

	Target.Recoil = 0;
	Target.XRand = 0;
	Target.YRand = 0;
	TargetPivot = rot(0,0,0);

	AdjustmentPhase = 0;
	AdjustmentTime = DeclineTime * (float(Current.Recoil) / float(MaxRecoil));

	BW.SendNetRecoil(0,0,AdjustmentTime);
}

final simulated function float ScaleRecoilAmount(float amount)
{
	if (VSize(BW.Instigator.Velocity) >= 30) // moving modifiers
	{
		// increase recoil when moving by function of current move speed
		if (MaxMoveMultiplier > 1.0f)
			amount *= 1f + ((MaxMoveMultiplier - 1f) * FMin(1f, VSize(BW.Instigator.Velocity) / (class'BallisticReplicationInfo'.default.PlayerGroundSpeed * BW.Instigator.WalkingPct)));
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
// CalcViewPivotDelta
//
// Calculates the change in view offsetting.
//===========================================================
final simulated function Rotator CalcViewPivotDelta()
{
	return CurrentPivot - LastPivot;
}

//===========================================================
// GetViewPivot
//
// Returns a Rotator for the component of recoil that is 
// being applied to the player's view.
//===========================================================
final simulated function Rotator GetViewPivot()
{
	if (BW.Instigator.Controller == None || PlayerController(BW.Instigator.Controller) == None || PlayerController(BW.Instigator.Controller).bBehindView)
		return CurrentPivot;

	return CurrentPivot * ViewBindFactor;
}

//===========================================================
// GetEscapePivot
//
// Returns a Rotator for the component of recoil that is 
// not being applied to the player's view (and appears to 
// be offsetting the weapon relative to the view.)
//===========================================================
final simulated function Rotator GetEscapePivot()
{
	if (ViewBindFactor == 1)
		return rot(0,0,0);

	return CurrentPivot * (1 - ViewBindFactor);
}

//===========================================================
// CalculateRecoil
//
// Calculates the offset for the current recoil state by 
// using random factors and the recoil pattern.
//===========================================================
private final simulated function Rotator CalculateRecoil(StateData state)
{
	local Rotator R;
	local float AdjustedRecoil;

	// Randomness
    if (Params.MinRandFactor > 0)
	{
		AdjustedRecoil = Params.MaxRecoil * Params.MinRandFactor + state.Recoil * (1 - Params.MinRandFactor);
		R.Yaw = ((-AdjustedRecoil * Params.XRandFactor + AdjustedRecoil * Params.XRandFactor *2 * state.XRand) * 0.3);
		R.Pitch = ((-AdjustedRecoil * Params.YRandFactor + AdjustedRecoil * Params.YRandFactor * 2 * state.YRand) * 0.3);
	}
	else
	{
		R.Yaw = ((-state.Recoil * Params.XRandFactor + state.Recoil * Params.XRandFactor * 2 * state.XRand) * 0.3);
		R.Pitch = ((-state.Recoil * Params.YRandFactor + state.Recoil * Params.YRandFactor * 2 * state.YRand) * 0.3);
    }
        
	// Pitching/Yawing

	// Azarael notes:
	// This will work, but ONLY if you have 100% view binding of recoil.
	// If there is any escape factor, you will get a visual jump where the evaluation of the two curves differs.
	if (BW.bScopeView && bUseAltSightCurve)
	{
		R.Yaw += Params.EvaluateXRecoilAlt(state.Recoil);
		R.Pitch += Params.EvaluateYRecoilAlt(state.Recoil);
	}
	else
	{
		R.Yaw += Params.EvaluateXRecoil(state.Recoil);
		R.Pitch += Params.EvaluateYRecoil(state.Recoil);
	}

	if (BW.Handedness() < 0) // held in left hand - reverse recoil curve
		R.Yaw = -R.Yaw;

    R *= class'BallisticReplicationInfo'.default.RecoilScale;
	
    return R;
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
final simulated function ReceiveNetRecoil(int pitch, int yaw, float shift_time)
{
	StartPivot = CurrentPivot;

	TargetPivot.Pitch = pitch;
	TargetPivot.Yaw = yaw;

	AdjustmentPhase = 0;
	AdjustmentTime = shift_time;

	if (TargetPivot != rot(0,0,0))
		MoveState = ERecoilState.Climbing;
	else
		MoveState = ERecoilState.Declining;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Debug
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
final simulated function int DrawDebug(Canvas Canvas, int YPos, int YL)
{
    Canvas.DrawText("Recoil: "$ Current.Recoil $"/"$ MaxRecoil $", XRand "$ Current.XRand $", YRand "$ Current.YRand $" (Lerp "$ Start.Recoil $"-"$Target.Recoil $", XRand "$ Start.XRand $"-"$Target.XRand $", YRand "$ Start.YRand $"-"$Target.YRand $", Time "$AdjustmentTime$", Phase "$AdjustmentPhase$")");
	YPos += YL;
	Canvas.SetPos(4, YPos);
	Canvas.DrawText("Pivot: ("$ CurrentPivot.Pitch $", "$ CurrentPivot.Yaw $"), Start: ("$ StartPivot.Pitch $", "$ StartPivot.Yaw $"), Target: ("$ TargetPivot.Pitch $", "$ TargetPivot.Yaw $"), Last: ("$ LastPivot.Pitch $", "$ LastPivot.Yaw $")");
	YPos += YL;
	Canvas.SetPos(4, YPos);
	Canvas.DrawText("State: "$ GetEnum(enum'ERecoilState', MoveState) $", Should Shift: "$ ShouldShift() $", ViewBindFactor: Cur " $ ViewBindFactor $ ", Hip "$ Params.ViewBindFactor $ ", ADS " $ Params.ADSViewBindFactor);

	return YPos;
}