//=============================================================================
// RX22ASurfaceFire.
//
// A fire on a surface. Intensity varies depending on fuel.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22ASurfaceFire extends BW_FuelPatch
	placeable;

var() float				Damage;			// Damage per 0.5 seconds
var() class<DamageType>	DamageType;		// Damage type for touching damage
var Controller	InstigatorController;
var   float				LastTriggerTime;
var() Sound				IgniteSound;

var   RX22AFireControl	GasControl;
var   Pawn				Ignitioneer;	// Pawn responsible for igniting the fire

var   bool				bPlayIgnite;
var   actor				MyAmbientSoundActor;

var   float			RepulsionForceMag;

replication
{
	unreliable if (Role == ROLE_Authority && bNetInitial)
		bPlayIgnite;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (bPlayIgnite && Role < ROLE_Authority)
		PlayIgnite();
}

simulated function PlayIgnite()
{
	if (level.NetMode != NM_DedicatedServer)
		Spawn(class'RX22ATrailIgnite',,,Location);
	if (Role == ROLE_Authority)
		bPlayIgnite=true;
}

// Scales a RangeVector
simulated function RangeVector MultiplyRV (RangeVector RV, float Scale)
{
	RV.X.Max*=Scale;	RV.Y.Max*=Scale;	RV.Z.Max*=Scale;
	RV.X.Min*=Scale;	RV.Y.Min*=Scale;	RV.Z.Min*=Scale;
	return RV;
}

simulated function FuelChanged()
{
	if (level.NetMode == NM_DedicatedServer)
		return;
	Emitters[0].StartSizeRange = MultiplyRV(default.Emitters[0].StartSizeRange, lerp(Fuel/MaxFuel, 1, 2.5));
	Emitters[1].StartSizeRange = MultiplyRV(default.Emitters[1].StartSizeRange, lerp(Fuel/MaxFuel, 1, 2.25));
	if (Fuel/MaxFuel > 0.5)
	{
		Emitters[2].Disabled = false;
		Emitters[2].StartSizeRange = MultiplyRV(default.Emitters[2].StartSizeRange, lerp((Fuel-5)/(MaxFuel-5), 0.25, 1));
	}
	else
		Emitters[2].Disabled = true;
}

function Timer()
{
	if (PhysicsVolume.bWaterVolume)
		return;

	super.Timer();
}

function Toast(Actor A)
{
	local Vector XYVel;
	local int		  Health;
	if ( (Instigator == None || Instigator.Controller == None) && InstigatorController != None)
		A.SetDelayedDamageInstigatorController( InstigatorController );
	if (Pawn(A) != None)
		Health = Pawn(A).Health;
	if (Ignitioneer != None && (A == Instigator || BW_FuelPatch(A)!=None) || (Instigator==None && InstigatorController==None))
		class'BallisticDamageType'.static.GenericHurt (A, Damage, Ignitioneer, A.Location, vect(0,0,0), DamageType);
	else
		class'BallisticDamageType'.static.GenericHurt (A, Damage, Instigator, A.Location, vect(0,0,0), DamageType);	
	//No, you will not just "ignore" fires! :)
	if (Pawn(A) != None && Pawn(A).Health < Health) // took damage
	{
		XYVel = -A.Velocity;
		XYVel.Z = 0;
		Pawn(A).AddVelocity(XYVel + RepulsionForceMag * Normal(A.Location - Location) + vect(0,0,20));
	}
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Role == ROLE_Authority)
	{
		if (Instigator == None)
			Instigator = Pawn(Owner);
		if (InstigatorController == None && Instigator != None)
			InstigatorController = Instigator.Controller;
	}

	if (PhysicsVolume.bWaterVolume)
	{	Destroy();	return;		}
	AddFuel(0);
	if (level.netMode != NM_DedicatedServer)
	{
		PlaySound(IgniteSound, , 0.4, , 96);
		MyAmbientSoundActor=Spawn(class'RX22AFlameSound',,,location);
	}
}

simulated function Destroyed()
{
	if (MyAmbientSoundActor != None)
		MyAmbientSoundActor.Destroy();
	if (GasControl!=None)
		GasControl.PatchRemove(self);
	super.Destroyed();
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
		Kill();
}

defaultproperties
{
     Damage=25.000000
     DamageType=Class'BallisticProV55.DTRX22AFireTrap'
     IgniteSound=Sound'BW_Core_WeaponSound.RX22A.RX22A-IgniteFire'
     RepulsionForceMag=275.000000
     Fuel=8.000000
     MaxFuel=20.000000
     Extent=64
     bCanIgnite=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=80.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.490000
         FadeInEndTime=0.490000
         MaxParticles=2
         StartLocationRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000))
         StartSpinRange=(X=(Min=0.450000,Max=0.550000))
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=60.000000),Y=(Min=40.000000,Max=50.000000),Z=(Min=40.000000,Max=50.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22ASurfaceFire.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-31.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22ASurfaceFire.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         Disabled=True
         Backup_Disabled=True
         UniformSize=True
         Acceleration=(Z=80.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=32,G=64,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.392000
         FadeInEndTime=0.392000
         MaxParticles=2
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         StartSizeRange=(X=(Max=70.000000),Y=(Max=70.000000),Z=(Max=70.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RX22ASurfaceFire.SpriteEmitter5'

     AutoDestroy=True
     bNetInitialRotation=True
     RemoteRole=ROLE_SimulatedProxy
     CollisionRadius=72.000000
     CollisionHeight=70.000000
     bCollideActors=True
}
