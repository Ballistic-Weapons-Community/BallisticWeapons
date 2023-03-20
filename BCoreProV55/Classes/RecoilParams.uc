//=============================================================================
// RecoilParams.
//
// Parameters declared as a subobject within a Ballistic Weapon and passed to 
// the RecoilComponent.
//
// by Azarael 2020
// adapting code written by DarkCarnivour
//=============================================================================
class RecoilParams extends Object
    editinlinenew;

// Gameplay
var() InterpCurve 		XCurve;						// Curve used to apply Yaw according to recoil amount.
var() InterpCurve 		YCurve;						// Curve used to apply Pitch according to recoil amount.
var() InterpCurve 		XCurveAlt;					// Curve used to apply Yaw according to recoil amount.
var() InterpCurve 		YCurveAlt;					// Curve used to apply Pitch according to recoil amount.
var() float				PitchFactor;				// Recoil is multiplied by this and added to Aim Pitch.
var() float				YawFactor;					// Recoil is multiplied by this and added to Aim Yaw.
var() float				XRandFactor;				// Recoil multiplied by this for recoil Yaw randomness
var() float				YRandFactor;				// Recoil multiplied by this for recoil Pitch randomness
var() float				MinRandFactor;				// Bias for calculation of recoil random factor
var() float				MaxRecoil;					// The maximum recoil amount
var() float				DeclineTime;				// Time it takes for Recoil to decline maximum to zero
var() float				DeclineDelay;				// The time between firing and when recoil should start decaying
var() float             ViewBindFactor;           	// How much of the recoil is applied to the player's view rotation
var() float             ADSViewBindFactor;          // Above for ADS.
var() float             HipMultiplier;            	// Hipfire recoil is scaled up by this value
var() float             CrouchMultiplier;         	// Crouch recoil is scaled by this value
var() bool              bViewDecline;               // Weapon will move back down through its recoil path when recoil is declining
var() bool				bUseAltSightCurve;			// Weapon will use a different recoil curve when in sights

final function float EvaluateXRecoil(float Recoil)
{
    return MaxRecoil * InterpCurveEval(XCurve, Recoil / MaxRecoil) * YawFactor;
}
    
final function float EvaluateYRecoil(float Recoil)
{
    return MaxRecoil * InterpCurveEval(YCurve, Recoil / MaxRecoil) * PitchFactor;
}

final function float EvaluateXRecoilAlt(float Recoil)
{
    return MaxRecoil * InterpCurveEval(XCurveAlt, Recoil / MaxRecoil) * YawFactor;
}
    
final function float EvaluateYRecoilAlt(float Recoil)
{
    return MaxRecoil * InterpCurveEval(YCurveAlt, Recoil / MaxRecoil) * PitchFactor;
}

defaultproperties
{
    XCurve=(Points=(,(InVal=1.000000)))
    YCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
    XCurveAlt=(Points=(,(InVal=1.000000)))
    YCurveAlt=(Points=(,(InVal=1.000000,OutVal=1.000000)))
    PitchFactor=1.000000
    YawFactor=1.000000
    XRandFactor=0.000000
    YRandFactor=0.000000
    MaxRecoil=4096.000000
    DeclineTime=2.000000
    DeclineDelay=0.300000
    ViewBindFactor=1.000000
    ADSViewBindFactor=1.000000
    HipMultiplier=1.600000
	CrouchMultiplier=0.750000
    bViewDecline=False
}