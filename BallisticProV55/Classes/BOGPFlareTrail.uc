//=============================================================================
// BOGPFlareTrail.
//
// Trail for the BOGP flare.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPFlareTrail extends BallisticEmitter;

simulated function SetupColor(int TeamNum)
{
	if(TeamNum != 1)
		return;

	Emitters[0].ColorMultiplierRange.X.Min=0.5;
	Emitters[0].ColorMultiplierRange.X.Max=0.5;
	Emitters[0].ColorMultiplierRange.Y.Max=0.5;
	Emitters[0].ColorMultiplierRange.Y.Max=0.5;
	Emitters[0].ColorMultiplierRange.Z.Max=1.0;
	Emitters[0].ColorMultiplierRange.Z.Max=1.0;

	Emitters[1].ColorMultiplierRange.X.Min=0.75;
	Emitters[1].ColorMultiplierRange.X.Max=0.75;
	Emitters[1].ColorMultiplierRange.Y.Max=0.75;
	Emitters[1].ColorMultiplierRange.Y.Max=0.75;
	Emitters[1].ColorMultiplierRange.Z.Max=1.0;
	Emitters[1].ColorMultiplierRange.Z.Max=1.0;

	Emitters[2].ColorMultiplierRange.X.Min=0.65;
	Emitters[2].ColorMultiplierRange.X.Max=0.65;
	Emitters[2].ColorMultiplierRange.Y.Max=0.65;
	Emitters[2].ColorMultiplierRange.Y.Max=0.65;
	Emitters[2].ColorMultiplierRange.Z.Max=1.0;
	Emitters[2].ColorMultiplierRange.Z.Max=1.0;

	Emitters[3].ColorMultiplierRange.X.Min=0.65;
	Emitters[3].ColorMultiplierRange.X.Max=0.65;
	Emitters[3].ColorMultiplierRange.Y.Max=0.65;
	Emitters[3].ColorMultiplierRange.Y.Max=0.65;
	Emitters[3].ColorMultiplierRange.Z.Max=1.0;
	Emitters[3].ColorMultiplierRange.Z.Max=1.0;

	Emitters[4].ColorMultiplierRange.X.Min=0.35;
	Emitters[4].ColorMultiplierRange.X.Max=0.35;
	Emitters[4].ColorMultiplierRange.Y.Max=0.35;
	Emitters[4].ColorMultiplierRange.Y.Max=0.35;
	Emitters[4].ColorMultiplierRange.Z.Max=1.0;
	Emitters[4].ColorMultiplierRange.Z.Max=1.0;

	Emitters[5].ColorMultiplierRange.X.Min=0.5;
	Emitters[5].ColorMultiplierRange.X.Max=0.5;
	Emitters[5].ColorMultiplierRange.Y.Max=0.5;
	Emitters[5].ColorMultiplierRange.Y.Max=0.5;
	Emitters[5].ColorMultiplierRange.Z.Max=1.0;
	Emitters[5].ColorMultiplierRange.Z.Max=1.0;

	Emitters[6].ColorMultiplierRange.X.Min=0.55;
	Emitters[6].ColorMultiplierRange.X.Max=0.55;
	Emitters[6].ColorMultiplierRange.Y.Max=0.55;
	Emitters[6].ColorMultiplierRange.Y.Max=0.55;
	Emitters[6].ColorMultiplierRange.Z.Max=1.0;
	Emitters[6].ColorMultiplierRange.Z.Max=1.0;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.800000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-8.000000,Max=-8.000000))
         SpinsPerSecondRange=(X=(Min=0.300000,Max=0.300000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=220.000000,Max=260.000000),Y=(Min=220.000000,Max=260.000000),Z=(Min=220.000000,Max=260.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BOGPFlareTrail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.750000,Max=0.750000))
         FadeOutStartTime=0.600000
         CoordinateSystem=PTCS_Relative
         MaxParticles=60
         StartLocationRange=(X=(Max=-4.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=20.000000,Max=50.000000),Y=(Min=20.000000,Max=50.000000),Z=(Min=20.000000,Max=50.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=-600.000000),Y=(Min=-96.000000,Max=96.000000),Z=(Min=-96.000000,Max=96.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BOGPFlareTrail.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.650000,Max=0.650000),Z=(Min=0.650000,Max=0.650000))
         Opacity=0.250000
         FadeOutStartTime=1.980000
         MaxParticles=40
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=20.000000,Max=28.000000),Y=(Min=20.000000,Max=28.000000),Z=(Min=20.000000,Max=28.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-8.000000,Max=8.000000),Y=(Min=-8.000000,Max=8.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.BOGPFlareTrail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=160,G=96,R=96,A=255))
         ColorMultiplierRange=(Y=(Min=0.650000,Max=0.650000),Z=(Min=0.650000,Max=0.650000))
         FadeOutStartTime=2.000000
         MaxParticles=60
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=8.000000,Max=16.000000),Y=(Min=8.000000,Max=16.000000),Z=(Min=8.000000,Max=16.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000),Z=(Min=96.000000,Max=250.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.BOGPFlareTrail.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.350000,Max=0.350000),Z=(Min=0.350000,Max=0.350000))
         Opacity=0.200000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(X=(Min=-8.000000,Max=-8.000000))
         StartSizeRange=(X=(Min=900.000000,Max=1000.000000),Y=(Min=900.000000,Max=1000.000000),Z=(Min=900.000000,Max=1000.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.BOGPFlareTrail.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.100000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-8.000000,Max=-8.000000))
         SpinsPerSecondRange=(X=(Min=0.150000,Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=400.000000,Max=600.000000),Y=(Min=400.000000,Max=600.000000),Z=(Min=400.000000,Max=600.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.BOGPFlareTrail.SpriteEmitter5'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=50
         DistanceThreshold=100.000000
         PointLifeTime=6.000000
         FadeOut=True
         FadeIn=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.550000,Max=0.550000),Z=(Min=0.550000,Max=0.550000))
         Opacity=0.200000
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         MaxParticles=3
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=30.000000,Max=30.000000)
     End Object
     Emitters(6)=TrailEmitter'BallisticProV55.BOGPFlareTrail.TrailEmitter1'

     AutoDestroy=True
     bHardAttach=True
     bDirectional=True
}
