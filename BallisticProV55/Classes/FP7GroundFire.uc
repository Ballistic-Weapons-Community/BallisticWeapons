//=============================================================================
// FP7GroundFire.
//
// A small patch of fire. This is an emitter, but it also does the server side
// damage stuff. These will fall to the ground and stay wherever they land.
// This is spaawned on server for damage and on clients for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7GroundFire extends BallisticEmitter
	placeable;
	
const BURNINTERVAL = 0.2;

var   float				BurnTime;		// How long its been burning
var 	float				Damage;
var() class<DamageType>	DamageType;		// Damage type for touching damage
var   AvoidMarker		Fear;			// Da phear spauwt...
var Controller	InstigatorController;
var FP7FireControl	FireControl;

function Reset()
{
	Destroy();
}

simulated function Tick(float DT)
{
	super.Tick(DT);
	if (BurnTime == 666)
		return;
	BurnTime-=DT;
	if (BurnTime <= 0)
	{
		Kill();
		BurnTime=666;
	}
}

singular simulated event BaseChange()
{
	if (Mover(Base) != None)
		Destroy();
}

function Landed(vector HitNormal)
{
	HitWall(HitNormal, none);
}
function HitWall (vector HitNormal, actor Wall)
{
	SetPhysics(PHYS_None);
	if (level.NetMode == NM_Client)
		return;
	bCollideWorld=false;
	SetCollision(true, false, false);
	SetCollisionSize( 72, 72 );
	Fear = Spawn(class'AvoidMarker');
	Fear.SetCollisionSize(120, 120);
    Fear.StartleBots();
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	if (level.NetMode != NM_Client)
		SetTimer(BURNINTERVAL + (FRand() * 0.5), true);
	BurnTime -= 4*FRand();
	if (level.netMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
	}
}

function Timer()
{
	local Actor A;

	if (level.netMode == NM_DedicatedServer && BurnTime == 666)
		Destroy();

	if (PhysicsVolume.bWaterVolume)
		return;
		
	foreach TouchingActors(class'Actor', A)
	{
		if ( Instigator == None || Instigator.Controller == None )
			A.SetDelayedDamageInstigatorController( InstigatorController );
			
		if (Pawn(A) != None)
			FireControl.TryDamage(Pawn(A), BURNINTERVAL, DamageType);
		else class'BallisticDamageType'.static.GenericHurt (A, Damage, Instigator, A.Location, vect(0,0,0), DamageType);
	}
}

simulated function Destroyed()
{
	if (Fear!=None)
		Fear.Destroy();
	super.Destroyed();
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
	{
		if (level.netMode == NM_DedicatedServer)
			Destroy();
		else
			Kill();
	}
}

defaultproperties
{
     BurnTime=5.000000
     Damage=30.000000
     DamageType=Class'BallisticProV55.DTFP7Burned'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.600000))
         FadeOutStartTime=0.500000
         MaxParticles=40
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=2.000000,Max=3.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=4.000000,Max=7.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=125.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.FP7GroundFire.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.600000,Max=0.700000),Z=(Min=0.400000,Max=0.600000))
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(Z=15.000000)
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=30.000000,Max=50.000000))
         InitialParticlesPerSecond=4.000000
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=65.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.FP7GroundFire.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         Acceleration=(Z=60.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.800000),Z=(Min=0.000000,Max=0.400000))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.075000
         MaxParticles=2
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Max=30.000000))
         StartSizeRange=(X=(Min=7.000000,Max=70.000000),Y=(Min=7.000000,Max=70.000000),Z=(Min=7.000000,Max=70.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         LifetimeRange=(Min=0.100000,Max=0.500000)
         StartVelocityRange=(Z=(Max=30.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.FP7GroundFire.SpriteEmitter10'

     AutoDestroy=True
     Physics=PHYS_Falling
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bCollideWorld=True
     bUseCylinderCollision=True
     Mass=30.000000
     bNotOnDedServer=False
}
