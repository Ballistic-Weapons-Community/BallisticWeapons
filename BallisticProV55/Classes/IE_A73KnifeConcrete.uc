//=============================================================================
// IE_A73KnifeConcrete.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_A73KnifeConcrete extends DGVEmitter
	placeable;
simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_High)
		Emitters[0].Disabled=true;
	Super.PreBeginPlay();
}

defaultproperties
{
     bVerticalZ=False
     Begin Object Class=MeshEmitter Name=MeshEmitter9
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=0.500000
         FadeInEndTime=0.100000
         StartLocationRange=(Y=(Min=-10.000000,Max=10.000000))
         SpinCCWorCW=(Z=1.000000)
         SpinsPerSecondRange=(X=(Max=3.000000),Y=(Max=3.000000),Z=(Max=3.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=0.100000,Max=0.500000),Y=(Min=0.100000,Max=0.500000),Z=(Min=0.100000,Max=0.500000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Regular
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=50.000000,Max=100.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_A73KnifeConcrete.MeshEmitter9'

     Begin Object Class=SparkEmitter Name=SparkEmitter8
         LineSegmentsRange=(Min=3.000000,Max=3.000000)
         TimeBeforeVisibleRange=(Min=5.000000,Max=5.000000)
         TimeBetweenSegmentsRange=(Min=0.200000,Max=0.200000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255))
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=0.300000
         MaxParticles=20
         StartLocationRange=(Y=(Min=-10.000000,Max=10.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=50.000000,Max=200.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Max=50.000000))
     End Object
     Emitters(1)=SparkEmitter'BallisticProV55.IE_A73KnifeConcrete.SparkEmitter8'

     AutoDestroy=True
}
