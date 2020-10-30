//=============================================================================
// WeaponParams.
//
// Parameters declared as a subobject within a Ballistic Weapon. The correct 
// parameters are selected based on the game style.
//
// by Azarael 2020
//=============================================================================
class WeaponParams extends Object
    editinlinenew;

//-----------------------------------------------------------------------------
// Movement speed
//-----------------------------------------------------------------------------
var() float					PlayerSpeedFactor;		// Instigator movement speed is multiplied by this when this weapon is in use
var() float					PlayerJumpFactor;		// Player JumpZ multiplied by this when holding this weapon
//-----------------------------------------------------------------------------
// Conflict Loadout
//-----------------------------------------------------------------------------
var() byte					InventorySize;			// How much space this weapon should occupy in an inventory. 0-100. Used by mutators, games, etc...
//-----------------------------------------------------------------------------
// Sighting
//-----------------------------------------------------------------------------
var() float					SightMoveSpeedFactor;	// Additional slowdown factor in iron sights
var() float					SightingTime;			// Time it takes to move weapon to and from sight view
//-----------------------------------------------------------------------------
// Aim
//-----------------------------------------------------------------------------
var() float					DisplaceDurationMult;   // Duration multiplier for aim displacement.
//-----------------------------------------------------------------------------
// Ammo
//-----------------------------------------------------------------------------
var() int			        MagAmmo;				//Ammo currently in magazine for Primary and Secondary. Max is whatever the default is.

var() array<RecoilParams>	RecoilParams;
var() array<AimParams>		AimParams;

defaultproperties
{
    PlayerSpeedFactor=1.000000
    PlayerJumpFactor=1.000000
    InventorySize=12
    SightMoveSpeedFactor=0.900000
    SightingTime=0.350000
    DisplaceDurationMult=1.000000
    MagAmmo=30
}