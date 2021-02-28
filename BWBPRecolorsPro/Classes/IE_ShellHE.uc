//=============================================================================
// IE_ShellHE. Explosive shotgun shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_ShellHE extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(3)=1
     DisableDGV(4)=1
     DisableDGV(5)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter39
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.500000),Z=(Min=0.000000,Max=0.500000))
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartLocationRange=(Y=(Min=-20.000000,Max=20.000000),Z=(Min=-15.000000,Max=15.000000))
         StartSizeRange=(X=(Min=1.500000,Max=7.000000))
         InitialParticlesPerSecond=100000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.IE_ShellHE.SpriteEmitter39'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter40
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         FadeOutStartTime=0.500000
         MaxParticles=6
         DetailMode=DM_High
         StartLocationRange=(Y=(Min=-15.000000,Max=15.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSizeRange=(X=(Min=0.500000,Max=2.500000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=25.000000,Max=100.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=70.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_ShellHE.SpriteEmitter40'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.207143,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.357143,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.889286,Color=(R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.900000),Z=(Min=0.000000,Max=0.300000))
         FadeOutStartTime=0.132000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         SpinCCWorCW=(X=0.000000)
         SpinsPerSecondRange=(X=(Max=0.290000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=25.000000,Max=45.000000),Y=(Min=25.000000,Max=45.000000),Z=(Min=25.000000,Max=45.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.100000,Max=0.800000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_ShellHE.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.500000,Max=0.700000))
         Opacity=0.650000
         FadeOutStartTime=0.132000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(Y=(Min=-18.000000,Max=18.000000),Z=(Min=-13.000000,Max=13.000000))
         StartSizeRange=(X=(Min=5.000000,Max=15.000000),Y=(Min=5.000000,Max=15.000000),Z=(Min=5.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.IE_ShellHE.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.207143,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.360714,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.889286,Color=(R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.900000),Z=(Min=0.000000,Max=0.300000))
         Opacity=0.650000
         FadeOutStartTime=0.132000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(Y=(Min=-18.000000,Max=18.000000),Z=(Min=-13.000000,Max=13.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=8.000000,Max=25.000000),Y=(Min=8.000000,Max=25.000000),Z=(Min=8.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPRecolorsPro.IE_ShellHE.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=5.000000)
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.207143,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.360714,Color=(A=255))
         ColorScale(3)=(RelativeTime=0.889286,Color=(A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.650000
         FadeOutStartTime=0.132000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(Y=(Min=-18.000000,Max=18.000000),Z=(Min=-13.000000,Max=13.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=8.000000,Max=25.000000),Y=(Min=8.000000,Max=25.000000),Z=(Min=8.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.100000,Max=0.900000)
         StartVelocityRange=(Z=(Max=60.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPRecolorsPro.IE_ShellHE.SpriteEmitter31'

     Begin Object Class=SparkEmitter Name=SparkEmitter4
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.200000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=192,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255))
         FadeOutStartTime=0.500000
         StartLocationRange=(Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=12.000000))
         InitialParticlesPerSecond=100000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.250000,Max=1.250000)
         StartVelocityRange=(X=(Min=25.000000,Max=100.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-20.000000,Max=50.000000))
     End Object
     Emitters(6)=SparkEmitter'BWBPRecolorsPro.IE_ShellHE.SparkEmitter4'

     AutoDestroy=True
}
