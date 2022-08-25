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

// Struct used for skin replacements
struct MaterialSwap
{
    var()   Material    Material;
    var()   int         Index;
};

struct BoneScale
{
    var()   Name        BoneName;
    var()   int         Slot;
    var()   float       Scale;
};

struct WeaponModeType							// All the settings for a weapon firing mode
{
	var() localized string 	ModeName;			// Display name for this mode
	var() bool 				bUnavailable;		// Is it disabled and hidden(not in use)
	var() string 			ModeID;				// A non localized ID to easily identify this mode. Format: WM_????????, e.g. WM_FullAuto or WM_Burst
	var() float 			Value;				// Just a useful extra numerical value. Could be max count for burst mode or whatever...
	var() int 				RecoilParamsIndex;	// Index of the recoil parameters to use for this mode
	var() int				AimParamsIndex;		// Index of the aim parameters to use for this mode
};

enum EZoomType
{
	ZT_Irons, // Iron sights or simple non-magnifying aiming aid such as a red dot sight or holographic. Smoothly zooms into FullZoomFOV as the weapon repositions to sights view.
	ZT_Fixed, // Fixed scope zoom. Does not allow any change in zoom and goes straight to FullZoomFOV when StartScopeView is called.
	ZT_Logarithmic, //Zooms between MinZoom and MaxZoom magnification levels in relative steps.
	ZT_Minimum, // Minimum zoom level. Zooms straight to the lowest zoom level and stops on scope up. Will zoom between FOV (90 - (88 * MinFixedZoomLevel)) and FullZoomFOV.
	ZT_Smooth // Smooth zoom. Replaces bSmoothZoom, allows the weapon to zoom from FOV 90 to FullZoomFOV.
};
//-----------------------------------------------------------------------------
// Layouts
//-----------------------------------------------------------------------------
var() int					Weight;					// How likely it is for this layout to be chosen, higher is more likely
var() String				LayoutName;
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
// Handling
//-----------------------------------------------------------------------------
var() float					CockAnimRate;
var() float					ReloadAnimRate;
//-----------------------------------------------------------------------------
// Sighting
//-----------------------------------------------------------------------------
var() float					SightMoveSpeedFactor;	// Additional slowdown factor in iron sights
var() float					SightingTime;			// Time it takes to move weapon to and from sight view
var() Vector                SightOffset;            // Offset when moving weapon to ADS position
var() Rotator               SightPivot;             // Pivot when moving weapon to ADS position
var() EZoomType             ZoomType;               // Type of zoom. Precise control is within the weapon's sighting properties
var() bool         			bAdjustHands;      		//Adjust hand position when sighting?
var() rotator      			WristAdjust;       		//Amount to move wrist bone when using iron sights.
var() rotator      			RootAdjust;        		//Amount to move arm bone when using iron sights.
//-----------------------------------------------------------------------------
// Appearance
//-----------------------------------------------------------------------------
var() array<MaterialSwap>   WeaponMaterialSwaps;
var() array<BoneScale>      WeaponBoneScales;
var() array<MaterialSwap>   AttachmentMaterialSwaps;
var() Vector                ViewOffset;            // Offset when at rest
var() Rotator               ViewPivot;            // Pivot when at rest
var() String				WeaponName;
var() Mesh					LayoutMesh;
var() class<BallisticGunAugment>	GunAugmentClass;		//The RDS, Suppressor, Bayonet actor. Will look for a socket called "Attach"
//-----------------------------------------------------------------------------
// Aim
//-----------------------------------------------------------------------------
var() float					DisplaceDurationMult;   // Duration multiplier for aim displacement.
//-----------------------------------------------------------------------------
// Ammo
//-----------------------------------------------------------------------------
var() int			        MagAmmo;				//Ammo currently in magazine for Primary and Secondary. Max is whatever the default is.
//-----------------------------------------------------------------------------
// Pistol Dual Wielding
//-----------------------------------------------------------------------------
var() bool			        bDualBlocked;			//Prevent this weapon from being dual wielded.

//-----------------------------------------------------------------------------
// Firemodes
//-----------------------------------------------------------------------------
var() int InitialWeaponMode;
var() array<WeaponModeType> WeaponModes;				//A list of the available weapon firing modes and their info for this weapon

var() array<RecoilParams>	RecoilParams;
var() array<AimParams>		AimParams;
var() array<FireParams>     FireParams;
var() array<FireParams>     AltFireParams;

defaultproperties
{
    PlayerSpeedFactor=1.000000
    PlayerJumpFactor=1.000000
    InventorySize=12
    SightMoveSpeedFactor=0.900000
    SightingTime=0.350000
    ZoomType=ZT_Irons
    DisplaceDurationMult=1.000000
    MagAmmo=30
	CockAnimRate=1.000000
    ReloadAnimRate=1.000000
}