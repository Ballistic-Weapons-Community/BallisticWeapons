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
    DependsOn(BUtil)
    DependsOn(FireEffectParams);

const DEFAULT_TIME_DILATION = 1.1f;

//-----------------------------------------------------------------------------
// WeaponFire General
//-----------------------------------------------------------------------------
var() float                     FireInterval;           // analogous to FireRate but correctly named
var() int                       AmmoPerFire;            // Ammo cost per fire 

var() float                     PreFireTime;            // seconds before first shot
var() float                     MaxHoldTime;            // weapon will release fire automatically after this period of time

var() Name                      TargetState;            // switch to this state on activation
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
var() Name 						AimedFireAnim;		    // Fire anim to play when ADS
//-----------------------------------------------------------------------------
// Subobjects
//-----------------------------------------------------------------------------
var() array<FireEffectParams>   FireEffectParams;       // subobjects which define the gameplay effects of the firemode as well as various display factors

static simulated final function Initialize(BallisticWeapon BW, int ModeIndex, int AmmoIndex);

//Accessor stub for stats
final function FireEffectParams.FireModeStats GetStats() 
{
	local FireEffectParams.FireModeStats FS;
	
	FS = FireEffectParams[0].GetStats();

    FS.DPS = (FS.DamageInt / FireInterval) * DEFAULT_TIME_DILATION;

    if (FS.DamageInt > 0)
	    FS.TTK = FireInterval * (Ceil(175/FS.DamageInt) - 1) / DEFAULT_TIME_DILATION;
    else
        FS.TTK = 0;

    if (FireInterval < 0.4)
		FS.RPM = String(int((1 / FireInterval) * 60 * DEFAULT_TIME_DILATION))$"RPM";
	else 
        FS.RPM = String((1 / FireInterval) * DEFAULT_TIME_DILATION) @ FS.ShotTypeString $ "/second";

    FS.RPS = (FS.RPShot / FireInterval) * DEFAULT_TIME_DILATION;
	FS.FCPS = (FS.FCPShot / FireInterval) * DEFAULT_TIME_DILATION;
	
	return FS;
}

defaultproperties
{
    FireInterval=0.5
    AmmoPerFire=1

    PreFireAnim=PreFire
    FireAnim=Fire
    FireLoopAnim=FireLoop
    FireEndAnim=FireEnd

    PreFireAnimRate=1.0
    FireAnimRate=1.0
    FireLoopAnimRate=1.0
    FireEndAnimRate=1.0

    PreFireTime=0.0

    BurstFireRateFactor=0.65
}