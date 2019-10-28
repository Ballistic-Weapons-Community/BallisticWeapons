//=============================================================================
// BallisticGib.
//
// A general purpose gib actor with lots of basic gib features...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticGib extends Effects config(BallisticProV55);

// General Variables ----------------------------------------------------------
var() int						Spin;				// Random spin applied after impact
var() float						DampenFactor;		// Dampen factor for impacts
var() globalconfig bool			bUseBloodSplats;	// Toggles blood splats
// Sound Vars -----------------------------------------------------------------
var() array<sound>				HitSounds;			// Random hit sounds
var() float						HitSoundVolume;		// Volume for sound
var() float						HitSoundRadius; 	// Radius for sound
var() float						HitSoundThreshold;	// Required speed to play hit sound
var   float						LastSoundTime;
// ----------------------------------------------------------------------------
var() class<BallisticDecal>		DecalClass;			// Decal to leave when hitting a surface
var() class<Emitter>			TrailClass;			// Emitter to use as trail
var() class<Emitter>			FireTrailClass;		// emitter to use as trail for flaming gibs
var   emitter					Trail;
var   float						LastDecalTime;
var() bool						bFiery;				// Will use firy trail
var() float						HitDecalThreshold;	// Required speed to spawn hit decal
var() bool						bNoTrailWhenStill;	// Kill trail when comes to rest
// ----------------------------------------------------------------------------
var   bool						bInitialized;

// Initialize velocity and spin
simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

	SetTimer(0.05, false);
}

simulated function InitGib()
{
	RandSpin (32768);
	if (Level.DetailMode < DM_SuperHigh)
		LifeSpan *= 0.5;
	SetTimer(FMax(0.2, LifeSpan-2.0), false);

	if (bFiery)
	{	if (FireTrailClass != None)
			Trail = Spawn(FireTrailClass,self,,Location, Rotation);
	}
	else if (TrailClass != None)
		Trail = Spawn(TrailClass,self,,Location, Rotation);
	if (Trail != None)
		Trail.SetBase(self);
	bInitialized = true;
}

// Set random spin
simulated final function RandSpin (float SpinRate)
{
	DesiredRotation = RotRand();
	RotationRate.Yaw = (FRand()*SpinRate*2)-SpinRate;
	RotationRate.Pitch = (FRand()*SpinRate*2)-SpinRate;
	RotationRate.Roll = (FRand()*SpinRate*2)-SpinRate;
}

// Landing is the same as hitting any other wall, divert to HitWall()
simulated function Landed (Vector HitNormal)
{
    HitWall (HitNormal, None);
}

// Play sounds, check speed and so on
simulated function HitWall (Vector HitNormal, Actor Wall)
{
    local float Speed;
	local Rotator R;

    Velocity = DampenFactor * ((Velocity dot HitNormal) * HitNormal * -2.0 + Velocity);
    Speed = VSize(Velocity);
    RandSpin(Spin);
    if (Speed < 20 || (Mover(Wall) != None))
    {
        bBounce = False;
        SetPhysics (PHYS_None);
        R = Normalize(Rotation);
		bCollideWorld = false;
		SetCollision(false, false);
		if (Wall != None)
		{
			bHardAttach = true;
			SetBase(Wall);
		}
		if (bNoTrailWhenStill && Trail != None)
			Trail.Kill();
    }

	if (Speed > HitSoundThreshold && HitSounds.Length > 0 && level.TimeSeconds - LastSoundTime > 0.15)
	{
		LastSoundTime = level.TimeSeconds;
		PlaySound(HitSounds[Rand(HitSounds.Length)],,HitSoundVolume,,HitSoundRadius,,true);
	}
	if (bUseBloodSplats && DecalClass != None && Speed > HitDecalThreshold && Wall != None && Wall.bWorldGeometry && level.TimeSeconds - LastDecalTime > 0.2)
	{
		LastDecalTime = level.TimeSeconds;
		Spawn(DecalClass,,,Location, Rotator(-HitNormal));
	}
}

simulated function Timer()
{
	if (bInitialized)
		GotoState('FadeOut');
	else
		InitGib();
}

/*
simulated event Destroyed()
{
	if (Trail != None)
		Trail.Destroy();
	super.Destroyed();
}
*/
State FadeOut
{
	function Tick(float DT)
	{
		SetLocation(Location - vect(0,0,1) * 9 * DT);
	}

	function BeginState()
	{
		bCollideWorld=false;
		LifeSpan = 2.0;
		if (Trail != None)
			Trail.Kill();
	}
}

defaultproperties
{
     Spin=70000
     DampenFactor=0.500000
     bUseBloodSplats=True
     HitSoundVolume=0.400000
     HitSoundRadius=64.000000
     HitSoundThreshold=100.000000
     HitDecalThreshold=50.000000
     bNoTrailWhenStill=True
     DrawType=DT_StaticMesh
     Physics=PHYS_Falling
     LifeSpan=16.000000
     AmbientGlow=32
     bUnlit=False
     TransientSoundVolume=0.170000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bCollideWorld=True
     bBounce=True
     bFixedRotationDir=True
     Mass=15.000000
}
