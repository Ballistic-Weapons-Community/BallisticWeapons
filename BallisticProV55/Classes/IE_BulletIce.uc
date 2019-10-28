//=============================================================================
// IE_BulletIce.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletIce extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter3
         StaticMesh=StaticMesh'BallisticHardware2.Impact.Ice1'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.750000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.400000),Y=(Min=0.100000,Max=0.400000),Z=(Min=0.100000,Max=0.400000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Regular
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=150.000000,Max=250.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_BulletIce.MeshEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.260000
         FadeOutStartTime=2.100000
         FadeInEndTime=0.120000
         StartSizeRange=(X=(Min=8.000000,Max=15.000000),Y=(Min=8.000000,Max=15.000000),Z=(Min=8.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Max=8.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_BulletIce.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.760000
         FadeOutStartTime=1.342000
         FadeInEndTime=0.110000
         MaxParticles=20
         AlphaRef=128
         SpinsPerSecondRange=(X=(Min=1.000000,Max=2.000000))
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.FlamePartsAlpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.200000,Max=2.200000)
         StartVelocityRange=(X=(Min=150.000000,Max=300.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_BulletIce.SpriteEmitter6'

     AutoDestroy=True
}
