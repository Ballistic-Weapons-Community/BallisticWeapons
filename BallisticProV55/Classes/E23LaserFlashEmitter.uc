//=============================================================================
// E23SGFlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E23LaserFlashEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter4
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.VPR.VPRMuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.228571,Color=(B=96,G=96,R=96,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.152000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-2.000000)
         SpinCCWorCW=(Z=0.000000)
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.600000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.900000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=2.500000,Max=3.000000),Y=(Min=1.250000,Max=1.500000),Z=(Min=1.250000,Max=1.500000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         SpawnOnTriggerRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.E23LaserFlashEmitter.MeshEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.250000,Color=(B=96,G=96,R=96,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.102000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=55.000000,Max=70.000000),Y=(Min=55.000000,Max=70.000000),Z=(Min=55.000000,Max=70.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.E23LaserFlashEmitter.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=96,G=255,R=200,A=255))
         ColorMultiplierRange=(Z=(Min=0.750000,Max=0.750000))
         FadeOutStartTime=0.285000
         FadeInEndTime=0.015000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.100000)
         StartSizeRange=(X=(Min=30.000000,Max=35.000000),Y=(Min=30.000000,Max=35.000000),Z=(Min=30.000000,Max=35.000000))
         Texture=Texture'BW_Core_WeaponTex.VPR.VPR-MuzzleEffect'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=2.000000,Max=3.000000)
         SpawnOnTriggerPPS=20.000000
         StartVelocityRange=(X=(Min=150.000000,Max=350.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.E23LaserFlashEmitter.SpriteEmitter14'

}
