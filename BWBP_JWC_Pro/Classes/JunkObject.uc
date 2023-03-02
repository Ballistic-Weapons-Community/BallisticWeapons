//=============================================================================
// JunkObject.
//
// JunkObjects hold all the info needed to define the appearance and behaviour
// of a single junk weapon. These settings affect the 1st person weapon, the
// 3rd person attachment, pickups, anims, firemodes, AI, Sounds, Blocking, etc.
//
// JunkObjects are created during the game and also hold some internal info
// during their use.
//
// JOs also have lots of functions that can be used to extend or skip the
// default implementation of a certain feature or behaviour. When using a JO
// function to override something, returning true will tell the system to
// not do the default stuff, while false will let it go ahead. This way, a
// function can be used to just change something extra.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkObject extends Info config(BWBP_JWC_Pro) exportstructs;

// Which hands are used
enum EHandStyle
{
	HS_OneHanded,
	HS_TwoHanded
};
// The different possible grip styles for the junk hands
enum EGripStyle
{
	GS_Average,
	GS_Small,
	GS_Large,
	GS_Ball,
	GS_Bowl,
	GS_Axe,
	GS_Thin,
	GS_Crowbar,
	GS_2x4,
	GS_Capacitor,
	GS_IcePick,
	GS_DualAverage,
	GS_DualBig
};
// All the possible anim styles for the junk hands
enum EAnimStyle
{
	AS_Average,
	AS_Light,
	AS_Heavy,
	AS_Loose,	//Wide
	AS_Bowl,	//Swing
	AS_Ball,	//Throw
	AS_Stabber,	//Stab
	AS_DualAverage,
	AS_DualBig,
	AS_DualPoke
};

// Properties that affect first person junk appearance
//var(Display)StaticMesh		StaticMesh;			// StaticMesh to use for display of weapon in hand
//var(Display)mesh				Mesh;				// Mesh used if no StaticMesh specified
//var(Display)float				DrawScale;			// DrawScale of in hand weapon (multiplied by weapon/hand drawscale)
var(Display)vector				HandOffset;			// Extra offset added to Weapon's PlayerViewOffset
var(Display)rotator				HandPivot;			// Extra rotation added to Weapon's PlayerViewPivot
var(Display)class<Actor>		JunkActorClass;		// Class of actor to use for in hand JunkActor
var(Display)float				HandFOV;			// Display FOV for hands and JunkActor
var(Display)float				HandScale;			// Scale for weapon hands (junk drawscale is multiplied by this)
// Properties that affect junk pickup appearance
var(Pickup) StaticMesh			PickupMesh;			// StaticMesh to use for pickup
//var(Pickup) int					CullDistance;		// General CullDistance. Used for pickups, etc... FIXME!!!
var(Pickup)	float				PickupDrawScale;	// DrawScale of Pickup
var(Pickup)	Sound				PickupSound;		// Sound to use for pickup
var(Pickup)	rotator				SpawnPivot;			// Rotational orientation of pickups (to make it look right lying on the ground)
var(Pickup)	vector				SpawnOffset;		// Offset of pickup (use to move closer/further from ground, forward/back and left/right)
var(Pickup)	vector				PickupPrePivot;		// FIXME
var(Pickup) localized string	PickupMessage;		// Message to show when getting this junk

