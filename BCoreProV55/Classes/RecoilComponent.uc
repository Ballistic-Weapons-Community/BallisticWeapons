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
var private float               RecoilXRand;				    // Random between 0 and 1. Recorded random number for recoil Yaw randomness
var private float               RecoilYRand;				    // Random between 0 and 1. Recorded random number for recoil Pitch randomness
var private Rotator             LastViewPivot;   		        // Pivot saved between GetViewPivotDelta calls, used to find delta recoil  
var private float               ViewRecoilFactor;
var private float               RecoilDeclineDelay;

var private float               LastRecoilTime;

// Gameplay parameters
var private RecoilParams        Params;                         // Recoil parameters

// Replication
var bool                        bForceRecoilUpdate;             // Forces ApplyAimToView call to recalculate recoil (set after ReceiveNetRecoil)

//=============================================================
// Accessors
//=============================================================
final function float GetRecoil()
{
    return Recoil;
}

final function float GetRecoilXRand()
{
    return RecoilXRand;
}

final function float GetRecoilYRand()
{
    return RecoilYRand;
}

final function float GetDeclineDelay()
{
    return Params.RecoilDeclineDelay;
}

//=============================================================
// Mutators
//=============================================================
final function SetDeclineDelay(float value)
{
    RecoilDeclineDelay = value;
}
//=============================================================
// Utility
//=============================================================
final function bool HoldingRecoil()
{
    return LastRecoilTime + RecoilDeclineDelay >= Level.TimeSeconds;
}

final function bool ShouldUpdateView()
{
    local bool ret;

    ret = bForceRecoilUpdate || (Recoil > 0 && HoldingRecoil());

    if (bForceRecoilUpdate)
        bForceRecoilUpdate = false;

    return ret;
}

//=============================================================
// Gameplay
//=============================================================
final simulated function Initialize(RecoilParams params)
{
    Params = params;

    ViewRecoilFactor = Params.ViewRecoilFactor;
    RecoilDeclineDelay = Params.RecoilDeclineDelay;
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
		Recoil -= FMin(Recoil, Params.RecoilMax * (DeltaTime / Params.RecoilDeclineTime));
}

simulated function AddRecoil (float Amount, optional byte Mode)
{
	LastRecoilTime = Level.TimeSeconds;
	
	if (Outer.bAimDisabled || Amount == 0)
		return;
		
	Amount *= Outer.BCRepClass.default.RecoilScale;
	
	if (Outer.Instigator.bIsCrouched && VSize(Outer.Instigator.Velocity) < 30)
		Amount *= Params.CrouchAimFactor;
		
	if (!Outer.bScopeView)
		Amount *= Params.HipRecoilFactor;
	
	Recoil = FMin(RecoilMax, Recoil + Amount);

	if (!Outer.bUseNetAim || Role == ROLE_Authority)
	{
		RecoilXRand = FRand();
		RecoilYRand = FRand();
		
		if (Recoil == RecoilMax)
		{
			if (Amount < 260)
			{
				RecoilXRand *= 5 * (400 - Amount) / 400;
				RecoilYRand *= 5 * (400 - Amount) / 400;
			}
			else
			{
				RecoilXRand *= 3;
				RecoilYRand *= 3;
			}
		}
	}
}

//=============================================================
// Display
//=============================================================
final simulated function float ShiftViewRecoilFactor(float delta)
{
    ViewRecoilFactor = Smerp(delta, Params.ViewRecoilFactor, 1);
}

final simulated function OnScopeUp()
{
    ViewRecoilFactor = 1.0;
}

final simulated function OnScopeDown()
{
    // BallisticWeapon's PositionSights will handle this for clients
    if (Level.NetMode == NM_DedicatedServer)
        ViewRecoilFactor = Params.ViewRecoilFactor;
}

final simulated function Rotator GetWeaponPivot()
{
    return GetRecoilPivot(false);
}

final simulated function Rotator GetViewPivot()
{
    return GetRecoilPivot(true) * ViewRecoilFactor;
}

final simulated function Rotator GetViewPivotDelta()
{
    local Rotator CurViewPivot, DeltaPivot;

    CurrentViewPivot = GetRecoilPivot(true) * ViewRecoilFactor;

    DeltaPivot = CurViewPivot - LastViewPivot;

    LastViewPivot = CurViewPivot;

    return DeltaPivot;
}

private final simulated function Rotator GetRecoilPivot(bool bIgnoreViewAim)

	local Rotator R;
	local float AdjustedRecoil;

	if (!bIgnoreViewAim && ViewRecoilFactor==1)
        return R;
        
	// Randomness
    if (Params.RecoilMinRandFactor > 0)
	{
		AdjustedRecoil = RecoilMax * RecoilMinRandFactor + Recoil * (1 - RecoilMinRandFactor);
		R.Yaw = ((-AdjustedRecoil*RecoilXFactor + AdjustedRecoil*RecoilXFactor*2*RecoilXRand) * 0.3);
		R.Pitch = ((-AdjustedRecoil*RecoilYFactor + AdjustedRecoil*RecoilYFactor*2*RecoilYRand) * 0.3);
	}
	else
	{
		R.Yaw = ((-Recoil*RecoilXFactor + Recoil*RecoilXFactor*2*RecoilXRand) * 0.3);
		R.Pitch = ((-Recoil*RecoilYFactor + Recoil*RecoilYFactor*2*RecoilYRand) * 0.3);
    }
        
	// Pitching/Yawing
	R.Yaw += RecoilMax * InterpCurveEval(RecoilXCurve, Recoil/RecoilMax) * RecoilYawFactor;
	R.Pitch += RecoilMax * InterpCurveEval(RecoilYCurve, Recoil/RecoilMax) * RecoilPitchFactor;
	
	if (Outer.InstigatorController != None && Outer.InstigatorController.Handedness == -1)
		R.Yaw = -R.Yaw;
	
	if (bIgnoreViewAim || Outer.Instigator.Controller == None || PlayerController(Outer.Instigator.Controller) == None || PlayerController(Outer.Instigator.Controller).bBehindView)
        return R;
        
	return R*(1-ViewRecoilFactor);
}

//=============================================================
// AI
//=============================================================
final function bool BotShouldFire()
{
    if (Recoil * Params.RecoilYawFactor > 100 * (1+4000/Dist)) || (Recoil * Params.RecoilPitchFactor > 100 * (1+4000/Dist))
        return false;

    return true;
}

//=============================================================
// Replication
//=============================================================
final simulated function UpdateRecoil(byte XRand, byte YRand, float RecAmp)
{
	RecoilXRand = float(XRand)/255;
	RecoilYRand = float(YRand)/255;
	Recoil = RecAmp;
	bForceRecoilUpdate=True;
}