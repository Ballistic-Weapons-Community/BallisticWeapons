//=============================================================================
// IE_ShellWood.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_ShellWood extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter42
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=110,G=150,R=180,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=140,G=150,R=160,A=255))
         FadeOutStartTime=0.520000
         FadeInEndTime=0.120000
         MaxParticles=4
         StartLocationRange=(Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000))
         InitialParticlesPerSecond=100000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=20.000000,Max=50.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_ShellWood.SpriteEmitter42'

     Begin Object Class=MeshEmitter Name=MeshEmitter14
         StaticMesh=StaticMesh'BallisticHardware2.Impact.WoodChipA1'
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-150.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.100000
         MaxParticles=7
         DetailMode=DM_SuperHigh
         StartLocationRange=(Y=(Min=-15.000000,Max=15.000000),Z=(Min=-10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSizeRange=(X=(Min=0.050000,Max=0.200000),Y=(Min=0.050000,Max=0.200000),Z=(Min=0.050000,Max=0.150000))
         InitialParticlesPerSecond=100000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=50.000000,Max=150.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=50.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.IE_ShellWood.MeshEmitter14'

     AutoDestroy=True
}
