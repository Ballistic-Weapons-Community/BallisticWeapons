/******************************************************************************
UT3TranslocatorEffectRed

Creation date: 2008-07-14 14:50
Last change: $Id$
Copyright (c) 2008, Wormbo
******************************************************************************/

class UT3TranslocatorEffectRed extends UT3TranslocatorEffect;


//=============================================================================
// Default values
//=============================================================================

defaultproperties
{
     FlashColor=(X=1000.000000,Y=200.000000,Z=200.000000)
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         RespawnDeadParticles=False
         UniformMeshScale=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.200000,Color=(G=12,R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=128,G=128,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=100
         SphereRadiusRange=(Min=24.000000,Max=24.000000)
         StartLocationPolarRange=(X=(Max=65536.000000),Y=(Min=16384.000000,Max=16384.000000),Z=(Min=48.000000,Max=64.000000))
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleCylinder'
         MeshSpawning=PTMS_Random
         MeshScaleRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=0.750000,Max=0.750000))
         RevolutionsPerSecondRange=(Z=(Max=1.000000))
         SpinsPerSecondRange=(Z=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         ScaleSizeByVelocityMultiplier=(X=0.020000,Y=0.020000)
         InitialParticlesPerSecond=150.000000
         Texture=Texture'EpicParticles.Flares.FlickerFlare2'
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRadialRange=(Min=-100.000000,Max=-300.000000)
         VelocityLossRange=(Z=(Max=50.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'LDGGameBW.UT3TranslocatorEffectRed.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=128,R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=64,G=64,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         StartLocationRange=(Z=(Min=-48.000000,Max=48.000000))
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         Texture=Texture'EpicParticles.Flares.FlickerFlare2'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         InitialDelayRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(1)=SpriteEmitter'LDGGameBW.UT3TranslocatorEffectRed.SpriteEmitter1'

}
