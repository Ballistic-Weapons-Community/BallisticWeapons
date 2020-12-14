//=============================================================================
// IE_GunConcrete.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_GunConcrete extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[0].Disabled=true;
	Super.PreBeginPlay();
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter6
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
         MaxParticles=5
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
     Emitters(0)=MeshEmitter'BallisticProV55.IE_GunConcrete.MeshEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-30.000000)
         ColorScale(0)=(Color=(B=230,G=240,R=255,A=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=230,G=240,R=255,A=255))
         FadeOutStartTime=0.100000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Max=0.300000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=20.000000,Max=60.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=30.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_GunConcrete.SpriteEmitter14'

}
