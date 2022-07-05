//=============================================================================
// A73FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HMCFlashEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
		 ZTest=True
         FadeOut=True
         RespawnDeadParticles=False
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.121429,Color=(B=255,G=192,A=255))
         ColorScale(2)=(RelativeTime=0.242857,Color=(B=255,G=128,A=255))
         ColorScale(3)=(RelativeTime=0.385714,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=0.571429,Color=(G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(G=128,R=128,A=255))
         FadeOutStartTime=0.045000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=10.000000)
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.HMCFlashEmitter.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
		 ZTest=True
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.089286,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.178571,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.275000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=0.400000,Color=(B=255,G=128,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.028000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=40.000000)
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=160.000000,Max=160.000000),Z=(Min=160.000000,Max=160.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterSpray1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
         StartVelocityRange=(X=(Min=340.000000,Max=340.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.HMCFlashEmitter.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
		 ZTest=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=180,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=91,G=91,R=91,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.860000
         FadeOutStartTime=1.020000
         FadeInEndTime=0.560000
         MaxParticles=40
         StartLocationRange=(X=(Min=-30.000000))
         SpinsPerSecondRange=(X=(Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=3.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         SpawnOnTriggerRange=(Min=4.000000,Max=6.000000)
         SpawnOnTriggerPPS=20.000000
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=50.000000,Max=65.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.HMCFlashEmitter.SpriteEmitter26'
}
