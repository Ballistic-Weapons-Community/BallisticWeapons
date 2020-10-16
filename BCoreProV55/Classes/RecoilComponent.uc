//=============================================================================
// RecoilComponent.
//
// Represents the recoil system component of a Ballistic Weapon.
//
// by Azarael 2020
// adapting code written by DarkCarnivour
//=============================================================================
class RecoilComponent extends Object within BallisticWeapon;

// State
var private float               Recoil;						    // The current recoil amount. Increases each shot, decreases when not firing
var private float               XRand;				            // Random between 0 and 1. Recorded random number for recoil Yaw randomness
var private float               YRand;				            // Random between 0 and 1. Recorded random number for recoil Pitch randomness
var private Rotator             LastViewPivot;   		        // Pivot saved between GetViewPivotDelta calls, used to find delta recoil  
var private float               ViewBindFactor;             // Amount to bind recoil offsetting to view
var private float               DeclineDelay;                   // Delay in seconds before recoil declines

var private float               LastRecoilTime;                 // Last time at which recoil was added

// Gameplay parameters
var private RecoilParams        Params;                         // Recoil parameters

// Replication
var private bool                bForceUpdate;                   // Forces ApplyAimToView call to recalculate recoil (set after ReceiveNetRecoil)

//=============================================================
// Accessors
//=============================================================
final function float GetRecoil()
{
    return Recoil;
}

final function float GetRecoilXRand()
{
    return XRand;
}

final function float GetRecoilYRand()
{
    return YRand;
}

final function float GetDeclineDelay()
{
    return Params.DeclineDelay;
}

//=============================================================
// Mutators
//=============================================================
final function SetDeclineDelay(float value)
{
    DeclineDelay = value;
}
//=============================================================
// Utility
//=============================================================
final function bool HoldingRecoil()
{
    return LastRecoilTime + DeclineDelay >= Level.TimeSeconds;
}

final function bool ShouldUpdateView()
{
    local bool ret;

    ret = bForceUpdate || (Recoil > 0 && HoldingRecoil());

    bForceUpdate = false;

    return ret;
}

//=============================================================
// Gameplay
//=============================================================
final simulated function Initialize(RecoilParams params)
{
    Params = params;

    ViewBindFactor = Params.ViewBindFactor;
    DeclineDelay = Params.DeclineDelay;
}

final simulated function OnBerserkStart()
{
}

final simulated function OnBerserkEnd()
{
}

final simulated function Tick(float DeltaTime)
{
	if (Recoil > 0 && !HoldingRecoil())
		Recoil -= FMin(Recoil, Params.MaxRecoil * (DeltaTime / Params.DeclineTime));
}

final simulated function AddRecoil (float Amount, optional byte Mode)
{
	LastRecoilTime = Level.TimeSeconds;
	
	if (Outer.bAimDisabled || Amount == 0)
		return;
		
	Amount *= Outer.BCRepClass.default.RecoilScale;
	
	if (Outer.Instigator.bIsCrouched && VSize(Outer.Instigator.Velocity) < 30)
		Amount *= Params.CrouchMultiplier;
		
	if (!Outer.bScopeView)
		Amount *= Params.HipMultiplier;
	
	Recoil = FMin(Params.MaxRecoil, Recoil + Amount);

	if (!Outer.bUseNetAim || Role == ROLE_Authority)
	{
		XRand = FRand();
		YRand = FRand();
		
		if (Recoil == Params.MaxRecoil)
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
	
	if (Outer.InstigatorController != None && Outer.InstigatorController.Handedness == -1)
		R.Yaw = -R.Yaw;
	
	if (bIgnoreViewAim || Outer.Instigator.Controller == None || PlayerController(Outer.Instigator.Controller) == None || PlayerController(Outer.Instigator.Controller).bBehindView)
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