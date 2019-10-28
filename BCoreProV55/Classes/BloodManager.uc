//=============================================================================
// BloodManager.
//
// NEW behaviour is implemented in static functions that are called from the
// client-side and don't need replication.
//
// This class is responsible for spawning gore effects it get from BloodSets
// where and how it wants for a certain type of damage. It can also hold info
// and alter non speceis specific properties of the gore effects.
//
// The static functions in this class are called from damage code to handle
// gore effects for wounds, deaths, dismemberment, etc...
//
// BloodManagers know the type of blood effects, decals, etc to ask for and
//	they know where and how to spawn them as well as alter certain species
//	insensetive properties.
//	There should be a Bloodmanager for each type of damage.
// BloodSets know the blood color and other per-speceis properties of the gore.
//	There should be a BloodSet for each type of victim.
//
//
// ---------- Old net replicated behaviour ----------
// Base form of the BloodManager, this class is spawned on server and
// replicated to clients to spawn blood and gore related effects. Spawns blood
// effect and blood decal in SplatRange by default.
// Uses BloodSets to find the right effects and decals for a victim.
// These should be spawned at HitLocation and Rotated acording to Momentum.
//
// Run the static function: StartSpawnBlood() with the HitLocation, momentum
// and Victim from just about any damage code to easily implement this actor.
// --------------------------------------------------
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodManager extends Effects
	config(BallisticProV55);

var   class<BallisticBloodSet>	BloodSet;		// The blood set to use for this victim (e.g. Alien, Human, Bot, etc)
var() float						SplatRange;		// Victim must be within this range from a wall for a splat decal to appear
var() float						BloodDelay;		// Time to delay spawning of blood effects
var() float						DecalChance;	// Chance of blood splat decal appearing
var() float						EffectChance;	// Chance of blood effect appearing
var() float						DripperThreshold;//Damage amount required to spawn wound blood dripper
var() float						DripperChance;	// Chance of dripper spawning dripper Threshold is reached

var() globalconfig bool		bUseBloodSplats;			// Toggles blood splats from weapon damage
var() globalconfig bool		bUseBloodExplodes;			// Toggles big bad blood explosion effects
var() globalconfig bool		bUseStumps;					// Toggles stumps for severed limbs
var() globalconfig bool		bUseChunks;					// Toggles gibs and chunky bits
var() globalconfig bool		bUseBloodEffects;			// Toggels blood effect emitters
var() globalconfig bool		bUseScreenFX;				// Toggles blood splatter that stick to the camera... sick!

var() globalconfig int		GibMultiplier;				// For extra gibs

replication
{
	reliable if (Role == ROLE_Authority)
		BloodSet;
}

// Set Timers and crap...
simulated function PostNetBeginPlay()
{
	if (BloodDelay >= LifeSpan)
		LifeSpan+=BloodDelay;

	Super.PostNetBeginPlay();

	if ( level.netMode == NM_Client )
		Initialize(BloodSet);
}
// Ether Spawn the effects or start the BloodDelay Timer
simulated function Initialize(class<BallisticBloodSet> BS)
{
	BloodSet = BS;
	if (BloodDelay > 0.0)
		SetTimer(BloodDelay, false);
	else
		SpawnEffects ();
}
// BloodDelay is up...
simulated event Timer()
{
	SpawnEffects();
}

// Speciy some conditions which may prevent this from spawning, e.g. LowGore
simulated function bool CanSpawnStuff()
{
	if (!bUseBloodSplats || class'GameInfo'.static.UseLowGore())
		return false;
	return true;
}
// Spawn an effect and a decal by default
simulated function SpawnEffects ()
{
	local Actor T;
	local vector HitLoc, HitNorm, End;

	if (Level.NetMode == NM_DedicatedServer || !CanSpawnStuff())
		return;

	// Spawn a decal within splat range and in the direction of this BloodManager
	if (default.DecalChance > 0 && default.DecalChance > FRand())
	{
		End = Location + Vector(Rotation) * default.SplatRange;
		T = Trace(HitLoc, HitNorm, End, Location, false);
		if (T != None && T.bWorldGeometry)
			Spawn(GetWallSplat(BloodSet),,,HitLoc, Rotator(-HitNorm));
	}
	// Spawn an effect in the direction of this BloodManager
	if (default.EffectChance > 0 && default.EffectChance > FRand())
		Spawn(GetBloodEffect(BloodSet),,,Location, Rotation);
}
// This can be called to easily spawn and initialized all blood effects for a specific type of damage
static function StartSpawnBlood (vector HitLocation, vector Momentum, Pawn Victim)
{
	local BloodManager BM;

	if (Victim==None)
		return;
	BM = Victim.Spawn(default.class, , , HitLocation, Rotator(Momentum));
	// Send what BloodSet to use
	BM.Initialize(GetBloodSet(Victim));
}

