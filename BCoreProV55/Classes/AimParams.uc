//=============================================================================
// AimParams.
//
// Parameters declared as a subobject within a Ballistic Weapon and passed to 
// the AimComponent.
//
// by Azarael 2020
// adapting code written by DarkCarnivour
//=============================================================================
class AimParams extends Object
    editinlinenew
    DependsOn(BUtil);

// General
var() BUtil.IntRange		AimSpread;				// Range for how far aim can be from crosshair (rotator units) based on chaos value
var() float					AimAdjustTime;			// Time it should take to move aim pointer to new random aim when view moves
var() float    				OffsetAdjustTime; 		// Offsetting time for long gun and sprinting
var() float					VelocityAimAdjustMult;	// Multiplies AimAdjustTime when in ADS, as velocity approaches max

// Multipliers
var() float					CrouchMultiplier;	// Aim will be mutiplied by this when crouched
var() float					ADSMultiplier;		// Aim is multiplied by this when ADS

// Rotational offsets
var() Rotator				SprintOffset;		// Rotation applied to AimOffset when sprinting
var() Rotator				JumpOffset;			// Temporarily offset aim by this when jumping

// View Bind
var() float					ViewBindFactor;		// How much of the aim is applied to the player's view rotation. 0.0 - 1.0
var() float					ADSViewBindFactor;	// How much of aim is applied to view in ADS mode.
// Chaos
var() float					JumpChaos;			// Chaos applied for jump event
var() float					FallingChaos;		// Chaos applied when falling
var() float					SprintChaos;		// Chaos applied for sprint event
var() int   				AimDamageThreshold;	// Damage done to player is divided by this to calculate chaos added from being damaged
var() float				    ChaosDeclineTime;	// Time it take for chaos to decline from 1 to 0
var() float                 ChaosDeclineDelay;  // Delay before chaos declines
var() int				    ChaosSpeedThreshold;// Player speed divided by this to set chaos. <100=Very High Spread, 500=Average, >500 Good Spread.
var() int					ChaosTurnThreshold; // Speed(Rotator units per second) of view rotation required to reach full chaos.

defaultproperties
{
    AimSpread=(Min=16,Max=128)
    AimAdjustTime=0.50
    OffsetAdjustTime=0.30
	VelocityAimAdjustMult=0.67f
    CrouchMultiplier=0.80
    ADSMultiplier=1.00
    ViewBindFactor=0.00
	ADSViewBindFactor=1.00
	SprintOffSet=(Pitch=0,Yaw=0)
    SprintChaos=0.100000
    AimDamageThreshold=100
    ChaosDeclineTime=0.64
    ChaosDeclineDelay=0.00
    ChaosSpeedThreshold=500.00
    ChaosTurnThreshold=131072.00
}