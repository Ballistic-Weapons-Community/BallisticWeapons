//=============================================================================
// BallisticWeapon.
//
// A special sub-class of Engine.Weapon, this is to add support for new Ballistic
// weapon features. These features include:
//
// An improved ammo system allowing the use of magazines, reloading, etc.
//
// Various fire modes including Semi-Auto, Burst, Full Auto and more that alter
// how many bullets and how quickly a weapon can refire.
//
// A crosshair system allowing the crosshair to change as the weapon is fired.
//
// A comprehensive aiming system which alteres accuracy and weapon stability
// according to player movements and many other factors. Aim is also
// predictable so that a laser sight could show the exact aim of the weapon.
// Firing recoil is also included and used interpolation curves and randomness
// to rotate the aim.
//
// Sights or Scopes which can be used to aim precisely. Scopes also have a
// variable zoom level which can be controlled in several ways.
//
// Red and Blue team variants for the weapon skins.
//
// by Nolan "Dark Carnivour" Richert
// upgraded/fixed by Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
// Azarael notes:
// The future aim for this class is for it to serve primarily as the graphical 
// and input components of the weapon as well as the replication channel.
// Sub objects should handle reloading, aim and recoil systems.
//=============================================================================
class BallisticWeapon extends Weapon
	abstract
 	config(BallisticProV55)
	DependsOn(BUtil)
	HideDropDown
	CacheExempt;

// These settings below may look intimidating, but just remember, many of them are
// internal things that you don't need to worry about and for many others, the defaults
// will be ok. There are lots of settings just available in case you need to change
// some behavior.
//=============================================================================
// ENUMS
//=============================================================================
enum EReloadState
{
   	RS_None,				//Not reloading or cocking. Used as default as well as after reload finishes
    RS_PreClipOut,		//Reload just started. Magazine still in gun
   	RS_PreClipIn,			//Magazine pulled. New magazine coming up
 	RS_PostClipIn,			//New magazine in. From here it either goes to ready or cocking
	RS_StartShovel,		//Pre shovel loop
	RS_Shovel,				//Busy shovelling shells. Either pushing shell toward gun or retracting hand to get another one
	RS_PostShellIn,		//Shell just gone in. Decide to either go for another one or stop reloading and go to EndShovel
	RS_EndShovel,		//Shovel loop finished. Hand moving back to handle or whatever
	RS_Cocking,			//Gun being cocked. Ready after this.
	RS_GearSwitch   		//Adjusting some kind of gear like a suppressor or a GL
};

enum EMeleeState
{
	MS_None, 				//Default.
	MS_Pending, 			//Gun couldn't fire yet, but melee is being held.
	MS_Held,				//Gun is in melee position, charging the attack.
	MS_Strike,				//Gun is attacking.
	MS_StrikePending 		//Gun is in the middle of its own strike, but wants to prepare another at the end of this one.
};

enum ESightingState
{
   	SS_None,			//Not viewing through sights or moving gun into sight postions
   	SS_Lowering,		//Finished sight view, lowering un
    SS_Raising,			//Lifting gun and getting to sight view
 	SS_Active			//Looking through sights
};

enum ModeSaveType
{
	MR_None,				//Don't remember any weapon modes.
	MR_Last,				//Remember the last mode used.
	MR_SavedDefault			//Remember the mode saved manually using the SaveMode command.
};

enum EZoomType // Azarael
{
	ZT_Irons, // Iron sights or simple non-magnifying aiming aid such as a red dot sight or holographic. Smoothly zooms into FullZoomFOV as the weapon repositions to sights view.
	ZT_Fixed, // Fixed scope zoom. Does not allow any change in zoom and goes straight to FullZoomFOV when StartScopeView is called.
	ZT_Logarithmic, //Zooms between MinZoom and MaxZoom magnification levels in relative steps.
	ZT_Minimum, // Minimum zoom level. Zooms straight to the lowest zoom level and stops on scope up. Will zoom between FOV (90 - (88 * MinFixedZoomLevel)) and FullZoomFOV.
	ZT_Smooth // Smooth zoom. Replaces bSmoothZoom, allows the weapon to zoom from FOV 90 to FullZoomFOV.
};

enum EScopeHandling
{
    SH_Default,     // Hold to ADS up. Weapon locks into ADS mode. Press once to release.
    SH_Hold,        // Hold to ADS. Release to drop gun.
    SH_Toggle,      // Press to ADS. Press again to drop gun.
};

//=============================================================================
// STRUCTS
//=============================================================================
struct XYRange
{
	var() config Range X;
	var() config Range Y;
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

struct SpecialInfoEntry
{
	var() name		ID;
	var() string	Info;
};

//=============================================================================
// GLOBALLY CONFIGURABLE SETTINGS
//=============================================================================
var() globalconfig 	ModeSaveType 	ModeHandling;
var() globalconfig  bool			bInvertScope;			// Inverts Prev/Next weap relation to Zoom In/Out
var() globalconfig 	EScopeHandling  ScopeHandling;			// Should iron sights continue when the key is released, once activated?
var() globalconfig 	bool			bOldCrosshairs;			// Use UT2004 crosshairs instead of BW's
var() globalconfig 	float			AimKnockScale;			// Scale the weapon displacement caused by taking damage
var() globalconfig 	bool			bDrawCrosshairDot; 		// Draw dot in the centre of crosshairs
var() globalconfig	bool			bUseBigIcon;			// For HUDFix huds - makes the Icon the BigIcon
var() globalconfig	byte			MaxInventoryCapacity;   // total InventorySize player can carry
//=============================================================================
// END GLOBALLY CONFIGURABLE SETTINGS
//=============================================================================

//=============================================================================
// CONFIGURABLE SETTINGS
//=============================================================================
var() config byte					LastWeaponMode;			//The last known used weapon mode
var() config byte					SavedWeaponMode;		//A manually set or saved initial weapon mode
var() config float					WeaponPrice;			// Cash cost to buy the weapon
var() config float					PrimaryAmmoPrice;		// Cost to fill primary fm ammo
var() config float					SecondaryAmmoPrice;		// Cost to fill secondary fm ammo
var() config array<SpecialInfoEntry> SpecialInfo; 			// A list of special info strings and their IDs
//=============================================================================
// END CONFIGURABLE SETTINGS
//=============================================================================

//=============================================================================
// STATIC DEFINITIONS
//=============================================================================
var Object.Color  					MagEmptyColor;			//used by Simple XHairs if mag is empty
var Object.Color					CockingColor;			//used by Simple XHairs when weapon needs cocking
//=============================================================================
// END STATIC DEFINITIONS
//=============================================================================

var     RewindCollisionManager      RwColMgr;                       // Used for rewind-based instant fire tracing
var     bool                        RewindActive;                   // True if currently in rewind mode (for cleanup)

//=============================================================================
// WEAPON STATE VARIABLES
//=============================================================================
var		WeaponParams				WeaponParams;
var		bool						bPendingBringupTimer;
var     int                         NetInventoryGroup;
var     bool                        bDeferInitialSwitch, bServerDeferInitialSwitch;
//-----------------------------------------------------------------------------
// AI
//-----------------------------------------------------------------------------
var() 	float						AIReloadTime;					// How long it's likely to take to reload. Used by bots to tell if they should reload
var		float						BotTryReloadTime;				// Time when bot should try reload again
var		Vehicle						OwnerLastVehicle;				// Vehicle being driven last tick...
var		Controller					InstigatorController;			// Controller of the instigator
//-----------------------------------------------------------------------------
// Fire Modes
//-----------------------------------------------------------------------------
var		BallisticFire   			BFireMode[NUM_FIRE_MODES];		// BallisticFire FireModes. So you don't have to write: BallisticFire(FireMode[m])
var		byte 						PendingMode;
var		int							FireCount;						// How many shots have been fired since trigger was pulled
var     float						LastFireTime;					// Time of last fire
//-----------------------------------------------------------------------------
// Sights
//-----------------------------------------------------------------------------
var  	float						OldZoomFOV;						// FOV saved for temporary scope down
var  	float						SightingPhase;					// Current level of progress moving weapon into place for sight view
var   	bool						bPendingSightUp;				// Currently out of sight view for something. Will go back when done
var   	bool						bScopeView;						// Currently viewing through scope or sights
var     bool                        bScopeDesired;                  // Weapon wishes to transition to scope
var  	bool						bScopeHeld;						// Scope key has not been released
var   	float						NextCheckScopeTime;				// Used to prevent CheckScope() from exiting scope view for a period of time (eg. Prevent RG recoil from cutting scope view)
var  	float						LogZoomLevel;					// Separate from PC.ZoomLevel because of bZooming code for Anti TCC
var   	ESightingState				SightingState;					// State of non anim, sight related gun movement
var		bool						bStandardCrosshairOff;			// True if ScopeView has hidden the UT2004 crosshair.
//-----------------------------------------------------------------------------
// Movement speed
//-----------------------------------------------------------------------------
var	  bool							PlayerSpeedUp;					// Player speed has been altered by this weapon
var   BCSprintControl				SprintControl;					// A low, poor sort of hack to draw Sprint info on the HUD
//-----------------------------------------------------------------------------
// Melee
//-----------------------------------------------------------------------------
var EMeleeState						MeleeState;
var float							MeleeInterval, MeleeHoldTime;
var  protected BallisticMeleeFire 	MeleeFireMode;
var	float							MeleeFatigue;
//-----------------------------------------------------------------------------
// Ammo/Reload
//-----------------------------------------------------------------------------
var   bool							bNeedReload;					// Gun needs to be reloaded. When on, pressing fire will start a reload
var   bool							bNeedCock;						// Gun needs to be cocked. Will be cocked when reload ends
var   bool							bPreventReload;					// Reload will not start. Used to prevent reloading while fire anim plays
var   EReloadState					ReloadState;					// State of the gun during reloading or cocking. Set seperately on client and server
var   bool							bServerReloading;				// Used to let clients know that server side is still reloading
//-----------------------------------------------------------------------------
// Recoil
//-----------------------------------------------------------------------------
var	RecoilComponent					RcComponent;					// Object which handles recoil
//-----------------------------------------------------------------------------
// Aim
//-----------------------------------------------------------------------------
var AimComponent					AimComponent;
//=============================================================================
// END WEAPON STATE VARIABLES
//=============================================================================

//=============================================================================
// GENERAL WEAPON VARIABLES
//
// These variables are consistent for every instance of a weapon and are 
// user-defined but generally not modified within the game. 
// Contains things like display offsets, icon coords etc
//=============================================================================
var() class<BallisticWeaponParams>	ParamsClass;
//-----------------------------------------------------------------------------
// Replication
//-----------------------------------------------------------------------------
var() class<BCReplicationInfo>		BCRepClass;				// BCReplication info class to use for server side variables that are sent to clients
//-----------------------------------------------------------------------------
// Display
//-----------------------------------------------------------------------------
struct WeaponSkin
{
	var() Material	RedTex;		// Texture to use when red
	var() Material	BlueTex;	// Texture to use when blue
	var() int		SkinNum;	// Index in Skins array
};

var() array<WeaponSkin>		TeamSkins;					// A list of which skins change to show team colors
var() Material				BigIconMaterial;			// A big icon for this weapon. Used in outfitting screens
var() IntBox				BigIconCoords;				// Coords for drawing the BigIcon in the weapon bar (HUDFix)
var	bool					bSkipDrawWeaponInfo;		// Skips the Ballistic versions of NewDrawWeaponInfo
var	bool					bAllowWeaponInfoOverride;	// If true, prevents upgraded HUDs from overriding the weapon info display
var() float					IdleTweenTime;				// Just a general tween time used by anims like idle
//-----------------------------------------------------------------------------
// Sound
//-----------------------------------------------------------------------------
var() BUtil.FullSound		BringUpSound;				// Sound to play when weapon is brought out
var() BUtil.FullSound		PutDownSound;				// Sound to play when weapon is put away
//-----------------------------------------------------------------------------
// Fire Modes
//-----------------------------------------------------------------------------
var() array<WeaponModeType> WeaponModes;				//A list of the available weapon firing modes and their info for this weapon

var() travel byte			CurrentWeaponMode;			// The index of the firing mode currently active
var	bool					bRedirectSwitchToFiremode;  // Compatibility for Ballistic UI - implemented in later weapons
//-----------------------------------------------------------------------------
// Sighting
//-----------------------------------------------------------------------------
var   Actor					SightFX;				// SightFX actor
var() class<Actor>			SightFXClass;			// Effect to attach as an iron sight effect or could be used for anything
var() name					SightFXBone;			// Bone to attach SightFX to
var() bool					bUseSights;				// This weapon has sights or a scope that can be used
var() bool					bNoTweenToScope;		// Don't tween to the first idle frame to fix the animation jump (M75 fix) FIXME the M75 uses animations to scope
var() config float 			ScopeXScale;			// Manual scaling for scopes
var() name					ZoomInAnim;				// Anim to play for raising weapon to view through Scope or sights
var() name					ZoomOutAnim;			// Anim to play when lowering weapon after viewing through scope or sights
var() Material				ScopeViewTex;			// Texture displayed in Scope View. Fills the screen
var() BUtil.FullSound		ZoomInSound;			// Sound when zooming in
var() BUtil.FullSound		ZoomOutSound;			// Sound when zooming out
var() float					FullZoomFOV;			// The FOV that can be reached when fully zoomed in
var() bool					bNoMeshInScope;			// Weapon mesh is hidden when in scope/sight view
var() bool					bNoCrosshairInScope;	// Crosshair will be hidden when in scope or sights
var() float					SightZoomFactor; 		// Base FOV multiplied by this to give sight aim factor
var() name					SightBone;				// Bone at which camera should be to view through sights. Uses origin if none
var() Rotator				SightPivot;				// Rotate the weapon by this when in sight view
var() Vector				SightOffset;			// Offset of actual sight view position from SightBone or mesh origin.
var() float					SightDisplayFOV;		// DisplayFOV for drawing gun in scope/sight view
var float 					MinFixedZoomLevel; 		// Minimum zoom level for ZT_Minimum.
var float					MinZoom, MaxZoom;		// Min and max magnification levels for ZT_Logarithmic.
var int						ZoomStages;				// Number of zoom stages
var Vector					SMuzzleFlashOffset;		// Offset for muzzle flash in scope
//-----------------------------------------------------------------------------
// Ammo/Reload
//-----------------------------------------------------------------------------
var() int					AmmoType;					// Current ammunition type index (indexes into FireParams for firemodes)
var() bool					bNoMag;						// Does not use reloading. Takes ammo straight from inventory
var() Name					CockAnim;					// Animation to use for cocking
var() Name					CockAnimPostReload;			// Anim to use for cocking at end of reload
var() Name					CockSelectAnim;				// Anim used when bringing up a weapon which needs cocking
var() BUtil.FullSound		CockSound;					// Sound to play for cocking
var() bool					bCockAfterReload;			// Always cock the gun after reload
var() bool					bCockOnEmpty;				// Gun will cock when reload ends if mag was empty before reload
var() bool					bNonCocking;				// Gun doesn't, can't or shouldn't get cocked...
var() Name					ReloadAnim;					// Anim to use for Reloading. Also anim to use for shovel loop
var() Name					ReloadEmptyAnim;			// Anim played when reloading an empty weapon
var() BUtil.FullSound		ClipHitSound;				// Sound to play when magazine gets hit
var() BUtil.FullSound		ClipOutSound;				// Sound to play when magazine is pulled out
var() BUtil.FullSound		ClipInSound;				// Sound to play when magazine is put in
var() float					ClipInFrame;				// RED! Frame at which magazine is put in. Also frame of shovel loop when shell is placed in
var() bool					bCanSkipReload;				// Can press fire to exit reloading from shovel loop or PreClipIn
var() bool					bAltTriggerReload;			// Pressing alt fire triggers reload/skip/cock just like primary.
var() bool					bShovelLoad;				// Ammo is loaded into gun repeatedly, e.g. the loading of a winchester or pump-action shotgun
var() Name					StartShovelAnim;			// Played before shoveling loop starts
var() Name					EndShovelAnim;				// Anim to play after shovel loop ends
var() Name					EndShovelEmptyAnim;			// Played if the weapon needs cocking at the end of the shovel loop
var() int					ShovelIncrement;			// Amount of ammo to stick in gun each time
var   bool					bPlayThirdPersonReload; 	// Play an anim on the Pawn for reloading.
var	  float					FireAnimCutThreshold;   	// Cuts the fire anim if the SightingState is higher than this.
//-----------------------------------------------------------------------------
// Recoil
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Aim
//-----------------------------------------------------------------------------
var() rotator				LongGunPivot;			// How to rotate aim and gun at full LongGunFactor
var() vector				LongGunOffset;			// How much to offset weapon position at full LongGunFactor
//-----------------------------------------------------------------------------
// Melee
//-----------------------------------------------------------------------------
var class<BallisticMeleeFire>	MeleeFireClass;
//-----------------------------------------------------------------------------
// Flags 
// These describe a weapon or its capabilities. 
// Use for mutators, AI, anything that needs to try just types of weapons
//-----------------------------------------------------------------------------
var() bool		bWT_Bullet;							
var() bool		bWT_Shotgun;						
var() bool		bWT_Hazardous;						// It is dangerous to the user (if not used carefully)
var() bool		bWT_Splash;							// Has large radius damage attacks
var() bool		bWT_Sidearm;							
var() bool		bWT_Machinegun;						// A fairly automatic non-proj pistol, smg, ar, mg, minigun, etc
var() bool		bWT_RapidProj;						// A fairly automatic projectile weapon
var() bool		bWT_Projectile;						// Has non-instant non-rapid projectile attack
var() bool		bWT_Grenade;						// Has non-instant bouncing grenade type projectiles
var() bool		bWT_Energy;							// Energy attack
var() bool		bWT_Super;							// Is considered a 'super weapon' or more powerful than normal weapons. 
													// Gameplay relevant. Pickups for guns with this set will never stay. Ballistic Freon won't resupply weapons with this set.
var() bool		bWT_Trap;							// Some kind of weird or deployable weapon. eg. mine, bomb, beartrap
var() bool		bWT_Heal;							// Has the ability to heal in some fashion.
var() bool		bWT_Spam;							// Is unusually powerful relative to other weapons in the hands of bad players who refuse to use the Aimed key.
													// Loadout will refuse to give spammers this weapon.
var() localized array<String>	ManualLines;		// String array containing usage information.
var	Object.Color	HeaderColor, TextColor;
//=============================================================================
// END GENERAL WEAPON VARIABLES
//=============================================================================

//=============================================================================
// GAMEPLAY VARIABLES
//
// These variables are user-defined, and may additionally be modified either 
// by the game ruleset or by weapon modes and attachments.
//=============================================================================
//-----------------------------------------------------------------------------
// Move speed
//-----------------------------------------------------------------------------
var() float					PlayerSpeedFactor;		// Instigator movement speed is multiplied by this when this weapon is in use
var() float					PlayerJumpFactor;		// Player JumpZ multiplied by this when holding this weapon
//-----------------------------------------------------------------------------
// Effects
//-----------------------------------------------------------------------------
var() Sound					UsedAmbientSound;		// Use this instead of AmbientSound to have gun hum when in use
//-----------------------------------------------------------------------------
// Sights
//-----------------------------------------------------------------------------
var() EZoomType 			ZoomType;				// Type of zoom used for ADS
var() float					SightingTime;			// Time it takes to move weapon to and from sight view
//-----------------------------------------------------------------------------
// Ammo/Reloading
//-----------------------------------------------------------------------------
var() travel int			MagAmmo;				//Ammo currently in magazine for Primary and Secondary. Max is whatever the default is.

var() float					CockAnimRate;			//Rate to play cock anim at
var() float					CockSelectAnimRate; 	//Rate for this anim
var() float					CockingBringUpTime;		//Time in code before weapon is ready
var() float					ReloadAnimRate;			//Rate to play Reload Anim at
var() float					StartShovelAnimRate;	//Rate for start anim
var() float					EndShovelAnimRate;		//Rate for end anim
//-----------------------------------------------------------------------------
// Aim
//-----------------------------------------------------------------------------
var(Aim) bool				bAimDisabled;		// Disables the entire aiming system. Bullets go exactly where crosshair is aimed.
var(Aim) bool				bUseNetAim;			// Aim info is replicated to clients. Otherwise client and server aim will be separate
var(Aim) bool				bUseSpecialAim;		// Firemodes will use GetPlayerAim instead of normal AdjustAim. Used for autotracking and other special aiming functions
var() float					GunLength;			// How far weapon extends from player. Used by long-gun check
//=============================================================================
// END GAMEPLAY VARIABLES
//=============================================================================

replication
{
	// Things the server should send to the owning client
	reliable if( bNetOwner && Role==ROLE_Authority)
		MagAmmo, bServerReloading, NetInventoryGroup, bServerDeferInitialSwitch;

	// functions on server, called by client
   	reliable if( Role < ROLE_Authority )
		ServerReloadRelease, ServerStartReload, ServerSkipReload, ServerCockGun, ServerStopReload, ServerReloaded, // reload system
		ServerZeroAim, ServerReaim, // aim system
		ServerWeaponSpecial, ServerWeaponSpecialRelease, // weapon special ability
		ServerSwitchWeaponMode, // weapon mode
		ServerMeleeHold, ServerMeleeRelease, // melee integration
		ServerSetScopeView; // ADS


	// functions on client, called by server
   	reliable if( Role == ROLE_Authority )
		ClientReloadRelease, ClientStartReload, ClientCockGun, ClientWeaponReloaded, // reload system
		ReceiveNetAim, ClientDisplaceAim, // aim system
		ReceiveNetRecoil, // recoil system
		ClientWeaponSpecial, ClientWeaponSpecialRelease, // weapon special ability
		ClientSwitchWeaponMode, // weapon mode
		ClientJumped, ClientDodged, ClientPlayerDamaged, // client events
		ClientScopeDown, ClientJamMode,ClientInitWeaponFromTurret,
		ClientApplyBlockFatigue; // gameplay events
}

//The Core -------------------------------------------------------------------------------------------------------------

// These functions can be used to safely play anims and avoid disrupting anims that are essential to timing or reload state
simulated final function bool SafePlayAnim (name Sequence, optional float Rate, optional float TweenTime, optional int Channel, optional string AnimID)
{ if (!CanPlayAnim(Sequence, Channel, AnimID)) return false; return PlayAnim (Sequence, Rate, TweenTime, Channel); }
simulated final function bool SafeLoopAnim (name Sequence, optional float Rate, optional float TweenTime, optional int Channel, optional string AnimID)
{ if (!CanPlayAnim(Sequence, Channel, AnimID)) return false; return LoopAnim (Sequence, Rate, TweenTime, Channel); }
simulated final function bool SafeTweenAnim (name Sequence, float Time, optional int Channel, optional string AnimID)
{ if (!CanPlayAnim(Sequence, Channel, AnimID)) return false; return TweenAnim (Sequence, Time, Channel); }

// This should be expanded in subclasses if needed
simulated function bool CanPlayAnim (name Sequence, optional int Channel, optional string AnimID)
{
	if (ReloadState != RS_None && AnimID != "RELOAD")
	{
		if (MeleeState > MS_Pending && AnimID == "FIRE")
			return true;
		return false;
	}
	return true;
}

// Quick shortcut...
simulated final function vector ViewAlignedOffset (vector Offset) { return class'BUtil'.static.ViewAlignedOffset(self, Offset); }

// Set a few things...
simulated function PostBeginPlay()
{
    local int m;
	Super.PostBeginPlay();

	CreateRecoilComponent();
	CreateAimComponent();

	ParamsClass.static.Initialize(self);

	//Set up channel 1 for sight fire blending.
	AnimBlendParams(1,0);

	if (bUseBigIcon)
	{
		IconMaterial 	= BigIconMaterial;
		IconCoords 		= BigIconCoords;
	}		

    for (m = 0; m < NUM_FIRE_MODES; m++)
    	if (FireMode[m] != None && BallisticFire(FireMode[m]) != None)
			BFireMode[m] = BallisticFire(FireMode[m]);

	//Abuse the existing fire mode class for its ModeDoFire.
	if (MeleeFireClass != None)
	{
		MeleeFireMode =  BallisticMeleeFire(Level.ObjectPool.AllocateObject(MeleeFireClass)); //new(XLevel) MeleeFireClass;
		
		if (MeleeFireMode != None)
		{
			MeleeFireMode.ThisModeNum = 2;
			MeleeFireMode.Weapon = self;
			MeleeFireMode.BW = self;
			MeleeFireMode.Instigator = Instigator; // this will always fail
			MeleeFireMode.Level = Level;
			MeleeFireMode.Owner = self;
			MeleeFireMode.PreBeginPlay();
			MeleeFireMode.BeginPlay();
			MeleeFireMode.PostBeginPlay();
			MeleeFireMode.PostNetBeginPlay();
		}
	}
}

//===========================================================================
// PostNetBeginPlay
//
// Scales accuracy, sets up burst mode and sets the initial fire mode.
//===========================================================================
simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (BCRepClass.default.bNoReloading)
		bNoMag = true;

