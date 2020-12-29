//=============================================================================
// IE_BloodShellPurple.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BloodShellPurple extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.BloodVolumetric'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.800000),Y=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.287000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         AlphaRef=64
         SpinsPerSecondRange=(Z=(Max=1.000000))
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.510000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.600000),Y=(Min=1.500000,Max=2.000000),Z=(Min=1.500000,Max=2.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(X=(Min=40.000000,Max=40.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_BloodShellPurple.MeshEmitter0'

     AutoDestroy=True
}
