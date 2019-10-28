//=============================================================================
// G5HatchEmitter.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G5HatchEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=128,G=128,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=128))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=75
         StartLocationOffset=(X=-190.000000,Z=10.000000)
         StartLocationRange=(X=(Max=40.000000))
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=25.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=2.500000)
         SpawnOnTriggerRange=(Min=30.000000,Max=30.000000)
         SpawnOnTriggerPPS=40.000000
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.G5HatchEmitter.SpriteEmitter4'

}
