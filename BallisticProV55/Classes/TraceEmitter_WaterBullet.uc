//=============================================================================
// TraceEmitter_WaterBullet.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_WaterBullet extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	if (Emitters[0] != None)
	{
		Emitters[0].StartLocationRange.X.Max = FMin(2000, Distance);
		Emitters[0].SpawnOnTriggerRange.Min = FMin(120, Distance * 0.06);
		Emitters[0].SpawnOnTriggerRange.Max = Emitters[0].SpawnOnTriggerRange.Min;
		Trigger(Owner, None);
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=5.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.075000
         FadeInEndTime=0.175000
         CoordinateSystem=PTCS_Relative
         MaxParticles=120
         StartLocationRange=(X=(Max=1000.000000))
         StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.AquaBubble1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=2.500000)
         SpawnOnTriggerRange=(Min=100.000000,Max=100.000000)
         SpawnOnTriggerPPS=99999.000000
         StartVelocityRange=(X=(Max=100.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.TraceEmitter_WaterBullet.SpriteEmitter0'

}
