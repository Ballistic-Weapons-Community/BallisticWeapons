//=============================================================================
// G28GasCloud_Exp.
//
// A cloud of gas from the T10 grenade. The controller wil damage the actors this is touching
// Blows up!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class G28GasCloud_Exp extends BW_FuelPatch
	placeable;

var   AvoidMarker		Fear;			// Da phear spauwt...
var   G28CloudControl_Exp	MyControl;		// The cloud controlling actor
var   float				Density;		// How thick is this cloud. Adds up when grenade sits in once place for awhile
var() Sound				IgniteSound;
var   Pawn				Ignitioneer;	// Pawn responsible for igniting the fire

simulated event PostNetReceive()
{
	super.PostNetReceive();
	if (bIgnited)
		Ignite(None);
}

simulated function Ignite(Pawn EventInstigator)
{
	local RX22ACloudBang Bang;

	bIgnited = true;
	if (level.NetMode != NM_DedicatedServer)
	{
		Bang = Spawn(class'RX22ACloudBang',,,Location);
		Bang.InitCloudBang(1);
		PlaySound(IgniteSound, , 0.8, , 112);
	}
	if (Role == ROLE_Authority)
	{
		Ignitioneer = EventInstigator;
		HurtRadius(50, 224, class'DTG28CloudBomb', 10000, Location);
	}
}

simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local pawn InstigatedBy;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) )
		{
			if (Ignitioneer != None && (Victims == Instigator || Instigator == None))
				InstigatedBy = Ignitioneer;
			else
				InstigatedBy = Instigator;
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			Victims.TakeDamage
			(
				damageScale * DamageAmount,
				InstigatedBy,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
			if (Instigator != None && Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, Instigator.Controller, DamageType, Momentum, HitLocation);
		}
	}
	bHurtEntry = false;
}

function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (bIgnited)
		return;
	if (class<BallisticDamageType>(DamageType)!=None && !class<BallisticDamageType>(DamageType).default.bIgniteFires/* && !class<BallisticDamageType>(DamageType).IsDamage(",Flame,")*/)
		return;

	bIgnited = true;
//	if (EventInstigator != None)
//		Instigator = EventInstigator;
	SetTimer(0.2,false);
	Ignite(EventInstigator);
}


simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	MyControl = G28CloudControl_Exp(Owner);
	if (level.NetMode != NM_Client)
	{
		if (level.netMode == NM_DedicatedServer)
		{
			Emitters[0].Disabled = true;
			Emitters[1].Disabled = true;
		}
	}
}

function Reset()
{
	Destroy();
}

simulated function Terminate(float Delay)
{
	SetTimer(Delay, false);
}

simulated function Timer()
{
	if (level.netMode == NM_DedicatedServer)
		GotoState('DSDying');
	else
		Kill();
}

state DSDying
{
Begin:
	Sleep(3.0);
	Destroy();
}

simulated function Destroyed()
{
	if (MyControl != None)
		MyControl.CloudDie(self);
	if (Fear!=None)
		Fear.Destroy();
	super.Destroyed();
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
		Kill();
}

defaultproperties
{
     Fuel=100.000000
     IgniteSound=Sound'BW_Core_WeaponSound.RX22A.RX22A-IgniteFire'
     Density=1.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=150,R=150,A=200))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=255,G=150,R=150,A=200))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=58,R=58,A=64))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.900000,Max=0.900000))
         Opacity=0.490000
         FadeOutStartTime=1.050000
         FadeInEndTime=1.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=200
         StartLocationRange=(X=(Min=-96.000000,Max=96.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Max=0.010000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=150.000000,Max=200.000000),Z=(Min=150.000000,Max=200.000000))
         InitialParticlesPerSecond=0.700000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.G28GasCloud_Exp.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=150,R=150,A=200))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=255,G=150,R=150,A=200))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=58,R=58,A=64))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.900000,Max=0.900000))
         Opacity=0.580000
         FadeOutStartTime=1.450000
         FadeInEndTime=0.675000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationRange=(X=(Min=-64.000000,Max=64.000000))
         SpinsPerSecondRange=(X=(Max=0.030000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         InitialParticlesPerSecond=0.750000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=2.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.G28GasCloud_Exp.SpriteEmitter0'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
     bCanBeDamaged=True
     CollisionRadius=192.000000
     CollisionHeight=192.000000
     bCollideActors=True
     bUseCylinderCollision=True
     bNotOnDedServer=False
}
