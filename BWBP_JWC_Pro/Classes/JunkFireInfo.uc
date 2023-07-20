//=============================================================================
// JunkFireInfo.
//
// An plain information class that holds generic info and settings for a single
// firemode of a junkobject.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkFireInfo extends Object
	editinlinenew;

// Anim timing to use for things like fire hit timing
enum EAnimTimedStyle
{
	ATS_NonTimed,	// Dont use the notify for timing, we'll figure it out another way
	ATS_Timed,		// Standard notify tells us when it happens
	ATS_Early		// Ignore standard notify and react to early one
};

// Min and max damage for three different areas
struct AreaDamage
{
	var() int Head;
	var() int Limb;
	var() int Misc;
};
// How anims are switched when there are mutiple possible anims
enum EAnimChangeStyle
{
	ACS_Sequenial,	// Go to next in list
	ACS_Random		// Go to a random one
};
// What a should a projectile do when it hits something
enum EImpactType
{
	IT_Explode,		// Do 'Explode' and get destroyed
	IT_Bounce,		// Bounce off surface
	IT_Stick		// Stick in surface
	/*IT_FallToGround*/
};
// It breaks when this happens
enum EBreakType
{
	BT_Never,			// Never breaks
	BT_HitActor,		// Breaks when it hits and actor
	BT_HitWall,			// When it hits a wall
	BT_HitAnything,		// WHen it hits anything
	BT_HitNothing,		// When it misses
	BT_AnySwipe			// Breaks just for attacking
};

/*
Standard FireAnims:
				Average:		Light:			Heavy:			Wide:			Swing:			Stab:
Melee			AvgHit?			LightHit?		HeavyHit?		WideHit?		SwingHit?		StabHit?		1-3
HeldAttack		AvgAttack		LightAttack		HeavyAttack		WideAttack		SwingAttack		StabAttack		1
PrepHold		AvgPrepAttack	LightPrepAttack	HeavyPrepAttack	WidePrepAttack	SwingPrepAttack	StabPrepAttack	1
Throw			AvgThrow		LightThrow		HeavyThrow		WideThrow		SwingThrow		StabThrow		1
PrepThrow		AvgPrepThrow	LightPrepThrow	HeavyPrepThrow	WidePrepThrow	SwingPrepThrow	StabPrepThrow	1

Two handed:
				Average:		Big:			Poke:
DualMelee		Avg2Hit? 		Big2Hit?		Poke2Hit?			1-3
DualHeldAttack	Avg2Attack		Big2Attack?		Poke2Attack?		1-3
DualHold		Avg2PrepAttack	Big2PrepAttack?	PokePrepAttack?		1-3
*/

var(General)AreaDamage				Damage;				// Min and Max damage for each of the three damage areas (Head, Limb, General)
var(General)int						KickForce;			// magnitude of velocity applied to enemies when hit by this weapon
var(General)class<DamageType>		DamageType;			// DamageType for this fire
var(General)float					RefireTime;			// Minimum time between shots. The fire rate
var(General)float					AnimRate;			// Speed at which to play fire anim
var(General)BUtil.FullSound			Sound;				// Sound for firing
var(General)array<name>				Anims;				// List of possible fire anims
var(Held)	array<name>				PreFireAnims;		// List of possible pre fire anims
var(General)EAnimChangeStyle		AnimStyle;			// Style in which anims are picked from list (Random or Sequential)
var(General)int						AmmoPerFire;		// Ammo consumed for firing
var(Held)	bool					bFireOnRelease;		// Fire on release insted of press
var(General)EAnimTimedStyle			AnimTimedFire;		// Use anim notifies to time the hit traces or projectile spawning, etc
var(General)bool					bAnimTimedSound;	// Use Anim notify to time playing of fire sound
var(General)float					AimError;			// AimError for this fire

defaultproperties
{
     Sound=(Volume=1.000000,Radius=32.000000,Pitch=1.000000,bAtten=True,bNoOverride=True)
     aimerror=1000.000000
}
