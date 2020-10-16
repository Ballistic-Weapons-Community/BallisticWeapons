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
var() InterpCurve 		RecoilXCurve;				// Curve used to apply Yaw according to recoil amount.
var() InterpCurve 		RecoilYCurve;				// Curve used to apply Pitch according to recoil amount.
var() float				RecoilPitchFactor;			// Recoil is multiplied by this and added to Aim Pitch.
var() float				RecoilYawFactor;			// Recoil is multiplied by this and added to Aim Yaw.
var() float				RecoilXFactor;				// Recoil multiplied by this for recoil Yaw randomness
var() float				RecoilYFactor;				// Recoil multiplied by this for recoil Pitch randomness
var() float				RecoilMinRandFactor;		// Bias for calculation of recoil random factor
var() float				RecoilMax;					// The maximum recoil amount
var() float				RecoilDeclineTime;			// Time it takes for Recoil to decline maximum to zero
var() float				RecoilDeclineDelay;			// The time between firing and when recoil should start decaying
var() float             ViewRecoilFactor;           // How much of the recoil is applied to the player's view rotation
var() float             HipRecoilFactor;            // Hipfire recoil is scaled up by this value
var() float             CrouchRecoilFactor;         // Crouch recoil is scaled by this value

defaultproperties
{
    RecoilXCurve=(Points=(,(InVal=1.000000)))
    RecoilYCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
    RecoilPitchFactor=1.000000
    RecoilYawFactor=1.000000
    RecoilXFactor=0.000000
    RecoilYFactor=0.000000
    RecoilMax=4096.000000
    RecoilDeclineTime=2.000000
    RecoilDeclineDelay=0.300000
    ViewRecoilFactor=1.000000
    HipRecoilFactor=1.600000
}