    if (NetInventoryGroup != 255)
        InventoryGroup = NetInventoryGroup;

    bDeferInitialSwitch = bServerDeferInitialSwitch;

	// Azarael - This assumes that all firemodes implementing burst modify the primary fire alone.
	// To my knowledge, this is the case.
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_Burst")
	{
		BFireMode[0].bBurstMode = True;
		BFireMode[0].MaxBurst = WeaponModes[CurrentWeaponMode].Value;

		RcComponent.DeclineDelay = CalculateBurstRecoilDelay(BFireMode[0].bBurstMode);
	}
}

simulated final function OnWeaponParamsChanged()
{
	SightingTime 				= WeaponParams.SightingTime;
	default.SightingTime 		= WeaponParams.SightingTime;

	MagAmmo 					= WeaponParams.MagAmmo;
	default.MagAmmo				= WeaponParams.MagAmmo;

	PlayerSpeedFactor 			= WeaponParams.PlayerSpeedFactor;
	default.PlayerSpeedFactor	= WeaponParams.PlayerSpeedFactor;

	PlayerJumpFactor 			= WeaponParams.PlayerJumpFactor;
	default.PlayerJumpFactor	= WeaponParams.PlayerJumpFactor;
}

simulated final function CreateRecoilComponent()
{
	RcComponent = RecoilComponent(Level.ObjectPool.AllocateObject(class'RecoilComponent'));

	RcComponent.BW = self;
	RcComponent.Level = Level;
}

simulated final function CreateAimComponent()
{
	AimComponent = AimComponent(Level.ObjectPool.AllocateObject(class'AimComponent'));

	AimComponent.BW = self;
	AimComponent.Level = Level;
	AimComponent.GunLength = GunLength;
	AimComponent.LongGunPivot = LongGunPivot;
	AimComponent.LongGunOffset = LongGunOffset;
}

exec function OffsetX1(int x1)
{
	IconCoords.X1 = x1;
}

exec function OffsetX2(int x2)
{
	IconCoords.X2 = x2;
}
exec function OffsetY1(int y1)
{
	IconCoords.Y1 = y1;
}
exec function OffsetY2(int y2)
{
	IconCoords.Y2 = y2;
}

exec function LogIconCoords()
{
	log(self @ "BigIconCoords=(X1="$IconCoords.X1$",X2="$IconCoords.X2$",Y1="$IconCoords.Y1$",Y2="$IconCoords.Y2$")");
	PlayerController(InstigatorController).ClientMessage("Logged IconCoords for" @ self);
}

static final operator(34) Range *= (out Range A, float B)
{
	A.Min *= B;
	A.Max *= B;
	return A;
}
static final operator(34) XYRange *= (out XYRange A, float B)
{
	A.X *= B;
	A.Y *= B;
	return A;
}
static final operator(34) Range /= (out Range A, float B)
{
	A.Min /= B;
	A.Max /= B;
	return A;
}
static final operator(34) XYRange /= (out XYRange A, float B)
{
	A.X /= B;
	A.Y /= B;
	return A;
}

//===========================================================================
// BlendFire
//
// Configures the animation blending for sight fire transitions.
// Both FireAnim and AimedFireAnim play during this time.
//===========================================================================
simulated final function bool BlendFire()
{
	switch(SightingState)
	{
		case SS_None: return false;
		case SS_Raising: AnimBlendToAlpha(1, 1, (1-SightingPhase) * SightingTime); return true;
		case SS_Lowering: AnimBlendToAlpha(1, 0, SightingPhase * SightingTime); return true;
		case SS_Active: AnimBlendParams(1,1); return true;
	}
	
	if (bScopeView)
	{
		AnimBlendParams(1,1);
		return true;
	}
	return false;
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Anim == ZoomInAnim)
	{
		SightingState = SS_Active;
		ScopeUpAnimEnd();
		return;
	}
	else if (Anim == ZoomOutAnim)
	{
		SightingState = SS_None;
		ScopeDownAnimEnd();
		return;
	}

	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim) )
		bPreventReload=false;
		
	if (MeleeFireMode != None && anim == MeleeFireMode.FireAnim)
	{
		if (MeleeState == MS_StrikePending)
			MeleeState = MS_Pending;
		else MeleeState = MS_None;
		ReloadState = RS_None;
		if (Role == ROLE_Authority)
			bServerReloading=False;
		bPreventReload=false;
	}
		
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if (MeleeState < MS_Held)
			bPreventReload=false;
		if (Channel == 0 && (bNeedReload || ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			AimComponent.ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		AimComponent.ReAim(0.05);
	}
	
	if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}
// On the server, this adjusts anims, ammo and such. On clients it only adjusts anims.
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(Channel, anim, frame, rate);
    AnimEnded(Channel, anim, frame, rate);
}

simulated function float GetModifiedJumpZ(Pawn P)
{
	return P.JumpZ * PlayerJumpFactor;
}

simulated function StartBerserk()
{
	if ( (Level.GRI != None) && Level.GRI.WeaponBerserk > 1.0 )
		return;
		
	bBerserk = true;
	UpdateBerserkRecoil();

	ReloadAnimRate = default.ReloadAnimRate / 0.75;
    CockAnimRate = default.CockAnimRate / 0.75;
    
    if (FireMode[0] != None)
        FireMode[0].StartBerserk();
    if (FireMode[1] != None)
        FireMode[1].StartBerserk();
}

simulated function StopBerserk()
{
	bBerserk = false;
	UpdateBerserkRecoil();

	ReloadAnimRate = default.ReloadAnimRate;
    CockAnimRate = default.CockAnimRate;
    
    if ( (Level.GRI != None) && Level.GRI.WeaponBerserk > 1.0 )
		return;

    if (FireMode[0] != None)
        FireMode[0].StopBerserk();
    if (FireMode[1] != None)
        FireMode[1].StopBerserk();
}

simulated function UpdateBerserkRecoil()
{
	local float factor;

	factor = 0.75f;

	if (!bBerserk)
		factor = 1f / factor;

	RcComponent.DeclineTime *= factor;
	RcComponent.DeclineDelay *= factor;
}

//==================================================================
// VEHICLE ENTRY/EXIT
//==================================================================
simulated function PlayerEnteredVehicle(Vehicle V)
{
	if (Role == ROLE_Authority)
		bServerReloading=false;
	ReloadState = RS_None;
	PlayIdle();

	if (bOldCrosshairs)
		return;
	if (PlayerController(InstigatorController)!=None && PlayerController(InstigatorController).MyHud != None)
		PlayerController(InstigatorController).MyHud.bCrosshairShow = PlayerController(InstigatorController).MyHud.default.bCrosshairShow;
}
simulated function PlayerLeftVehicle(Vehicle V)
{
	if (bOldCrosshairs)
		return;
	if (PlayerController(InstigatorController)!=None && PlayerController(InstigatorController).MyHud != None/* && (CrosshairPic1 != None || CrosshairPic2 != None)*/)
		PlayerController(InstigatorController).MyHud.bCrosshairShow = false;
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (Instigator != None && Instigator.Weapon == self && OwnerLastVehicle != Instigator.DrivenVehicle )
	{
		if (Instigator.DrivenVehicle != None)
			PlayerEnteredVehicle(Instigator.DrivenVehicle);
		else
			PlayerLeftVehicle(OwnerLastVehicle);
		OwnerLastVehicle = Instigator.DrivenVehicle;
	}
}

// Check a few things and run the aiming tick
simulated event WeaponTick(float DT)
{
	Super.WeaponTick(DT);

	AimComponent.UpdateAim(DT);
	RcComponent.UpdateRecoil(DT);

	ApplyAimRotation();
	AimComponent.SetLastLookDir(GetPlayerAim());

	AimComponent.UpdateDisplacements(DT);

	TickSighting(DT);
	TickFireCounter(DT);
	
	//FIXME. This shouldn't be necessary at all.
	if (bPreventReload && !IsFiring())
		if(CheckFireAnim())
			bPreventReload = false;

	if (!bNoMag && level.TimeSeconds > BotTryReloadTime && AIController(InstigatorController) != None && (!InstigatorController.LineOfSightTo(AIController(InstigatorController).Enemy)) && BotShouldReload() )
	{
		BotTryReloadTime = level.TimeSeconds + 1.0;
		BotReload();
	}
}

simulated final function bool CheckFireAnim()
{
	local int i, channel;
	local Name anim;
	local float rate, frame;
	
	for (i = 0; i < NUM_FIRE_MODES; i ++)
	{
		if(!HasAnim(FireMode[i].FireAnim) || FireMode[i].FireAnim == IdleAnim)
			return true;
	}
	
	GetAnimParams(channel, anim, frame, rate);
	if (Anim == FireMode[0].FireAnim || Anim == FireMode[1].FireAnim)
		return false;
	if (Anim == FireMode[0].FireEndAnim || Anim == FireMode[1].FireEndAnim)
		return false;
	return true;
}

simulated function TickFireCounter (float DT)
{
	if (!IsFiring() && FireCount > 0)
		FireCount = 0;
}

//================================================================================
// NETCODE
//
// Rewind functions
//================================================================================
final function RewindCollisions()
{
    local PlayerController PC;

    if (RwColMgr == None)
    {
        //Log("BallisticWeapon::RewindCollisions: No Manager");
        return;
    }

    PC = PlayerController(InstigatorController);

    if (PC == None)
    {
        //Log("BallisticWeapon::RewindCollisions: Weapon not owned by PlayerController");
        return;
    }

    //Log("BallisticWeapon::RewindCollisions: Rewinding: Ping:" $ PC.PlayerReplicationInfo.Ping * 0.004f);
        
    RewindActive = True;

    RwColMgr.RewindCollisions(Instigator, PC.PlayerReplicationInfo.Ping * 0.004f);    
}

final function RestoreCollisions()
{
    if (RwColMgr == None || !RewindActive)
        return;

    //Log("BallisticWeapon::RestoreCollisions: Restoring");

    RwColMgr.RestoreCollisions();

    RewindActive = false;
}

//================================================================================
// NOTIFY FUNCTIONS
//
// Used to time reloading
//================================================================================
// Animation notify for when a shell is loaded in
simulated function Notify_ShellIn()
{
	local float BotSafety;
	local int AmmoNeeded;

	if (ReloadState == RS_Shovel)
	{
		ReloadState = RS_PostShellIn;
		if (Role == ROLE_Authority)
		{
			AmmoNeeded = Min(ShovelIncrement, default.MagAmmo - MagAmmo);

			if (AmmoNeeded > Ammo[0].AmmoAmount)
				MagAmmo+=Ammo[0].AmmoAmount;
			else
				MagAmmo+=AmmoNeeded;
				Ammo[0].UseAmmo (AmmoNeeded, True);
		}
		PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
		// A bot will stop reloading if they feel unsafe. Dumb ones will do this less
		if (AIController(InstigatorController) != None && MagAmmo > 0 && AIController(InstigatorController).Enemy != None)
		{
			BotSafety = FMin( Level.TimeSeconds - Instigator.LastPainTime, VSize(Instigator.Location - AIController(InstigatorController).Enemy.Location)/200 );
			if (AIController(InstigatorController).Skill + FRand()*2 > BotSafety)
				SkipReload();
		}
	}
}
// Animation notify for when the magazine is stuck in
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;

	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;
	PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.MagAmmo-MagAmmo;
		if (AmmoNeeded > Ammo[0].AmmoAmount)
			MagAmmo+=Ammo[0].AmmoAmount;
		else
			MagAmmo = default.MagAmmo;
		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
}
// Animation notify for when the magazine is pulled out
simulated function Notify_ClipOut()
{
	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PreClipIn;
	PlayOwnedSound(ClipOutSound.Sound,ClipOutSound.Slot,ClipOutSound.Volume,ClipOutSound.bNoOverride,ClipOutSound.Radius,ClipOutSound.Pitch,ClipOutSound.bAtten);
}
// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockStart()
{
	if (ReloadState == RS_None)	return;
	ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}
// Animation notify for ejecting a cartridge
simulated function Notify_BrassOut()
{
	BFireMode[0].EjectBrass();
}
// Animation notify to make gun cock after fired
simulated function Notify_CockAfterFire()
{
	bPreventReload=false;
	if (bNeedCock && ReloadState == RS_None && MagAmmo > 0)
		CommonCockGun(1);
}
// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && ReloadState == RS_None && MagAmmo > 0)
		CommonCockGun(2);
}
// Animation notify for when the magazine is hit
simulated function Notify_ClipHit()
{
	PlayOwnedSound(ClipHitSound.Sound,ClipHitSound.Slot,ClipHitSound.Volume,ClipHitSound.bNoOverride,ClipHitSound.Radius,ClipHitSound.Pitch,ClipHitSound.bAtten);
}
//================================================================================
// END NOTIFIES
//================================================================================

