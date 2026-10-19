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
var private bool                bOverrideADSViewBind;       // Use ADSViewBindOverride instead of Params.ADSViewBindFactor.
var private float               ADSViewBindOverride;        // Per weapon ADS view bind (e.g. an alternate scope). Params are shared by every weapon, so don't write to them.

// State
var private float               LastRecoilTime;             // Last time at which recoil was added
var private ERecoilState		MoveState;

//=============================================================================
// PREDICTION
//
// The owner's machine adds the recoil of its own shots as it fires them, the way the server will a moment later.
// It used to wait for the server's numbers, so the kick of a shot came a round trip after it: 60 ms at 60 ping,
// 200 ms at 200. The random part of a shot comes from the weapon's RecoilSeed and the shot's number, so both
// machines draw the same. The server still sends its numbers for every shot. Where they differ from what was
// predicted the difference is eased in, and shots that were not predicted are taken from them as before.
//
// A fire mode is predicted when its bPredictRecoil is set (BallisticFire.ShakeView). The server then aims the
// unbound part of the recoil as it is now, not as it was a round trip ago (BallisticWeapon.GetPastFireRot).
//=============================================================================
struct PredictedShot
{
	var int			Count;
	var int			Recoil;
	var Rotator		Pivot;
	var float		Time;
};
var private int					ShotCount;					// Shots that added recoil. The owner's machine counts its own, and takes the server's when they part
var private bool				bPredicting;				// Owner's machine: running the recoil itself, since a shot it predicted
var private PredictedShot		Predicted[16];				// Owner's machine: where its last predicted shots took the recoil, at ShotCount & 15
var private bool				bOwnerPredicts;				// Server: the owner's machine predicted the last shot that added recoil
var string						DiagHow;					// DIAG: what the owner's machine made of the server's last numbers
var private int					ServerCount;				// Owner's machine: the shot the server's last numbers were for
var private float				RoundTrip;					// Owner's machine: how long the server's numbers for a predicted shot took
const RECOIL_TOLERANCE_DIV		= 64;						// Predicted and server's recoil amounts within MaxRecoil / this agree
const PIVOT_TOLERANCE			= 16;						// Predicted and server's pivots within this agree (0.09 degrees)

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
final function bool CanDeclineRecoil()
{
    return LastRecoilTime + DeclineDelay < Level.TimeSeconds;
}

final function bool ShouldShift()
{
	return MoveState != ERecoilState.Holding;
}

//===========================================================
// ShouldUpdateView
//
// Called by weapon to determine if delta recoil 
// should be added to the view rotation on this tick
//===========================================================
final function bool ShouldUpdateView()
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

final function Cleanup()
{
	local int i;

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
	bOverrideADSViewBind = false;
	ADSViewBindOverride = 0;

	LastRecoilTime = 0;

	MoveState = ERecoilState.Holding;

	StartPivot = rot(0,0,0);
	CurrentPivot = rot(0,0,0);
	LastPivot = rot(0,0,0);
	TargetPivot = rot(0,0,0);

	AdjustmentPhase = 0;
	AdjustmentTime = 0;

	ShotCount = 0;
	bPredicting = false;
	bOwnerPredicts = false;
	ServerCount = 0;
	RoundTrip = 0;
	for (i = 0; i < ArrayCount(Predicted); i++)
		Predicted[i].Count = 0;

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
final function Recalculate()
{
    assert(Params != None);
    
	PitchFactor 		= Params.PitchFactor;
	YawFactor 			= Params.YawFactor;
	XRandFactor 		= Params.XRandFactor;
	YRandFactor 		= Params.YRandFactor;
	MinRandFactor 		= Params.MinRandFactor;
	MaxRecoil 			= Params.MaxRecoil;
	DeclineTime 		= Params.DeclineTime;
	DeclineDelay		= Params.DeclineDelay;
	HipMultiplier 		= Params.HipMultiplier;
	MaxMoveMultiplier 	= Params.MaxMoveMultiplier;
	CrouchMultiplier 	= Params.CrouchMultiplier;
    bViewDecline        = Params.bViewDecline;
    bUseAltSightCurve   = Params.bUseAltSightCurve;

	// Testing - hard recoil lock
	if (class'BallisticGameStyles'.static.WYSIWYG())
	{
		Params.ViewBindFactor = 1;
		Params.ADSViewBindFactor = 1;
	}

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
final function UpdateRecoil(float dt)
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
			Current.Recoil = Lerp(AdjustmentPhase, Start.Recoil, Target.Recoil);
			Current.XRand = Lerp(AdjustmentPhase, Start.XRand, Target.XRand);
			Current.YRand = Lerp(AdjustmentPhase, Start.YRand, Target.YRand);

			CurrentPivot.Pitch = Lerp(AdjustmentPhase, StartPivot.Pitch, TargetPivot.Pitch);
			CurrentPivot.Yaw = Lerp(AdjustmentPhase, StartPivot.Yaw, TargetPivot.Yaw);
		}

		else 
		{
			Current = Target;

			CurrentPivot = TargetPivot;

			MoveState = ERecoilState.Holding;
		}
	}

	// initiate view decline if past recoil decline delay
	else if (RunsRecoil() && Current.Recoil > 0 && CanDeclineRecoil())
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
	if (BW.bAimDisabled || Amount == 0 || BW.Role < ROLE_Authority)
		return;

	ShotRecoil(Amount);

	bOwnerPredicts = BW.ModePredictsRecoil(Mode);
	BW.SendNetRecoil(ShotCount, Target.Recoil, TargetPivot.Pitch, TargetPivot.Yaw, Params.ClimbTime);
	if (class'BallisticDiag'.static.Logs(BW.Instigator))
		Log(class'BallisticDiag'.static.Head(BW.Level, "recoil sent") $ class'BallisticDiag'.static.Who(BW.Instigator) $ "|" $ BW.Class.Name
			$ "|after shot " $ BW.DiagShots $ "|shot " $ ShotCount $ "|recoil " $ Target.Recoil $ "|pitch " $ TargetPivot.Pitch $ "|yaw " $ TargetPivot.Yaw
			$ "|mode " $ Mode $ " predicted " $ bOwnerPredicts $ "|climb over " $ Params.ClimbTime $ " s");
}

