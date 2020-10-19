//=============================================================================
// RecoilComponent.
//
// Represents the recoil system component of a Ballistic Weapon.
//
// by Azarael 2020
// adapting code written by DarkCarnivour
//=============================================================================
class RecoilComponent extends Object;

// Parameters set externally - MUST BE CLEANED UP

// Weapon
var BallisticWeapon				Weapon;
var LevelInfo					Level;
var Pawn						Instigator;

// System parameters
var RecoilParams				Params;

// UnrealScript's shitty object handling necessitates copying most of the RecoilParams fields we might want to modify
// and exposing them as public so that we can apply modifiers from the weapon
//
// The nice modifier-based / delegate-based solution to this crashes for no good reason, so whatever :) :) :) :) :) :)

var float						PitchFactor;					// Recoil is multiplied by this and added to Aim Pitch.
var float						YawFactor;						// Recoil is multiplied by this and added to Aim Yaw.
var float						XRandFactor;					// Recoil multiplied by this for recoil Yaw randomness
var float						YRandFactor;					// Recoil multiplied by this for recoil Pitch randomness
var float						MinRandFactor;					// Bias for calculation of recoil random factor
var float						MaxRecoil;						// The maximum recoil amount
var float						DeclineTime;					// Time it takes for Recoil to decline maximum to zero
var float						DeclineDelay;					// The time between firing and when recoil should start decaying
var float             			HipMultiplier;            		// Hipfire recoil is scaled up by this value
var float             			CrouchMultiplier;         		// Crouch recoil is scaled by this value

// Parameters set internally
var private float               Recoil;						    // The current recoil amount. Increases each shot, decreases when not firing
var private float               XRand;				            // Random between 0 and 1. Recorded random number for recoil Yaw randomness
var private float               YRand;				            // Random between 0 and 1. Recorded random number for recoil Pitch randomness

// View application
var private Rotator             LastViewPivot;   		        // Pivot saved between GetViewPivotDelta calls, used to find delta recoil  
var private float               ViewBindFactor;             	// Amount to bind recoil offsetting to view

// State
var private float               LastRecoilTime;                 // Last time at which recoil was added

// Replication
var private bool                bForceUpdate;                   // Forces ApplyAimToView call to recalculate recoil (set after ReceiveNetRecoil)

//=============================================================
// Accessors
//=============================================================
final simulated function float GetRecoil()
{
    return Recoil;
}

final simulated function float GetRecoilXRand()
{
    return XRand;
}

final simulated function float GetRecoilYRand()
{
    return YRand;
}

//=============================================================
// Utility
//=============================================================
final simulated function bool HoldingRecoil()
{
    return LastRecoilTime + DeclineDelay >= Level.TimeSeconds;
}

final simulated function bool ShouldUpdateView()
{
    local bool ret;

    ret = bForceUpdate || (Recoil > 0 && HoldingRecoil());

    bForceUpdate = false;

    return ret;
}

//=============================================================
// Cleanup (hello where are the RAII?)
//=============================================================
final simulated function Cleanup()
{
	Weapon = None;
	Level = None;
	Instigator = None;

	Params = None;

	Recoil = 0;
	XRand = 0;
	YRand = 0;

	LastViewPivot = rot(0,0,0);
	ViewBindFactor = 0;

	LastRecoilTime = 0;

	bForceUpdate = false;
}

//=============================================================
// Gameplay
//=============================================================
final simulated function Recalculate()
{
	PitchFactor 		= Params.PitchFactor;
	YawFactor 			= Params.YawFactor;
	XRandFactor 		= Params.XRandFactor;
	YRandFactor 		= Params.YRandFactor;
	MinRandFactor 		= Params.MinRandFactor;
	MaxRecoil 			= Params.MaxRecoil;
	DeclineTime 		= Params.DeclineTime;
	DeclineDelay		= Params.DeclineDelay;
	HipMultiplier 		= Params.HipMultiplier;
	CrouchMultiplier 	= Params.CrouchMultiplier;

	Weapon.OnRecoilParamsChanged();
}

final simulated function Tick(float DeltaTime)
{
	if (Recoil > 0 && !HoldingRecoil())
		Recoil -= FMin(Recoil, MaxRecoil * (DeltaTime / DeclineTime));
}

