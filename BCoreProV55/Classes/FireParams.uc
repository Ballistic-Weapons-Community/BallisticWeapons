//=============================================================================
// FireParams.
//
// Fire mode parameters declared as a subobject. The correct 
// parameters are selected based on the game style.
//=============================================================================
//
// by Azarael 2020
//=============================================================================
class FireParams extends Object
    editinlinenew
    DependsOn(BUtil);

//-----------------------------------------------------------------------------
// WeaponFire General
//-----------------------------------------------------------------------------
var() float                     FireInterval;           // analogous to FireRate but correctly named
var() int                       AmmoPerFire;            // Ammo cost per fire 

var() bool                      bWaitForRelease;        // if true, fire button must be released between each shot
var() bool					    bReleaseFireOnDie;	    // If bFireOnRelease, mode will fire if holder died before release

var() float                     PreFireTime;            // seconds before first shot
var() float                     MaxHoldTime;            // weapon will release fire automatically after this period of time
//-----------------------------------------------------------------------------
// Ballistic General
//-----------------------------------------------------------------------------
var() string                    ModeName;               // name of mode for display on weapon
var() int                       MaxFireCount;           // maximum number of shots which can be fired before weapon mode check fails
var() float	                    BurstFireRateFactor;	// Multiplies down fire rate in burst mode
var() bool						bCockAfterFire;		    // Cock the gun after each shot
//-----------------------------------------------------------------------------
// Animation
//-----------------------------------------------------------------------------
var() Name                      PreFireAnim;            // Pre fire animation
var() Name                      FireAnim;               // Standard fire animation
var() Name                      FireLoopAnim;           // Looped fire animation
var() Name                      FireEndAnim;            // End fire animation

var() float                     PreFireAnimRate;
var() float                     FireAnimRate;
var() float                     FireLoopAnimRate;
var() float                     FireEndAnimRate;

var() Name 						AimedFireAnim;		    // Fire anim to play when scoped
//-----------------------------------------------------------------------------
// Subobjects
//-----------------------------------------------------------------------------
var() array<FireEffectParams>   FireEffectParams;       // subobjects which define the gameplay effects of the firemode as well as various display factors

static simulated final function Initialize(BallisticWeapon BW, int ModeIndex, int AmmoIndex);

defaultproperties
{
    PreFireAnim=PreFire
    FireAnim=Fire
    FireLoopAnim=FireLoop
    FireEndAnim=FireEnd

    PreFireAnimRate=1.0
    FireAnimRate=1.0
    FireLoopAnimRate=1.0
    FireEndAnimRate=1.0

    PreFireTime=0.0
    FireInterval=0.5
}