// Decal to use for blood splat. Uses bullet one by default. Override this for different types.
static function class<Projector> GetWallSplat(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.BulletSplat;
}
// Effect to use for blood splat. Uses bullet one by default. Override this for different types.
static function class<Actor> GetBloodEffect(class<BallisticBloodSet> BS, optional name Bone)
{
	if (Bone == 'head')
		return BS.default.BulletHeadEffect;
	return BS.default.BulletEffect;
}


// Figure out what blood set to use for the victim
static function class<BallisticBloodSet> GetBloodSet(Pawn Victim)
{
	return class'BloodSetHunter'.static.GetBloodSetFor(Victim);
}

static function class<actor> GetScreenEffect(class<BallisticBloodSet> BS)
{
	return BS.default.ScreenEffectMisc;
}

// Stub for extra FX in sub-classes
static function ExtraBloodHitFX(class<BallisticBloodSet> BS, Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage);

static function DoBloodHit(Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{
	local Actor HitFX, T;
	local vector TraceHit, TraceNorm, BoneDir, BoneLoc;
	local class<BallisticBloodSet> BS;
	local class<Projector> DecalClass;

	if (Victim.Level.NetMode == NM_DedicatedServer || class'GameInfo'.static.NoBlood())
		return;
	BS = GetBloodSet(Victim);
	if (BS == None)
		return;

	// Spawn a decal within splat range and in the direction of the HitRay
	if (default.bUseBloodSplats && !class'GameInfo'.static.UseLowGore() && default.DecalChance > 0 && default.DecalChance > FRand())
	{
		DecalClass = GetWallSplat(BS, Bone);
		if (DecalClass != None)
		{
			T = Victim.Trace(TraceHit, TraceNorm, HitLoc + HitRay * default.SplatRange, HitLoc, false);
			if (T != None && T.bWorldGeometry)
				Victim.Spawn(GetWallSplat(BS, Bone),,,TraceHit, Rotator(-TraceNorm));
		}
	}
	ExtraBloodHitFX(BS, Victim, Bone, HitLoc, HitRay, Damage);
	if (!default.bUseBloodEffects)
		return;
	// Spawn an effect in the direction of the HitRay
	if (default.EffectChance > 0 && default.EffectChance > FRand())
	{
		HitFX = Victim.Spawn(GetBloodEffect(BS, Bone),Victim,,HitLoc, Rotator(HitRay));
	}
	// Spawn dripping blood
	if (!class'GameInfo'.static.UseLowGore() && default.DripperChance > 0 && Damage >= default.DripperThreshold && default.DripperChance > FRand() && Victim.Health > 0 && BS.default.WoundDripper != None)
	{
		if (Bone == 'pelvis')
			Bone = 'spine';
		BoneLoc = Victim.GetBoneCoords(Bone).Origin;
		BoneDir = BoneLoc - HitLoc;
		BoneDir.Z = 0;
		if (Bone == 'head')
			HitLoc = (vect(0,0,1) * HitLoc.Z + BoneLoc * vect(1,1,0)) - Normal(BoneDir)*6;
		else
			HitLoc += BoneDir * 0.4;
		HitFX = Victim.Spawn(BS.default.WoundDripper,Victim,,HitLoc, Rotator(-HitRay));
		HitFX.SetBase(Victim);
	}
}

static function DoSeverEffects(Pawn Victim, name Bone, vector HitRay, float GibPerterbation, float Damage);
static function DoSeverStump(Pawn Victim, name Bone, vector HitRay, float Damage);

defaultproperties
{
     SplatRange=384.000000
     DecalChance=1.000000
     EffectChance=1.000000
     DripperThreshold=10.000000
     DripperChance=0.500000
     bUseBloodSplats=True
     bUseBloodExplodes=True
     bUseStumps=True
     bUseChunks=True
     bUseBloodEffects=True
     bUseScreenFX=True
     GibMultiplier=1
     DrawType=DT_None
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=2.000000
}
