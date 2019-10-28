//=============================================================================
// IE_ShellWater.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_ShellWater extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BallisticHardware2.Effects.VolumetricA4'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=225,R=200,A=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=225,R=200,A=128))
         FadeOutStartTime=0.120000
         FadeInEndTime=0.042000
         MaxParticles=2
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(Y=(Min=0.250000,Max=0.250000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=0.100000,Max=0.250000),Y=(Min=0.200000,Max=0.400000),Z=(Min=0.200000,Max=0.400000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_ShellWater.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=5))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=5))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.460000
         FadeOutStartTime=0.225000
         FadeInEndTime=0.060000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=3.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=8.000000
         DrawStyle=PTDS_Modulated
         Texture=Texture'BallisticEffects.Particles.RippleA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_ShellWater.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseCollision=True
         UseCollisionPlanes=True
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-180.000000)
         CollisionPlanes(0)=(W=-70.000000,Z=1.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.620000
         FadeOutStartTime=0.570000
         FadeInEndTime=0.075000
         MaxParticles=8
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.WaterParticle1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=2.000000,Max=200.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_ShellWater.SpriteEmitter6'

     AutoDestroy=True
}
