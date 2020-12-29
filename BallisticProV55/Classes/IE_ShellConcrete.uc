//=============================================================================
// IE_ShellConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_ShellConcrete extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter38
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=96,G=96,R=96,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=96,G=96,R=96,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.850000
         FadeOutStartTime=0.500000
         FadeInEndTime=0.200000
         MaxParticles=3
         StartLocationRange=(Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=25.000000,Max=35.000000))
         InitialParticlesPerSecond=200000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=15.000000,Max=80.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_ShellConcrete.SpriteEmitter38'

     Begin Object Class=MeshEmitter Name=MeshEmitter12
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         RenderTwoSided=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-150.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000)
         FadeOutStartTime=1.000000
         MaxParticles=4
         DetailMode=DM_SuperHigh
         StartLocationRange=(Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         SpinsPerSecondRange=(X=(Max=4.000000),Y=(Max=4.000000),Z=(Max=4.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.400000),Y=(Min=0.100000,Max=0.400000),Z=(Min=0.100000,Max=0.400000))
         InitialParticlesPerSecond=200000.000000
         DrawStyle=PTDS_Regular
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=50.000000,Max=150.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.IE_ShellConcrete.MeshEmitter12'

     AutoDestroy=True
}