//================================================================================
// ANIM PLAY FUNCTIONS
//
// These are called to play anims and can be overridden in subclasses.
//================================================================================
simulated function PlayIdle()
{
	if (MeleeState == MS_Pending)
	{
		MeleeState = MS_Held;
		MeleeFireMode.PlayPreFire();
		if (SprintControl != None && SprintControl.bSprinting)
			PlayerSprint(false);
		ServerMeleeHold();
		return;
	}
	
	/*
	if (IsFiring())
		return;
	*/
	
	if (SightingState != SS_None)
	{
		if (SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	
	else if (bScopeView)
	{
		if(HasAnim(ZoomOutAnim) && SafePlayAnim(ZoomOutAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	
	else
	    SafeLoopAnim(IdleAnim, IdleAnimRate, IdleTweenTime, ,"IDLE");
}
simulated function PlayReload()
{
	if (bShovelLoad)
		SafePlayAnim(StartShovelAnim, StartShovelAnimRate, , 0, "RELOAD");
	else
	{
	    if (MagAmmo < 1 && HasAnim(ReloadEmptyAnim))
			SafePlayAnim(ReloadEmptyAnim, ReloadAnimRate, , 0, "RELOAD");
		else	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
	}
}
simulated function PlayShovelEnd()
{
	if (bNeedCock && HasAnim(EndShovelEmptyAnim))
		SafePlayAnim(EndShovelEmptyAnim, EndShovelAnimRate, 0.1, ,"RELOAD");
	else SafePlayAnim(EndShovelAnim, EndShovelAnimRate, 0.1, ,"RELOAD");
}
simulated function PlayShovelLoop()
{
	SafePlayAnim(ReloadAnim, ReloadAnimRate, 0.0, , "RELOAD");
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('Shovel');
}
simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None)
		TemporaryScopeDown(default.SightingTime);
}
//================================================================================
// END ANIM PLAY FUNCTIONS
//================================================================================

simulated function ClientJamMode(byte Mode)
{
	if (level.NetMode == NM_Client)
		BFireMode[Mode].DoJam();
}

// Called when reloading sequence ends. (sequence includes cocking)
simulated function ReloadFinished()
{
	if (Role == ROLE_Authority)
		bServerReloading=false;
	if (BFireMode[0] != None)
		BFireMode[0].WeaponReloaded();
	if (BFireMode[1] != None)
		BFireMode[1].WeaponReloaded();
}

// Returns true if gun will need reloading after a certain amount of ammo is consumed. Subclass for special stuff
simulated function bool MayNeedReload(byte Mode, float Load)
{
	if (!bNoMag && BFireMode[Mode]!= None && BFireMode[Mode].bUseWeaponMag && (/*MagAmmo < 1 || */MagAmmo - Load < 1))
		return true;
	return bNeedReload;
}

simulated function EmptyFire (byte Mode)
{
	if (/*bNeedReload && */ClientState == WS_ReadyToFire && FireCount < 1 && Instigator.IsLocallyControlled())
		ServerStartReload(Mode);
}

// Fire pressed. Change weapon if out of ammo, reload if empty mag or skip reloading if possible
simulated function FirePressed(float F)
{
	if (!HasAmmo())
		OutOfAmmo();
	else if (bNeedReload && ClientState == WS_ReadyToFire)
	{
		//Do nothing!
	}
	else if (bCanSkipReload && ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn) || (ReloadState == RS_PreClipOut)))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	//mod
	else if (ReloadState == RS_None && bNeedCock && !bPreventReload && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime)
	{
		CommonCockGun();
		if (Level.NetMode == NM_Client)
			ServerCockGun();
	}
}

//Weapons should only drop if they're not doing something else
simulated function OutOfAmmo()
{
    if ( Instigator == None || !Instigator.IsLocallyControlled() || HasAmmo() || bPreventReload)
        return;
		
    DoAutoSwitch();
}

simulated function Fire(float F)	{	FirePressed(0);	}
simulated function AltFire(float F)	{	if (bAltTriggerReload)FirePressed(1);	}

//Skip reloading if fire is pressed in time
simulated function SkipReload()
{
	if (ReloadState == RS_Shovel || ReloadState == RS_PostShellIn)
	{//Leave shovel loop and go to EndShovel
		PlayShovelEnd();
		ReloadState = RS_EndShovel;
	}
	else if (ReloadState == RS_PreClipOut)
	{//skip reload if magazine has not yet been pulled out
		ReloadState = RS_PostClipIn;
		SetAnimFrame(ClipInFrame);
	}
}
final function ServerSkipReload()	{	SkipReload();	}

final function ServerStopReload()	{	ReloadState = RS_None;	}

//================================================================================
// ADS HANDLING
//
// Azarael notes:
// 
// In netplay, a lot of the ADS management is client side.
// The client is responsible for managing:
// - whether the player wishes to scope; 
// - the point that the scope request is at; 
// - notifying the server that a scope attempt is in progress so that aim can be stabilized;
// - notifying the server that the weapon should change to using scoped parameters.
// 
// This is exploitable and it should be fixed.
//--------------------------------------------------------------------------------
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CanUseSights
//
// Returns true if the player may enter iron sights
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated function bool CanUseSights()
{
	if 
	( 
		(SprintControl != None && SprintControl.bSprinting) || 
		ClientState == WS_BringUp || 
		ClientState == WS_PutDown || 
		ReloadState != RS_None || 
		MeleeState != MS_None
	) 
		return false;

	return true;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ScopeView
//
// If not in ADS, zeroes aim on the server and flags that sight interpolation
// should begin.
//
// If in ADS, ends ADS mode on client and server.
//
// Toggle mode: should 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
exec simulated function ScopeView()
{
	bScopeHeld      = true;

	bPendingSightUp = false;

    // abort any scope view in progress
	if (bScopeView)
	{
        bScopeDesired = false;
		StopScopeView();
		return;
	}
	
	if (!bUseSights)
		return;

	if (!CanUseSights())
		return;

    switch (ScopeHandling)
    {
        case SH_Default:
        case SH_Hold:
            bScopeDesired = true;
            break;
        case SH_Toggle:
            bScopeDesired = !bScopeDesired;
            break;
    }

    if (!bScopeDesired)
    {
        ServerReaim(0.1);

        if( InstigatorController.IsA( 'PlayerController' ) && ZoomType == ZT_Smooth)
            PlayerController(InstigatorController).StopZoom();
    }

    else 
    {	
        ZeroAim(SightingTime); //Level out sights over aim adjust time to stop the "shunt" effect
	
        if (!IsFiring() && !bNoTweenToScope)
            TweenAnim(IdleAnim, SightingTime);

        if (AimComponent.AllowADS())
            PlayScopeUp();
    }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ScopeViewRelease
//
// Notifies the weapon that the player no longer wishes to scope.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
exec simulated function ScopeViewRelease()
{
	bScopeHeld = false;

	if (!bUseSights)
		return;

    switch (ScopeHandling)
    { 
        case SH_Hold:       // abandon ADS on key release
            if (bScopeView)
                StopScopeView();
            bScopeDesired = false;
            break;
        case SH_Default:    // abandon ADS attempt on key release
            bScopeDesired = false;
        case SH_Toggle:     // do nothing on key release
            break;
    }

    if (!bScopeView)
		ServerReaim(0.1);

	if( InstigatorController.IsA( 'PlayerController' ) && ZoomType == ZT_Smooth)
		PlayerController(InstigatorController).StopZoom();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CheckScope
//
// Called at intervals to ensure the player can still maintain ADS view.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated function bool CheckScope()
{
	if (level.TimeSeconds < NextCheckScopeTime)
		return true;

	NextCheckScopeTime = level.TimeSeconds + 0.25;
		
	if 
	(	AimComponent.IsDisplaced() ||
		(ReloadState != RS_None && ReloadState != RS_Cocking) || 
		(Instigator.Controller.bRun == 0 && Instigator.Physics == PHYS_Walking) || 
		(SprintControl != None && SprintControl.bSprinting)
	)
	{
		StopScopeView();
		return false;
	}

	return true;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// StartScopeView
//
// Called when entering full ADS mode, which is either when the weapon has 
// interpolated to its final ADS position, or a scope up animation has ended.
//
// Enters ADS mode, switches parameters, applies any necessary zoom and 
// modifies the crosshairs.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated final function StartScopeView()
{
	StartScopeZoom();
	SetScopeView(true);
	ScopeModifyCrosshair();
		
	if (bPendingSightUp)
		bPendingSightUp=false;

	if (!bNeedCock)
		PlayIdle();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ServerSetScopeView
//
// Called on clients when transitioning to or from full ADS mode to notify 
// the server of the change.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
final function ServerSetScopeView(bool bNewValue)
{	
	SetScopeView(bNewValue);	
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// SetScopeView
//
// Called on client and server when transitioning to or from full ADS mode.
// The client replicates the call to the server.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated final function SetScopeView(bool bNewValue)
{
	if (bScopeView == bNewValue)
		return;

	if (Level.NetMode == NM_Client)
		ServerSetScopeView(bNewValue);

	if (Role == ROLE_Authority && ThirdPersonActor != None)
		BallisticAttachment(ThirdPersonActor).SetAimed(bNewValue);
		
	bScopeView = bNewValue;

	if (Role == ROLE_Authority)
	{
		CheckSetNetAim();

		if (!Instigator.IsLocallyControlled())
			BindScopeViewFactors();
	}

	OnScopeViewChanged();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// StopScopeView
//
// Called on client when leaving full ADS mode.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated final function StopScopeView(optional bool bNoAnim)
{
	SetScopeView(false);
	
	if (bNoMeshInScope)
	{
		if (BFireMode[0] != None && BFireMode[0].MuzzleFlash != None)
			AttachToBone(BFireMode[0].MuzzleFlash, 'tip');
		if (BFireMode[1] != None && BFireMode[1].MuzzleFlash != None)
			AttachToBone(BFireMode[1].MuzzleFlash, 'tip');
	}
	
	PlayScopeDown(bNoAnim);
	
	bScopeDesired = False;

	EndScopeZoom();
	ScopeRestoreCrosshair();
}

//------------------------------------------------------------------------
// Animations (general)
//
// Also used to invoke various events
//------------------------------------------------------------------------
// Play the scope down anim or start the 'sighting' repositioning of gun
simulated function PlayScopeDown(optional bool bNoAnim)
{
	if (!bNoAnim && HasAnim(ZoomOutAnim))
	    SafePlayAnim(ZoomOutAnim, 1.0);
	else if (SightingState == SS_Active || SightingState == SS_Raising)
		SightingState = SS_Lowering;

    BlendFire();

	InstigatorController.bRun = 0;
}

// Play the scope up anim or start the 'sighting' repositioning of gun
// Azarael - Anti TCC compatible zoom
simulated function PlayScopeUp()
{
	if (HasAnim(ZoomInAnim))
	    SafePlayAnim(ZoomInAnim, 1.0);
	else
		SightingState = SS_Raising;
	if(ZoomType == ZT_Irons)
		PlayerController(InstigatorController).bZooming = True;

	InstigatorController.bRun = 1;
}

//------------------------------------------------------------------------
// Animations (specific)
// 
// This code is invoked only when the weapon uses actual animations to scope
// The only weapon that does is the M75-TIC
//------------------------------------------------------------------------
// Scope up anim just ended. Either go into scope view or move the scope back down again
simulated function ScopeUpAnimEnd()
{
	if (!bUseSights || (SprintControl != None && SprintControl.bSprinting))
	{
		PlayScopeDown();
		return;
	}

	if (bPendingSightUp)
	{
		StartScopeView();
		bPendingSightUp=false;
	}

	else if (bScopeDesired)
	{
		StartScopeView();
        bScopeDesired = false;
	}
	else
		PlayScopeDown();
}

// Scope down anim has just ended. Play idle anims if the anim was frozen.
simulated function ScopeDownAnimEnd()
{
	local int Channel;
	local name Anim;
	local float Frame, Rate;
	
	GetAnimParams(Channel, Anim, Frame, Rate);
	if (!bPendingSightUp && Frame == 0.0f) //Frozen idle anim
		PlayIdle();
	PlayerController(InstigatorController).bZooming = False;
}

//------------------------------------------------------------------------
//	Events
//------------------------------------------------------------------------
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// OnScopeViewChanged
//
// Called whenever bScopeView is modified.
// 
// Mod authors should override this and call the super version in order 
// to implement any handling which depends on being scoped or not.
//
// This function SHOULD NOT be overridden to apply aim or recoil modifiers
// directly!
//
// You should instead call another function from here (such as 
// ApplySuppressorAimModifiers() for example) and that function should also
// be linked in with OnAimParamsChanged() below, to ensure the recoil and 
// aim behaviour is consistent when the underlying parameters are changed 
// or a recalculation is otherwise forced.
//
// The handling of ApplyADSAimModifiers() below demonstrates how this 
// should look.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated function OnScopeViewChanged()
{
	if (bScopeView)
	{
		AimComponent.ApplyADSModifiers(); 
		ApplyADSAimModifiers();
	}
	else 
		AimComponent.Recalculate();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// OnAimParamsChanged
//
// Called whenever the AimComponent is asked to recalculate, either 
// explicitly or when its basic parameters are changed.
//
// If this function has been called, any modifications applied on top of 
// the aim component's basic parameters (such as scope view, suppressor, 
// berserk etc) have been removed. 
//
// Mod authors should override this function and check which of their 
// modifications still apply, then reapply them from here, as is done 
// for ADS and core accuracy scaling below.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated function OnAimParamsChanged()
{
	if (bScopeView)
	{
		AimComponent.ApplyADSModifiers(); 
		ApplyADSAimModifiers();
	}

	if (BCRepClass.default.AccuracyScale != 1)
	{
		AimComponent.AimSpread.Min *= BCRepClass.default.AccuracyScale;
		AimComponent.AimSpread.Max *= BCRepClass.default.AccuracyScale;
	}
}

//------------------------------------------------------------------------
// Aim parameter modification
//------------------------------------------------------------------------

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CheckSetNetAim
//
// Called whenever a function modifies a variable which could cause this 
// weapon to need to replicate its aim.
//
// By default, Pro weapons always use net aim. However, any weapon which 
// would formerly have used SetScopeBehavior() to change net aim, or set it 
// directly, should use this function instead.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated function CheckSetNetAim()
{
	bUseNetAim = default.bUseNetAim || bScopeView;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// BindScopeViewFactors
//
// Called to change the view binding level of the Aim and Recoil components.
// When in ADS mode, all aim and recoil movement is bound 100% to the view,
// and the weapon's point of aim is always equal to the player's view rotation.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated final function BindScopeViewFactors()
{	
	if (bScopeView)
	{
		AimComponent.OnADSViewStart();
		RcComponent.OnADSViewStart();
	}
	else
	{
		AimComponent.OnADSViewEnd();
		RcComponent.OnADSViewEnd();
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ApplyADSAimModifiers
//
// This function should be overridden to apply any aim system changes 
// which a particular weapon might want for ADS mode.
// 
// This function should ONLY be used to apply aim system modifiers -
// those which affect the AimComponent - as it will be called whenever 
// the AimComponent recalculates!
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated function ApplyADSAimModifiers()
{	
    AimComponent.ChaosDeclineTime *= 2.0;
    AimComponent.ChaosSpeedThreshold *= 0.7;
}

//------------------------------------------------------------------------
// FOV changing
//------------------------------------------------------------------------
simulated function StartScopeZoom()
{
	local PlayerController PC;

	PC = PlayerController(InstigatorController);

	if (ZoomInSound.Sound != None)	
		class'BUtil'.static.PlayFullSound(self, ZoomInSound);

    PlayerZoom(PC);
}

simulated final function PlayerZoom(PlayerController PC)
{
    switch(ZoomType)
	{
		case ZT_Smooth:
			PC.StartZoomWithMax((90-FullZoomFOV)/88); //PC.DefaultFOV
			break;
		case ZT_Minimum:
			PC.bZooming=True;
			PC.SetFOV(FClamp(90.0 - ((90-FullZoomFOV)/88 * MinFixedZoomLevel) * 88.0, 1, 170));
			PC.ZoomLevel = MinFixedZoomLevel;
			PC.DesiredZoomLevel = MinFixedZoomLevel;
			break;
		case ZT_Fixed:
			PC.bZooming=True;
			PC.SetFOV(FullZoomFOV);
			PC.ZoomLevel = (90 - FullZoomFOV) / 88;
			PC.DesiredZoomLevel = (90 - FullZoomFOV) / 88;
			break;
		case ZT_Logarithmic:
			PC.bZooming=True;
			LogZoomLevel = loge(MinZoom)/loge(MaxZoom);
			PC.SetFOV(PC.DefaultFOV / 2**(    (loge(MaxZoom)/loge(2)) * LogZoomLevel    )); 
			
			PC.ZoomLevel = (90 - PC.FOVAngle) / 88;
			PC.DesiredZoomLevel = PC.ZoomLevel;
			//2 to the power of what two must be raised to to get maxzoom.
			//therefore when zoom level is 0, the power is 0 = 2**0 = 1.
			//when zoom level is 1, the power is 2 ** log2(maxzoom) == maxzoom.
			//fix this!
			break;
	}
}

simulated final function EndScopeZoom()
{	
	local PlayerController PC;

	PC = PlayerController(InstigatorController);

	if (ZoomOutSound.Sound != None)	
		class'BUtil'.static.PlayFullSound(self, ZoomOutSound);
	
	OldZoomFOV = PC.FovAngle;

	if (ZoomType != ZT_Irons)
	{
		PC.SetFOV(PC.DefaultFOV);
		PC.bZooming = False;
	}
}

simulated function ChangeZoom (float Value)
{
	local PlayerController PC;
	local float OldZoomLevel;
	local float NewZoomLevel;
	local int SoughtFOV;
	
	PC = PlayerController(InstigatorController);
	if (PC == None /*|| PC.DesiredZoomLevel != PC.ZoomLevel*/)
		return;
		
	if (bInvertScope)
		Value*=-1;

	OldZoomLevel = PC.ZoomLevel;

	switch(ZoomType)
	{
		case ZT_Smooth:
			NewZoomLevel = FClamp(PC.ZoomLevel+Value, 0.05, (90-FullZoomFOV)/88);
			break;
		case ZT_Minimum:
			NewZoomLevel = FClamp(PC.ZoomLevel + Value * (  (90-FullZoomFOV)/88 - ((90-FullZoomFOV)/88 * MinFixedZoomLevel)   ), MinFixedZoomLevel, (90-FullZoomFOV)/88);
			break;
		case ZT_Logarithmic:
			Value *= 1f - (loge(MinZoom)/loge(MaxZoom));
			LogZoomLevel = FClamp(LogZoomLevel + Value, loge(MinZoom)/loge(MaxZoom), 1);
			SoughtFOV = PC.DefaultFOV / 2**(    (loge(MaxZoom)/loge(2)) * LogZoomLevel    ); 
			NewZoomLevel = (90 - SoughtFOV) / 88;
	}
	if (NewZoomLevel > OldZoomLevel)
		if (ZoomInSound.Sound != None)	class'BUtil'.static.PlayFullSound(self, ZoomInSound);
	else if (NewZoomLevel < OldZoomLevel)
		if (ZoomOutSound.Sound != None)	class'BUtil'.static.PlayFullSound(self, ZoomOutSound);
	
	PC.bZooming = true;
	
	if (NewZoomLevel == OldZoomLevel)
		return; //our zoom was max or min
		
	if (ZoomType == ZT_Logarithmic)
	{
		PC.SetFOV(SoughtFOV);
		PC.ZoomLevel = NewZoomLevel;
	}
	PC.DesiredZoomLevel = NewZoomLevel;
}

//------------------------------------------------------------------------
// Crosshair
//------------------------------------------------------------------------
simulated final function ScopeModifyCrosshair()
{
	local PlayerController PC;

	PC = PlayerController(InstigatorController);

	if ( PC.bBehindView )
		bNoCrosshairInScope = False;
	else
		bNoCrosshairInScope = default.bNoCrosshairInScope;
		
	//Take down normal crosshairs if the weapon has none in scope view
	if (bNoCrosshairInScope)
	{
		if (bOldCrosshairs && PC.myHud.bCrosshairShow)
		{
			bStandardCrosshairOff = True;
			PC.myHud.bCrosshairShow = False;
		}
	}

	// Show standard UT2004 crosshairs for any weapon without one in scope view
	else if (!PC.myHud.bCrosshairShow)
		PC.myHud.bCrosshairShow = True;
}

simulated final function ScopeRestoreCrosshair()
{
	if (bStandardCrosshairOff)
	{
		if (bOldCrosshairs)
		{
			bStandardCrosshairOff = False;
			PlayerController(InstigatorController).myHud.bCrosshairShow = True;	
		}
	}
	// Ballistic crosshair users: Hide crosshair if weapon has crosshair in scope
	else if (!bOldCrosshairs)
	{
		PlayerController(InstigatorController).myHud.bCrosshairShow = False;
	}
}

//------------------------------------------------------------------------
// Temporary scope drop (in response to long gun, etc)
//------------------------------------------------------------------------
// Tell the weapon lower and wait until anims are over to go back to scope/sight view
simulated function TemporaryScopeDown(optional float NewSightingTime, optional float StartPhase)
{
	if (!bScopeView && SightingState == SS_None)
		return;

    bScopeDesired = false;

	StopScopeView();
	if (StartPhase != 0.0)
		SightingPhase = StartPhase;
}

// anim has ended and we're still pending sight up so tell it to go back up
// This isn't used in Pro - it's counterintuitive
simulated function ScopeBackUp(optional float NewSightingTime, optional float StartPhase)
{
	if (StartPhase != 0.0)
		SightingPhase = StartPhase;
	PlayScopeUp();
}

//------------------------------------------------------------------------
// Rendering
//------------------------------------------------------------------------
simulated function RenderSightFX(Canvas Canvas)
{
	local coords C;

	if (SightFX != None)
	{
		C = GetBoneCoords(SightFXBone);
		SightFX.SetLocation(C.Origin);
		if (RenderedHand < 0)
			SightFX.SetRotation( OrthoRotation(C.XAxis, -C.YAxis, C.ZAxis) );
		else
			SightFX.SetRotation( OrthoRotation(C.XAxis, C.YAxis, C.ZAxis) );
		Canvas.DrawActor(SightFX, false, false, DisplayFOV);
	}
}

simulated event WeaponRenderOverlays( Canvas Canvas )
{
    local int m;
	local vector NewScale3D;
	local rotator CenteredRotation;
	local name AnimSeq;
	local float frame,rate;

    if (Instigator == None)
        return;

	if ( InstigatorController != None )
		Hand = Clamp(InstigatorController.Handedness, -1, 1);

    // draw muzzleflashes/smoke for all fire modes so idle state won't
    // cause emitters to just disappear
    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None)
        {
            FireMode[m].DrawMuzzleFlash(Canvas);
        }
    }

	if ( (OldMesh != None) && (bUseOldWeaponMesh != (OldMesh == Mesh)) )
	{
		GetAnimParams(0,AnimSeq,frame,rate);
		bInitOldMesh = true;
		if ( bUseOldWeaponMesh )
			LinkMesh(OldMesh);
		else
			LinkMesh(Default.Mesh);
		PlayAnim(AnimSeq,rate,0.0);
	}

    if ( (Hand != RenderedHand) || bInitOldMesh )
    {
		newScale3D = Default.DrawScale3D;
		if ( Hand != 0 )
			newScale3D.Y *= Hand;
		SetDrawScale3D(newScale3D);
		SetDrawScale(Default.DrawScale);
		CenteredRoll = Default.CenteredRoll;
		CenteredYaw = Default.CenteredYaw;
		CenteredOffsetY = Default.CenteredOffsetY;
		PlayerViewPivot = Default.PlayerViewPivot;
		SmallViewOffset = Default.SmallViewOffset;
		if ( SmallViewOffset == vect(0,0,0) )
			SmallViewOffset = Default.PlayerviewOffset;
		bInitOldMesh = false;
		if ( Default.SmallEffectOffset == vect(0,0,0) )
			SmallEffectOffset = EffectOffset + Default.PlayerViewOffset - SmallViewOffset;
		else
			SmallEffectOffset = Default.SmallEffectOffset;
		if ( Mesh == OldMesh )
		{
			SmallEffectOffset = EffectOffset + OldPlayerViewOffset - OldSmallViewOffset;
			PlayerViewPivot = OldPlayerViewPivot;
			SmallViewOffset = OldSmallViewOffset;
			if ( Hand != 0 )
			{
				PlayerViewPivot.Roll *= Hand;
				PlayerViewPivot.Yaw *= Hand;
			}
			CenteredRoll = OldCenteredRoll;
			CenteredYaw = OldCenteredYaw;
			CenteredOffsetY = OldCenteredOffsetY;
			SetDrawScale(OldDrawScale);
		}
		else if ( Hand == 0 )
		{
			PlayerViewPivot.Roll = Default.PlayerViewPivot.Roll;
			PlayerViewPivot.Yaw = Default.PlayerViewPivot.Yaw;
		}
		else
		{
			PlayerViewPivot.Roll = Default.PlayerViewPivot.Roll * Hand;
			PlayerViewPivot.Yaw = Default.PlayerViewPivot.Yaw * Hand;
		}
		RenderedHand = Hand;
	}
	if ( class'PlayerController'.Default.bSmallWeapons )
		PlayerViewOffset = SmallViewOffset;
	else if ( Mesh == OldMesh )
		PlayerViewOffset = OldPlayerViewOffset;
	else
		PlayerViewOffset = Default.PlayerViewOffset;
	if ( Hand == 0 )
		PlayerViewOffset.Y = CenteredOffsetY;
	else
		PlayerViewOffset.Y *= Hand;

    SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );
    if ( Hand == 0 )
    {
		CenteredRotation = Instigator.GetViewRotation();
		CenteredRotation.Yaw += CenteredYaw;
		CenteredRotation.Roll = CenteredRoll;
	    SetRotation(CenteredRotation);
    }
    else
	    SetRotation( Instigator.GetViewRotation() );

	PreDrawFPWeapon();	// Laurent -- Hook to override things before render (like rotation if using a staticmesh)

    bDrawingFirstPerson = true;
    Canvas.DrawActor(self, false, false, DisplayFOV);
    bDrawingFirstPerson = false;
	if ( Hand == 0 )
		PlayerViewOffset.Y = 0;
}

// Draw the scope view
simulated event RenderOverlays (Canvas C)
{
	local Vector X, Y, Z;
	
	if (!bScopeView)
	{
		WeaponRenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
		return;
	}
	if (!bNoMeshInScope)
	{
		WeaponRenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
	}
	else
	{
		GetViewAxes(X, Y, Z);
		if (BFireMode[0].MuzzleFlash != None)
		{
			BFireMode[0].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
			BFireMode[0].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
			C.DrawActor(BFireMode[0].MuzzleFlash, false, false, DisplayFOV);
		}
		if (BFireMode[1].MuzzleFlash != None)
		{
			BFireMode[1].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
			BFireMode[1].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
			C.DrawActor(BFireMode[1].MuzzleFlash, false, false, DisplayFOV);
		}
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	// Draw Scope View
    if (ScopeViewTex != None)
    {
		C.ColorModulate.W = 1;
   		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY);
		
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ScopeXScale))/2, C.SizeY, 0, 0, 1, 1024);

		C.SetPos((C.SizeX - (C.SizeY*ScopeXScale))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeY*ScopeXScale), C.SizeY, 0, 0, 1024, 1024);

		C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ScopeXScale))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ScopeXScale))/2, C.SizeY, 0, 0, 1, 1024);
	}
}

