//=============================================================================
// RSNova_OneShotZap.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNova_OneShotZap extends BallisticEmitter;

simulated function SetTarget(vector End, bool Hit)
{
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset = VToRV(End, End);
	if (Hit)
	{
		Emitters[2].StartLocationOffset = End;
		Emitters[3].StartLocationOffset = End;
	}
	else
	{
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
	}
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamEndPoints(0)=(offset=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000)))
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         BeamTextureUScale=4.000000
         RotatingSheets=3
         LowFrequencyNoiseRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
         HighFrequencyNoiseRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.471429,Color=(A=255))
         ColorScale(4)=(RelativeTime=0.646429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.195000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=2.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.RSNova_OneShotZap.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.471429,Color=(A=255))
         ColorScale(4)=(RelativeTime=0.628571,Color=(B=255,G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.700000),Y=(Min=0.700000,Max=0.900000))
         FadeOutStartTime=0.170000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNova_OneShotZap.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=64,A=255))
         ColorScale(2)=(RelativeTime=0.289286,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.428571,Color=(B=64,A=255))
         ColorScale(4)=(RelativeTime=0.617857,Color=(B=255,G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(G=192,R=255,A=255))
         FadeOutStartTime=0.470000
         CoordinateSystem=PTCS_Absolute
         MaxParticles=1
         StartLocationOffset=(X=400.000000,Y=400.000000)
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.750000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSNova_OneShotZap.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=192,R=255,A=255))
         FadeOutStartTime=1.280000
         CoordinateSystem=PTCS_Absolute
         StartLocationOffset=(X=400.000000,Y=400.000000)
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Max=1000.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSNova_OneShotZap.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.100000,Max=0.100000))
         Opacity=0.540000
         FadeOutStartTime=0.180000
         FadeInEndTime=0.180000
         MaxParticles=100
         AddLocationFromOtherEmitter=3
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         AddVelocityFromOtherEmitter=3
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSNova_OneShotZap.SpriteEmitter3'

     AutoDestroy=True
}
