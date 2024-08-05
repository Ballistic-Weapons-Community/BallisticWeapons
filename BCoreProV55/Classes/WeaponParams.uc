//=============================================================================
// WeaponParams.
//
// Parameters declared as a subobject within a Ballistic Weapon. The correct 
// parameters are selected based on the game style.
//
// by Azarael 2020
//=============================================================================
class WeaponParams extends Object
    DependsOn(FireEffectParams);

// Struct used for skin replacements
struct MaterialSwap
{
    var()   Material    Material;
	var()	string		MaterialName;
    var()   int         Index;
    var()   int         PIndex;
    var()   int         AIndex;
};

struct BoneScale
{
    var()   Name        BoneName;
    var()   int         Slot;
    var()   float       Scale;
};

struct GunAugment
{
	var() class<BallisticGunAugment>	GunAugmentClass;		//The RDS, Suppressor, Bayonet actor.
	var()	Name	BoneName;
	var()	float	Scale;
	var()	vector 	AugmentOffset;
	var()	rotator	AugmentRot;
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
	ZT_Fixed, // Zooms to MaxZoom only.
	ZT_Logarithmic, //Zooms between MinZoom and MaxZoom magnification levels in relative steps.
	ZT_Minimum, // Minimum zoom level. Zooms straight to the lowest zoom level and stops on scope up. Will zoom between FOV (90 - (88 * MinFixedZoomLevel)) and FullZoomFOV.
	ZT_Smooth // Smooth zoom. Replaces bSmoothZoom, allows the weapon to zoom from FOV 90 to FullZoomFOV.
};
//-----------------------------------------------------------------------------
// Layouts
//-----------------------------------------------------------------------------
var() int					Weight;					// How likely it is for this layout to be chosen, higher is more likely
var() String				LayoutName;				// The layout name in menus
var() String				LayoutDescription;		// Short description to show in UI.
var() String				LayoutTags;				// Internal tag used to change gun functionality eg gauss, explosive, suppressed
//-----------------------------------------------------------------------------
// Movement speed
//-----------------------------------------------------------------------------
var() float					PlayerSpeedFactor;		// Instigator movement speed is multiplied by this when this weapon is in use
var() float					PlayerJumpFactor;		// Player JumpZ multiplied by this when holding this weapon
//-----------------------------------------------------------------------------
// Conflict Loadout
//-----------------------------------------------------------------------------
var() byte					InventorySize;			// How much space this weapon should occupy in an inventory. 0-100. Used by mutators, games, etc...
var() byte					MaxInventoryCount;		// Maximum number that may be requested from Conflict Loadout
var() int					WeaponPrice;			// How many cash should this cost
//-----------------------------------------------------------------------------
// Handling
//-----------------------------------------------------------------------------
var() float					CockAnimRate;
var() float					ReloadAnimRate;
//-----------------------------------------------------------------------------
// Sighting
//-----------------------------------------------------------------------------
// General handling
var() float					SightMoveSpeedFactor;	// Additional slowdown factor in iron sights
var() float					SightingTime;			// Time it takes to move weapon to and from sight view

// Display - TRY TO MOVE THESE INTO STRUCTS OF THE MAIN WEAPON
var() int					SightDisplayFOV;		// Display FOV for sights. TODO: try to get general agreement on sights
var() Vector                SightOffset;            // Offset when moving weapon to ADS position
var() Rotator               SightPivot;             // Pivot when moving weapon to ADS position

// Zooming
var() EZoomType             ZoomType;               // Type of zoom. Precise control is within the weapon's sighting properties
var() Material				ScopeViewTex;			// Texture displayed in Scope View. Fills the screen
var() float					ScopeScale;				// Scale of scope
var() float					MinZoom;				// Minimum scope zoom factor
var() float					MaxZoom;				// Maximun Zoom for Sniper
var() int					ZoomStages;				// Zoom stages for sniper

// Hand adjust
var() bool         			bAdjustHands;      		// Adjust hand position when sighting?
var() rotator      			WristAdjust;       		// Amount to move wrist bone when using iron sights.
var() rotator      			RootAdjust;        		// Amount to move arm bone when using iron sights.
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
var() Mesh					AttachmentMesh;
var() StaticMesh			PickupMesh;
var() float					PickupDrawScale;	// DrawScale may be weird so it looks good in the menu. Use this for in game pickups
var() array<GunAugment>		GunAugments;		//The RDS, Suppressor, Bayonet actor. Will look for a socket called "Attach"
var() array<int>			AllowedCamos;			// Which camos we can use for this layout, leave blank for all
//-----------------------------------------------------------------------------
// Aim
//-----------------------------------------------------------------------------
var() float					DisplaceDurationMult;   // Duration multiplier for aim displacement.
//-----------------------------------------------------------------------------
// Ammo
//-----------------------------------------------------------------------------
var() int			        MagAmmo;				//Ammo currently in magazine for Primary and Secondary. Max is whatever the default is.
var() bool					bMagPlusOne;			//A true value means weapon can store an extra round in chamber. Primarily used in realistic.
var() bool					bNeedCock;				//A true value means this gun is drawn with no round in the chamber, will trigger the cock anim or CockingDrawAnim
//-----------------------------------------------------------------------------
// Pistol Dual Wielding
//-----------------------------------------------------------------------------
var() bool			        bDualBlocked;			//Prevent this weapon from being dual wielded.
var() bool			        bDualMixing;			//Allow this gun to mix and match, used in classic handguns

//-----------------------------------------------------------------------------
// Firemodes
//-----------------------------------------------------------------------------
var() int InitialWeaponMode;
var() array<WeaponModeType> WeaponModes;				//A list of the available weapon firing modes and their info for this weapon

var() editinline array<RecoilParams>	RecoilParams;
var() editinline array<AimParams>		AimParams;
var() editinline array<FireParams>    	FireParams;
var() editinline array<FireParams>     	AltFireParams;

//-----------------------------------------------------------------------------
// AI
//-----------------------------------------------------------------------------
var   bool			bNoaltfire;			//Dissalow a bot to use alt-fire (use this when the alt-fire makes the gun ADS but the gun has multiple layout alt-fires that we want to keep)

//-----------------------------------------------------------------------------

final function FireEffectParams.FireModeStats GetFireStats() 
{
    local FireEffectParams.FireModeStats FS;

    if (FireParams.Length > 0)
	    return FireParams[0].GetStats();

    return FS;
}

final function FireEffectParams.FireModeStats GetAltFireStats() 
{
    local FireEffectParams.FireModeStats FS;

    if (AltFireParams.Length > 0)
	    return AltFireParams[0].GetStats();

    return FS;
}

// for short manual displayed on conflict
final function string BuildShortManualString()
{
	local string S;

	S = "Mag Ammo: "$ MagAmmo $ "|";
	S $= "ADS Speed: "$ SightingTime $ " seconds|";
	//if (WeaponPrice != 0)
	//	S $= "Price: "$ WeaponPrice $ " credits|";

	return S;
}

defaultproperties
{
    PlayerSpeedFactor=1.000000
    PlayerJumpFactor=1.000000
    InventorySize=6
    WeaponPrice=100
	ScopeScale=1
    SightMoveSpeedFactor=0.900000
    SightingTime=0.350000
    ZoomType=ZT_Irons
    DisplaceDurationMult=1.000000
    MagAmmo=30
	CockAnimRate=1.000000
    ReloadAnimRate=1.000000
}