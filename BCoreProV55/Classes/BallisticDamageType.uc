//=============================================================================
// BallisticDamageType.
//
// Adds multi random death messages
// Adds support for he/she, him/her, his/her and himself/herself in messages
// Adds sounds for damage to pawns
// Adds support for damage specific blood effects using a BloodManager
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticDamageType extends WeaponDamageType config(BallisticProV55);

var() localized Array<string>	DeathStrings;					// Multiple deathstrings may be interesting...
var() localized Array<string>	FemaleSuicides, MaleSuicides;	// Multiple suicide messages
var() localized string			SimpleKillString, SimpleSuicideString;
var() localized string			HipString, AimedString;
var() localized string			His, Her, Himself, Herself, Him, MHer, He, She;

var() float							EffectChance;		// Chance of blood effect appearing
var() class<BloodManager>	BloodManager;		// BloodManager loaded from BloodManagerName
var() string						BloodManagerName;	// BloodManager to use for this damagetype
var   bool							bCantLoadBlood;		// No able to load BloodManager. So we know not to keep trying...

var int								FlashThreshold;
var vector 							FlashV;
var float							FlashF;

var() bool							bCanBeBlocked;		// This damage(eg. sword slash) can be blocked with a shield, sword or whatever...
var() float							BlockPenetration;	// Scaler for damage to do through block, if any
var() int							ShieldDamage;		// Damage this can do to shields that block it (for future mod purposses, used by JunkWar)
var() bool							bDetonatesBombs;	// This damage can detonate bombs, mines, etc...
var() bool							bIgniteFires;		// This damage can ignite flammable things and cause fires.
var() byte							ArmorHitType;		// Tells BArmor what effects to use (Bullet, Misc or None)
var() bool							bSnipingDamage;   // Ballistic Freon - extend camp check longer than normal
var() bool							bPowerPush;		 // 3SPN: Attacks of this damagetype impart a lot of momentum and are commonly used for abusive purposes
var() bool							bNegatesMomentum; // Arrests horizontal momentum of struck target
var() bool 							bHeaddie; 			// Is a headshot damagetype
var() bool							bIgnoredOnLifts;			//If used against a player on a lift, or exiting a lift, this damagetype will be ignored completely
var() float							InvasionDamageScaling; // Scale the damage by this in Invasion (because Invasion requires different balance to PvP)
var string							DamageIdent;		// The stats slot this damagetype fits into
var() bool							bDisplaceAim;		// This damagetype forcibly displaces the weapon if it hits
var() bool							bMetallic; // This damagetype is delivered by means of a metal object (bullet, knife, etc)
var()	int							AimDisplacementDamageThreshold;
var() float							AimDisplacementDuration;

var globalconfig bool			bSimpleDeathMessages; //Simplify DMs

var() string	DamageDescription;	// Words that describe this damagetype. e.g. ",Poison,Melee,Bite," or ",Electro,Lightning,"
									// Makes it easier for systems to identify the damage and work accordingly...
									// Always seperate the keywords with commas like in examples!

/*	This will be expanded upon later and implemented as the system develops and demand rises
Some Standard Damage Description Words:
	,Bullet,		Done by ballistic bullet weapon, e.g. Pistol, Machinegun, Rifle, etc
	,Shell,			Done by shotgun shell, e.g. Shotgun shell...
	,Flame,			Done by fire, e.g. Flame thrower, Incendiary grenade, etc
	,Explode,		Done by explosion, e.g. Bomb, rocket, grenade
	,Blunt,			Done by blunt weapon, e.g. Baseball bat, Shotgun butt, South African bread
	,Hack,			Done by heavy hack style weapon, e.g. Axe
	,Stab,			Done by stab weapon, e.g. Knife, harpoon, spear, bayonette
	,Slash,			Done by swung blade weapon, e.g. Knife, Sword, Scythe
	,Plasma,
	,Laser,			Laser type things
	,Electro,		Electical type damage like lightning
	,RoadKill,		Run down by a vehicle
	,Gas,			Done by poison gas, e.g. Deadly green gas, Deadly yellow gas, other deadly gasses...
	,Liquid,		Submerged in death
	,Poison,		Vic was poisoned by a damage that continued hurting after the hit
	,Ice,			Damage is cold and icy by nature. e.g. Freeze gun
	,GearSafe,		Doesn't tear into a victim or cut through armor and gas tanks, basically doesn't harm the gear, just the guy inside... Likely used with: Poison, Gas, Liquid
	,Hazard,		Done by hazardous weapon, ie. one that can easily damage the user. e.g. Explosives, grenades, fire, etc
	,NonSniper,		Not possible for this damage to be the result of marksmanship. eg. Traps, Mines, Bombs, Explosives
*/