// Cut in before the gun is rendered and move it around if we're trying to use sight view...
simulated function PreDrawFPWeapon()
{
	if (SightingState != SS_None)
		PositionSights();

	AimComponent.OnPreDrawFPWeapon();
}

// Relocate the weapon according to sight view.
// Improved ironsights.
// SightZoomFactor used instead of FullZoomFOV.
simulated function PositionSights()
{
	local Vector SightPos, Offset, NewLoc, OldLoc;//, X,Y,Z;
	local PlayerController PC;

	//bots can't use sights
	PC=PlayerController(InstigatorController);

	if (SightBone != '')
		SightPos = GetBoneCoords(SightBone).Origin - Location;

	OldLoc = Instigator.Location + Instigator.CalcDrawOffset(self);
	Offset = SightOffset; Offset.X += float(Normalize(Instigator.GetViewRotation()).Pitch) / 4096;
	NewLoc = (PC.CalcViewLocation-(Instigator.WalkBob * (1-SightingPhase))) - (SightPos + ViewAlignedOffset(Offset));

	if (SightingPhase >= 1.0)
	{	// Weapon locked in sight view
		SetLocation(NewLoc);
		SetRotation(Instigator.GetViewRotation() + SightPivot);
		DisplayFOV = SightDisplayFOV;

		if (SightingState == SS_Raising)
		{
			AimComponent.OnADSViewStart();
			RcComponent.OnADSViewStart();
		}

		if (ZoomType == ZT_Irons)
			PC.DesiredFOV = PC.DefaultFOV * SightZoomFactor;
	}
	
	else if (SightingPhase <= 0.0)
	{	// Weapon completely lowered
		SetLocation(OldLoc);
		SetRotation(Instigator.GetViewRotation());
		DisplayFOV = default.DisplayFOV;
		PlayerController(InstigatorController).bZooming = False;

		if (SightingState == SS_Lowering)
		{
			AimComponent.OnADSViewEnd();
			RcComponent.OnADSViewEnd();
		}

		if(ZoomType == ZT_Irons)
		{
	        PC.DesiredFOV = PC.DefaultFOV;
			PlayerController(InstigatorController).SetFOV(PlayerController(InstigatorController).DefaultFOV);
			PlayerController(InstigatorController).bZooming = False;
		}
	}
	else
	{	// Gun is on the move...
		SetLocation(class'BUtil'.static.VSmerp(SightingPhase, OldLoc, NewLoc));
		SetRotation(Instigator.GetViewRotation() + SightPivot * SightingPhase);
		DisplayFOV = Smerp(SightingPhase, default.DisplayFOV, SightDisplayFOV);

		AimComponent.UpdateADSTransition(SightingPhase);
		RcComponent.UpdateADSTransition(SightingPhase);

		//Don't do this for scoped weapons
		if (ZoomType == ZT_Irons)
	        PC.DesiredFOV = PC.DefaultFOV * (Lerp(SightingPhase, 1, SightZoomFactor));
	}
}

//------------------------------------------------------------------------
// Update
//------------------------------------------------------------------------
// Interpolate our generated 'sighting anims' (the gun's movement to and from the sight view position)
simulated function TickSighting (float DT)
{
	if (bScopeView)
		CheckScope();

	if (!Instigator.IsFirstPerson() && SightingState != SS_None)
		PositionSights();
	
	switch (SightingState)
	{
	case SS_None:
	case SS_Active:
		return;
	case SS_Raising:
		// Raising gun to sight position
		if (SightingPhase < 1.0)
		{
			if ((bScopeDesired || bPendingSightUp) && CanUseSights())
				SightingPhase += DT/SightingTime;
			else
			{
				SightingState = SS_Lowering;
				InstigatorController.bRun = 0;
			}
		}
		else
		{	// Got all the way up. Now go to scope/sight view
			SightingPhase = 1.0;
			SightingState = SS_Active;
			ScopeUpAnimEnd();
		}
		break;
	case SS_Lowering:
		// Lowering gun from sight pos
		if (SightingPhase > 0.0)
		{
			if (bScopeDesired && CanUseSights())
				SightingState = SS_Raising;
			else
				SightingPhase -= DT/SightingTime;
		}
		else
		{	// Got all the way down. Tell the system our anim has ended...
			SightingPhase = 0.0;
			SightingState = SS_None;

			ScopeDownAnimEnd();
			DisplayFOV = default.DisplayFOV;
		}
		break;
	}
}

// Tell the client to exit scope view
simulated final function ClientScopeDown()	{	if (level.NetMode != NM_Client)	return;		StopScopeView();	}

simulated function bool WeaponCentered()
{
	return ( bSpectated || bScopeView || (Hand > 1) );
}

// Swap sighted offset and pivot for left handers
simulated function SetHand(float InHand)
{
	super.SetHand(InHand);
	if (Hand < 0)
	{
		SightOffset.Y = default.SightOffset.Y * -1;
		SightPivot.Roll = default.SightPivot.Roll * -1;
		SightPivot.Yaw = default.SightPivot.Yaw * -1;
	}
	else
	{
		SightOffset.Y = default.SightOffset.Y;
		SightPivot.Roll = default.SightPivot.Roll;
		SightPivot.Yaw = default.SightPivot.Yaw;
	}
}
//---------------------------------------------------------------------------
// END ADS HANDLING
//===========================================================================


//================================================================================
// KEY EVENTS
//
// This is the standard form of a key event pipeline. There are 8 functions covering all events and behavior related to
// a key on both client and server side.
// First the exec function is called on local machine. It would normally be used to call the server function. It could
// be used in subclasses to implement client side only features that need not interact with the server. The server
// function runs only on the server and should be used to do server side only stuff. The client function can be called
// from the server and is a handy way to get back to the client after the server has done its stuff. The Common function
// is not replcated and is useful for stuff that is common to both client and server. The Release functions mirror
// normal four, but should be used when a key is released.
// E.g. for reloading functions:
// Exec called when key pressed and calls Server. Server verifys that reloading is ok and runs some server reload stuff,
// the Client function and the Common function. Client function does some client reload stuff and calls Common function.
// Common function does commons stuff like set up timing, etc...
//================================================================================

//================================================================================
// WEAPON SPECIAL
//
// Weapon Special key event. Client side before server has any say. 
// Override for client only WS functions. Calls ServerWeaponSpecial.
//---------------------------------------------------------------------------
exec simulated function WeaponSpecial(optional byte i)
{ 
	WeaponSpecialImpl(i);
}

simulated function WeaponSpecialImpl(byte i)
{
	if(!Instigator.bNoWeaponFiring)	
		ServerWeaponSpecial(i);	
}

// Server side WS event. Override for server side WS funcs. ClientWeaponSpecial can be called from here.
function ServerWeaponSpecial(optional byte i);

// Client WS. This is the call back from server. Not called by default...
simulated function ClientWeaponSpecial(optional byte i);

// Actual implementation of WeaponSpecial. Stuff common to client and server here. Should be called from any of these. Not Called by default.
simulated function CommonWeaponSpecial(optional byte i);

// WeaponSpecial Key Released Event... Works the same as the press stuff...
exec simulated function WeaponSpecialRelease(optional byte i){ if(!Instigator.bNoWeaponFiring) ServerWeaponSpecialRelease(i); }
function ServerWeaponSpecialRelease(optional byte i);
simulated function ClientWeaponSpecialRelease(optional byte i);
simulated function CommonWeaponSpecialRelease(optional byte i);
//---------------------------------------------------------------------------
// END WEAPON SPECIAL
//===========================================================================


//===========================================================================
// WEAPON COCKING
//---------------------------------------------------------------------------
exec simulated function CockGun(optional byte Type)		{if (bNonCocking || ReloadState != RS_None || bPreventReload) return; ServerCockGun(Type); }
simulated function ClientCockGun (optional byte Type)	{ CommonCockGun(Type);							}
function ServerCockGun(optional byte Type)
{	
	if (bNonCocking || ReloadState != RS_None || bPreventReload) 
		return;
	bServerReloading=True; 
	ClientCockGun(Type); 
	CommonCockGun(Type);				
}

//This is run by AnimEnd() when reload or fire sequence finishes
//or by Timer() when BringUp time is finished
simulated function CommonCockGun(optional byte Type)
{
	local int m;

	if (bNonCocking || ReloadState == RS_Cocking || bPreventReload) //Azarael - G5 fix
		return;
	if (Role == ROLE_Authority)
	{
		bServerReloading=true;
		if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).CockingAnim != '')
			Instigator.SetAnimAction('CockGun');
	}
	ReloadState = RS_Cocking;
	PlayCocking(Type);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].CockingGun(Type);
}
//---------------------------------------------------------------------------
// END WEAPON COCKING
//===========================================================================

//===========================================================================
// MELEE ATTACKS
//---------------------------------------------------------------------------
exec simulated function MeleeHold()
{
	MeleeHoldImpl();
}

simulated function MeleeHoldImpl()
{
	if (MeleeFireMode == None || (ClientState != WS_ReadyToFire && ClientState != WS_Bringup) || (MeleeState != MS_None && MeleeState != MS_Strike))
		return;
		
	if (MeleeState == MS_Strike)
		MeleeState = MS_StrikePending;
	//Gun is firing. Set pending flag, AnimEnd will handle the rest.
	else if (IsFiring() || ClientState == WS_Bringup)
		MeleeState = MS_Pending;
	else
	{
		MeleeState = MS_Held;
		ReloadState = RS_None;
		MeleeFireMode.PlayPreFire();
		GunLength = 1;
		if (SprintControl != None && SprintControl.bSprinting)
			PlayerSprint(false);
		ServerMeleeHold();
	}
}

function AddSpeedModification(float value)
{
	if (value > 1f && SprintControl != None && SprintControl.bSprinting)
		PlayerSprint(false);

	PlayerSpeedFactor = FMin(PlayerSpeedFactor * value, value);

	UpdateSpeed();
}

function RemoveSpeedModification(float value)
{
	if (value > 1f && SprintControl != None && SprintControl.bSprinting)
		PlayerSprint(true);

	PlayerSpeedFactor = default.PlayerSpeedFactor;

	UpdateSpeed();
}

function UpdateSpeed()
{
	local float NewSpeed;
	
	NewSpeed = Instigator.default.GroundSpeed * PlayerSpeedFactor;
	if (ComboSpeed(xPawn(Instigator).CurrentCombo) != None)
		NewSpeed *= 1.4;
	if (Instigator.GroundSpeed != NewSpeed)
		Instigator.GroundSpeed = NewSpeed;
}

function ServerMeleeHold()
{
	//PlayerController(InstigatorController).ClientMessage("ServerMeleeHold");
	MeleeState = MS_Held;
	ReloadState = RS_None;
	bServerReloading=True; //lock the gun to prevent desynchronisation
	MeleeFireMode.HoldStartTime = Level.TimeSeconds;
	MeleeFireMode.PlayPreFire();
	GunLength = 1;
	AddSpeedModification(1.05);
	bPreventReload = True;
}

exec simulated function MeleeRelease()
{
	MeleeReleaseImpl();
}

simulated function MeleeReleaseImpl()
{
	if (MeleeFireMode == None || ClientState != WS_ReadyToFire || MeleeState == MS_None)
		return;
	switch(MeleeState)
	{
		case MS_Pending: 
			MeleeState = MS_None; 
			break;
		case MS_StrikePending: 
			MeleeState = MS_Strike; 
			break;
		case MS_Held:
			if (Role < Role_Authority)
			{
				MeleeState = MS_Strike;
				MeleeFireMode.PlayFiring();
				if (SprintControl != None && SprintControl.bSprinting)
					PlayerSprint(true);
			}
			ServerMeleeRelease();
			GunLength = default.GunLength;
			break;
	}
}

final function ServerMeleeRelease()
{
	//PlayerController(InstigatorController).ClientMessage("ServerMeleeRelease");
	MeleeState = MS_Strike;
	if (Instigator.IsLocallyControlled())
		MeleeFireMode.PlayFiring();
	else MeleeFireMode.ServerPlayFiring();
	MeleeFireMode.DoFireEffect();
	RemoveSpeedModification(1.15);
	GunLength = default.GunLength;
	//Trace, damage code
	//Fire delay
}

final function ApplyAttackFatigue()
{
	local float Penalty;
	
	if (BallisticMeleeFire(FireMode[1]) != None && (FireMode[1].IsFiring() || BallisticMeleeFire(FireMode[0]) == None))
		Penalty = BallisticMeleeFire(BFireMode[1]).FatiguePerStrike * 2.5;
	else Penalty = BallisticMeleeFire(BFireMode[0]).FatiguePerStrike * 2.5;
	
	ApplyBlockFatigue(Penalty);
}

final function ApplyBlockFatigue(float value)
{
	MeleeFatigue = FMin(1, MeleeFatigue + value);
	
	ClientApplyBlockFatigue(value);
}

simulated final function ClientApplyBlockFatigue(float value)
{
	MeleeFatigue = FMin(1, MeleeFatigue + value);
}

simulated final function bool IsHoldingMelee()
{
	if (BallisticMeleeFire(BFireMode[1]) != None && BFireMode[1].IsFiring())
		return true;
	
	if (MeleeState > MS_Pending)
		return true;

	return false;
}
//---------------------------------------------------------------------------
// END MELEE ATTACKS
//===========================================================================

simulated final function bool SprintActive()
{
	return (!BCRepClass.default.bNoJumpOffset && SprintControl != None && SprintControl.bSprinting);
}

//===========================================================================
// RELOADING
//
// Run on client, send call to server. It will send it back if reload is valid.
//---------------------------------------------------------------------------
exec simulated function Reload (optional byte i)
{
	if (ClientState == WS_ReadyToFire && ReloadState == RS_None) 
		ServerStartReload(i);	
}

