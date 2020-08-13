//=============================================================================
// BOGPFlareActorBurner.
//
// Fire attached to players. This is spawned on server to do damage and on
// client for effects.
//
// 45 + 72 == 117. 
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPFlareActorBurner extends BallisticEmitter
	placeable;

var   Actor				Victim;			// The guy on fire
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done every 0.5 seconds
var() float				BurnTime;		// How to burn for
var Controller	InstigatorController;

function Reset()
{
	Destroy();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(1, true);

	if (level.netMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
		Emitters[3].Disabled=true;
	}
	else
	{
		// Attach emitters properly
		Emitters[0].SkeletalMeshActor = Victim;
		Emitters[1].SkeletalMeshActor = Victim;
		Emitters[2].SkeletalMeshActor = Victim;
		Emitters[3].SkeletalMeshActor = Victim;
	}
	SetLocation(Victim.Location - vect(0, 0, 1)*Victim.CollisionHeight);
	SetRotation(Victim.Rotation + rot(0, -16384, 0));
	SetBase(Victim);
}

simulated event Timer()
{
	if (BurnTime == -1)
		return;
	BurnTime-=1;
	if (BurnTime <= 0 || Victim.PhysicsVolume.bWaterVolume)
	{
		BurnTime=-1;
		Kill();
		bDynamicLight=false;
	}
	if (Victim != None && Level.NetMode != NM_Client && BurnTime > 1)
	{
		if ( Instigator == None || Instigator.Controller == None )
			Victim.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (Victim, Damage, Instigator, Victim.Location, vect(0,0,0), DamageType);
	}
}

simulated event Tick(float DT)
{
	Super.Tick(DT);
	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (level.netMode == NM_DedicatedServer && BurnTime <= 1)
		Destroy();
	if (BurnTime == -1)
		return;
	else if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		Emitters[0].SkeletalMeshActor = None;
		Emitters[1].SkeletalMeshActor = None;
		Emitters[2].SkeletalMeshActor = None;
		Emitters[3].SkeletalMeshActor = None;
		SetBase(None);
		Kill();
		BurnTime=-1;
	}
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
     DamageType=Class'BallisticProV55.DTBOGPFlareBurn'
     Damage=15
     BurnTime=6.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.600000))
         FadeOutStartTime=0.200000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=400
         StartLocationRange=(X=(Min=-7.000000,Max=7.000000),Y=(Min=-7.000000,Max=7.000000),Z=(Max=7.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=3.000000,Max=5.000000))
         UseSkeletalLocationAs=PTSU_Location
         SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=20.000000,Max=50.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BOGPFlareActorBurner.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=192))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.400000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         UseSkeletalLocationAs=PTSU_Location
         SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BOGPFlareActorBurner.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.580000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.920000
         MaxParticles=200
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=80.000000)
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=20.000000,Max=20.000000))
         SpinsPerSecondRange=(X=(Max=0.300000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=8.000000,Max=20.000000))
         UseSkeletalLocationAs=PTSU_SpawnOffset
         SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=140.000000,Max=160.000000))
         VelocityLossRange=(Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.BOGPFlareActorBurner.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.500000,Max=0.600000))
         FadeOutStartTime=0.530000
         FadeInEndTime=0.280000
         CoordinateSystem=PTCS_Relative
         MaxParticles=50
         StartLocationOffset=(Y=8.000000)
         StartLocationRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=20.000000,Max=70.000000))
         StartSpinRange=(X=(Min=0.450000,Max=0.550000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=80.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.BOGPFlareActorBurner.SpriteEmitter14'

     AutoDestroy=True
     LightType=LT_Flicker
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     bDynamicLight=True
     AmbientSound=Sound'BallisticSounds2.FP7.FP7FireLoop'
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
}
