//=============================================================================
// BallisticBrass.
//
// Decorative actors ejected by firemodes and attachments
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticBrass extends Effects abstract
	config(BallisticProV55);

// General Variables ----------------------------------------------------------
var() int						Spin;				// Random spin applied after impact
var() float						DampenFactor;		// Dampen factor for impacts
var() Rotator					RandomDir;			// Adds some random rotation to the start velocity calculations
var() Vector					StartVelocity;		// Velocity applied at start
var() globalconfig float		LifeTimeScale;		// Scales the lifespan of brass (0 = Stays... FOREVER!!!)
var() bool						bAddOwnerVelocity;	// Add velocity of owner (or Owner.Instigator if inventory)
// Sound Vars -----------------------------------------------------------------
var() bool						bHitSounds;		// Play sounds when shell hits wall or floor
var() array<sound>				HitSounds;		// Sound for each surface type. Use sound groups for multiple sounds per surface
var() float						HitSoundVolume; // Volume for impact sound
var() float						HitSoundRadius; // Radius for impact sound
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
// ----------------------------------------------------------------------------

simulated function ApplyHandedness()
{
	if (Owner != None && Weapon(Owner)!= None && Weapon(Owner).Hand < 0)
		StartVelocity.Y *= -1;
}
// Initialize velocity and spin
simulated function PostBeginPlay()
{
	local vector X,Y,Z;
	local rotator R;

    Super.PostBeginPlay();

    ApplyHandedness();
    R.Pitch = randomDir.Pitch * (-1+FRand()*2);
    R.Yaw = randomDir.Yaw * (-1+FRand()*2);
    R.Roll = randomDir.Roll * (-1+FRand()*2);
	GetAxes(Rotation+R, X,Y,Z);
//	GetAxes(Rotation+RandomDir*(-1+FRand()*2), X,Y,Z);
	Velocity = X * StartVelocity.X + Y * StartVelocity.Y + Z * StartVelocity.Z;
	if (bAddOwnerVelocity)
	{
		if ((Inventory(Owner) != None || InventoryAttachment(Owner) != None) && Owner.Instigator!=None)
			Velocity += Owner.Instigator.Velocity;
		else
			Velocity += Owner.Velocity;
	}

	RandSpin (32768);
	if (Level.DetailMode < DM_SuperHigh || class'BallisticMod'.default.EffectsDetailMode < 2)
		LifeSpan *= 0.5;
	else
		LifeSpan *= LifeTimeScale;
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
/*
function Bump( actor Other )
{
	local Rotator R;
	if (Mover(Other) == None)
		return;
    bBounce = False;
	SetPhysics (PHYS_None);
    R = Rotation;
    R.Pitch=0;
	SetRotation(R);
	bHardAttach = true;
	bCollideWorld = false;
	SetCollision(false, false);
	SetBase(Other);
}
*/
// Play sounds, check speed and so on
simulated function HitWall (Vector HitNormal, Actor Wall)
{
    local float Speed;
	local Rotator R;
	local Vector HitLoc, HitNorm, V, V2;
	local Material HitMat;
	local int Surf;

    Velocity = DampenFactor * ((Velocity dot HitNormal) * HitNormal * -2.0 + Velocity);
    Speed = VSize(Velocity);
    RandSpin(Spin);
    if (Speed < 20 || (Wall != None && Mover(Wall) != None))
    {
        bBounce = False;
        SetPhysics (PHYS_None);
        R = Normalize(Rotation);
        if (HitNormal.Z == 1)
        {
			if (R.Pitch > 16384 || R.Pitch < -16384)
        		R.Pitch = 32768;
			else
        		R.Pitch = 0;
        }
        else
        {
        	V = Vector(Rotator(HitNormal)-rot(16384,0,0)); V.Z=0;
        	V2 = Vector(R); V2.Z=0;
        	R.Pitch += ((Rotator(HitNormal).Pitch - 16384) - R.Pitch) * Abs(Normal(V) Dot Normal(V2));
        }
		SetRotation(R);
		bCollideWorld = false;
		SetCollision(false, false);
		if (Wall != None)
		{
			bHardAttach = true;
			SetBase(Wall);
		}
		if (LifeTimeScale != 0)
			SetTimer(FMax(0.2, LifeSpan-2.0), false);
    }
	else if (Speed > 100)
    {
		if (Wall != None && !Wall.bWorldGeometry)
			Surf = int(Wall.SurfaceType);
		else
		{
			Trace(HitLoc, HitNorm, Location-HitNormal*10, Location+HitNormal*10, false, , HitMat);
			if (HitMat != None)
			Surf = int(HitMat.SurfaceType);
		}
		if (bHitSounds && HitSounds.Length > Surf)
			PlaySound(HitSounds[Surf],,HitSoundVolume,,HitSoundRadius,,true );
    }
}

simulated function Timer()
{
	GotoState('FadeOut');
}

State FadeOut
{
	function Tick(float DT)
	{
//		if (Base != None)
//			SetRelativeLocation(RelativeLocation - vect(0,0,1) * 8 * DT);
//		else
			SetLocation(Location - vect(0,0,1) * 9 * DT);
	}

	function BeginState()
	{
		bCollideWorld=false;
		LifeSpan = 2.0;
	}
}

defaultproperties
{
     Spin=70000
     DampenFactor=0.500000
     RandomDir=(Pitch=2048,Yaw=2048)
     StartVelocity=(Y=20.000000,Z=100.000000)
     LifeTimeScale=1.000000
     bAddOwnerVelocity=True
     bHitSounds=True
     HitSoundVolume=0.400000
     HitSoundRadius=64.000000
     DrawType=DT_StaticMesh
     Physics=PHYS_Falling
     LifeSpan=16.000000
     AmbientGlow=16
     bUnlit=False
     TransientSoundVolume=0.170000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bCollideWorld=True
     bBounce=True
     bFixedRotationDir=True
     Mass=30.000000
     RotationRate=(Pitch=32768,Yaw=60000)
}
