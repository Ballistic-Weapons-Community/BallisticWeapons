//=============================================================================
// BG_StumpSpurter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_StumpSpurter extends DGVEmitter;

var float nextSpurtTime;
var bool  bKillingTime;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	Emitters[0].Trigger();
	nextSpurtTime = Level.TimeSeconds + 1.5;
}

simulated event Timer()
{
	if (bKillingTime)
	{
		Destroy();
		return;
	}
	super.Timer();

	if (nextSpurtTime > Level.TimeSeconds)
		return;

	nextSpurtTime = Level.TimeSeconds + 1.5;
	Emitters[0].SpawnOnTriggerRange.Max *= 0.85;
	Emitters[0].SpawnOnTriggerRange.Min *= 0.85;
	Emitters[0].SpawnOnTriggerPPS *= 0.85;
	Emitters[0].Trigger();

	if (Emitters[0].SpawnOnTriggerRange.Max < 10)
	{
		SetTimer(6.0, false);
		bKillingTime=true;
		Kill();
	}
}

defaultproperties
{
     bAutoAlignVelocity=True
     DisableDGV(1)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         UseSpawnedVelocityScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=-100.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnFromOtherEmitter=1
         SpawnAmount=1
         SpawnedVelocityScaleRange=(X=(Min=0.050000,Max=0.050000),Y=(Min=0.050000,Max=0.050000),Z=(Min=0.050000,Max=0.050000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.700000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.768000
         MaxParticles=200
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=3.000000,Max=5.000000),Z=(Min=3.000000,Max=5.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Particles.BloodDrip1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=1.200000)
         SpawnOnTriggerRange=(Min=18.000000,Max=25.000000)
         SpawnOnTriggerPPS=20.000000
         StartVelocityRange=(X=(Min=70.000000,Max=80.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=25.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_StumpSpurter.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=9.080000
         MaxParticles=30
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=0.900000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         DrawStyle=PTDS_Modulated
         Texture=Texture'BallisticBloodPro.Decals.Splat2'
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=10000.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_StumpSpurter.SpriteEmitter22'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         UseSpawnedVelocityScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnFromOtherEmitter=1
         SpawnAmount=1
         SpawnedVelocityScaleRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.700000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.768000
         MaxParticles=100
         StartLocationRange=(Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=5.000000,Max=12.000000),Z=(Min=5.000000,Max=12.000000))
         InitialParticlesPerSecond=10.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Particles.BloodDrip1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=1.200000)
         StartVelocityRange=(X=(Min=10.000000,Max=40.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=5.000000,Max=30.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.BG_StumpSpurter.SpriteEmitter23'

}
