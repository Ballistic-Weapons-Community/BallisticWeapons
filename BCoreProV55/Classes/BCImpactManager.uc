//=============================================================================
// BCImpactManager.
//
// Impact managers are spawned when weapon shots hit walls. Their purpose is to
// spawn the right decals, emmiters, etc depending on the surfacetype.
//
// Update: This thing is so damned handy, its now used everywhere in BW!
// Just run static StartSpawn() from anywhere with some hit parameters and its
// done! Only drawback is standard ImpactManagers are not replicated and only do
// things locally, but this is yet to be a problem.
//
// Features:
// -StartSpawn: Static function that makes it super simple to use ImpactManagers
// -PerSurface hit Effects:
// -PerSurface hit Projectors:
// -PerSurface hit Sounds:
// -Hit Delaying: A variable is provided to allow delaying effect spawning
// -Hit Flags: Can be used to limit certain effects when needed
// -ViewShake: Impacts can now do local player view shake
//
// All effects, sounds and decals are listed to match SurfaceTypes 0-10.
// If array.length < surface index then entry [0] is used.
// Use 'None' entries if you want no effect to occur for a specific surface.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BCImpactManager extends Effects;

var() array<class<Actor> >		HitEffects;		// Effect (usually an emmitter) to spawn for each surface type
var() array<class<Projector> >	HitDecals;		// Projector to use for each surface type
var() float						DecalScale;		// Scales all decals by this amount
var() array<sound>				HitSounds;		// Sound for each surface type. Use sound groups for multiple sounds per surface
var() float						HitSoundVolume; // Volume for playing hit sounds
var() float						HitSoundRadius; // Radius for playing hit sounds
var() float						HitSoundPitch;	// Pitch for playing hit sounds
var() float						HitDelay;		// Use to delay the effects
var() float						EffectBackOff;	// How much to push effect back from surface
var   vector					HitNorm;
var   int						HitSurf;
var   byte						HitFlags;
var()	bool						bOptimize;		//Additional optimisations

// Its got the shakes now!!!
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view
var() float	 ShakeRadius;			// Shake the view of players withing this radius
var() bool	 bShakeOnWaterHit;		// Do viewshake when hit surface is water

// Hit flags: Thes can be added to IM calls to limit certain effects
const HF_NoEffects	= 1;
const HF_NoSounds	= 2;
const HF_NoDecals	= 4;
const HF_NoVShake	= 8;

/*
	EST_Default,	0
	EST_Rock,		1
	EST_Dirt,		2
	EST_Metal,		3
	EST_Wood,		4
	EST_Plant,		5
	EST_Flesh,		6
    EST_Ice,		7
    EST_Snow,		8
    EST_Water,		9
    EST_Glass,		10
*/

simulated function PostNetBeginPlay()
{
	local actor T;
	local vector HitLocation;
	local Material HitMat;

	Super.PostNetBeginPlay();

	if (HitDelay >= LifeSpan)
		LifeSpan+=HitDelay;

	if ( Role < ROLE_Authority )
	{
		T = Trace (HitLocation, HitNorm, Location - Vector(Rotation)*5, Location, false, , HitMat);
		if (T.bWorldGeometry)
			Initialize(HitMat.SurfaceType, HitNorm);
	}
}

simulated function Initialize (int HitSurfaceType, vector Norm, optional byte Flags)
{
	HitSurf = HitSurfaceType;
	HitNorm = Norm;
	HitFlags = Flags;
	if (HitDelay > 0.0)
		SetTimer(HitDelay, false);
	else
		SpawnEffects (HitSurf, HitNorm, Flags);
}

simulated event Timer()
{
	SpawnEffects(HitSurf, HitNorm, HitFlags);
}

simulated function SpawnEffects (int HitSurfaceType, vector Norm, optional byte Flags)
{
	local Projector P;
	
	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (HitSounds.Length > 0 && (Flags & HF_NoSounds) == 0)
	{
		if (HitSurfaceType >= HitSounds.Length)
			PlaySound(HitSounds[0], SLOT_Interact, HitSoundVolume,,HitSoundRadius,HitSoundPitch,true);
		else if (HitSounds[HitSurfaceType] != None)
			PlaySound(HitSounds[HitSurfaceType], SLOT_Interact, HitSoundVolume,,HitSoundRadius,HitSoundPitch,true);
	}
	
	if (ShakeRadius > 0 && (Flags & HF_NoVShake) == 0 && (HitSurfaceType != 9 || bShakeOnWaterHit))
		DoViewShake();
	
	if (Level.DetailMode == DM_Low && bOptimize)
		return;
		
	if (HitEffects.Length > 0 && (Flags & HF_NoEffects) == 0)
	{
		if (HitSurfaceType >= HitEffects.Length)
			Spawn (HitEffects[0], Owner,, Location+EffectBackOff*Norm, Rotation);
		else if (HitEffects[HitSurfaceType] != None)
			Spawn (HitEffects[HitSurfaceType], Owner,, Location, Rotation);
	}
	
	if (Level.DetailMode < DM_SuperHigh)
		return;
	
	if (HitDecals.Length > 0 && (Flags & HF_NoDecals) == 0)
	{
		if (HitSurfaceType >= HitDecals.Length)
			P = Spawn (HitDecals[0], Owner,, Location, Rotator(-Norm));
		else if (HitDecals[HitSurfaceType] != None)
			P = Spawn (HitDecals[HitSurfaceType], Owner,, Location, Rotator(-Norm));
		if (BallisticDecal(P) != None && BallisticDecal(P).bWaitForInit)
		{
			P.SetDrawScale(P.DrawScale*DecalScale);
			BallisticDecal(P).InitDecal();
		}
	}


}

simulated function DoViewShake ()
{
	local PlayerController PC;
	local float Dist, ScaleFactor;

	PC = level.GetLocalPlayerController();
	if ( PC != None && PC.ViewTarget != None/* && PC.ViewTarget.Base != None */)
	{
		Dist = VSize(Location - PC.ViewTarget.Location);
		if (Dist < ShakeRadius)
		{
			if (Dist < ShakeRadius/3)
				ScaleFactor = 1.0;
			else
				ScaleFactor = (ShakeRadius - Dist) / ShakeRadius;
			PC.ShakeView(ShakeRotMag*ScaleFactor, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*ScaleFactor, ShakeOffsetRate, ShakeOffsetTime);
		}
	}
}

// This can be called from weapon impact code to start the whole process
// This actor (ImpactManager) is spawned here and Initialized
static function StartSpawn (vector V, vector Norm, int Surface, actor OwnedBy, optional byte Flags)
{
	local BCImpactManager EM;

	if (OwnedBy==None)
		return;
	EM = OwnedBy.Spawn (default.class, OwnedBy, , V, Rotator(Norm));
	if (EM == None)	{
		log ("Failed to spawn effect manager for class: "$default.class,'Warning');	return;	}

	EM.Initialize(Surface, Norm, Flags);
}

defaultproperties
{
     DecalScale=1.000000
     HitSoundVolume=0.500000
     HitSoundRadius=64.000000
     HitSoundPitch=1.000000
     DrawType=DT_None
     bHidden=True
     bNetTemporary=False
     LifeSpan=0.100000
}