final simulated function AddRecoil (float Amount, optional byte Mode)
{
	LastRecoilTime = Weapon.Level.TimeSeconds;
	
	if (Weapon.bAimDisabled || Amount == 0)
		return;
		
	Amount *= Weapon.BCRepClass.default.RecoilScale;
	
	if (Instigator.bIsCrouched && VSize(Instigator.Velocity) < 30)
		Amount *= CrouchMultiplier;
		
	if (!Weapon.bScopeView)
		Amount *= HipMultiplier;
	
	Recoil = FMin(MaxRecoil, Recoil + Amount);

	if (!Weapon.bUseNetAim || Weapon.Role == ROLE_Authority)
	{
		XRand = FRand();
		YRand = FRand();
		
		if (Recoil == MaxRecoil)
		{
			if (Amount < 260)
			{
				XRand *= 5 * (400 - Amount) / 400;
				YRand *= 5 * (400 - Amount) / 400;
			}
			else
			{
				XRand *= 3;
				YRand *= 3;
			}
		}
	}
}

//=============================================================
// Display
//=============================================================
final simulated function UpdateADSTransition(float delta)
{
    ViewBindFactor = Smerp(delta, Params.ViewBindFactor, 1);
}

final simulated function OnADSStart()
{
    ViewBindFactor = 1.0;
}

final simulated function OnADSEnd()
{
    // BallisticWeapon's PositionSights will handle this for clients
    if (Level.NetMode == NM_DedicatedServer)
        ViewBindFactor = Params.ViewBindFactor;
}

final simulated function Rotator GetWeaponPivot()
{
    return GetRecoilPivot(false);
}

final simulated function Rotator GetViewPivot()
{
    return GetRecoilPivot(true) * ViewBindFactor;
}

final simulated function Rotator GetViewPivotDelta()
{
    local Rotator CurViewPivot, DeltaPivot;

    CurViewPivot = GetRecoilPivot(true) * ViewBindFactor;

    DeltaPivot = CurViewPivot - LastViewPivot;

    LastViewPivot = CurViewPivot;

    return DeltaPivot;
}

private final simulated function Rotator GetRecoilPivot(bool bIgnoreViewAim)
{
	local Rotator R;
	local float AdjustedRecoil;

	if (!bIgnoreViewAim && ViewBindFactor == 1)
        return R;
        
	// Randomness
    if (Params.MinRandFactor > 0)
	{
		AdjustedRecoil = Params.MaxRecoil * Params.MinRandFactor + Recoil * (1 - Params.MinRandFactor);
		R.Yaw = ((-AdjustedRecoil * Params.XRandFactor + AdjustedRecoil * Params.XRandFactor *2 * XRand) * 0.3);
		R.Pitch = ((-AdjustedRecoil * Params.YRandFactor + AdjustedRecoil * Params.YRandFactor * 2 * YRand) * 0.3);
	}
	else
	{
		R.Yaw = ((-Recoil * Params.XRandFactor + Recoil * Params.XRandFactor * 2 * XRand) * 0.3);
		R.Pitch = ((-Recoil * Params.YRandFactor + Recoil * Params.YRandFactor * 2 * YRand) * 0.3);
    }
        
	// Pitching/Yawing
	R.Yaw += Params.EvaluateXRecoil(Recoil);
	R.Pitch += Params.EvaluateYRecoil(Recoil);
	
	if (Weapon.InstigatorController != None && Weapon.InstigatorController.Handedness == -1)
		R.Yaw = -R.Yaw;
	
	if (bIgnoreViewAim || Weapon.Instigator.Controller == None || PlayerController(Weapon.Instigator.Controller) == None || PlayerController(Weapon.Instigator.Controller).bBehindView)
        return R;
        
	return R*(1-ViewBindFactor);
}

//=============================================================
// AI
//=============================================================
final function bool BotShouldFire(float Dist)
{
    if (Recoil * Params.YawFactor > 100 * (1+4000/Dist) || (Recoil * Params.PitchFactor > 100 * (1+4000/Dist)))
        return false;

    return true;
}

//=============================================================
// Replication
//=============================================================
final simulated function UpdateRecoil(byte NetXRand, byte NetYRand, float NetRecoil)
{
	XRand = float(NetXRand)/255;
	YRand = float(NetYRand)/255;
	Recoil = NetRecoil;
	bForceUpdate=True;
}