var() class<BCImpactManager> ImpactManager; // Impact effects associated with this damage

// New gore system vars
var() bool				bMultiSever;				// Don't just sever the hitbone, try the other bones too
var() bool				bOnlySeverLimbs;			// Do not sever spine or pelvis, no matter how much damage
var() bool				bSeverPreventsBlood;		// No blood hit effects if the bone was severed
var() bool				bNoSeverStumps;				// Don't spawn attached stumps

// Motion blur caused by this damage
var() float MinMotionBlurDamage;					// Damage that must be done to start causing motion blur
var() float MotionBlurDamageRange;					// Damage amount beyond MinMotionBlurDamage at which max blur is acheived
var() float MotionBlurFactor;						// Amount of blur to apply. 0 None, 1 Full, >1 Stays full longer  (scaled depending on damage)
var() float MotionBlurTime;							// How long blur is applied (also scaled depending on damage... obviously)
var() bool	bUseMotionBlur;							// use motion blur effects for this DT

// This lets you put some his/her type words in the death messages
// %ke:	killer he/she
// %ve: vicitm he/she
// %km:	killer him/her
// %vm: vicitm him/her
// %kh:	killer his/her
// %vh: vicitm his/her
// %ks:	killer himself/herself
// %vs: vicitm himself/herself
static function string Detag (string s, PlayerReplicationInfo Victim, PlayerReplicationInfo Killer)
{
	local string kh, vh, vs, ks, km, vm, ve, ke;

	if (Victim!=None && Victim.bIsFemale)	{
		vh = default.Her;
		vs = default.Herself;
		vm = default.MHer;
		ve = default.She;	}
	else	{
		vh = default.His;
		vs = default.Himself;
		vm = default.Him;
		ve = default.He;	}
	if (Killer != None && Killer.bIsFemale)	{
		kh = default.Her;
		ks = default.Herself;
		km = default.MHer;
		ke = default.She;	}
	else	{
		kh = default.His;
		ks = default.Himself;
		km = default.Him;
		ke = default.He;	}

	SwitchText(s, "%ke", ke);
	SwitchText(s, "%ve", ve);
	SwitchText(s, "%km", km);
	SwitchText(s, "%vm", vm);
	SwitchText(s, "%kh", kh);
	SwitchText(s, "%vh", vh);
	SwitchText(s, "%ks", ks);
	SwitchText(s, "%vs", vs);
	return s;
}
static function SwitchText(out string Text, string Replace, string With)
{
	local int i;
	local string Input;

	Input = Text;
	Text = "";
	i = InStr(Input, Replace);
	while(i != -1)
	{
		Text = Text $ Left(Input, i) $ With;
		Input = Mid(Input, i + Len(Replace));
		i = InStr(Input, Replace);
	}
	Text = Text $ Input;
}

static function bool IsAimed(PlayerController PC)
{
	if (PC.Pawn != None && BallisticWeapon(PC.Pawn.Weapon) != None && BallisticWeapon(PC.Pawn.Weapon).SightingState != SS_None)
		return true;
	return false;
}

