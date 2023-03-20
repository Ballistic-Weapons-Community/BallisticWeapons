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
var BallisticWeapon				BW;
var LevelInfo					Level;
var editinline RecoilParams		Params;

// UnrealScript's shitty object handling necessitates copying most of the RecoilParams fields we might want to modify
// and exposing them as public so that we can apply modifiers from the weapon
//
// The nice modifier-based / delegate-based solution to this crashes for no good reason, so whatever :) :) :) :) :) :)
//=============================================================================
// MUTABLES
//=============================================================================
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
var bool                        bViewDecline;                   // Weapon will move back down through its recoil path when recoil is declining
var bool						bUseAltSightCurve;				// Weapon will use a different recoil curve when in sights

//=============================================================================
// STATE
//=============================================================================
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

    ret = bViewDecline || bForceUpdate || (Recoil > 0 && HoldingRecoil());

    bForceUpdate = false;

    return ret;
}

//=============================================================
// Cleanup (hello where are the RAII?)
//=============================================================
final simulated function Cleanup()
{
	BW = None;
	Level = None;

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
	CrouchMultiplier 	= Params.CrouchMultiplier;
    bViewDecline        = Params.bViewDecline;
    bUseAltSightCurve   = Params.bUseAltSightCurve;

	if (ViewBindFactor == 0)
		ViewBindFactor = Params.ViewBindFactor;

	BW.OnRecoilParamsChanged();
}

final simulated function UpdateRecoil(float dt)
{
	if (Recoil > 0 && !HoldingRecoil())
		Recoil -= FMin(Recoil, MaxRecoil * (dt / DeclineTime));
}

final simulated function AddRecoil (float Amount, optional byte Mode)
{
	LastRecoilTime = BW.Level.TimeSeconds;
	
	if (BW.bAimDisabled || Amount == 0)
		return;
		
	if (BW.Instigator.bIsCrouched && VSize(BW.Instigator.Velocity) < 30)
		Amount *= CrouchMultiplier;
		
	if (!BW.bScopeView)
		Amount *= HipMultiplier;
	
	Recoil = FMin(MaxRecoil, Recoil + Amount);

	if (!BW.bUseNetAim || BW.Role == ROLE_Authority)
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

final simulated function Rotator GetWeaponPivot()
{
    return GetRecoilPivot(false);
}

final simulated function Rotator GetViewPivot()
{
    return GetRecoilPivot(true) * ViewBindFactor;
}

final simulated function Rotator CalcViewPivotDelta()
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
	if (BW.bScopeView && bUseAltSightCurve)
	{
		R.Yaw += Params.EvaluateXRecoilAlt(Recoil);
		R.Pitch += Params.EvaluateYRecoilAlt(Recoil);
	}
	else
	{
		R.Yaw += Params.EvaluateXRecoil(Recoil);
		R.Pitch += Params.EvaluateYRecoil(Recoil);
	}
	if (BW.InstigatorController != None && BW.InstigatorController.Handedness == -1)
		R.Yaw = -R.Yaw;

    R *= class'BallisticReplicationInfo'.default.RecoilScale;
	
	if (bIgnoreViewAim || BW.Instigator.Controller == None || PlayerController(BW.Instigator.Controller) == None || PlayerController(BW.Instigator.Controller).bBehindView)
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
final simulated function ReceiveNetRecoil(byte NetXRand, byte NetYRand, float NetRecoil)
{
	XRand = float(NetXRand)/255;
	YRand = float(NetYRand)/255;
	Recoil = NetRecoil;
	LastRecoilTime = Level.TimeSeconds;
	bForceUpdate=True;
}

//=============================================================
// Debug
//=============================================================
final simulated function DrawDebug(Canvas Canvas)
{
    Canvas.DrawText("RecoilComponent: Recoil: "$Recoil$"/"$MaxRecoil$", ViewBindFactor: Cur " $ ViewBindFactor $ ", Hip "$ Params.ViewBindFactor $ ", ADS " $ Params.ADSViewBindFactor );
}