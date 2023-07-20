//=============================================================================
// BOGPFlare.
//
// Flare fired by the BGOP Grenade Pistol.
// Has a slight splash damage that ignites those within it.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPFlare extends BallisticGrenade;

var() class<BCImpactManager> FizzleImpactManager;
var() float FallSpeed;
var() float FallOffDistance;
var() float	IgniteRadius;

var vector VelocityDir;
var vector FallStart;
var float FallOff;
var float FallingSpeed;
var float LastIgniteCheckTime;
var float DieTime;
var bool bColored;

simulated function InitProjectile()
{
	Super.InitProjectile();

	FallStart=Location;

	DieTime = Level.TimeSeconds + 1;

	if(Instigator != None && Instigator.GetTeamNum() == 1)
		LightHue = 160;

	VelocityDir = Normal(Velocity);
}

simulated event Tick(float DT)
{
	local float Dist;

	Dist = VSize(Location - FallStart);
	FallOff = FMin(1.0,Dist/FallOffDistance);
	FallingSpeed += (FallSpeed*DT)*FallOff;

	Velocity = ((Speed * FMax(0.1,1.0-FallOff)) * VelocityDir) + (FMin(512.0,FallingSpeed) * vect(0,0,-1));

	if(Level.TimeSeconds >= DieTime)
		FizzleOut();

	// Waits until the client has an instigator before coloring.
	if(Role != ROLE_Authority && !bColored && Instigator != None)
	{
		bColored = true;
		BOGPFlareTrail(Trail).SetupColor(Instigator.GetTeamNum());
	}

	Super.Tick(DT);
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    if(Pawn(Other) != None)
	{
		IgniteActor(Other);
		HitActor = Other;
		class'BallisticDamageType'.static.GenericHurt(Other, Max(5,ImpactDamage*(1.0-FallOff)), Instigator, HitLocation, Velocity, ImpactDamageType);
	}
}

simulated function FizzleOut()
{
	if(ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (Instigator == None)
			FizzleImpactManager.static.StartSpawn(Location, Vect(0,0,0), 0, Level.GetLocalPlayerController());
		else
			FizzleImpactManager.static.StartSpawn(Location, Vect(0,0,0), 0, Instigator);
	}

	Destroy();
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	if (Level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if(BOGPFlareTrail(Trail) != None)
		{
			if(Instigator != None)
			{
				bColored = true;
				BOGPFlareTrail(Trail).SetupColor(Instigator.GetTeamNum());
			}
		}
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
		if (Trail != None)
			Trail.SetBase (self);
	}
}

simulated function IgniteActor(Actor A)
{
	local BOGPFlareActorBurner PF;

	PF = Spawn(class'BOGPFlareActorBurner',self, ,A.Location);
	PF.Instigator = Instigator;

    if(Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		PF.InstigatorController = Instigator.Controller;

	PF.Initialize(A);
}

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local BW_FuelPatch Patch;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && BW_FuelPatch(Victims) == None && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			if(Pawn(Victims) != None && Vehicle(Victims) == None)
				IgniteActor(Victims);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	foreach VisibleCollidingActors(class 'BW_FuelPatch', Patch, IgniteRadius, HitLocation)
	{
		if(Patch != None)
			Patch.Ignite(Instigator);
	}
	bHurtEntry = false;
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if(NewVolume.bWaterVolume)
		Destroy();
}

defaultproperties
{
    WeaponClass=Class'BallisticProV55.BOGPPistol'
    FizzleImpactManager=Class'BallisticProV55.IM_BOGPFlareFizzle'
    FallSpeed=460.000000
    FallOffDistance=4600.000000
    IgniteRadius=256.000000
    ArmedDetonateOn=DT_Impact
    bNoInitialSpin=True
    bAlignToVelocity=True
    DetonateDelay=0.000000
    ImpactDamage=40
    ImpactDamageType=Class'BallisticProV55.DTBOGPFlare'
    ImpactManager=Class'BallisticProV55.IM_BOGPFlareScorch'
    TrailClass=Class'BallisticProV55.BOGPFlareTrail'
    MyRadiusDamageType=Class'BallisticProV55.DTBOGPFlareBurn'
    SplashManager=Class'BallisticProV55.IM_ProjWater'
    ShakeRadius=0.000000
    MotionBlurRadius=0.000000
    MotionBlurFactor=0.000000
    MotionBlurTime=0.000000
    TossZ=0.000000
    MyDamageType=Class'BallisticProV55.DTBOGPFlareBurn'
    LightType=LT_Steady
    LightEffect=LE_QuadraticNonIncidence
    LightHue=25
    LightSaturation=128
    LightBrightness=256.000000
    LightRadius=32.000000
    bDynamicLight=True
    LifeSpan=0.000000
    DrawScale=0.300000
    bIgnoreTerminalVelocity=True
}