//===========================================================
// PredictRecoil
//
// Called on the owner's machine for a shot of its own,
// ahead of the server's numbers for it
//===========================================================
final function PredictRecoil(float Amount)
{
	local int i;

	if (BW.bAimDisabled || Amount == 0 || BW.Role == ROLE_Authority)
		return;

	// Every earlier shot of this machine has been answered by now. One the server never fired (it can happen with
	// the last of a burst) leaves the server's count behind: go on from it
	if (ShotCount > ServerCount && RoundTrip > 0 && MoveState != ERecoilState.Climbing && Level.TimeSeconds - LastRecoilTime > RoundTrip + 0.1)
	{
		Log(class'BallisticDiag'.static.Head(BW.Level, "recoil predicted") $ class'BallisticDiag'.static.Who(BW.Instigator) $ "|" $ BW.Class.Name
			$ "|count " $ ShotCount $ " taken back to the server's " $ ServerCount $ " from rest");
		ShotCount = ServerCount;
	}

	ShotRecoil(Amount);
	bPredicting = true;

	i = ShotCount & 15;
	Predicted[i].Count = ShotCount;
	Predicted[i].Recoil = Target.Recoil;
	Predicted[i].Pivot = TargetPivot;
	Predicted[i].Time = Level.TimeSeconds;
	Log(class'BallisticDiag'.static.Head(BW.Level, "recoil predicted") $ class'BallisticDiag'.static.Who(BW.Instigator) $ "|" $ BW.Class.Name
		$ "|my shot " $ BW.DiagShots $ "|shot " $ ShotCount $ "|recoil " $ Target.Recoil $ "|pitch " $ TargetPivot.Pitch $ "|yaw " $ TargetPivot.Yaw
		$ "|amount " $ Amount $ "|rand " $ Target.XRand $ " " $ Target.YRand);
}

//===========================================================
// ShotRecoil
//
// One shot's recoil, the same on the server and the owner's
// machine
//===========================================================
private final function ShotRecoil(float Amount)
{
	local StateData NewTarget;
	local Rotator NewTargetDeltaPivot;

	Amount = ScaleRecoilAmount(Amount);
	ShotCount++;

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
	NewTarget.XRand = ShotRand(1);
	NewTarget.YRand = ShotRand(2);
	
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
	AdjustmentTime = Params.ClimbTime;

	MoveState = ERecoilState.Climbing;

	LastRecoilTime = BW.Level.TimeSeconds;
}

//===========================================================
// ShotRand
//
// The random factor of this shot's recoil, from the weapon's
// seed and the shot's number: both machines draw the same
//===========================================================
private final function float ShotRand(int Salt)
{
	local int X, i;

	X = BW.RecoilSeed + ShotCount * 7919 + Salt * 104729;
	for (i = 0; i < 3; i++)
	{
		X = X ^ (X << 13);
		X = X ^ (X >>> 17);
		X = X ^ (X << 5);
	}
	return float(X & 16777215) / 16777216.0;
}

//===========================================================
// RunsRecoil
//
// The machine that moves the recoil on: the server, and the
// owner's machine while it predicts
//===========================================================
final function bool RunsRecoil()
{
	return BW.Role == ROLE_Authority || bPredicting;
}