// Random messages
static function string DeathMessage(PlayerReplicationInfo Killer, PlayerReplicationInfo Victim)
{
	local string s, t;
	
	if (default.bSimpleDeathMessages)
	{
		if (default.WeaponClass == None)
			s = "%k ["$GetItemName(String(default.Class))$"] %o";
		else 
		{
			if(default.SimpleKillString == "")
				t = default.WeaponClass.default.ItemName;
			else t = default.SimpleKillString;
			if(default.HipString != "")
				t @= default.HipString;
			if (default.DamageIdent == "Melee" && default.WeaponClass.default.InventoryGroup != 1)
				t @= "Melee";
			if (default.bHeaddie)
				t @= "Headshot";
			s = "%k ["$t$"] %o";
		}
	}

	else if (default.DeathStrings.Length > 0)
		s = default.DeathStrings[Rand(default.DeathStrings.Length)];
	else
		s = default.DeathString;
	return static.Detag(s, Victim, Killer);
}

// Scoped death message (only for Simple DMs and with gametype support)
static function string ScopedDeathMessage(PlayerReplicationInfo Killer, PlayerReplicationInfo Victim)
{
	local string s, t;
	
	if (default.WeaponClass == None)
		s = "%k ["$GetItemName(String(default.Class))$"] %o";
	else 
	{
		if(default.SimpleKillString == "")
			t = default.WeaponClass.default.ItemName;
		else t = default.SimpleKillString;
		if (default.DamageIdent == "Melee" && default.WeaponClass.default.InventoryGroup != 1)
			t @= "Melee";
		t @= default.AimedString;
		if (default.bHeaddie)
			t @= "Headshot";
		s = "%k ["$t$"] %o";
	}
	
	return static.Detag(s, Victim, Killer);
}

static function string SuicideMessage(PlayerReplicationInfo Victim)
{
	if (default.bSimpleDeathMessages)
	{
		if (default.WeaponClass == None)
			return "["$default.Class$"] %o";
		if(default.SimpleKillString == "")
			return "["$default.WeaponClass.default.ItemName$"] %o";
		return "["$default.SimpleKillString$"] %o ";
	}
	if (Victim.bIsFemale && default.FemaleSuicides.Length < 1)
		return default.FemaleSuicide;
	if (default.MaleSuicides.Length < 1)
		return default.MaleSuicide;
	if (Victim.bIsFemale)
		return default.FemaleSuicides[Rand(default.FemaleSuicides.Length)];
	return default.MaleSuicides[Rand(default.MaleSuicides.Length)];
}

// Is keyword in description: Keep the commas in the keyword!  e.g. ,Fire, ,Gas, ,Bullet,
static function bool IsDamage(string TypeString)
{
	return InStr(default.DamageDescription, TypeString) >= 0;
}

// Call this to do damage to something. This lets the damagetype modify the things if it needs to
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);
}
// Compatability for Hurt(), Call this with the DamageType if it might not be a BallisticDamageType
// Use like this: class'BallisticDamageType'.static.GenericHurt (..., QuestionableDamagetype);
static function GenericHurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	if (class<BallisticDamageType>(DT) != None)
		class<BallisticDamageType>(DT).static.Hurt (Victim, Damage, Instigator, HitLocation, Momentum, DT);
	else
		Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);
}

// Spawn some blood effects
static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (Monster(Victim) == None && !Victim.PhysicsVolume.bWaterVolume && !default.bCantLoadBlood && GetBloodManager() != None)
		GetBloodManager().static.StartSpawnBlood(HitLocation + Normal(momentum)*Victim.CollisionRadius*1.5, Momentum, Victim);
}
// Spawn some blood effects
static function class<BloodManager> GetBloodManager ()
{
	if (default.BloodManager == None)
	{
		default.BloodManager = class<BloodManager>(DynamicLoadObject(default.BloodManagerName,class'class',true));
		if (default.BloodManager == None)
			default.bCantLoadBlood = true;
	}
	return default.BloodManager;
}