//First this is run on the server
function ServerStartReload (optional byte i)
{
	local int m;

	if (bPreventReload)
		return;
		
	if (ReloadState != RS_None)
		return;
		
	if (MagAmmo >= default.MagAmmo)
	{
		if (bNeedCock)
			ServerCockGun(0);
		return;
	}
	
	if (Ammo[0].AmmoAmount < 1)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
		
	CommonStartReload(i);	//Server animation
	ClientStartReload(i);	//Client animation
}
//This is called by the server once it has decided that the reload is possible
//This is run on client by server
simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
		CommonStartReload(i);
}
// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (bShovelLoad)
		ReloadState = RS_StartShovel;
	else
		ReloadState = RS_PreClipOut;
	PlayReload();

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}
exec simulated function ReloadRelease(optional byte i);
function ServerReloadRelease(optional byte i);
simulated function ClientReloadRelease(optional byte i);
simulated function CommonReloadRelease(optional byte i);
//---------------------------------------------------------------------------
// END RELOADING
//===========================================================================

//===========================================================================
// FIRE MODE SWITCHING
//
// Request is sent to server to switch mode. 
// Server validates request and replicates to clientif switch was successful. 
// Each side then implements any necessary switching by itself.
//---------------------------------------------------------------------------
exec simulated function SwitchWeaponMode (optional byte ModeNum)	
{
	if (ModeNum == 0)
		ServerSwitchWeaponMode(255);
	else ServerSwitchWeaponMode(ModeNum-1);
}

// Cycle through the various weapon modes
function ServerSwitchWeaponMode (byte NewMode)
{
	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
	
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}

	if (!WeaponModes[NewMode].bUnavailable)
	{
		CommonSwitchWeaponMode(NewMode);
		ClientSwitchWeaponMode(CurrentWeaponMode);
		NetUpdateTime = Level.TimeSeconds - 1;
	}
}

simulated function CommonSwitchWeaponMode(byte NewMode)
{
	local int LastMode;

	if (Instigator == None)
		return;

	LastMode = CurrentWeaponMode;
	CurrentWeaponMode = NewMode;

	BFireMode[0].SwitchWeaponMode(CurrentWeaponMode);
	BFireMode[1].SwitchWeaponMode(CurrentWeaponMode);

	if (WeaponModes[LastMode].RecoilParamsIndex != WeaponModes[CurrentWeaponMode].RecoilParamsIndex)
	{
		ParamsClass.static.SetRecoilParams(self);
	}

	if (WeaponModes[LastMode].AimParamsIndex != WeaponModes[CurrentWeaponMode].AimParamsIndex)
	{
		ParamsClass.static.SetAimParams(self);
	}

	CheckBurstMode();

	if (ModeHandling == MR_Last && Instigator.IsLocallyControlled())
    {
        default.LastWeaponMode = CurrentWeaponMode;
    }
}

simulated function ClientSwitchWeaponMode (byte NewMode)
{
	if (Level.NetMode != NM_Client)
		return;

	CommonSwitchWeaponMode(NewMode);
}

simulated function CheckBurstMode()
{	
	// Azarael - This assumes that all firemodes implementing burst modify the primary fire alone.
	// To my knowledge, this is the case.
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_Burst")
	{
		BFireMode[0].bBurstMode = True;
		BFireMode[0].MaxBurst = WeaponModes[CurrentWeaponMode].Value;
	}
	
	else if(BFireMode[0].bBurstMode)
	{	
		BFireMode[0].bBurstMode = False;
	}
	
	RcComponent.DeclineDelay = CalculateBurstRecoilDelay(BFireMode[0].bBurstMode);

}

simulated function float CalculateBurstRecoilDelay(bool burst)
{
	if (burst)
	{
		return
			(BFireMode[0].FireRate * WeaponModes[CurrentWeaponMode].Value * (1f - BFireMode[0].BurstFireRateFactor)) // cooldown of burst
			+ (RcComponent.DeclineDelay - BFireMode[0].FireRate); // inherent delay, usually fire rate * 0.5
	}
	
	else
	{
		return RcComponent.DeclineDelay;
	}
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_FullAuto" || WeaponModes[CurrentWeaponMode].ModeID ~= "WM_None" || WeaponModes[CurrentWeaponMode].ModeID ~= "WM_Burst")
		return true;
	if (FireCount >= WeaponModes[CurrentWeaponMode].Value)
		return false;
	return true;
}
//---------------------------------------------------------------------------
// END FIRE MODE SWITCH
//===========================================================================

//===========================================================================
// DUAL WIELD
//---------------------------------------------------------------------------

// Base function for dual select key is to 'quick draw' the last dual wielded weapons.
// If there was no last pair, pick two handguns.
// If there is only one, pick it

// Go through chain and find the last handgun used. Make it pull the last slave or the best slave
// If there is no last, find the best handgun. Make it pull out the best slave
// If there are no handguns, don't do anything.

simulated function DoQuickDraw();

simulated function BallisticWeapon FindQuickDraw(BallisticWeapon CurrentChoice, float ChoiceRank)
{
    local Inventory Inv;
	local BallisticWeapon Best;

	for ( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
		if (BallisticWeapon(Inv) != None)
		{	Best = BallisticWeapon(Inv).FindQuickDraw(CurrentChoice, ChoiceRank);	break;	}

	if (Best == None)
		return CurrentChoice;
	else
		return Best;
}

exec simulated function DualSelect (optional class<Weapon> NewWeaponClass )
{
	local BallisticWeapon Best;
    local Inventory Inv;

	for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
	{
		if (BallisticWeapon(Inv) != None)
		{
			Best = BallisticWeapon(Inv).FindQuickDraw(None, 0);
			break;
		}
	}
	if (Best != None)
		Best.DoQuickDraw();
}
//---------------------------------------------------------------------------
// END DUAL WIELD
//===========================================================================

//---------------------------------------------------------------------------
// END KEY EVENT
//===========================================================================

// Big powerful cheat to give you all the ballistic weapons and some ammo of course
exec simulated function Reloaded()
{
	ServerReloaded();
}

final function ServerReloaded()
{
	local class<Weapon> Weap;
	local Inventory Inv;
	local int i;
	local array<CacheManager.WeaponRecord> Recs;
	

	if ((Level.Netmode != NM_Standalone && !Instigator.PlayerReplicationInfo.bAdmin)|| Instigator == None || Vehicle(Instigator) != None)
		return;

	class'CacheManager'.static.GetWeaponList(Recs);
	for (i=0;i<Recs.Length;i++)
	{
		if (!class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			continue;
		Weap = class<Weapon>(DynamicLoadObject(Recs[i].ClassName, class'Class'));
		if (Weap != None && ClassIsChildOf(Weap, class'BallisticWeapon'))
			Instigator.GiveWeapon(Recs[i].ClassName);
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	for(Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory)
		if (Weapon(Inv)!=None)
			Weapon(Inv).SuperMaxOutAmmo();
}

//Overwrites old HasAmmo() so that we can use our weapons when there is still ammo in the mag
simulated function bool HasAmmo()
{
	return (HasMagAmmo(255) || HasNonMagAmmo(255) || MeleeFireMode != None);	//This weapon is empty?
}
simulated function bool HasMagAmmo(byte Mode)
{
	if (!bNoMag)
	{
		if ((Mode == 255 || Mode == 0) && BFireMode[0] != None && BFireMode[0].bUseWeaponMag && MagAmmo >= FireMode[0].AmmoPerFire)
			return true;
		if ((Mode == 255 || Mode == 1) && BFireMode[1] != None && BFireMode[1].bUseWeaponMag && MagAmmo >= FireMode[1].AmmoPerFire)
			return true;
	}
	return false;
}

simulated function bool HasNonMagAmmo(byte Mode)
{
	if ((Mode == 255 || Mode == 0) && Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
		return true;
	if ((Mode == 255 || Mode == 1) && Ammo[1] != None && FireMode[1] != None && Ammo[1].AmmoAmount >= FireMode[1].AmmoPerFire)
		return true;
	return false;
}
simulated function bool HasAmmoLoaded(byte Mode)
{
	if (bNoMag)
		return HasNonMagAmmo(Mode);
	else
		return HasMagAmmo(Mode);
}

// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	if (bNoMag || (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false))
		ConsumeAmmo(Mode, Load, bAmountNeededIsMax);
	else
	{
		if (MagAmmo < Load)
			MagAmmo = 0;
		else
			MagAmmo -= Load;
	}
	return true;
}

// End Main Core functions ---------------------------------------------------------------------------------------------

// Misc and Barely changed old functions -------------------------------------------------------------------------------
// FIXME: Clean up this section!

final function string GetSpecialInfo (name InfoID)
{
	local int i;

	for(i=0;i<SpecialInfo.length;i++)
	{
		if (Specialinfo[i].ID == InfoID)
			return Specialinfo[i].Info;
	}
	return "";
}

final static function string StaticGetSpecialInfo (name InfoID)
{
	local int i;

	for(i=0;i<default.SpecialInfo.length;i++)
	{
		if (default.Specialinfo[i].ID == InfoID)
			return default.Specialinfo[i].Info;
	}
	return "";
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	if (Mode == 1)
		return default.FireModeClass[1].default.AmmoClass.default.PickupClass;
	else
		return default.FireModeClass[0].default.AmmoClass.default.PickupClass;
}

// Initialize and reset a lot of thing on bringup
simulated function BringUp(optional Weapon PrevWeapon)
{
	local int mode, i;
	local Inventory Inv;
	local float NewSpeed;
	
	// Set ambient sound when gun is held
	if (UsedAmbientSound != None)
		AmbientSound = UsedAmbientSound;

    if (SightFXClass!=None && Instigator.IsLocallyControlled() && Instigator.IsHumanControlled() && level.DetailMode == DM_SuperHigh && SightFX == None && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
		SightFX = Spawn(SightFXClass);
		if (SightFX != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(SightFX), DrawScale);
	}

	InstigatorController = Instigator.Controller;
	Instigator.bCountJumps = true;
	// Reset Reloading
	if (Role == ROLE_Authority)
		bServerReloading=false;
	bPreventReload=False;
	ReloadState = RS_None;
	// Reset Melee
	MeleeState = MS_None;

	if (PlayerSpeedFactor != default.PlayerSpeedFactor)
		PlayerSpeedFactor = default.PlayerSpeedFactor;

	// Link up with sprint control
	if (SprintControl == None)	{
		for (Inv=Instigator.Inventory;Inv!=None;Inv=Inv.Inventory)
			if (BCSprintControl(Inv) != None)	{
				SprintControl = BCSprintControl(Inv);		break;	}
	}

	AimComponent.OnWeaponSelected();

	Instigator.WalkingPct = WeaponParams.SightMoveSpeedFactor;

	if (Role == ROLE_Authority)
	{
		// If factor differs from previous wep, or no previous wep, set groundspeed anew
		if (BallisticWeapon(PrevWeapon) == None || BallisticWeapon(PrevWeapon).PlayerSpeedFactor != PlayerSpeedFactor)
		{
			NewSpeed = Instigator.default.GroundSpeed * PlayerSpeedFactor;

			if (SprintControl != None && SprintControl.bSprinting)
				NewSpeed *= SprintControl.SpeedFactor;

			if (ComboSpeed(xPawn(Instigator).CurrentCombo) != None)
				NewSpeed *= 1.4;

			if (Instigator.GroundSpeed != NewSpeed)
				Instigator.GroundSpeed = NewSpeed;
		}
		
		//Transfer over SpeedUp responsibility if we can
		if (BallisticWeapon(PrevWeapon) != None)
			BallisticWeapon(PrevWeapon).PlayerSpeedUp = False;
		PlayerSpeedUp = True;
	}	
	
	if (BallisticWeapon(PrevWeapon) != None)
		AimComponent.DisplaceEndTime = BallisticWeapon(PrevWeapon).AimComponent.DisplaceEndTime;
	
	// Dumber bots take longer to change weapons
	if (AIController(InstigatorController) != None && AIController(InstigatorController).Skill <= 4)
		BringUpTime = default.BringUpTime*(2-(AIController(InstigatorController).Skill/4));

	// Change certain skins to show team colors
	if (Instigator.PlayerReplicationInfo != None && Instigator.PlayerReplicationInfo.Team != None)
	{
		for (i=0;i<TeamSkins.Length;i++)
		{
			if (Instigator.PlayerReplicationInfo.Team.TeamIndex == 0)
			{
				if (TeamSkins[i].RedTex != None)
					Skins[TeamSkins[i].SkinNum]=TeamSkins[i].RedTex;
			}
			else if (TeamSkins[i].BlueTex != None)
				Skins[TeamSkins[i].SkinNum]=TeamSkins[i].BlueTex;
		}
	}
	if (PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
	{
		if (bOldCrosshairs)
			PlayerController(Instigator.Controller).MyHud.bCrosshairShow = PlayerController(Instigator.Controller).MyHud.default.bCrosshairShow;
		else
			PlayerController(Instigator.Controller).MyHud.bCrosshairShow = false;
	}

	// Old Stuff from weapon.uc
    if (ClientState == WS_Hidden)
    {
		if (BringUpSound.Sound != None)
			class'BUtil'.static.PlayFullSound(self, BringUpSound);
		ClientPlayForceFeedback(SelectForce);  // jdf

        if (Instigator.IsLocallyControlled())
        {
			if (bNeedCock && MagAmmo > 0 && HasAnim(CockSelectAnim)) 
				PlayAnim(CockSelectAnim, CockSelectAnimRate, 0.0);
            else if (HasAnim(SelectAnim))
                PlayAnim(SelectAnim, SelectAnimRate, 0.0);
		}
        ClientState = WS_BringUp;
	}
	if (bNeedCock && MagAmmo > 0 && HasAnim(CockSelectAnim)) 
		BringUpTime = CockingBringUpTime;
	else BringUpTime = default.BringUpTime;
	
    if (!IsInState('PendingClientWeaponSet'))
    	SetTimer(BringUpTime, false);
    else bPendingBringupTimer = True;
		
    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
	{
		if (FireMode[Mode] == None)
			continue;
		FireMode[Mode].bIsFiring = false;
		FireMode[Mode].HoldTime = 0.0;
		FireMode[Mode].bServerDelayStartFire = false;
		FireMode[Mode].bServerDelayStopFire = false;
		FireMode[Mode].bInstantStop = false;
	}
	   if ( (PrevWeapon != None) && PrevWeapon.HasAmmo() && !PrevWeapon.bNoVoluntarySwitch )
		OldWeapon = PrevWeapon;
	else
		OldWeapon = None;
}

//Azarael - Anti TCC compatible weapon zoom.
simulated function bool PutDown()
{
    local int Mode;

    if (ClientState == WS_BringUp || ClientState == WS_ReadyToFire)
    {
        if (Instigator.PendingWeapon != None && !Instigator.PendingWeapon.bForceSwitch)
        {
            for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
            {
                if (FireMode[Mode]!=None && FireMode[Mode].bFireOnRelease && FireMode[Mode].bIsFiring)
                    return false;
            }
        }

        if (Instigator.IsLocallyControlled())
        {
            for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
            {
                if (FireMode[Mode]!=None && FireMode[Mode].bIsFiring)
                    ClientStopFire(Mode);
            }

            if (ClientState != WS_BringUp && HasAnim(PutDownAnim))
                PlayAnim(PutDownAnim, PutDownAnimRate, 0.0);
        }
        ClientState = WS_PutDown;

		if (bScopeView)
			StopScopeView(true);

		if (ReloadState != RS_None)
		{
			if (level.NetMode == NM_Client)
				ServerStopReload();
			ReloadState = RS_None;
		}
		if (MeleeState != MS_None)
			MeleeState = MS_None;
		bPendingSightUp=false;
//		if (PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
		if (!bOldCrosshairs && (Instigator.PendingWeapon == None || BallisticWeapon(Instigator.PendingWeapon) == None) && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
			PlayerController(Instigator.Controller).MyHud.bCrosshairShow = PlayerController(Instigator.Controller).MyHud.default.bCrosshairShow;
		if (PutDownSound.Sound != None)
			class'BUtil'.static.PlayFullSound(self, PutDownSound);
        SetTimer(PutDownTime, false);
    }
    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
    {
		if (FireMode[Mode]==None)
			continue;
		FireMode[Mode].bServerDelayStartFire = false;
		FireMode[Mode].bServerDelayStopFire = false;
	}
    Instigator.AmbientSound = None;
	AmbientSound = None;
    OldWeapon = None;
    
    if(PlayerController(Instigator.Controller) != None)
		PlayerController(Instigator.Controller).bZooming = False;
		
    return true; // return false if preventing weapon switch
}

simulated function Weapon WeaponChange( byte F, bool bSilent )
{
    local Weapon newWeapon;

    if ( InventoryGroup == F )
    {
		if ( !HasAmmo() )
		{
			if (Inventory != None)
			{
                newWeapon = Inventory.WeaponChange(F,bSilent);
				if (newWeapon != None && newWeapon != Instigator.Weapon && newWeapon.HasAmmo())
					return newWeapon;
			}
            if ( !bSilent && (newWeapon == None) && Instigator.IsHumanControlled() )
                Instigator.ClientMessage( ItemName$MessageNoAmmo );
		}
		else
			return self;
    }
    else if ( Inventory == None )
        return None;
    else
        return Inventory.WeaponChange(F,bSilent);
}

// need to figure out modified rating based on enemy/tactical situation
simulated function float RateSelf()
{
    if ( !HasAmmo() )
        CurrentRating = -2;
	else if ( Instigator.Controller == None )
		return 0;
	else
	{
		CurrentRating = Instigator.Controller.RateWeapon(self);
		if (!bNoMag){
			if(!HasNonMagAmmo(255) && MagAmmo < default.MagAmmo / 4)
				CurrentRating /= (1+AIReloadTime);
//				CurrentRating = CurrentRating * 0.25;
			else if (MagAmmo <= 0)
				CurrentRating /= (2+AIReloadTime);
//				CurrentRating = FClamp(CurrentRating / (1+AIReloadTime), 2, CurrentRating);
		}
	}
	return CurrentRating;
}

function float GetAIRating()
{
	if (bNoMag)
		return AIRating;
	if (DiscourageReload())
		return AIRating * 0.25;
	return AIRating;
}

function bool DiscourageReload()
{
	return MagAmmo < 1 && AIController(Instigator.Controller).Enemy != None && (Level.TimeSeconds - AIController(Instigator.Controller).LastSeenTime < AIReloadTime || AmmoAmount(0) < 1);
}

// Makes a bot reload if they have the skill or its forced
// Allows clever bots to reload when they get the chance and dumb ones only when they have to
function bool BotReload(optional bool bForced)
{
	if (bForced || AIController(Instigator.Controller).Skill > Rand(5))
	{
		ServerStartReload();
		return true;
	}
	return false;
}

// Is reloading a good idea???
function bool BotShouldReload ()
{
	if ( (Level.TimeSeconds - AIController(Instigator.Controller).LastSeenTime > AIReloadTime + AIReloadTime * (MagAmmo/default.MagAmmo)) &&
		 (Level.TimeSeconds - Instigator.LastPainTime > AIReloadTime) )
		return true;
	return false;
}

// return false if out of range, can't see target, etc.
function bool CanAttack(Actor Other)
{
    local float Dist, CheckDist;
    local vector HitLocation, HitNormal,X,Y,Z, projStart;
    local actor HitActor;
    local int m;
	local bool bInstantHit;

    if ( (Instigator == None) || (Instigator.Controller == None) )
		return false;

	if (ReloadState != RS_None)
		return false;
		
	if (!bNoMag && (bNeedReload || MagAmmo < 1))
	{
		BotReload(true);
		return false;
	}
	
	if (!bNonCocking && bNeedCock && !bNeedReload && MagAmmo > 0)
	{
		CommonCockGun();
		return false;
	}

    // check that target is within range
    Dist = VSize(Instigator.Location - Other.Location);

    if (Dist > FireMode[0].MaxRange() && Dist > FireMode[1].MaxRange())
	{
		if (!bNoMag && BotShouldReload())
			BotReload();
        return false;
	}

    // check that can see target
    if (!Instigator.Controller.LineOfSightTo(Other))
	{
		if (!bNoMag && BotShouldReload())
			BotReload();
        return false;
	}

	// Skilled bots can conserve ammo by not firing when the spread is too high
	if ((Rand(6) < AIController(Instigator.Controller).Skill) && !RcComponent.BotShouldFire(Dist) )
		return false;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
		if (FireMode[m] == None)
			continue;
		if ( FireMode[m].bInstantHit )
			bInstantHit = true;
		else
		{
			CheckDist = FMax(CheckDist, 0.5 * FireMode[m].ProjectileClass.Default.Speed);
	        CheckDist = FMax(CheckDist, 300);
	        CheckDist = FMin(CheckDist, VSize(Other.Location - Location));
		}
	}
    // check that would hit target, and not a friendly
    GetAxes(GetPlayerAim(), X,Y,Z);
    projStart = GetFireStart(X,Y,Z);
    if ( bInstantHit )
        HitActor = Trace(HitLocation, HitNormal, Other.Location + Other.CollisionHeight * vect(0,0,0.8), projStart, true);
    else
    {
        // for non-instant hit, only check partial path (since others may move out of the way)
        HitActor = Trace(HitLocation, HitNormal,
                projStart + CheckDist * Normal(Other.Location + Other.CollisionHeight * vect(0,0,0.8) - Location),
                projStart, true);
    }

    if ( (HitActor == None) || (HitActor == Other) || (Pawn(HitActor) == None)
		|| (Pawn(HitActor).Controller == None) || !Instigator.Controller.SameTeamAs(Pawn(HitActor).Controller) )
        return true;

    return false;
}

function bool RecommendHeal(Bot B)
{
	local DestroyableObjective O;
	local Vehicle V;
	
	V = B.Squad.GetLinkVehicle(B);
	
	if ( (V != None)
		&& (VSize(Instigator.Location - V.Location) < 1.5 * FireMode[0].MaxRange())
		&& (V.Health < V.HealthMax) && (V.LinkHealMult > 0) )
		return true;

	if ( Vehicle(B.RouteGoal) != None && B.Enemy == None && VSize(Instigator.Location - B.RouteGoal.Location) < 1.5 * FireMode[0].MaxRange()
	     && Vehicle(B.RouteGoal).TeamLink(B.GetTeamNum()) )
		return true;

	O = DestroyableObjective(B.Squad.SquadObjective);
	if ( O != None && B.Enemy == None && O.TeamLink(B.GetTeamNum()) && O.Health < O.DamageCapacity
	     && VSize(Instigator.Location - O.Location) < 1.1 * FireMode[0].MaxRange() && B.LineOfSightTo(O) )
		return true;
		
	return false;
}

simulated function bool IsFiring() // called by pawn animation, mostly
{
    if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
        return (FireMode[0].IsFiring() || (FireMode[1] != None && FireMode[1].IsFiring()) || MeleeState > MS_Pending);

    return  ( ClientState == WS_ReadyToFire && (FireMode[0].IsFiring() || (FireMode[1] != None && FireMode[1].IsFiring())  || MeleeState > MS_Pending) );
}

simulated function bool ReadyToFire(int Mode)
{
    local int alt;

    if ( Mode == 0 )
        alt = 1;
    else
        alt = 0;

	if (FireMode[Mode] == None)
		return false;

    if ( (FireMode[alt] != FireMode[Mode] && FireMode[alt].bModeExclusive && FireMode[alt].bIsFiring) // block if other mode is firing or pending fire
		|| !FireMode[Mode].AllowFire() // block if this mode disallows fire
		|| (FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].PreFireTime) ) // block if pre fire time would not last until weapon is ready to fire again
    {
        return false;
    }

	return true;
}

function bool BotFire(bool bFinished, optional name FiringMode)
{
	if (ReloadState != RS_None)
		return false;

	if (!bNoMag && (bNeedReload || MagAmmo < 1))
		BotReload(true);
	else
		Super.BotFire(bFinished, FiringMode);
}

simulated function bool StartFire(int Mode)
{
    local int alt;

    if (!ReadyToFire(Mode))
        return false;

    if (Mode == 0)
        alt = 1;
    else
        alt = 0;

    FireMode[Mode].bIsFiring = true;
    FireMode[Mode].NextFireTime = Level.TimeSeconds + FireMode[Mode].PreFireTime;

    if (FireMode[alt] != None && FireMode[alt].bModeExclusive)
    {
        // prevents rapidly alternating fire modes
        FireMode[Mode].NextFireTime = FMax(FireMode[Mode].NextFireTime, FireMode[alt].NextFireTime);
    }

    if (Instigator.IsLocallyControlled())
    {
        if (FireMode[Mode].PreFireTime > 0.0 || FireMode[Mode].bFireOnRelease)
        {
            FireMode[Mode].PlayPreFire();
        }
        FireMode[Mode].FireCount = 0;
    }

    return true;
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None || class != W.Class)
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
    }
 	
   	else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;
    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
			W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

//Now adds initial ammo in all cases
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
    if ( FireMode[m] != None && FireMode[m].AmmoClass != None )
    {
		Ammo[m] = Ammunition(Instigator.FindInventoryType(FireMode[m].AmmoClass));
        if (Ammo[m] == None)
        {
            Ammo[m] = Spawn(FireMode[m].AmmoClass, instigator);
            Instigator.AddInventory(Ammo[m]);
        }
		//Dropped pickup, just add ammo
        if ((WP != None) && (WP.bDropped || WP.AmmoAmount[m] > 0))
			Ammo[m].AddAmmo(WP.AmmoAmount[m]);
		//else add initial complement

		else if (bJustSpawned && (WP==None || !WP.bDropped) && (m == 0 || FireMode[m].AmmoClass != FireMode[0].AmmoClass))
			Ammo[m].AddAmmo(Ammo[m].InitialAmount);
        Ammo[m].GotoState('');
	}
}

//Azarael - used in BallisticTurrets and by Loadout
function SetAmmoTo(int Amount, int m)
{
	if (Amount > Ammo[m].MaxAmmo || Amount < 0)
		return;
		
	Ammo[m].AmmoAmount = Amount;
}

simulated function ClientWeaponSet(bool bPossiblySwitch)
{
    local int Mode;

    Instigator = Pawn(Owner);

    bPendingSwitch = bPossiblySwitch;

    if( Instigator == None )
    {
        GotoState('PendingClientWeaponSet');
        return;
    }

    for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
    {
        if( FireModeClass[Mode] != None )
        {
            if(FireMode[Mode] == None )
            {
                GotoState('PendingClientWeaponSet');
                return;
            }
            
            else if (( FireMode[Mode].AmmoClass != None ) && ( Ammo[Mode] == None ) )
            {
                GotoState('PendingClientWeaponSet');
                return;
            }
        }
		if (FireMode[Mode] != None)
			FireMode[Mode].Instigator = Instigator;
			
		if (MeleeFireMode != None)
			MeleeFireMode.Instigator = Instigator;
    }

    ClientState = WS_Hidden;
    GotoState('Hidden');

    if( Level.NetMode == NM_DedicatedServer || !Instigator.IsHumanControlled() )
        return;
		
    // set up mode handling
	if (Instigator.IsLocallyControlled())
	{
		if (ModeHandling == MR_Last)
		{
			if(LastWeaponMode != CurrentWeaponMode && LastWeaponMode != 255)
				ServerSwitchWeaponMode(LastWeaponMode);
		}
	
		else if (ModeHandling == MR_SavedDefault)
		{
			if (SavedWeaponMode != CurrentWeaponMode && SavedWeaponMode != 255)
				ServerSwitchWeaponMode(SavedWeaponMode);
		}
	}

    // if this weapon was switched to while waiting for replication, switch to it now
    if( Instigator.Weapon == self || Instigator.PendingWeapon == self ) 
    {
        if (Instigator.PendingWeapon != None)
            Instigator.ChangedWeapon();
        else
            BringUp();
        return;
    }

    // don't allow switching if pending weapon is game-relevant and would block it (bombing run ball launcher)
    if( Instigator.PendingWeapon != None && Instigator.PendingWeapon.bForceSwitch ) 
        return;

    // if there is no active weapon, use this one
    // we don't want to do this in loadout - we want to set our desired weapon only
    if( Instigator.Weapon == None ) 
    {
        if (bDeferInitialSwitch)
        {
            bDeferInitialSwitch = false;
            return;
        }

        Instigator.PendingWeapon = self;
        Instigator.ChangedWeapon();
    }



    // otherwise, check if player would want to switch
    else if ( bPossiblySwitch && !Instigator.Weapon.IsFiring() ) 
    {
        // don't switch if player has it disabled
		if ( PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).bNeverSwitchOnPickup )
			return;

        // rate weapons against each other to determine if we should switch
        if ( Instigator.PendingWeapon != None )
        {
            if ( RateSelf() > Instigator.PendingWeapon.RateSelf() )
            {
                Instigator.PendingWeapon = self;
                Instigator.Weapon.PutDown();
            }
        }
        else if ( RateSelf() > Instigator.Weapon.RateSelf() )
        {
            Instigator.PendingWeapon = self;
            Instigator.Weapon.PutDown();
        }
    }
}

