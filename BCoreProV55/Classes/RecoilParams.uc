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

var() float             ViewBindFactor;           	// Factor of recoil to apply directly to player view rotation when in hipfire mode
var() float             ADSViewBindFactor;          // Factor of recoil to apply directly to player view rotation when in ADS. READ NOTES BEFORE USING ANY VALUE OTHER THAN 1.

var() float             HipMultiplier;            	// Recoil from hipfire is scaled up by this value
var() float				MaxMoveMultiplier;			// Recoil while moving is scaled by this value - maximum is applied when player is moving at full basic run speed
var() float             CrouchMultiplier;         	// Recoil from stationary crouch is scaled by this value
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
	MaxMoveMultiplier=1.000000
	CrouchMultiplier=0.750000
    bViewDecline=False
}