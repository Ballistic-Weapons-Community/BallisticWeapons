//=============================================================================
// The RX22A flamer's primary fire effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22ASpray extends DGVEmitter;

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
	if (Range > 1800 && Emitters[0].UseCollision)
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
	if (Owner == None)
		return;
		
	AlignVelocity();

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

simulated function InitDGV()
{
	OldRotation = Rotation;
	super.InitDGV();
}

defaultproperties
{
     bVerticalZ=False
     bYIsSpread=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-75.000000)
         ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.488400
         FadeInEndTime=0.066000
         MaxParticles=3000
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.610000,RelativeSize=0.750000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.550000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=45.453999
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.660000,Max=0.660000)
         StartVelocityRange=(X=(Min=2250.000000,Max=2700.000000),Y=(Min=-120.000000,Max=120.000000),Z=(Min=-65.000000,Max=120.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22ASpray.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.R78.RifleMuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=64,A=255))
         ColorScale(1)=(RelativeTime=0.332143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=192,R=255,A=255))
         FadeOutStartTime=0.378000
         FadeInEndTime=0.066000
         MaxParticles=4000
         StartSpinRange=(Y=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=2.500000,Max=2.500000))
         InitialParticlesPerSecond=66.667000
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=3000.000000,Max=3000.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.RX22ASpray.MeshEmitter0'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=1.000000,Max=2.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.100000)
         UseColorScale=True
         FadeOut=True
         Disabled=True
         Backup_Disabled=True
         Acceleration=(Z=-75.000000)
         ColorScale(0)=(Color=(B=255,G=128,A=255))
         ColorScale(1)=(RelativeTime=0.414286,Color=(B=96,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         FadeOutStartTime=0.384000
         MaxParticles=100
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=2700.000000,Max=3750.000000),Y=(Min=-90.000000,Max=90.000000),Z=(Min=-90.000000,Max=90.000000))
     End Object
     Emitters(2)=SparkEmitter'BallisticProV55.RX22ASpray.SparkEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=128,A=255))
         ColorScale(1)=(RelativeTime=0.289286,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.770000
         FadeOutStartTime=0.372000
         FadeInEndTime=0.144000
         MaxParticles=1500
         SizeScale(0)=(RelativeSize=0.170000)
         SizeScale(1)=(RelativeTime=0.550000,RelativeSize=0.750000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.300000)
         StartSizeRange=(X=(Max=140.000000),Y=(Max=140.000000),Z=(Max=140.000000))
         InitialParticlesPerSecond=25.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=2700.000000,Max=3300.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RX22ASpray.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=64,A=255))
         ColorScale(1)=(RelativeTime=0.342857,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.800000
         FadeOutStartTime=0.420000
         FadeInEndTime=0.108000
         MaxParticles=3000
         SpinCCWorCW=(X=1.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=0.870000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=60.000000,Max=80.000000),Y=(Min=60.000000,Max=80.000000),Z=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=2700.000000,Max=3000.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RX22ASpray.SpriteEmitter2'

     AutoDestroy=True
     bHardAttach=True
}