// Plays a sound when this damage is done to pawns
// This is a hook for damage specific blood effects
static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
 	if (xPawn(Victim) != None)
 	{
		if (default.PawnDamageSounds.Length > 0)
			Victim.PlaySound(default.PawnDamageSounds[Rand(default.PawnDamageSounds.Length)],,default.TransientSoundVolume,,default.TransientSoundRadius);
		if (default.EffectChance > 0 && default.EffectChance > FRand())
			DoBloodEffects(HitLocation, Damage, Momentum, Victim, bLowDetail);
		if (Damage >= default.FlashThreshold)
		{
			if (PlayerController(Victim.Controller) != None)
				PlayerController(Victim.Controller).ClientFlash(default.FlashF, default.FlashV);
		}
	}
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

// Apply motion blur
static function LocalHitEffects (Pawn Victim, name HitBone, vector HitLocation, vector HitRay, int Damage)
{
	local float ScaleFactor;

	if (default.bUseMotionBlur && Victim.level.NetMode != NM_DedicatedServer && Victim.level.GetLocalPlayerController().ViewTarget == Victim /*Victim.IsLocallyControlled() PlayerController(Victim.Controller) != None*/ && Damage > default.MinMotionBlurDamage)
	{
		ScaleFactor = FMin(1.0, (Damage-default.MinMotionBlurDamage)/default.MotionBlurDamageRange);
		class'BC_MotionBlurActor'.static.DoMotionBlur(PlayerController(Victim.Controller), default.MotionBlurFactor * ScaleFactor, default.MotionBlurTime * ScaleFactor);
	}
}

// Pawn gives damage type a chance to modify hit properties. Called from PlayHit, so changes affect only effects, TakeDamage will be done already.
static function ModifyHit (Pawn Victim, out float Damage, vector Momentum, out vector HitLocation, out vector HitRay, out name HitBone);

// Return true to decide a sever from here instead of using pawn's default code. Set bCanSever to desired result.
static function bool OverrideCanSever(Pawn Pawn, name Bone, int Damage, vector HitLoc, vector HitRay, bool bDirectHit, out byte bCanSever);

// Spawn some blood effects
static function bool DoBloodHit (Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{
	if (default.bCantLoadBlood || GetBloodManager() == None)
		return false;
	GetBloodManager().static.DoBloodHit(Victim, Bone, HitLoc, HitRay, Damage);
	return true;
}
// Spawn sever effects
static function bool DoSeverEffect (Pawn Victim, name Bone, vector HitRay, int Damage)
{
	if (default.bCantLoadBlood || GetBloodManager() == None)
		return false;
	GetBloodManager().static.DoSeverEffects(Victim, Bone, HitRay, default.GibPerterbation, Damage);
	return true;
}
// Spawn sever stump
static function bool DoSeverStump (Pawn Victim, name Bone, vector HitRay, int Damage)
{
	if (default.bCantLoadBlood || GetBloodManager() == None)
		return false;
	if (default.bNoSeverStumps)
		return true;
	GetBloodManager().static.DoSeverStump(Victim, Bone, HitRay, Damage);
	return true;
}

defaultproperties
{
     AimedString="Aimed"
     His="his"
     Her="her"
     Himself="himself"
     Herself="herself"
     Him="him"
     MHer="her"
     He="he"
     She="she"
     FlashThreshold=200
     bDetonatesBombs=True
     ArmorHitType=255
     InvasionDamageScaling=1.000000
     DamageIdent="Unknown"
     AimDisplacementDuration=0.600000
     bSimpleDeathMessages=True
     MinMotionBlurDamage=10.000000
     MotionBlurDamageRange=80.000000
     MotionBlurFactor=4.000000
     MotionBlurTime=3.000000
     bDetonatesGoop=True
     bKUseTearOffMomentum=True
     bExtraMomentumZ=False
     bDirectDamage=False
     TransientSoundVolume=1.000000
     TransientSoundRadius=64.000000
}
