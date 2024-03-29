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
var() int                       MaxHits;        // Cannot hit a single target more times than this
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

simulated function ApplyFireEffectParams(FireEffectParams params)
{
    local ShotgunEffectParams effect_params;

    super.ApplyFireEffectParams(params);

    effect_params = ShotgunEffectParams(params);

    TraceCount = effect_params.TraceCount;
    TracerClass = effect_params.TracerClass;
    ImpactManager = effect_params.ImpactManager;
    MaxHits = effect_params.MaxHits;   

	default.TraceCount = effect_params.TraceCount;
    default.TracerClass = effect_params.TracerClass;
    default.ImpactManager = effect_params.ImpactManager;
    default.MaxHits = effect_params.MaxHits;
}

function int GetXInaccuracy()
{
	return XInaccuracy;
}

function int GetYInaccuracy()
{
	return YInaccuracy;
}

// Get aim then run several individual traces using different spread for each one
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator R, Aim;
	local int i;

    if (Level.NetMode == NM_DedicatedServer)
        BW.RewindCollisions();

	Aim = GetFireAim(StartTrace);

	for (i=0;i<TraceCount;i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
	}

    if (Level.NetMode == NM_DedicatedServer)
        BW.RestoreCollisions();

	ApplyHits();

	// update client's dispersion values before shot
	if (BallisticShotgunAttachment(Weapon.ThirdPersonActor) != None)
	{
		BallisticShotgunAttachment(Weapon.ThirdPersonActor).XInaccuracy = GetXInaccuracy();
		BallisticShotgunAttachment(Weapon.ThirdPersonActor).YInaccuracy = GetYInaccuracy();

		//log("BallisticShotgunFire: Server update: XInacc "$GetXInaccuracy()$", YInacc "$GetYInaccuracy());
	}

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
        Dmg = GetDamageForCollision(UnlaggedPawnCollision(Other), DamageHitLocation, TraceStart, Dir, HitDT);
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
	
	    Dmg = GetDamage(Other, DamageHitLocation, TraceStart, Dir, Victim, HitDT);
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

// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local int						PenCount, WallCount, WallPenForce;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc, ExitNormal;
	local Material					HitMaterial, ExitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	WallPenForce = WallPenetrationForce;
	BW.UpdatePenetrationStatus(0);
	
	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		BW.UpdatePenetrationStatus(WallCount);
		
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);

		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;

		if (Other == None)
		{
			LastHitLoc = End;
			break;
		}

		// Water
		if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
		{
			if (VSize(HitLocation - Start) > 1)
				WaterHitLoc=HitLocation;
			Start = HitLocation;
			Dist = Min(Dist, MaxWaterTraceRange);
			End = Start + X * Dist;
			Weapon.bTraceWater=false;
			continue;
		}

		LastHitLoc = HitLocation;
			
		// Got something interesting
		if (!Other.bWorldGeometry && Other != LastOther)
		{
			OnTraceHit(Other, HitLocation, InitialStart, X, PenCount, WallCount, WallPenForce, WaterHitLoc);
		
			LastOther = Other;

			if (CanPenetrate(Other, HitLocation, X, PenCount))
			{
				PenCount++;
				
				Start = HitLocation + (X * Other.CollisionRadius * 2);
				End = Start + X * Dist;
				Weapon.bTraceWater=true;
				if (Vehicle(Other) != None)
					HitVehicleEffect (HitLocation, HitNormal, Other);
				continue;
			}
			else if (Vehicle(Other) != None)
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
			}
			else if (Mover(Other) == None)
				break;
		}

		// Do impact effect
		if (Other.bWorldGeometry || Mover(Other) != None)
		{
			WallCount++;
			
			if (Other.bCanBeDamaged)
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				OnTraceHit(Other, HitLocation, InitialStart, X, PenCount, WallCount, WallPenForce, WaterHitLoc);
				break;
			}

			if (
                    WallCount < MAX_WALLS && WallPenForce > 0 && 
                    class'WallPenetrationUtil'.static.GoThroughWall
                    (
                        Weapon, Instigator, 
                        HitLocation, HitNormal, 
                        WallPenForce * SurfaceScale(class'WallPenetrationUtil'.static.GetSurfaceType(Other, HitMaterial)), 
                        X, Start, 
                        ExitNormal, ExitMaterial
                    )
                )
			{
				WallPenForce -= VSize(Start - HitLocation) / SurfaceScale(class'WallPenetrationUtil'.static.GetSurfaceType(Other, HitMaterial));

				WallPenetrateEffect(Other, HitLocation, HitNormal, HitMaterial);
				WallPenetrateEffect(Other, Start, ExitNormal, ExitMaterial, true);
				Weapon.bTraceWater=true;
				continue;
			}

			bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
			
			break;
		}
		// Still in the same guy
		if (Other == Instigator || Other == LastOther)
		{
			Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
			End = Start + X * Dist;
			Weapon.bTraceWater=true;
			continue;
		}
		break;
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc, WaterHitLoc);
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

    // Guard against overkill from double-barreled shotguns
    // Nasty, but whatever works
    if (MaxHits > 0 && HitActorInfos[i].TotalHits == MaxHits)
        return;

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

	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(V - BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation(), Rotator(V - BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation()));
	
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

	if (ImpactManager == None || !Weapon.EffectIsRelevant(HitLocation,false))
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);

	ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, instigator);

	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation(), Rotator(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation()));

	return true;
}

defaultproperties
{
     TracerChance=0.500000
     TraceRange=(Min=500.000000,Max=2000.000000)
	 WallPenetrationForce=0.000000
	 bPenetrate=False
     FireSpreadMode=FSM_Scatter
}
