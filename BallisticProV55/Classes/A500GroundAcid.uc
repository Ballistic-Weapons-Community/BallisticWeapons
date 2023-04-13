//=============================================================================
// A500GroundAcid.
//
// A small patch of acid. This is an emitter, but it also does the server side
// damage stuff. These will fall to the ground and stay wherever they land.
// This is spawned on server for damage and on clients for effects.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500GroundAcid extends BallisticEmitter
	placeable;

const BURNINTERVAL = 0.3;

var   float				BurnTime;		// How long its been burning
var() float				Damage;			// Damage per 0.5 seconds
var() class<DamageType>	DamageType;		// Damage type for touching damage
var   AvoidMarker		Fear;			// Da phear spauwt...
var Controller	InstigatorController;
var bool				bStuck, bSetup;
var A500AcidControl	AcidControl;

replication
{
	reliable if (Role == ROLE_Authority)
		BurnTime;
}

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
		if(Level.NetMode == NM_DedicatedServer)
			bTearOff=True;
		Kill();
		BurnTime=666;
	}
}

function Landed(vector HitNormal)
{
	HitWall(HitNormal, none);
}

function HitWall (vector HitNormal, actor Wall)
{
	local Projector P;
	
	SetPhysics(PHYS_None);
	if (level.NetMode == NM_Client)
		return;
	bCollideWorld=false;
	SetRotation(rot(32768,0,0));
	SetCollision(true, false, false);
	SetCollisionSize( 108, 128 );
	Fear = Spawn(class'AvoidMarker');
	Fear.SetCollisionSize(120, 120);
    Fear.StartleBots();
	P = Spawn(Class'AD_A500BlastSplat', Self,, Location, Rotator(-HitNormal));
	if (BallisticDecal(P) != None && BallisticDecal(P).bWaitForInit)
		BallisticDecal(P).InitDecal();
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	if (level.NetMode != NM_Client)
		SetTimer(BURNINTERVAL + (FRand() * 0.5), true);
	BurnTime -= 2*FRand();
	if (level.NetMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
	}
}

function Timer()
{
	local Actor A;

	if (level.netMode == NM_DedicatedServer && BurnTime == 666 || AcidControl == None)
		Destroy();

	if (PhysicsVolume.bWaterVolume)
		return;

	foreach TouchingActors(class'Actor', A)
	{
		if ( Instigator == None || Instigator.Controller == None )
			A.SetDelayedDamageInstigatorController( InstigatorController );
			
		if (Pawn(A) != None)
			AcidControl.TryDamage(Pawn(A), BURNINTERVAL, Damage, DamageType);
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
     BurnTime=8.000000
     Damage=25.000000
     DamageType=Class'BallisticProV55.DTA500Pool'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-800.000000)
         ColorScale(0)=(Color=(G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.521429,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=170,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.337500
         FadeInEndTime=0.036000
         MaxParticles=75
         StartLocationRange=(Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.250000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=4.000000,Max=6.000000),Y=(Min=4.000000,Max=15.000000),Z=(Min=4.000000,Max=6.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidDrops01'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.450000,Max=0.450000)
         StartVelocityRange=(X=(Min=-350.000000,Max=350.000000),Y=(Min=-350.000000,Max=350.000000),Z=(Min=250.000000,Max=750.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A500GroundAcid.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.221429,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=255,A=255))
         Opacity=0.760000
         FadeOutStartTime=0.246000
         FadeInEndTime=0.030000
         MaxParticles=16
         StartLocationRange=(Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         SpinsPerSecondRange=(X=(Max=0.600000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=18.000000,Max=30.000000),Y=(Min=18.000000,Max=30.000000),Z=(Min=18.000000,Max=30.000000))
         InitialParticlesPerSecond=25.000000
         Texture=Texture'BallisticBloodPro.DeRez.Wisp1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Max=25.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.A500GroundAcid.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.221429,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=255,A=255))
         FadeOutStartTime=0.354000
         FadeInEndTime=0.024000
         MaxParticles=25
         StartLocationRange=(Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         SpinsPerSecondRange=(X=(Max=0.600000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.125000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=4.000000,Max=10.000000),Y=(Min=4.000000,Max=10.000000),Z=(Min=4.000000,Max=10.000000))
         InitialParticlesPerSecond=35.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaBubbleA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
         StartVelocityRange=(X=(Min=-55.000000,Max=55.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=25.000000,Max=95.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.A500GroundAcid.SpriteEmitter14'

     AutoDestroy=True
     bNetTemporary=True
     Physics=PHYS_Falling
     RemoteRole=ROLE_SimulatedProxy
	 
     LifeSpan=15.000000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bCollideWorld=True
     bUseCylinderCollision=True
     Mass=30.000000
     bNotOnDedServer=False
     bDirectional=True
}