state PendingClientWeaponSet
{
    simulated function Timer()
    {
        if ( Pawn(Owner) != None )
            ClientWeaponSet(bPendingSwitch);
        if ( IsInState('PendingClientWeaponSet') )
			SetTimer(0.05, false);
		if (bPendingBringupTimer)
		{
			SetTimer(BringUpTime, false);
			bPendingBringupTimer=False;
		}
    }

    simulated function BeginState()
    {
        SetTimer(0.05, false);
    }

    simulated function EndState()
    {
    }
}

function bool HandlePickupQuery( pickup Item )
{
    local WeaponPickup wpu;
	local BallisticWeaponPickup BWP;

	if (class == Item.InventoryType)
    {
        wpu = WeaponPickup(Item);
        if (wpu != None)
            return !wpu.AllowRepeatPickup();
        else
            return false;
    }
	
	// prevent pickup of a weapon if we don't have enough space for it
	if (
            default.MaxInventoryCapacity > 0 && 
            AIController(InstigatorController) == None && 
            class<BallisticWeapon>(Item.InventoryType) != None && 
            (!bWT_Super && !class<BallisticWeapon>(Item.InventoryType).default.bWT_Super)
        )
	{
		BWP = BallisticWeaponPickup(Item);

		if (BWP != None)
		{
			BWP.DetectedInventorySize += ParamsClass.default.Params[0].InventorySize;

			if (BWP.DetectedInventorySize >= default.MaxInventoryCapacity)
			{
				BWP.DetectedInventorySize = 0;
				return true;
			}
		}
	}

    if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

simulated function Destroyed()
{
    local int m;

	AmbientSound = None;

	if (SightFX != None)
		SightFX.Destroy();

	if (Instigator != None)
	{
		if (PlayerSpeedUp)
		{
			Instigator.GroundSpeed = Instigator.default.GroundSpeed;
			if (SprintControl != None && SprintControl.bSprinting)
				Instigator.GroundSpeed *= SprintControl.SpeedFactor;
			PlayerSpeedUp=false;
		}
		
		if(Instigator.Controller != None && PlayerController(Instigator.Controller) != None)
		{
			PlayerController(Instigator.Controller).bZooming = False;
			PlayerController(Instigator.Controller).DesiredZoomLevel=0.0;
			
			if (PlayerController(Instigator.Controller).MyHud != None)
			{
				if (bStandardCrosshairOff)
					PlayerController(Instigator.Controller).MyHud.bCrosshairShow = True;
				else PlayerController(Instigator.Controller).MyHud.bCrosshairShow = PlayerController(Instigator.Controller).MyHud.default.bCrosshairShow;
				Instigator.Controller.bRun = 0;
			}
		}
	}

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
		if ( FireMode[m] != None )
			FireMode[m].DestroyEffects();
		if (Ammo[m] != None)
		{
		    if (Instigator == None || Instigator.Health < 1)
				Ammo[m].Destroy();
			Ammo[m] = None;
		}
	}
	
	//Actor references may cause us severe pain.
	//They MUST be cleaned up.
	if (MeleeFireMode != None)
	{
		MeleeFireMode.Weapon = None;
		MeleeFireMode.BW = None;
		MeleeFireMode.Instigator = None;
		MeleeFireMode.Level = None;
		MeleeFireMode.Owner = None;
		MeleeFireMode.DestroyEffects();
		Level.ObjectPool.FreeObject(MeleeFireMode);
		MeleeFireMode = None;
	}

    if (RwColMgr != None)
    {
        if (RewindActive)
            RwColMgr.RestoreCollisions();

        RwColMgr = None;
    }

	WeaponParams = None;

    if (RcComponent != None)
    {
	    RcComponent.Cleanup();
	    Level.ObjectPool.FreeObject(RcComponent);
	    RcComponent = None;
    }

    if (AimComponent != None)
    {
	    AimComponent.Cleanup();
	    Level.ObjectPool.FreeObject(AimComponent);
	    AimComponent = None;
    }
    
	Super(Inventory).Destroyed();
}

function HolderDied()
{
    local int m;

	if (AmbientSound != None)
		AmbientSound = None;
    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
		if (FireMode[m] == None)
			continue;
        if (FireMode[m].bIsFiring)
        {
            StopFire(m);
            if (FireMode[m].bFireOnRelease && (BFireMode[m] == None || BFireMode[m].bReleaseFireOnDie))
                FireMode[m].ModeDoFire();
        }
    }
}

simulated event StopFire(int Mode)
{
	if ( FireMode[Mode].bIsFiring )
	    FireMode[Mode].bInstantStop = true;
    if (Instigator.IsLocallyControlled() && !FireMode[Mode].bFireOnRelease)
        FireMode[Mode].PlayFireEnd();

    FireMode[Mode].bIsFiring = false;
    FireMode[Mode].StopFiring();
    if (!FireMode[Mode].bFireOnRelease)
        ZeroFlashCount(Mode);
}

function DropFrom(vector StartLocation)
{
    local int m;
	local Pickup Pickup;

    if (!bCanThrow)// || !HasAmmo())
        return;

	if (AmbientSound != None)
		AmbientSound = None;

    ClientWeaponThrown();

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None && FireMode[m].bIsFiring)
            StopFire(m);
    }

	if ( Instigator != None )
		DetachFromPawn(Instigator);

	Pickup = Spawn(PickupClass,self,, StartLocation);
	if ( Pickup != None )
	{
        if (Instigator.Health > 0)
            WeaponPickup(Pickup).bThrown = true;
    	Pickup.InitDroppedPickupFor(self);
	    Pickup.Velocity = Velocity;
    }
    Destroy();
}
simulated function ClientWeaponThrown()
{
    local int m;

    if (Instigator != None && PlayerController(Instigator.Controller) != None)
        PlayerController(Instigator.Controller).EndZoom();
    AmbientSound = None;
    Instigator.AmbientSound = None;

    if( Level.NetMode != NM_Client )
        return;

    Instigator.DeleteInventory(self);
    if (Instigator == None || Instigator.Health < 1)
    {
	    for (m = 0; m < NUM_FIRE_MODES; m++)
    	{
        	if (Ammo[m] != None)
            	Instigator.DeleteInventory(Ammo[m]);
    	}
    }
}

simulated function bool CanThrow()
{
	local int Mode;

    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
    {
        if ( FireMode[Mode].bFireOnRelease && FireMode[Mode].bIsFiring )
            return false;
        if ( FireMode[Mode].NextFireTime > Level.TimeSeconds)
			return false;
    }
    return (bCanThrow && (ClientState == WS_ReadyToFire || (Level.NetMode == NM_DedicatedServer) || (Level.NetMode == NM_ListenServer)));
}

