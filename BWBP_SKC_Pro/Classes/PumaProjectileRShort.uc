//=============================================================================
// PUMAProjectileRShort.
//
// Energy explosive. Detonates after set distance. May let user set distance.
// Firing while shield up is bad idea.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUMAProjectileRShort extends PUMAProjectile;

var   float 		NewDetonateDelay;	// Detonate delay sent to clients
var() int		FireModeNum;		// Da fire mode that spawned dis grenade
var() bool 		bNoFXOnExplode; //Do FX in Destroyed and not in Explode
var   bool		bProgramInitialized; //New detonation distance sent


simulated event Timer()
{
	local float NewTimer;
	if (!bPrimed)
	{
		NewTimer = NewDetonateDelay - 0.05;
		if (NewTimer < 0.05)
			Explode(Location, vect(0,0,1));
		else 
			SetTimer(NewTimer, false);
		bPrimed=true;
		return;
	}
	Explode(Location, vect(0,0,1));
}

// Make the thing look like its pointing in the direction its going
simulated event Tick( float DT )
{

	if (bAlignToVelocity && ( RandomSpin == 0 || (bNoInitialSpin && !bHasImpacted) ))
		SetRotation(Rotator(Velocity));

}

simulated function Destroyed()
{
	local int Surf;
 
	if (bNoFXOnExplode && !bNoFX )
	{
		if (EffectIsRelevant(Location,false) && ImpactManager != None && level.NetMode != NM_DedicatedServer)
		{
			if (bCheckHitSurface)
				CheckSurface(Location, -Vector(Rotation), Surf);
			if (Instigator == None)
				ImpactManager.static.StartSpawn(Location, -Vector(Rotation), Surf, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ImpactManager.static.StartSpawn(Location, -Vector(Rotation), Surf, Instigator);
		}
	}
 
	Super.Destroyed();
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
  
	if (!bNoFXOnExplode)
	{
		if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
		{
			if (bCheckHitSurface)
				CheckSurface(HitLocation, HitNormal, Surf);
			if (Instigator == None)
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
		}
	}

	BlowUp(HitLocation);
	bExploded = True;

	Destroy(); 
}

simulated event PostBeginPlay ()
{
	Super(BallisticProjectile).PostBeginPlay();

	VelocityDir = Rotation;
 
	InitProjectile();
	if (Role == ROLE_Authority)
		SetTimer(0.05, false);
}


simulated function InitProjectile ()
{
	InitEffects();
	Velocity = Speed * Vector(VelocityDir);
	if (RandomSpin != 0 && !bNoInitialSpin)
		RandSpin(RandomSpin);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}
	else if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
	{
		SetTimer(DetonateDelay, false);
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.5;
		DampenFactorParallel *= 0.5;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	Speed = VSize(Velocity);

	if (Speed < 20)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc );
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Owner);
    	}
}

defaultproperties
{
     NewDetonateDelay=0.100000
     bNoFXOnExplode=True
     DetonateOn=DT_Timer
     bNetTemporary=False
}
