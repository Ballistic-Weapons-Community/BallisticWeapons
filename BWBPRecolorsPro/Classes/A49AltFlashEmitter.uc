//=============================================================================
// E23SGFlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class A49AltFlashEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.050000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_SuperHigh
         SpinCCWorCW=(X=1.000000)
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=120.000000,Max=120.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         DrawStyle=PTDS_Modulated
         Texture=Texture'BallisticEffects.Particles.RippleA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
         SpawnOnTriggerRange=(Min=4.000000,Max=4.000000)
         SpawnOnTriggerPPS=9.000000
         StartVelocityRange=(X=(Min=800.000000,Max=800.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.A49AltFlashEmitter.SpriteEmitter8'

}