simulated event Timer()
{
	local int Mode;

	AimComponent.Reaim(0.1);

    if (ClientState == WS_BringUp)
    {
		for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
			if (FireMode[Mode] != None)
				FireMode[Mode].InitEffects();
        PlayIdle();
        ClientState = WS_ReadyToFire;
		if (!bOldCrosshairs && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
			PlayerController(Instigator.Controller).MyHud.bCrosshairShow = false;
		if (bNeedCock)
		{
			if (BringUpTime == CockingBringUpTime)
				bNeedCock = False;
			else if (MagAmmo > 0)
				ServerCockGun();
		}
    }
    else if (ClientState == WS_PutDown)
    {
		if (SightFX != None)
		{
			SightFX.Destroy();
			SightFX=None;
		}

		if ( Instigator.PendingWeapon == None )
		{
			PlayIdle();
			ClientState = WS_ReadyToFire;
		}
		else
		{
			ClientState = WS_Hidden;
			Instigator.ChangedWeapon();
			for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
				if (FireMode[Mode] != None)
					FireMode[Mode].DestroyEffects();
		}
    }
	else if (Clientstate == WS_None && bNeedCock)
	{
		if (BringUpTime == CockingBringUpTime)
			bNeedCock = False;
		else if(Instigator.PendingWeapon == none)
		{
			if (MagAmmo > 0)
				CommonCockGun();
		}
	}
}

simulated function bool AllowWeapPrevUI()
{
	if (bScopeView && ZoomType != ZT_Irons)
		return false;
	return true;
}
simulated function bool AllowWeapNextUI()
{
	if (bScopeView && ZoomType != ZT_Irons)
		return false;
	return true;
}

/*
Old weapon switch behavior

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	// Adjust zoom level when in scope...
	if (bScopeView && CurrentWeapon == self && ZoomType > ZT_Fixed)
	{
		ChangeZoom(1/ZoomStages);
		return None;
	}

    if ( HasAmmo() )
    {
    	//First Weapon
        if ( (CurrentChoice == None) )
        {
            if ( CurrentWeapon != self )
                CurrentChoice = self;
        }
        
		//Most Previous Weapon Within Same Group
        else if ( InventoryGroup == CurrentWeapon.InventoryGroup )
        {
            if ( (GroupOffset < CurrentWeapon.GroupOffset)
                && ((CurrentChoice.InventoryGroup != InventoryGroup) || (GroupOffset > CurrentChoice.GroupOffset) || (CurrentWeapon.GroupOffset < CurrentChoice.GroupOffset)) )
                CurrentChoice = self;
		}
		
		//Closest Weapon Within Choice's Own Group
        else if ( InventoryGroup == CurrentChoice.InventoryGroup )
        {
            if ( GroupOffset > CurrentChoice.GroupOffset )
                CurrentChoice = self;
        }
        
        //Group Higher Than Choice
        //AND Group Lower Than Weapon
        //OR Choice Higher Than Weapon
        else if ( InventoryGroup > CurrentChoice.InventoryGroup && ( InventoryGroup < CurrentWeapon.InventoryGroup
                || CurrentChoice.InventoryGroup > CurrentWeapon.InventoryGroup ) )
                CurrentChoice = self;
        
        //Group Lower Than Weapon and Choice is Higher
        else if ( (CurrentChoice.InventoryGroup > CurrentWeapon.InventoryGroup)
                && (InventoryGroup < CurrentWeapon.InventoryGroup) )
            CurrentChoice = self;
            
        //Choice Equal to Weapon
        //Choice Offset Greater than Weapon Offset
        //Group Any Group Except That Of Choice And Weapon
        else if ( InventoryGroup != CurrentChoice.InventoryGroup &&
        		CurrentChoice.InventoryGroup == CurrentWeapon.InventoryGroup &&
        		CurrentChoice.GroupOffset > CurrentWeapon.GroupOffset)
            CurrentChoice = self;
    }
    
    if ( Inventory == None )
        return CurrentChoice;
    else
		return Inventory.PrevWeapon(CurrentChoice,CurrentWeapon);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	// Adjust zoom level when in scope...
	if (bScopeView && CurrentWeapon == self && ZoomType > ZT_Fixed)
	{
		ChangeZoom(-1/ZoomStages);
		return None;
	}

    if ( HasAmmo() )
    {
    	// - First Weapon Selected
        if ( (CurrentChoice == None) )
        {
            if ( CurrentWeapon != self )
                CurrentChoice = self;
        }
        
        //Next Weapon Within Weapon's Own Group
        else if ( InventoryGroup == CurrentWeapon.InventoryGroup )
        {
            if ( (GroupOffset > CurrentWeapon.GroupOffset)
                && ((CurrentChoice.InventoryGroup != InventoryGroup) || (GroupOffset < CurrentChoice.GroupOffset) || (CurrentWeapon.GroupOffset > CurrentChoice.GroupOffset)) )
                CurrentChoice = self;
        }
        
        //Closest Weapon Within Choice's Own Group
        else if ( InventoryGroup == CurrentChoice.InventoryGroup )
        {
			if ( GroupOffset < CurrentChoice.GroupOffset )
                CurrentChoice = self;
        }
		
		//Self < Choice && Weapon < Self || Choice < Weapon
        else if ( InventoryGroup < CurrentChoice.InventoryGroup && (InventoryGroup > CurrentWeapon.InventoryGroup
        || CurrentChoice.InventoryGroup < CurrentWeapon.InventoryGroup) )
                CurrentChoice = self;
        
        //Choice < Weapon < Self 
        else if ( (CurrentChoice.InventoryGroup < CurrentWeapon.InventoryGroup)
        && (InventoryGroup > CurrentWeapon.InventoryGroup) )
                CurrentChoice = self;
            

        //Choice Group = Weapon Group
        //Choice Offset < Weapon Offset
        //Self group not Weapon group
        else if ( InventoryGroup != CurrentChoice.InventoryGroup &&
        CurrentChoice.InventoryGroup == CurrentWeapon.InventoryGroup &&
        CurrentChoice.GroupOffset < CurrentWeapon.GroupOffset)
                CurrentChoice = self;
    }
    if ( Inventory == None )
        return CurrentChoice;
    else
        return Inventory.NextWeapon(CurrentChoice,CurrentWeapon);
}

*/

//New weapon switch behavior w/ StrCmp
simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	local int WepRelPos;  //This to curwep - negative if this weapon is before the currentweapon, positive if it's after
	local int ChoiceRelPos; //This to choice
	local int ChoiceWepRelPos; //Choice to curwep
	
	// Adjust zoom level when in scope...
	if (bScopeView && CurrentWeapon == self && ZoomType > ZT_Fixed)
	{
		ChangeZoom(1/ZoomStages);
		return None;
	}

    if ( HasAmmo() )
    {
    	//First Weapon
        if ( (CurrentChoice == None) )
        {
            if ( CurrentWeapon != self )
                CurrentChoice = self;
			if ( Inventory == None )
				return CurrentChoice;
			else
				return Inventory.PrevWeapon(CurrentChoice,CurrentWeapon);
        }
		
		if (Class != CurrentWeapon.Class)
		{
			WepRelPos = StrCmp(ItemName, CurrentWeapon.ItemName, 6, True);
			ChoiceRelPos = StrCmp(ItemName, CurrentChoice.ItemName, 6, True);
			ChoiceWepRelPos = StrCmp(CurrentChoice.ItemName, CurrentWeapon.ItemName, 6, True);
			
			//Most Previous Weapon Within Same Group
			if ( InventoryGroup == CurrentWeapon.InventoryGroup )
			{
				if ( WepRelPos < 0
					&& ((CurrentChoice.InventoryGroup != InventoryGroup) || ChoiceRelPos > 0 || ChoiceWepRelPos > 0) )
						CurrentChoice = self;
			}
			
			//Closest Weapon Within Choice's Own Group
			else if ( InventoryGroup == CurrentChoice.InventoryGroup )
			{
				if (ChoiceRelPos > 0 ) //comes after the choice
					CurrentChoice = self;
			}
			
			//Inv Group Higher Than Choice
			//AND Inv Group Lower Than Weapon
			//OR Choice Inv Group Higher Than Weapon Inv Group
			else if ( InventoryGroup > CurrentChoice.InventoryGroup && ( InventoryGroup < CurrentWeapon.InventoryGroup
					|| CurrentChoice.InventoryGroup > CurrentWeapon.InventoryGroup ) )
						CurrentChoice = self;
			
			//Group Lower Than Weapon and Choice is Higher
			else if ( (CurrentChoice.InventoryGroup > CurrentWeapon.InventoryGroup)
					&& (InventoryGroup < CurrentWeapon.InventoryGroup) )
					CurrentChoice = self;
				
			//Choice Equal to Weapon
			//Choice Offset Greater than Weapon Offset
			//Group Any Group Except That Of Choice And Weapon
			else if ( InventoryGroup != CurrentChoice.InventoryGroup &&
					CurrentChoice.InventoryGroup == CurrentWeapon.InventoryGroup &&
					ChoiceWepRelPos > 0)
					CurrentChoice = self;
		}
    }
    
    if ( Inventory == None )
        return CurrentChoice;
    else
		return Inventory.PrevWeapon(CurrentChoice,CurrentWeapon);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	local int WepRelPos;  //This to wep - -1 if this weapon is before the currentweapon, 1 if it's after
	local int ChoiceRelPos; //This to choice - -1 if this weapon is before the choice, 1 if it's after
	local int ChoiceWepRelPos; //Choice to wep - -1 if choice is before wep, 1 if it's after
	
	// Adjust zoom level when in scope...
	if (bScopeView && CurrentWeapon == self && ZoomType > ZT_Fixed)
	{
		ChangeZoom(-1/ZoomStages);
		return None;
	}

    if ( HasAmmo() )
    {
    	// - First Weapon Selected
        if ( (CurrentChoice == None) )
        {
            if ( CurrentWeapon != self )
                CurrentChoice = self;
			if ( Inventory == None )
				return CurrentChoice;
			else
				return Inventory.NextWeapon(CurrentChoice,CurrentWeapon);
        }
		
		if (Class != CurrentWeapon.Class)
		{		
			WepRelPos = StrCmp(ItemName, CurrentWeapon.ItemName, 6, True);
			ChoiceRelPos = StrCmp(ItemName, CurrentChoice.ItemName, 6, True);
			ChoiceWepRelPos = StrCmp(CurrentChoice.ItemName, CurrentWeapon.ItemName, 6, True);
			
			//Next Weapon Within Weapon's Own Group
			if ( InventoryGroup == CurrentWeapon.InventoryGroup )
			{
				if ( WepRelPos > 0
					&& ((CurrentChoice.InventoryGroup != InventoryGroup) || ChoiceRelPos < 0|| ChoiceWepRelPos < 0) )
					CurrentChoice = self;
			}
			
			//Closest Weapon Within Choice's Own Group
			else if ( InventoryGroup == CurrentChoice.InventoryGroup )
			{
				if (ChoiceRelPos < 0 )
					CurrentChoice = self;
			}
			
			//Self < Choice && Weapon < Self || Choice < Weapon
			else if ( InventoryGroup < CurrentChoice.InventoryGroup && (InventoryGroup > CurrentWeapon.InventoryGroup
			|| CurrentChoice.InventoryGroup < CurrentWeapon.InventoryGroup) )
					CurrentChoice = self;
			
			//Choice < Weapon < Self 
			else if ( (CurrentChoice.InventoryGroup < CurrentWeapon.InventoryGroup)
			&& (InventoryGroup > CurrentWeapon.InventoryGroup) )
					CurrentChoice = self;
				
			//Choice Group = Weapon Group
			//Choice Offset < Weapon Offset
			//Self group not Weapon group
			else if ( InventoryGroup != CurrentChoice.InventoryGroup &&
			CurrentChoice.InventoryGroup == CurrentWeapon.InventoryGroup &&
			ChoiceWepRelPos < 0)
			CurrentChoice = self;
		}
    }
    if ( Inventory == None )
        return CurrentChoice;
    else
        return Inventory.NextWeapon(CurrentChoice,CurrentWeapon);
}

// Obsolete since new attachement system
simulated function IncrementFlashCount(int Mode){}
simulated function ZeroFlashCount(int Mode) {}

// End of misc stuff ---------------------------------------------------------------------------------------------------

// The Aiming system ---------------------------------------------------------------------------------------------------

// Receive aim info from server
simulated final function ReceiveNetAim(float Yaw, float Pitch, float Time, float oChaos, float nChaos)
{
	if (!bUseNetAim || Role == ROLE_Authority)
		return;

	AimComponent.ReceiveNetAim(Yaw, Pitch, Time, oChaos, nChaos);
}

// Send the random values used for recoil to the client so he'll have the same recoil effect
final function SendNetRecoil()
{
	ReceiveNetRecoil(RcComponent.GetRecoilXRand() * 255, RcComponent.GetRecoilYRand() * 255, RcComponent.GetRecoil() );
}

// Receive random values for recoil from the server
// DC 110313
simulated final function ReceiveNetRecoil(byte XRand, byte YRand, float RecAmp)
{
	if (!bUseNetAim || Role == ROLE_Authority)
		return;

	RcComponent.ReceiveNetRecoil(XRand, YRand, RecAmp);
}

// End Net Stuff <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

// Core functions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//Using OffsetAdjustTime

simulated final function bool IsDisplaced()
{
	return AimComponent.IsDisplaced();
}



simulated final function OnDisplaceStart()
{
	if (bScopeView)
		TemporaryScopeDown();
}

simulated final function OnDisplaceEnd()
{
	if (bPendingSightUp && SightingState < SS_Raising)
		ScopeBackUp();
}

final function ServerReaim(float deltaTime)
{
	AimComponent.Reaim(deltaTime);
	AimComponent.ForceReaim();
}

// Azarael - Zeros aim over TimeMod
// for ADS support
simulated final function ZeroAim (float TimeMod)
{
	if (bAimDisabled)
		return;
		
	if (!bUseNetAim)
		AimComponent.ZeroAim(TimeMod);

	ServerZeroAim(TimeMod);
}

final function ServerZeroAim (float TimeMod)
{
	AimComponent.ZeroAim(TimeMod);
}

simulated final function Rotator GetAimPivot()
{
	return AimComponent.GetAimPivot();
}

simulated final function Rotator CalcFutureAim(float ExtraTime, bool bIgnoreViewAim)
{
	return AimComponent.CalcFutureAim(ExtraTime, bIgnoreViewAim);
}

simulated final function Rotator GetRecoilPivot()
{
	return RcComponent.GetWeaponPivot();
}

simulated final function Rotator GetFireRot()
{
	return GetAimPivot() + RcComponent.GetWeaponPivot();
}

simulated final function Vector GetFireDir()
{
	return Vector(GetFireRot());
}

simulated final function Rotator GetBasePlayerView()
{
	return GetPlayerAim() - AimComponent.GetViewPivot() - RcComponent.GetViewPivot();
}

// Rotate weapon and view according to aim
simulated function ApplyAimRotation()
{
	ApplyAimToView();
	PlayerViewPivot = default.PlayerViewPivot + (GetAimPivot() + GetRecoilPivot()) * (DisplayFOV / Instigator.Controller.FovAngle);
}

// Rotates the player's view according to Aim
// Split into recoil and aim to accomodate no view decline
simulated function ApplyAimToView()
{
	local Rotator AimPivotDelta, RecoilPivotDelta;

	//DC 110313
	if (Instigator.Controller == None || AIController(Instigator.Controller) != None || !Instigator.IsLocallyControlled())
		return;

	RecoilPivotDelta 	= RcComponent.CalcViewPivotDelta();
	AimPivotDelta  		= AimComponent.CalcViewPivotDelta();

	if (RcComponent.ShouldUpdateView())
		Instigator.SetViewRotation(Instigator.Controller.Rotation + AimPivotDelta + RecoilPivotDelta);
	else 
		Instigator.SetViewRotation(Instigator.Controller.Rotation + AimPivotDelta);
}

simulated final function byte GetAimParamsIndex()
{
	return WeaponModes[CurrentWeaponMode].AimParamsIndex;
}

// End Core <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

// Quick Access to aiming aystem output >>>>>>>>>>>>

//Firemodes use this to convert the portion of ChaosAimSpread not used for movement-related shenanigans
simulated function float GetConeInaccuracy()
{
	if (bAimDisabled)
		return 0;

	return AimComponent.CalcConeInaccuracy();
}

// Should return where the player is aiming this gun. Override this to point the gun in a wierd direction (e.g: Auto Tracking)
// To make WeaponFire code skip normal AdjustAim and use this, set bUseSpecialAim to true
simulated function Rotator GetPlayerAim(optional bool bFire)
{
	if (Instigator != None)
		return Instigator.GetViewRotation();

	else if (Owner != None)
		return Owner.Rotation;
	else
		return Rotation;
}
// End Access functions <<<<<<<<<<<<<<<<<<<<<<<<<<<<

// Some input events and similar >>>>>>>>>>>>>>>>>>>

// Aim goes bad when player takes damage
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local class<BallisticDamageType> BDT;
    local float DisplaceDuration;
	
	if (InstigatedBy != None && InstigatedBy.Controller != None && InstigatedBy.Controller.SameTeamAs(InstigatorController))
		return;
	
	if (bBerserk)
		Damage *= 0.75;
	
	BDT = class<BallisticDamageType>(DamageType);
	
	if (BDT != None && BDT.static.Displaces() && Damage >= BDT.default.AimDisplacementDamageThreshold)
    {
        DisplaceDuration = BDT.default.AimDisplacementDuration;

        if (BDT.static.ScalingDisplace())
            DisplaceDuration *= float(Damage) / float(BDT.default.AimDisplacementDamageThreshold);

         AimComponent.DisplaceAim(DisplaceDuration);	
    }			
		
	if (AimKnockScale == 0)
		return;

	AimComponent.ApplyDamageFactor(Damage);
}

final simulated final function ClientDisplaceAim(float Duration)
{
	if (Level.NetMode != NM_Client)
		return;
	AimComponent.DisplaceAim(Duration);
}

simulated function ClientPlayerDamaged(int Damage)
{
	if (Level.NetMode != NM_Client)
		return;
	AimComponent.ApplyDamageFactor(Damage);
}

simulated function OnWeaponDisplaced()
{
	local int m;
	
	if (bScopeView)
		StopScopeView();
		
	for (m = 0; m < NUM_FIRE_MODES; m++)
	{
		if (FireMode[m].bIsFiring)
			StopFire(m);
	}

	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).StaggerAnim != '')
        Instigator.SetAnimAction('Stagger');
}

// Do stuff when player sprints or jumps
// Azarael - workaround for Reloaded cheat
// Skips all Ammo and inactive Weapons
function OwnerEvent(name EventName)
{
	local Inventory Inv;
	
	if (Instigator.Weapon == Self)
	{
		if(EventName == 'Dodged' && !AimComponent.PendingForcedReaim() && Instigator.IsA('BallisticPawn'))
		{
			ClientDodged();
			AimComponent.OnPlayerJumped();
			NextCheckScopeTime = Level.TimeSeconds + 0.5;
		}
		else if ((EventName == 'Jumped' || EventName == 'Dodged') && !BCRepClass.default.bNoJumpOffset && !AimComponent.PendingForcedReaim())
		{
			AimComponent.OnPlayerJumped();
		}
	}
		
	for (Inv = Inventory; Inv != None; Inv = Inv.Inventory)
	{
		if (Ammunition(Inv) != None)
			continue;
		if (Weapon(Inv) != None && Inv != Instigator.Weapon)
			continue;

		break;
	}
	
	if (Inv != None)
		Inv.OwnerEvent(EventName);
}

simulated function PlayerSprint (bool bSprinting)
{
	if (BCRepClass.default.bNoJumpOffset)
		return;

	if (bScopeView && Instigator.IsLocallyControlled())
		StopScopeView();

	if (bAimDisabled)
		return;

	AimComponent.OnPlayerSprint();
}

//Hold scope when dodging
simulated function ClientDodged()
{
	if (Level.NetMode != NM_Client)
		return;

	if(bScopeView)
		NextCheckScopeTime = Level.TimeSeconds + 0.75;

	AimComponent.OnPlayerJumped();
}

simulated function ClientJumped()
{
	if (Level.NetMode != NM_Client)
		return;

	if(bScopeView)
		NextCheckScopeTime = Level.TimeSeconds + 1;

	AimComponent.OnPlayerJumped();
}

//====================================================================================
// RECOIL
//
// Mostly moved to the RecoilComponent class. 
//------------------------------------------------------------------------------------
simulated function AddRecoil(float Recoil, float FireChaos, optional byte Mode)
{
	RcComponent.AddRecoil(Recoil, Mode);
	AimComponent.AddFireChaos(FireChaos);

	if (ROLE == ROLE_Authority && bUseNetAim)
		SendNetRecoil();
}

simulated function float GetFireChaos()
{
	return AimComponent.GetFireChaos();
}

simulated function AddFireChaos(float chaos)
{
	AimComponent.AddFireChaos(chaos);
}

simulated final function byte GetRecoilParamsIndex()
{
	return WeaponModes[CurrentWeaponMode].RecoilParamsIndex;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// OnRecoilParamsChanged
//
// Called whenever the RecoilComponent is asked to recalculate, either 
// explicitly or when its basic parameters are changed.
//
// If this function has been called, any modifications applied on top of 
// the recoil component's basic parameters (such as suppressor, berserk etc) 
// have been removed and must be reapplied.
//
// Mod authors should override this function and check which of their 
// modifications still apply, then reapply them from here, as is done 
// for berserk below.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated function OnRecoilParamsChanged()
{
	if (bBerserk)
		UpdateBerserkRecoil();
}
//------------------------------------------------------------------------------------
// END RECOIL
//====================================================================================

//====================================================================================
// Turrets
//====================================================================================

// These can be called when a turret undeploys and gives this weapon. Override in sub-classes to add some functionality
function InitWeaponFromTurret(BallisticTurret Turret);
simulated function ClientInitWeaponFromTurret(BallisticTurret Turret);
function InitTurretWeapon(BallisticTurret Turret);

// End input functions <<<<<<<<<<<<<<<<<<<<<<<<<<<<<

// End Aiming ----------------------------------------------------------------------------------------------------------

// Rendering and HUD functions -----------------------------------------------------------------------------------------

// Put the mag ammo on the HUD instead of normal ammo
simulated function GetAmmoCount(out float MaxAmmoPrimary, out float CurAmmoPrimary)
{
	if ( Ammo[0] == None )
		return;

	if (bNoMag)
	{
		MaxAmmoPrimary = Ammo[0].MaxAmmo;
		CurAmmoPrimary = Ammo[0].AmmoAmount;
	}
	else
	{
		MaxAmmoPrimary = default.MagAmmo;
		CurAmmoPrimary = MagAmmo;
	}
}

simulated final static function Font GetFontSizeIndex(Canvas C, int FontSize)
{
    if ( C.ClipX >= 512 )
		FontSize++;
	if ( C.ClipX >= 640 )
		FontSize++;
	if ( C.ClipX >= 800 )
		FontSize++;
	if ( C.ClipX >= 1024 )
		FontSize++;
	if ( C.ClipX >= 1280 )
		FontSize++;
	if ( C.ClipX >= 1600 )
		FontSize++;

	return class'HudBase'.static.LoadFontStatic(Clamp( 8-FontSize, 0, 8));
}

simulated function string GetHUDAmmoText(int Mode)
{
	if (Ammo[Mode] != None)
		return string(Ammo[Mode].AmmoAmount);
	return "";
}

//Draw special weapon info on the hud
simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;

	Super.NewDrawWeaponInfo (C, YPos);
	
	DrawCrosshairs(C);
	
	if (bSkipDrawWeaponInfo)
		return;

	ScaleFactor = C.ClipX / 1600;
	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		Temp = GetHUDAmmoText(1);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 130 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
	}
	
	// This is pretty damn disgusting, but the weapon seems to be the only way we can draw extra info on the HUD
	// Would be nice if someone could have a HUD function called along the inventory chain
	if (SprintControl != None && SprintControl.Stamina < SprintControl.MaxStamina)
	{
		SprintFactor = SprintControl.Stamina / SprintControl.MaxStamina;
		C.CurX = C.OrgX  + 5    * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 330  * ScaleFactor * class'HUD'.default.HudScale;
		if (SprintFactor < 0.2)
			C.SetDrawColor(255, 0, 0);
		else if (SprintFactor < 0.5)
			C.SetDrawColor(64, 128, 255);
		else
			C.SetDrawColor(0, 0, 255);
		C.DrawTile(Texture'Engine.MenuWhite', 200 * ScaleFactor * class'HUD'.default.HudScale * SprintFactor, 30 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	}
}

