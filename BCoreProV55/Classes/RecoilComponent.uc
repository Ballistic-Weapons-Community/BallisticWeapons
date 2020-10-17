//=============================================================================
// RecoilComponent.
//
// Represents the recoil system component of a Ballistic Weapon.
//
// Note that we are calling GetRecoilParams() on the Weapon to avoid
// garbage collection issues which occur if we take a reference to the params
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
var private float               ViewBindFactor;             	// Amount to bind recoil offsetting to view
var private float               DeclineDelay;                   // Delay in seconds before recoil declines

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

final simulated function float GetDeclineDelay()
{
	return GetRecoilParams().DeclineDelay;
}

//=============================================================
// Mutators
//=============================================================
final simulated function SetDeclineDelay(float value)
{
    DeclineDelay = value;
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
// Gameplay
//=============================================================
final simulated function Initialize()
{
    ViewBindFactor = GetRecoilParams().ViewBindFactor;
    DeclineDelay = GetRecoilParams().DeclineDelay;
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
		Recoil -= FMin(Recoil, GetRecoilParams().MaxRecoil * (DeltaTime / GetRecoilParams().DeclineTime));
}

final simulated function AddRecoil (float Amount, optional byte Mode)
{
	LastRecoilTime = Level.TimeSeconds;
	
	if (Outer.bAimDisabled || Amount == 0)
		return;
		
	Amount *= Outer.BCRepClass.default.RecoilScale;
	
	if (Outer.Instigator.bIsCrouched && VSize(Outer.Instigator.Velocity) < 30)
		Amount *= GetRecoilParams().CrouchMultiplier;
		
	if (!Outer.bScopeView)
		Amount *= GetRecoilParams().HipMultiplier;
	
	Recoil = FMin(GetRecoilParams().MaxRecoil, Recoil + Amount);

	if (!Outer.bUseNetAim || Role == ROLE_Authority)
	{
		XRand = FRand();
		YRand = FRand();
		
		if (Recoil == GetRecoilParams().MaxRecoil)
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
    ViewBindFactor = Smerp(delta, GetRecoilParams().ViewBindFactor, 1);
}

final simulated function OnADSStart()
{
    ViewBindFactor = 1.0;
}

final simulated function OnADSEnd()
{
    // BallisticWeapon's PositionSights will handle this for clients
    if (Level.NetMode == NM_DedicatedServer)
        ViewBindFactor = GetRecoilParams().ViewBindFactor;
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
    if (GetRecoilParams().MinRandFactor > 0)
	{
		AdjustedRecoil = GetRecoilParams().MaxRecoil * GetRecoilParams().MinRandFactor + Recoil * (1 - GetRecoilParams().MinRandFactor);
		R.Yaw = ((-AdjustedRecoil * GetRecoilParams().XRandFactor + AdjustedRecoil * GetRecoilParams().XRandFactor *2 * XRand) * 0.3);
		R.Pitch = ((-AdjustedRecoil * GetRecoilParams().YRandFactor + AdjustedRecoil * GetRecoilParams().YRandFactor * 2 * YRand) * 0.3);
	}
	else
	{
		R.Yaw = ((-Recoil * GetRecoilParams().XRandFactor + Recoil * GetRecoilParams().XRandFactor * 2 * XRand) * 0.3);
		R.Pitch = ((-Recoil * GetRecoilParams().YRandFactor + Recoil * GetRecoilParams().YRandFactor * 2 * YRand) * 0.3);
    }
        
	// Pitching/Yawing
	R.Yaw += GetRecoilParams().EvaluateXRecoil(Recoil);
	R.Pitch += GetRecoilParams().EvaluateYRecoil(Recoil);
	
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
    if (Recoil * GetRecoilParams().YawFactor > 100 * (1+4000/Dist) || (Recoil * GetRecoilParams().PitchFactor > 100 * (1+4000/Dist)))
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