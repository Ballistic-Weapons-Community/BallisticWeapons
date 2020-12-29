//=============================================================================
// The emitter for the RX22A's gas spray altfire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AGasSpray extends DGVEmitter;

state Terminated
{
	simulated function BeginState()
	{
		SetTimer(0.15, false);
	}
	event Timer()
	{
		Kill();
	}
}

simulated function SetFlameRange(float Range)
{
	local int i;
	if (Range > 1350 && Emitters[0].UseCollision)
	{
		for (i=0;i<Emitters.length;i++)
			Emitters[i].UseCollision = false;
	}
	else if (!Emitters[0].UseCollision)
	{
		for (i=0;i<Emitters.length;i++)
			Emitters[i].UseCollision = true;
	}
}

event Tick(float DT)
{
	local int i;

	super.Tick(DT);

	Emitters[1].StartSpinRange.X.Max = float(Rotation.Yaw)/65536;
	Emitters[1].StartSpinRange.X.Min = Emitters[1].StartSpinRange.X.Max;
	Emitters[1].StartSpinRange.Y.Max = float(Rotation.Pitch)/65536 + 0.5;
	Emitters[1].StartSpinRange.Y.Min = Emitters[1].StartSpinRange.Y.Max;
	
	AlignVelocity();

	if (Owner != None)
	{
		for(i=0;i<Emitters.length;i++)
		{
			Emitters[i].StartVelocityRange.X.Max += Owner.Velocity.X;
			Emitters[i].StartVelocityRange.X.Min += Owner.Velocity.X;
			Emitters[i].StartVelocityRange.Y.Max += Owner.Velocity.Y;
			Emitters[i].StartVelocityRange.Y.Min += Owner.Velocity.Y;
			Emitters[i].StartVelocityRange.Z.Max += Owner.Velocity.Z;
			Emitters[i].StartVelocityRange.Z.Min += Owner.Velocity.Z;
		}
	}
}

simulated function InitDGV()
{
	OldRotation = Rotation;
	super.InitDGV();
}

defaultproperties
{
     bVerticalZ=False
     bYIsSpread=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.610000
         FadeOutStartTime=0.140000
         MaxParticles=4000
         SizeScale(0)=(RelativeSize=0.150000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         InitialParticlesPerSecond=80.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.AquaBubble1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         StartVelocityRange=(X=(Min=2900.000000,Max=3000.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22AGasSpray.SpriteEmitter16'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BallisticHardware2.Effects.VolumetricA2'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.900000,Max=0.900000))
         FadeOutStartTime=0.040000
         FadeInEndTime=0.027500
         MaxParticles=2000
         StartLocationOffset=(X=80.000000)
         SpinsPerSecondRange=(Z=(Max=1.000000))
         StartSpinRange=(Y=(Min=0.500000,Max=0.500000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
         InitialParticlesPerSecond=40.000000
         DrawStyle=PTDS_Darken
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         StartVelocityRange=(X=(Min=2500.000000,Max=3000.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.RX22AGasSpray.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Z=(Min=0.100000,Max=0.100000))
         Opacity=0.570000
         FadeOutStartTime=0.060000
         MaxParticles=2000
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=40.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.FlamePartsAlpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=2500.000000,Max=3000.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RX22AGasSpray.SpriteEmitter17'

     AutoDestroy=True
     bHardAttach=True
}