//===========================================================
// OwnerPredicts
//
// Server: the owner's machine predicted the last shot that
// added recoil, so it shows the recoil as it is here now
//===========================================================
final function bool OwnerPredicts()
{
	return bOwnerPredicts;
}

//===========================================================
// GetShotCount, GetLastRecoilTime
//
// The shots that added recoil so far, and when the last one
// did
//===========================================================
final function int GetShotCount()
{
	return ShotCount;
}

final function float GetLastRecoilTime()
{
	return LastRecoilTime;
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

	if (BW.Role == ROLE_Authority)
	{
		BW.SendNetRecoil(ShotCount, -1, 0, 0, AdjustmentTime);
		if (class'BallisticDiag'.static.Logs(BW.Instigator))
			Log(class'BallisticDiag'.static.Head(BW.Level, "recoil sent") $ class'BallisticDiag'.static.Who(BW.Instigator) $ "|" $ BW.Class.Name
				$ "|after shot " $ BW.DiagShots $ "|shot " $ ShotCount $ "|decline over " $ AdjustmentTime $ " s");
	}
	else if (class'BallisticDiag'.static.Logs(BW.Instigator))
		Log(class'BallisticDiag'.static.Head(BW.Level, "recoil predicted") $ class'BallisticDiag'.static.Who(BW.Instigator) $ "|" $ BW.Class.Name
			$ "|decline after shot " $ ShotCount $ " over " $ AdjustmentTime $ " s");
}

final function float ScaleRecoilAmount(float amount)
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

final function SetADSViewBindOverride(bool bOverride, optional float Value)
{
	bOverrideADSViewBind = bOverride;
	ADSViewBindOverride = Value;
}

final function float GetADSViewBindFactor()
{
	if (bOverrideADSViewBind)
		return ADSViewBindOverride;
	return Params.ADSViewBindFactor;
}

final function UpdateADSTransition(float delta)
{
    ViewBindFactor = Smerp(delta, Params.ViewBindFactor, GetADSViewBindFactor());
}

final function OnADSViewStart()
{
    ViewBindFactor = GetADSViewBindFactor();
}

final function OnADSViewEnd()
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
final function Rotator CalcViewPivotDelta()
{
	return (CurrentPivot - LastPivot) * ViewBindFactor;
}

//===========================================================
// GetViewPivot
//
// Returns a Rotator for the component of recoil that is 
// being applied to the player's view.
//===========================================================
final function Rotator GetViewPivot()
{
	if (BW.Instigator.Controller == None || PlayerController(BW.Instigator.Controller) == None || PlayerController(BW.Instigator.Controller).bBehindView)
		return CurrentPivot;

	return CurrentPivot * ViewBindFactor;
}

//===========================================================
// GetEscapePivot
//
// Returns a Rotator for the component of recoil that is 
// not being applied to the player's view. 
// Used to trace shot direction.
//===========================================================
final function Rotator GetEscapePivot()
{
	if (ViewBindFactor == 1)
		return rot(0,0,0);

	return CurrentPivot * (1 - ViewBindFactor);
}

//===========================================================
// GetViewEscapePivot
//
// Hack to make weapons that escape in sight view appear to 
// shoot above the front sight, rather than directly onto it.
//===========================================================
final function Rotator GetViewEscapePivot()
{
	return GetEscapePivot() * (1f / Params.EscapeMultiplier);
}