// Properties that affect the thrid person weapon attachment actor
var(ThirdPerson) class<InventoryAttachment> ThirdPersonActorClass; //Class for ThirdPersonActor
var(ThirdPerson) float			ThirdPersonDrawScale;//Drawscale for ThridPersonActor
var(ThirdPerson) StaticMesh		ThirdPersonMesh;	// SM to use for ThirdPersonActor
var(ThirdPerson) vector			ThirdPersonOffset;	// FIXME, Test this out
var(ThirdPerson) rotator		ThirdPersonPivot;	// Relative rotation of ThirdPersonActor
var(ThirdPerson) bool			ThirdPersonHeavy;	// Use heavy anims for player pawn
// Properties that affect weapon hands and interaction with the hands
var(Hands) 	EHandStyle			HandStyle;			// One or Two handed...
var(Hands) 	EGripStyle			RightGripStyle;		// Style of grip to use for right hand
var(Hands) 	EGripStyle			LeftGripStyle;		// Style of grip to use for left hand (for two handed weapons)
var(Hands)	float				PullOutRate;		// AnimRate for pullout anim
var(Hands)	EAnimStyle			PullOutStyle;		// PullOut anim to use
var(Hands)	EAnimStyle			IdleStyle;			// Idle anim to use
var(Hands)	float				PutAwayRate;		// AnimRate for Putaway anim
var(Hands)	EAnimStyle			PutAwayStyle;		// Anim to use for putaway
var(Hands)	name				AttachBone;			// Bone to attach in hand weapon actor to
var(Hands)	vector				AttachOffset;		// Locational offset for in hand JunkActor
var(Hands)	rotator				AttachPivot;		// Rotational pivot added to in hand JunkActor
// Properties that set how this junk is used as a weapon
var(Attack)	bool				bCanThrow;			// It can be thrown and uses ThrowFireInfo
var(Attack)	bool				bCanMelee;			// It can Melee and uses MeleeAFireInfo, FIXME
var(Attack)	bool				bCanHoldMelee;		// It can do Secondary Melee and uses MeleeBFireInfo
var(Attack) bool				bSwapSecondary;		// Use Throw for secondary by default. Held Melee is triggered by the thi fire method
var(Attack) int					Ammo;				// Amount of ammo this junk has
var(Attack) int					MaxAmmo;			// Max amount of ammo this junk can have
var(Attack) export editinline JunkMeleeFireInfo MeleeAFireInfo;	// Info for first generic melee fire
var(Attack) export editinline JunkMeleeFireInfo MeleeBFireInfo;	// Info for second generic melee fire
var(Attack) export editinline JunkThrowFireInfo ThrowFireInfo;	// Info for generic throw fire

var(Misc)	BUtil.FullSound		SelectSound;		// Sound to play when changin to this junk
var(Misc)	string				FriendlyName;		// Display name for this junk
var(Misc)	byte				InventoryGroup;		//

var(Misc)	float				MeleeRating;		// Rating of this weapon for melee use (Used by AI, etc)
var(Misc)	float				RangeRating;		// Rating of this weapon for ranged use (Used by AI, etc)

var()		class<JunkObject>	MorphedJunk;		// Junk this thing can turn into in some situations
var			class<JunkObject>	MorphSource;		// The junk that this is derived from (when morphing into this junk)

var()		config bool			bListed;			// This is in the list of junk to used by mutators
var()		/*config */float	SpawnWeight;		// A weight for spawning priority. >1 = More Common, <1 = Less Common, 2 = double common, etc

var()		bool				bCanBlock;			// Can be used to block enemy attacks
var()		bool				bDisallowShield;	// Do not allow the use of a shield with this junk
var()		float				BlockRate;			// How quickly this junk can recover from a block and block again.
var()		byte				BlockSurface;		// The surface type of this junk. Used when spawning effects for things that hit this junk.

var() int						PainThreshold;		// FIXME
var() int						NoUseThreshold;

var()		name				BlockLeftAnim;		// Anim when blocking hit to the left
var()		name				BlockRightAnim;		// Anim when blocking hit to the right
var()		name				BlockStartAnim;		// Anim when moving into blocked pose
var()		name				BlockEndAnim;		// Anim when leaving blocked mode
var()		name				BlockIdleAnim;		// Anim when idle while still blocking


// Internal vars set at runtime. Most people wont need to worry about these...
var			JunkWeapon			Weapon;				// The current weapon using this junk
var			JunkObject			NextJunk;			// Next JunkObject in the JunkWeapon's JunkChain
var			float				RenderedHand;		// The last handedness that was rendered for this junk

// Functions that can be used to hook into and/or override default behaviour of junk
// Returning true with overrides prevent default stuff from happening in most cases

