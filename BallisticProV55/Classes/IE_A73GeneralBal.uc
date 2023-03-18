//=============================================================================
// IE_A73General.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_A73GeneralBal extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[2].Disabled=true;
	if (Level.DetailMode < DM_High)
		Emitters[0].Disabled=true;

//	if ( !FastTrace(Location + Vector(Rotation)*8 ,Level.GetLocalPlayerController().Location) )
	if ( !FastTrace(Location + Vector(Rotation)*8 ,Level.GetLocalPlayerController().ViewTarget.Location) )
	{
		SetLocation(Location + Vector(Rotation)*8);
		Emitters[1].ZTest = true;
//		Emitters[2].ZTest = true;
	}
	Super.PreBeginPlay();
}

defaultproperties
{
     DisableDGV(1)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=200,G=32,R=200))
         MaxParticles=12
         StartSizeRange=(X=(Min=2.000000,Max=3.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73MuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=200.000000),Y=(Min=-70.000000,Max=70.000000),Z=(Min=-100.000000,Max=300.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_A73GeneralBal.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.342857,Color=(B=255,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128))
         FadeOutStartTime=0.090000
         FadeInEndTime=0.090000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000))
         InitialParticlesPerSecond=100000.000000
         Texture=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73MuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_A73GeneralBal.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=192))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=64))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.00000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.200000,Max=0.300000))
         FadeOutStartTime=1.00000
         FadeInEndTime=0.150000
         MaxParticles=45
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.610000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=20.000000),Y=(Min=5.000000,Max=20.000000),Z=(Min=5.000000,Max=20.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.750000,Max=2.250000)
         StartVelocityRange=(X=(Min=10.000000,Max=50.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_A73GeneralBal.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-150.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.467857,Color=(B=255,G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.028000
         MaxParticles=8
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Min=50.000000,Max=250.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-50.000000,Max=350.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_A73GeneralBal.SpriteEmitter15'

     Begin Object Class=BeamEmitter Name=BeamEmitter4
         BeamDistanceRange=(Min=5.000000,Max=8.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         HighFrequencyNoiseRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.328571,Color=(B=255,G=96,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,A=255))
         FadeOutStartTime=0.060000
         MaxParticles=8
         DetailMode=DM_High
         SizeScale(0)=(RelativeSize=0.350000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.750000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=10.000000),Y=(Min=6.000000,Max=10.000000),Z=(Min=6.000000,Max=10.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.350000)
         StartVelocityRange=(X=(Min=4.000000,Max=20.000000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
     End Object
     Emitters(4)=BeamEmitter'BallisticProV55.IE_A73GeneralBal.BeamEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-200.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.385714,Color=(B=255,G=64,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=96,A=255))
         //ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.200000,Max=0.400000),Z=(Min=0.600000,Max=0.800000))
         FadeOutStartTime=0.500000
         MaxParticles=8
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-35.000000,Max=35.000000),Y=(Min=-35.000000,Max=35.000000),Z=(Min=2.000000,Max=3.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=8.000000,Max=12.000000))
         InitialParticlesPerSecond=600.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=150.000000),Y=(Min=-175.000000,Max=175.000000),Z=(Min=-175.000000,Max=175.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_A73GeneralBal.SpriteEmitter3'

     AutoDestroy=True
}