//===========================================================
// CalculateRecoil
//
// Calculates the offset for the current recoil state by 
// using random factors and the recoil pattern.
//===========================================================
private final function Rotator CalculateRecoil(StateData state)
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
//===========================================================
// ReceiveNetRecoil
//
// The server's recoil after shot Count, on the owner's
// machine. Recoil < 0: the server started to decline it
//===========================================================
final function ReceiveNetRecoil(int Count, int Recoil, int Pitch, int Yaw, float ShiftTime)
{
	local int i;
	local Rotator Diff;

	ServerCount = Count;

	// a shot this machine predicted, or the decline after one
	if (bPredicting && Count <= ShotCount)
	{
		if (Recoil < 0)
		{
			// This machine started its own decline a round trip ago. If it has not fired since, it goes on from the
			// server's count: a shot fired on one machine and not on the other would leave every later shot's random
			// part different
			DiagHow = "decline, mine started already";
			if (MoveState == ERecoilState.Declining || Current.Recoil == 0)
			{
				if (ShotCount != Count)
					DiagHow = "decline, my count " $ ShotCount $ " taken back to " $ Count;
				ShotCount = Count;
			}
			return;
		}

		i = Count & 15;
		DiagHow = "too old to check";
		if (Predicted[i].Count != Count)
			return;
		RoundTrip = Level.TimeSeconds - Predicted[i].Time;
		DiagHow = "as predicted";

		Diff.Pitch = Pitch - Predicted[i].Pivot.Pitch;
		Diff.Yaw = Yaw - Predicted[i].Pivot.Yaw;
		if (Abs(Recoil - Predicted[i].Recoil) > Max(4, MaxRecoil / RECOIL_TOLERANCE_DIV) || Abs(Diff.Pitch) > PIVOT_TOLERANCE || Abs(Diff.Yaw) > PIVOT_TOLERANCE)
		{
			DiagHow = "PUT RIGHT by recoil " $ (Recoil - Predicted[i].Recoil) $ " pitch " $ Diff.Pitch $ " yaw " $ Diff.Yaw $ ", mine was " $ GetEnum(enum'ERecoilState', MoveState);
			CorrectPrediction(Count, Recoil - Predicted[i].Recoil, Diff, ShiftTime);
		}
		else if (Recoil != Predicted[i].Recoil || Diff.Pitch != 0 || Diff.Yaw != 0)
			DiagHow = "as predicted within the tolerance: recoil " $ (Recoil - Predicted[i].Recoil) $ " pitch " $ Diff.Pitch $ " yaw " $ Diff.Yaw;
		return;
	}

	DiagHow = "NOT PREDICTED, my count " $ ShotCount $ ", predicting " $ bPredicting;

	// shots this machine did not predict: as the server has them, a round trip after it
	ShotCount = Count;
	bPredicting = false;

	Start = Current;
	StartPivot = CurrentPivot;

	TargetPivot.Pitch = Pitch;
	TargetPivot.Yaw = Yaw;

	AdjustmentPhase = 0;
	AdjustmentTime = ShiftTime;

	if (Recoil >= 0)
	{
		Target.Recoil = Recoil;
		MoveState = ERecoilState.Climbing;
		LastRecoilTime = Level.TimeSeconds;
	}
	else
	{
		Target.Recoil = 0;
		Target.XRand = 0;
		Target.YRand = 0;
		MoveState = ERecoilState.Declining;
	}
}

//===========================================================
// CorrectPrediction
//
// Puts right where a predicted shot took the recoil, from
// the server's numbers for it. The shots predicted after it
// built on it, so they move with it
//===========================================================
private final function CorrectPrediction(int Count, int RecoilDiff, Rotator Diff, float ShiftTime)
{
	local int i;

	for (i = Count + 1; i <= ShotCount && i <= Count + 15; i++)
	{
		if (Predicted[i & 15].Count != i)
			continue;
		Predicted[i & 15].Recoil += RecoilDiff;
		Predicted[i & 15].Pivot += Diff;
	}

	Current.Recoil = Clamp(Current.Recoil + RecoilDiff, 0, MaxRecoil);

	// on the way back to rest already, and that goes to nothing whatever the shot did
	if (MoveState == ERecoilState.Declining)
	{
		Start.Recoil = Clamp(Start.Recoil + RecoilDiff, 0, MaxRecoil);
		return;
	}

	Start = Current;
	Target.Recoil = Clamp(Target.Recoil + RecoilDiff, 0, MaxRecoil);

	StartPivot = CurrentPivot;
	TargetPivot += Diff;

	AdjustmentPhase = 0;
	AdjustmentTime = ShiftTime;
	MoveState = ERecoilState.Climbing;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Debug
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
final function int DrawDebug(Canvas Canvas, int YPos, int YL)
{
    Canvas.DrawText("Recoil: "$ Current.Recoil $"/"$ MaxRecoil $", XRand "$ Current.XRand $", YRand "$ Current.YRand $" (Lerp "$ Start.Recoil $"-"$Target.Recoil $", XRand "$ Start.XRand $"-"$Target.XRand $", YRand "$ Start.YRand $"-"$Target.YRand $", Time "$AdjustmentTime$", Phase "$AdjustmentPhase$")");
	YPos += YL;
	Canvas.SetPos(4, YPos);
	Canvas.DrawText("Pivot: ("$ CurrentPivot.Pitch $", "$ CurrentPivot.Yaw $"), Start: ("$ StartPivot.Pitch $", "$ StartPivot.Yaw $"), Target: ("$ TargetPivot.Pitch $", "$ TargetPivot.Yaw $"), Last: ("$ LastPivot.Pitch $", "$ LastPivot.Yaw $")");
	YPos += YL;
	Canvas.SetPos(4, YPos);
	Canvas.DrawText("State: "$ GetEnum(enum'ERecoilState', MoveState) $", Should Shift: "$ ShouldShift() $", ViewBindFactor: Cur " $ ViewBindFactor $ ", Hip "$ Params.ViewBindFactor $ ", ADS " $ Params.ADSViewBindFactor $ ", Shots: " $ ShotCount $ ", Predicting: " $ bPredicting);

	return YPos;
}