// FIXME
static function bool DoHitEffects(Actor Other, vector HitLocation, vector HitNormal, vector StartTrace, int HitSurf);
// Override or Add special changes to the ThirdPersonActor
static function bool SetThirdPersonDisplay(Actor ThirdPersonActor);
// Undo special changes to the ThirdPersonActor
static function RestoreThirdPersonDisplay(Actor ThirdPersonActor);
// FIXME
simulated function JunkReload();
// FIXME
function bool HitActor (Actor Other, JunkMeleeFireInfo FireInfo);
// FIXME
function bool BlockDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType);
//FIXME
function bool SendFireEffect(WeaponFire Fire, JunkFireInfo FI, Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc);
function bool DoDamage(WeaponFire Fire, JunkFireInfo FI, Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount);
function bool SendDamageEffect(WeaponFire Fire, JunkFireInfo FI, int OldHealth, Actor Other, float Damage, vector HitLocation, vector Dir, class<DamageType> DT);

// Junk is about to be changed to something else, this can be used to cleanup this junk before change
simulated function Uninitialize (JunkObject NewJunkObject);
// Chance to Initialize stuff when Junk is set to this object. Return true to skip default init code
simulated function bool Initialize (JunkObject OldJunkObject);
// Called after Initialization of junk. Chance to change or add extra stuff at initialization
simulated function PostInitialize (Actor JunkActor);

//FIXME
static function InitProjectile (Projectile Proj);
//FIXME
function bool BlockHit( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType);

// Override or add more junk draw stuff
simulated function bool JunkRenderOverlays (Canvas Canvas);
// Chance to draw extra weapon info on HUD
simulated function DrawWeaponInfo (Canvas Canvas);
// Change pickup properties
static function bool InitializePickup (Pickup Pickup);
// FIXME
static function bool HandleHitWall (JunkProjectile P, vector HitNormal, Actor Wall);
// Undo changes to RangedFire
function bool RangeFireRestore(JunkThrowFireInfo FI, JunkObject NewJunk);
// Override or Add special changes to RangedFire
function bool RangeFireAssign(JunkThrowFireInfo FI, JunkObject OldJunk);
// Undo changes to MeleeFire
function bool MeleeFireRestore(JunkMeleeFireInfo FI, JunkObject NewJunk);
// Override or Add special changes to MeleeFire
function bool MeleeFireAssign(JunkMeleeFireInfo FI, JunkObject NewJunk);
// Chance to change things when ranged fire is switched back to Throw and melee fire gets props from MeleeA
function bool SwitchToRanged(JunkRangedFire F, JunkMeleeFireInfo FI);
// Chance to change things when ranged fire is switched to MeleeB and melee fire gets props from MeleeB
function bool SwitchToMelee(JunkRangedFire F, JunkMeleeFireInfo FI);

//FIXME
function InitDefaults()
{
	Ammo=default.Ammo;
}

defaultproperties
{
     JunkActorClass=Class'BWBP_JWC_Pro.JunkActor'
     HandFOV=60.000000
     HandScale=1.000000
     PickupDrawScale=1.000000
     SpawnPivot=(Roll=16384)
     PickupPrePivot=(Y=-16.000000)
     PickupMessage="You got a piece of Junk"
     ThirdPersonActorClass=Class'BWBP_JWC_Pro.JunkWeaponAttachment'
     ThirdPersonDrawScale=1.000000
     ThirdPersonPivot=(Yaw=32768,Roll=32768)
     PullOutRate=1.000000
     PutAwayRate=1.000000
     AttachBone="Prop"
     bCanMelee=True
     bCanHoldMelee=True
     Ammo=1
     MaxAmmo=1
     SelectSound=(Volume=0.500000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     FriendlyName="Junk"
     InventoryGroup=1
     MeleeRating=50.000000
     RangeRating=50.000000
     bListed=True
     SpawnWeight=1.000000
     bCanBlock=True
     BlockSurface=3
     PainThreshold=50
     NoUseThreshold=100
     BlockLeftAnim="AvgBlockHitLeft"
     BlockRightAnim="AvgBlockHitRight"
     BlockStartAnim="AvgPrepBlock"
     BlockEndAnim="AvgEndBlock"
     BlockIdleAnim="AvgBlockIdle"
     RenderedHand=1.000000
     CullDistance=2000.000000
}
