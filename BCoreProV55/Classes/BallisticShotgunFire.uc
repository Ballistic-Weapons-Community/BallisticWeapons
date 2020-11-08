//=============================================================================
// BallisticShotgunFire.
//
// Just instant fire with multiple traces.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticShotgunFire extends BallisticInstantFire;

//General Vars ----------------------------------------------------------------
var() int						TraceCount;		// Number of fire traces to use
var() class<Emitter>			TracerClass;	// Type of tracer to use
var() float						TracerChance;	// Chance of tracer effect spawning per trace. 0=never, 1=always
var() class<BCImpactManager>	ImpactManager;	// Impact manager to use for ListenServer and StandAlone impacts
var() bool						bDoWaterSplash;	// splash when hitting water, duh...
//-----------------------------------------------------------------------------
//Target collation ------------------------------------------------------------
struct HitActorInfo
{
	var() Actor 	HitActor;
	var() int   	Damage;
	var() Vector 	LastHitLocation;
	var() int	  	TotalHits;
	var() int	  	HeadHits;
};

var	 array<HitActorInfo>		HitActorInfos;

simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (TracerChance < 2 && (level.DetailMode == DM_High || class'BallisticMod'.default.EffectsDetailMode == 1))
		TracerChance *= 0.3;
}

// Get aim then run several individual traces using different spread for each one
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator R, Aim;
	local int i;

    if (Level.NetMode == NM_DedicatedServer)
        BW.RewindCollisions();

	DoTrace(StartTrace, Aim);

	Aim = GetFireAim(StartTrace);
	for (i=0;i<TraceCount;i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
	}

    if (Level.NetMode == NM_DedicatedServer)
        BW.RestoreCollisions();

	ApplyHits();

	// Tell the attachment the aim. It will calculate the rest for the clients
	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(BallisticFire).DoFireEffect();
}

// This is called for any actor found by this fire.
function OnTraceHit (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, int WallPenForce, optional vector WaterHitLocation)
{
	local float				Dmg;
	local float				ScaleFactor;
	local class<DamageType>	HitDT;
	local class<BallisticDamageType> BDT;
	local Actor				Victim;
	local Vector 			DamageHitLocation;
	local bool				bHeadshot;

    if (UnlaggedPawnCollision(Other) != None)
    {
        DamageHitLocation = GetDamageHitLocation(Other, HitLocation, TraceStart, Dir);
        Dmg = GetDamageForCollision(Other, DamageHitLocation, Dir, HitDT);
        Victim = UnlaggedPawnCollision(Other).UnlaggedPawn;
    }
	else 
    {   
        if (Other.IsA('xPawn') && !Other.IsA('Monster'))
        {
            DamageHitLocation = GetDamageHitLocation(xPawn(Other), HitLocation, TraceStart, Dir);
        }
        else
        {
            DamageHitLocation = HitLocation;
        }
	
	    Dmg = GetDamage(Other, DamageHitLocation, Dir, Victim, HitDT);
    }

	ScaleFactor = ResolveDamageFactors(Other, TraceStart, HitLocation, PenetrateCount, WallCount, WallPenForce, WaterHitLocation);
	
	Dmg *= ScaleFactor;

	if (Pawn(Victim) != None)
		ApplyForce(Pawn(Victim), TraceStart, ScaleFactor);

	BDT = class<BallisticDamageType>(HitDT);

	if (BDT != None && BDT.default.bHeaddie)
		bHeadshot = true;

	TrackHit(Victim, Dmg, HitLocation, bHeadshot); 
}

function TrackHit(Actor Target, int Damage, vector HitLocation, bool bHeadshot)
{	
	local int i;

	//Log("BallisticShotgunFire::TrackHit");

	for(i = 0; i < HitActorInfos.Length && HitActorInfos[i].HitActor != Target; ++i);

	if (i == HitActorInfos.Length)
	{	
		//Log("BallisticShotgunFire::TrackHit: Inserting new actor "$Target);
		HitActorInfos.Insert(HitActorInfos.Length, 1);

		HitActorInfos[i].HitActor = Target;
		HitActorInfos[i].LastHitLocation = HitLocation;
	}

	HitActorInfos[i].Damage += Damage;
	++HitActorInfos[i].TotalHits;
	if (bHeadshot)
		++HitActorInfos[i].HeadHits;

	//Log("BallisticShotgunFire::TrackHit: Damage: "$HitActorInfos[i].Damage$" Location: "$HitActorInfos[i].LastHitLocation$" Total Hits: "$HitActorInfos[i].TotalHits);
}

function ApplyHits()
{
	local int i;
	local Vector MomentumDir;
	local class <DamageType> HitDamageType;

	//Log("BallisticShotgunFire::ApplyHits");

	for (i = 0; i < HitActorInfos.Length; ++i)
	{
		//Log("Index "$i);

		if (HitActorInfos[i].HeadHits * 2 >= HitActorInfos[i].TotalHits)
			HitDamageType = DamageTypeHead;
		else 
			HitDamageType = DamageType;

		MomentumDir = Normal(HitActorInfos[i].LastHitLocation - Instigator.Location);

		ApplyDamage(HitActorInfos[i].HitActor, HitActorInfos[i].Damage, Instigator, HitActorInfos[i].LastHitLocation, MomentumDir * KickForce * HitActorInfos[i].TotalHits, HitDamageType);

		HitActorInfos[i].HitActor = None;
	}

	HitActorInfos.Remove(0, HitActorInfos.Length);
}

// Even if we hit nothing, this is already taken care of in DoFireEffects()...
function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
{
	local Vector V;

	V = Instigator.Location + Instigator.EyePosition() + Dir * TraceRange.Min;
	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(V - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation(), Rotator(V - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()));
	if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);
}

// Spawn the impact effects here for StandAlone and ListenServers cause the attachment won't do it
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);

	if (!Other.bWorldGeometry && Mover(Other) == None)
		return false;

	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	if (ImpactManager != None && Weapon.EffectIsRelevant(HitLocation,false))
	{
		if (Vehicle(Other) != None)
			Surf = 3;
		else if (HitMat == None)
			Surf = int(Other.SurfaceType);
		else
			Surf = int(HitMat.SurfaceType);
		ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, instigator);
		if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
			Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation(), Rotator(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()));
	}
	return true;
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
	FS.DamageInt = int(default.Damage * default.TraceCount);
	FS.Damage = String(FS.DamageInt);
	FS.DPS = (default.Damage * default.TraceCount) / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/FS.DamageInt) - 1);
	if (default.FireRate < 0.5)
		FS.RPM = String(int((1 / default.FireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/default.FireRate@"times/second";
	FS.RPShot = default.FireRecoil;
	FS.RPS = default.FireRecoil / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.Range = "Max:"@(default.TraceRange.Max / 52.5)@"metres";
	
	return FS;
}

static function float GetAttachmentDispersionFactor()
{
	return 3.0f;
}

defaultproperties
{
     TracerChance=0.500000
     TraceRange=(Min=500.000000,Max=2000.000000)
	 WallPenetrationForce=0.000000
     HeadMult=1.35f
     LimbMult=0.8f
	 bPenetrate=False
     FireSpreadMode=FSM_Scatter
     ShotTypeString="shots"
}