//Draws simple crosshairs to accurately describe hipfire at any FOV and resolution.
simulated function DrawCrosshairs(canvas C)
{
	local float			ScaleFactor;
	local float 		ShortBound, LongBound;
	local float 		OffsetAdjustment;
	local Color 		SavedDrawColor;

	ScaleFactor = C.ClipX / 1600;
	
	// Draw weapon specific Crosshairs
	if (bOldCrosshairs || PlayerController(Instigator.Controller) == None || (Instigator.IsFirstPerson() && bScopeView))
		return;
		
	if (!bNoMag && MagAmmo == 0)
	{
		SavedDrawColor = MagEmptyColor;
		SavedDrawColor.A = class'HUD'.default.CrosshairColor.A;
	}
	
	else if (bNeedCock)
	{
		SavedDrawColor = CockingColor;
		SavedDrawColor.A = class'HUD'.default.CrosshairColor.A;
	}

	else SavedDrawColor = class'HUD'.default.CrosshairColor;
	
	C.DrawColor = SavedDrawColor;
	
	ShortBound = 2;
	LongBound= 10;
	
	if (!bScopeView)
		OffsetAdjustment = AimComponent.CalcCrosshairOffset(C);
	
	//black
	//hor
	C.SetDrawColor(0,0,0,SavedDrawColor.A);
	
	if (!bScopeView)
	{
		C.SetPos((C.ClipX / 2) - (LongBound + OffsetAdjustment+1), (C.ClipY/2) - (ShortBound/2+1));
		C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound+2, ShortBound+2);
		
		C.SetPos((C.ClipX / 2) + OffsetAdjustment -1, (C.ClipY/2) - (ShortBound/2+1));
		C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound+2, ShortBound+2);
		
		//ver
		C.SetPos((C.ClipX / 2) - (ShortBound/2+1), (C.ClipY/2) - (LongBound + OffsetAdjustment+1));
		C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound+2, LongBound+2);
		
		C.SetPos((C.ClipX / 2) - (Shortbound/2+1), (C.ClipY/2) + OffsetAdjustment-1);
		C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound+2, LongBound+2);
		
		//centre square
		if (bDrawCrosshairDot)
		{
			C.DrawColor.A = SavedDrawColor.A;
			C.SetPos(C.ClipX / 2 - 2, C.ClipY/2 - 2);
			C.DrawTileStretched(Texture'Engine.WhiteTexture', 4, 4);
		}
	}
	
	//green
	C.DrawColor = SavedDrawColor;
	
	if (!bScopeView)
	{
		//hor
		C.SetPos((C.ClipX / 2) - (LongBound + OffsetAdjustment), (C.ClipY/2) - (ShortBound/2));
		C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound, ShortBound);
		
		C.SetPos((C.ClipX / 2) + OffsetAdjustment, (C.ClipY/2) - (ShortBound/2));
		C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound, ShortBound);
		
		//ver
		C.SetPos((C.ClipX / 2) - (ShortBound/2), (C.ClipY/2) - (LongBound + OffsetAdjustment));
		C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, LongBound);
		
		C.SetPos((C.ClipX / 2) - (Shortbound/2), (C.ClipY/2) + OffsetAdjustment);
		C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, LongBound);
		
		if (bDrawCrosshairDot)
		{
			C.DrawColor.A = SavedDrawColor.A;
			C.SetPos(C.ClipX / 2 - 1, C.ClipY/2 - 1);
			C.DrawTileStretched(Texture'Engine.WhiteTexture', 2, 2);
		}
	}
	
	C.SetDrawColor(255, 255, 255, 255);
}
// End render stuff ----------------------------------------------------------------------------------------------------

// Targeted hurt radius moved here to avoid crashing

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, optional Pawn ExcludedPawn )
{
	local actor target;
	local float damageScale, dist;
	local vector dir;
    local UnlaggedPawnCollision col;

	if( bHurtEntry ) //not handled well...
		return;

	bHurtEntry = true;
	
	foreach VisibleCollidingActors( class 'Actor', target, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if
            ( 
                (target != self) && 
                (target.Role == ROLE_Authority) && 
                FluidSurfaceInfo(target) == None && 
                target != ExcludedPawn
            )
		{
            col = UnlaggedPawnCollision(target);

            if (col != None && col.UnlaggedPawn == ExcludedPawn)
                continue;

			dir = target.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - target.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				target,
				damageScale * DamageAmount,
				Instigator,
				target.Location - 0.5 * (target.CollisionHeight + target.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	bHurtEntry = false;
}

exec simulated final function ScaleScope(float X)
{
	ScopeXScale = X;
	SaveConfig();
}

exec simulated final function SetDefaultMode()
{
	SavedWeaponMode = CurrentWeaponMode;
	Instigator.ClientMessage("Default mode for"@ItemName@"is now"@WeaponModes[SavedWeaponMode].ModeName$".");
	SaveConfig();
}

exec simulated final function ClearDefaultMode()
{
	SavedWeaponMode = default.CurrentWeaponMode;
	Instigator.ClientMessage("Cleared default mode for"@ItemName$".");
	SaveConfig();
}

exec simulated final function GetDefaultMode()
{
	if (SavedWeaponMode == 255)
		Instigator.ClientMessage("No mode saved for "@ItemName$".");
	else 	Instigator.ClientMessage("Default mode for"@ItemName$":"@WeaponModes[SavedWeaponMode].ModeName$".");
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

simulated function vector GetEffectStart()
{
    // 1st person
    if (Instigator.IsFirstPerson())
    {
        if ( WeaponCentered() )
			return CenteredEffectStart();
			
		return ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 32);
    }
    // 3rd person
    else
    {
        return (Instigator.Location +
            Instigator.EyeHeight*Vect(0,0,0.5) +
            Vector(Instigator.Rotation) * 40.0);
    }
}

//===========================================================================
//
// Debug stuff --------------------------------------------------------------------------------------------------
//
//===========================================================================

simulated function DebugMessage(coerce string message)
{
	if (PlayerController(Instigator.Controller) != None)
	{
		if (Role == ROLE_Authority)
			PlayerController(Instigator.Controller).ClientMessage("SERVER:"@message);
		else
			PlayerController(Instigator.Controller).ClientMessage("CLIENT:"@message);
	}
}

exec function AlignHelp() { Instigator.ClientMessage("BWBrassOff[X,Y,Z]; BWCenteredOffset; BWPlayerOffset[X,Y,Z]; BWDisplayFOV; BWDrawScale; BWSightOffset[X,Y,Z];"); }
// These ca be used to align the BrassOffset during the game
exec function BWBrassOffX (float V)	{	BFireMode[0].BrassOffset.X = V;		BrassMessage();	}
exec function BWBrassOffY (float V)	{	BFireMode[0].BrassOffset.Y = V;		BrassMessage();	}
exec function BWBrassOffZ (float V)	{	BFireMode[0].BrassOffset.Z = V;		BrassMessage();	}
function BrassMessage ()	{	Instigator.ClientMessage("BrassOffset is "$BFireMode[0].BrassOffset);	}

// These are to align the 1st person weapon itself
exec function BWCenteredOffset (float f)	{	CenteredOffsetY = f;	default.CenteredOffsetY = f;	Instigator.ClientMessage("CenteredOffset: Y"$CenteredOffsetY);	}

exec function BWPlayerOffsetX (float f) {	PlayerViewOffset.X = f;	default.PlayerViewOffset.X = f;	RVMessage();	}
exec function BWPlayerOffsetY (float f) {	PlayerViewOffset.Y = f;	default.PlayerViewOffset.Y = f;	RVMessage();	}
exec function BWPlayerOffsetZ (float f) {	PlayerViewOffset.Z = f;	default.PlayerViewOffset.Z = f;	RVMessage();	}

exec function BWDisplayFOV (float f) {	DisplayFov = f;			default.DisplayFov = f;			RVMessage();	}
exec function BWDrawScale (float f) {	SetDrawScale (F);										RVMessage();	}

function RVMessage (){	Instigator.ClientMessage("PlayerViewOffset: X: "$PlayerViewOffset.X$", Y: "$PlayerViewOffset.Y$", Z: "$PlayerViewOffset.Z$", Scale: "$DrawScale$", FOV: "$DisplayFov);	}

exec function BWSightOffsetX (float f) {	SightOffset.X = f;	default.SightOffset.X = f;	SVMessage();	}
exec function BWSightOffsetY (float f) {	SightOffset.Y = f;	default.SightOffset.Y = f;	SVMessage();	}
exec function BWSightOffsetZ (float f) {	SightOffset.Z = f;	default.SightOffset.Z = f;	SVMessage();	}

function SVMessage (){	Instigator.ClientMessage("SightOffset: X: "$SightOffset.X$", Y: "$SightOffset.Y$", Z: "$SightOffset.Z$", Scale: "$DrawScale$", Sight Display FOV: "$SightDisplayFov);	}

delegate DumpHead(array<CacheManager.WeaponRecord> Recs);
delegate DumpLine(class<BallisticWeapon> Weap, int Line);
delegate DumpTail(array<CacheManager.WeaponRecord> Recs);
function DumpClassWeapInfo ()
{
	local class<BallisticWeapon> Weap;
	local int i, j;
	local array<CacheManager.WeaponRecord> Recs;

	if (level.NetMode != NM_Standalone)
		return;
	class'CacheManager'.static.GetWeaponList(Recs);
	DumpHead(Recs);
	for (i=0;i<Recs.Length;i++)
	{
		if (!class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			continue;
		Weap = class<BallisticWeapon>(DynamicLoadObject(Recs[i].ClassName, class'Class'));
		if (Weap != None)
		{
			DumpLine(Weap, j);
			j++;
		}
	}
	class'BC_WeaponInfoCache'.static.EndSession();
	DumpTail(Recs);
}

delegate DumpIHead();
delegate DumpILine(BallisticWeapon Weap, int Line);
delegate DumpITail(int Count);
function DumpInvWeapInfo ()
{
	local Inventory Inv;
	local int i;

	if (level.NetMode != NM_Standalone)
		return;

	DumpIHead();
	for (Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory)
		if (BallisticWeapon(Inv) != None)
		{
			DumpILine(BallisticWeapon(Inv), i);
			i++;
		}
	DumpITail(i);
}
// This dumps to the log all the playerviewpivot and other stuff that can be changed with the RV# commands
exec function DumpRVInfo ()	{
	DumpIHead = DumpRVHead; DumpILine = DumpRVLine;	DumpITail = DumpRVTail; DumpInvWeapInfo ();	}
function DumpRVHead()	{
	local string s; s = "Dumping Review stuff for equiped weapons:"; log(s);	Instigator.ClientMessage(s);	}
function DumpRVLine(BallisticWeapon Weap, int Line)	{
	log(Line$" "$Weap.ItemName$"::PlayerViewOffset "$Weap.PlayerViewOffset$", DisplayFov "$Weap.DisplayFov$", DrawScale "$Weap.DrawScale$", CenteredOffsetY "$Weap.CenteredOffsetY);	}
function DumpRVTail(int Count)	{
	local string s; s = "Review stuff for "$Count$" weapons:"; log(s);	Instigator.ClientMessage(s);	}
/*
exec function DumpRVInfo ()	{
	DumpHead = DumpRVHead; DumpLine = DumpRVLine;	DumpTail = None; DumpClassWeapInfo ();	}
function DumpRVHead(array<CacheManager.WeaponRecord> Recs)	{
	local string s; s = "Dumping Review stuff: "$Recs.length$" Weapons found."; log(s);	Instigator.ClientMessage(s);	}
function DumpRVLine(class<BallisticWeapon> Weap, int Line)	{
	log(Line$" "$Weap.default.ItemName$"::PlayerViewOffset "$Weap.default.PlayerViewOffset$", DisplayFov "$Weap.default.DisplayFov$", DrawScale "$Weap.default.DrawScale$", CenteredOffsetY "$Weap.default.CenteredOffsetY);	}
*/
// This dumps to the log all the Sight alignments stuff. Use 'Set' in the consol to change things, then dump with this.
exec function DumpSightInfo ()	{
	DumpHead = DumpSightHead; DumpLine = DumpSightLine;	DumpTail = None; DumpClassWeapInfo ();	}
function DumpSightHead(array<CacheManager.WeaponRecord> Recs)	{
	local string s; s = "Dumping Sight stuff: "$Recs.length$" Weapons found."; log(s);	Instigator.ClientMessage(s);	}
function DumpSightLine(class<BallisticWeapon> Weap, int Line)	{
	log(Line$" "$Weap.default.ItemName$"::SightOffset "$Weap.default.SightOffset$", SightPivot "$Weap.default.SightPivot$", SightDisplayFOV "$Weap.default.SightDisplayFOV$", SightBone "$Weap.default.SightBone$", FullZoomFOV "$Weap.default.FullZoomFOV);	}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
    local string s;

	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(255,128,0);
    s = "Ballistic Weapon: ReloadState: ";
	Switch( ReloadState )
	{
	   	case RS_None: s=s$"None"; break;
    	case RS_PreClipOut: s=s$"PreClipOut"; break;
		case RS_PreClipIn: s=s$"PreClipIn"; break;
 		case RS_PostClipIn: s=s$"PostClipIn"; break;
		case RS_StartShovel: s=s$"StartShovel"; break;
		case RS_Shovel: s=s$"Shovel"; break;
		case RS_PostShellIn: s=s$"PostShellIn"; break;
		case RS_EndShovel: s=s$"EndShovel"; break;
		case RS_Cocking: s=s$"Cocking"; break;
	}
	s $= " MeleeState: ";
	Switch(MeleeState)
	{
		case MS_None: s $= "None"; break;
		case MS_Pending: s $= "Pending"; break;
		case MS_Held: s $= "Held"; break;
		case MS_Strike: s $= "Striking"; break;
		case MS_StrikePending: s $= "Striking, Pending"; break;
	}
	s = s $ ", MagAmmo: "$MagAmmo $ ", WeaponMode: "$WeaponModes[CurrentWeaponMode].ModeName $ ", FireCount: "$FireCount;
	Canvas.DrawText(s);
    YPos += YL;
    Canvas.SetPos(4,YPos);

	Canvas.DrawText("bNeedCock: "$bNeedCock$", bNeedReload: "$bNeedReload$", bPreventReload: "$bPreventReload$", bServerReloading: "$bServerReloading);
    YPos += YL;
	Canvas.SetPos(4,YPos);

	RcComponent.DrawDebug(Canvas);
    YPos += YL;
	Canvas.SetPos(4,YPos);
	
	AimComponent.DrawDebug(Canvas);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}
// End debug -----------------------------------------------------------------------------------------------------------

simulated final function bool HasSecondaryAmmo()
{
    return (Ammo[1] != None) && (Ammo[1] != Ammo[0]);
}

simulated final function ClientWeaponReloaded()
{
	bNeedReload=False;
}

static function String GetManual()
{
	local String S;
	
	S = class'GUIComponent'.static.MakeColorCode(default.HeaderColor)$"Description"$class'GUIComponent'.static.MakeColorCode(default.TextColor)$"|";
	S $= default.Description$"||";
	
	if (default.ManualLines.Length < 3)
		return S;
	
	S $= class'GUIComponent'.static.MakeColorCode(default.HeaderColor)$"Primary Fire"$class'GUIComponent'.static.MakeColorCode(default.TextColor)$"|";
	S $= default.ManualLines[0]$"||";
	
	S $= class'GUIComponent'.static.MakeColorCode(default.HeaderColor)$"Alt Fire"$class'GUIComponent'.static.MakeColorCode(default.TextColor)$"|";
	S $= default.ManualLines[1]$"||";
	
	S $= class'GUIComponent'.static.MakeColorCode(default.HeaderColor)$"Additional Information"$class'GUIComponent'.static.MakeColorCode(default.TextColor)$"|";
	S $= default.ManualLines[2];
	return S;
}

static function String GetShortManual()
{
	local String S;
	
	if (default.ManualLines.Length < 3)
		return "No information available.";
	
	S = class'GUIComponent'.static.MakeColorCode(default.HeaderColor)$"Primary Fire"$class'GUIComponent'.static.MakeColorCode(default.TextColor)$"|";
	S $= default.ManualLines[0]$"||";
	
	S $= class'GUIComponent'.static.MakeColorCode(default.HeaderColor)$"Alt Fire"$class'GUIComponent'.static.MakeColorCode(default.TextColor)$"|";
	S $= default.ManualLines[1]$"||";
	
	S $= class'GUIComponent'.static.MakeColorCode(default.HeaderColor)$"Additional Information"$class'GUIComponent'.static.MakeColorCode(default.TextColor)$"|";
	S $= default.ManualLines[2];
	return S;
}

defaultproperties
{
     AIReloadTime=2.000000
     BigIconCoords=(Y1=48,X2=511,Y2=212)
     bAllowWeaponInfoOverride=True
     IdleTweenTime=0.200000
     SightFXBone="tip"
     BCRepClass=Class'BCoreProV55.BCReplicationInfo'
     HeaderColor=(B=50,G=50,R=255)
     TextColor=(G=175,R=255)
     SpecialInfo(0)=(Id="EvoDefs",Info="0.0;10.0;0.5;50.0;0.2;0.2;0.1")
	 
     BringUpSound=(Volume=0.500000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Volume=0.500000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	 
	 MagAmmo=30
	 
	 CockAnim="Cock"
	 CockAnimRate=1.000000
     CockSelectAnim="PulloutFancy"
     CockSound=(Volume=0.500000,Radius=64.000000,Pitch=1.000000,bAtten=True)
	 
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
	 ReloadEmptyAnim="ReloadEmpty"
	 
	 StartShovelAnimRate=1.000000
	 EndShovelAnimRate=1.000000
	 
     ClipHitSound=(Volume=0.500000,Radius=64.000000,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=0.900000
     ShovelIncrement=1
     bPlayThirdPersonReload=True
	 
     FireAnimCutThreshold=0.600000
     WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
     WeaponModes(1)=(ModeName="Burst",ModeID="WM_Burst",Value=3.000000)
     WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=2
     LastWeaponMode=255
	 SavedWeaponMode=255

     NetInventoryGroup=255
	 
     bUseSights=True
     ScopeXScale=1.000000
     FullZoomFOV=80.000000
     SightZoomFactor=0.78
     SightOffset=(Z=2.500000)
     SightDisplayFOV=30.000000
	 SightingTime=0.350000
     MinFixedZoomLevel=0.050000
     MinZoom=1.000000
     MaxZoom=2.000000
     ZoomStages=2
	 
     SMuzzleFlashOffset=(X=25.000000,Z=-15.000000)
     MagEmptyColor=(B=50,G=50,R=255,A=255)
     CockingColor=(B=50,G=175,R=255,A=255)
     GunLength=64.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)
     bUseNetAim=True
	 
	 ScopeHandling=SH_Default
     SelectAnim="Pullout"
     PutDownAnim="putaway"
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000
     PutDownTime=0.300000
     BringUpTime=0.300000
     bNoAmmoInstances=False
     DisplayFOV=60.000000
     Priority=2
     CenteredOffsetY=0.000000
     CenteredRoll=500
     CustomCrosshair=7
     BobDamping=1.700000
     ItemName="BallisticWeapon"
     LightPeriod=3
     AmbientGlow=12
     TransientSoundVolume=0.500000
}
