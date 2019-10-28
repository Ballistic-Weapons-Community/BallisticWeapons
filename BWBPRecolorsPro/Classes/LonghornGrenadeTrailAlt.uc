//=============================================================================
// LonghornGrenadeTrailAlt.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LonghornGrenadeTrailAlt extends BallisticEmitter;

simulated function SetupColor(int TeamNum)
{
	if(TeamNum != 1)
		return;

	Emitters[0].ColorMultiplierRange.X.Max=0.20;
	Emitters[0].ColorMultiplierRange.X.Min=0.10;
	Emitters[0].ColorMultiplierRange.Y.Max=0.60;
	Emitters[0].ColorMultiplierRange.Y.Min=0.20;
	Emitters[0].ColorMultiplierRange.Z.Max=0.50;
	Emitters[0].ColorMultiplierRange.Z.Min=0.30;

	Emitters[4].ColorMultiplierRange.X.Max=0.20;
	Emitters[4].ColorMultiplierRange.X.Min=0.10;
	Emitters[4].ColorMultiplierRange.Y.Max=0.60;
	Emitters[4].ColorMultiplierRange.Y.Min=0.20;
	Emitters[4].ColorMultiplierRange.Z.Max=0.50;
	Emitters[4].ColorMultiplierRange.Z.Min=0.30;


}

simulated function ActivateBeacon()
{
	Emitters[7].Disabled=false;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseCollision=True
         UseMaxCollisions=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-2000.000000)
         ColorScale(0)=(Color=(B=180,G=180,R=180,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=160,G=96,R=96,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.200000,Max=0.800000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=3.000000
         MaxParticles=200
         DetailMode=DM_High
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000),Z=(Min=200.000000,Max=800.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailAlt.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=196,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.200000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(X=(Min=-8.000000,Max=-8.000000))
         StartSizeRange=(X=(Min=20.000000,Max=25.000000),Y=(Min=20.000000,Max=25.000000),Z=(Min=20.000000,Max=25.000000))
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailAlt.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=196,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.100000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-8.000000,Max=-8.000000))
         SpinsPerSecondRange=(X=(Min=0.150000,Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=25.000000),Y=(Min=20.000000,Max=25.000000),Z=(Min=20.000000,Max=25.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailAlt.SpriteEmitter5'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=20
         DistanceThreshold=100.000000
         PointLifeTime=1.000000
         FadeOut=True
         FadeIn=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=64,G=64,R=64,A=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64,A=128))
         Opacity=0.100000
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         MaxParticles=3
         DetailMode=DM_High
         StartSizeRange=(X=(Min=50.000000,Max=55.000000),Y=(Min=25.000000,Max=27.000000),Z=(Min=25.000000,Max=27.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=1.000000)
     End Object
     Emitters(3)=TrailEmitter'BWBPRecolorsPro.LonghornGrenadeTrailAlt.TrailEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseCollision=True
         UseMaxCollisions=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-1500.000000)
         ColorScale(0)=(Color=(B=180,G=180,R=180,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=160,G=96,R=96,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.200000,Max=0.800000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=3.000000
         MaxParticles=40
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000),Z=(Min=200.000000,Max=800.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailAlt.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         Opacity=0.650000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.150000
         MaxParticles=45
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=2.000000)
         StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=80.000000,Max=105.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailAlt.SpriteEmitter28'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=True
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=196,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.160400
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.300000,Max=0.300000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         LifetimeRange=(Min=0.401000,Max=0.401000)
     End Object
     Emitters(6)=SpriteEmitter'BWBPRecolorsPro.LonghornGrenadeTrailAlt.SpriteEmitter7'

     AutoDestroy=True
     bHardAttach=True
     bDirectional=True
}
