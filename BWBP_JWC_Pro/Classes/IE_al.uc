//=============================================================================
// IE_A73General.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_al extends DGVEmitter
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
		Emitters[0].ZTest = true;
		Emitters[5].ZTest = true;
	}
	Super.PreBeginPlay();
}

defaultproperties
{
     DisableDGV(1)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.135714,Color=(B=255,R=64))
         ColorScale(2)=(RelativeTime=0.260714,Color=(B=255,G=25,R=25,A=255))
         ColorScale(3)=(RelativeTime=0.385714,Color=(R=64,A=255))
         ColorScale(4)=(RelativeTime=0.510714,Color=(B=128,G=255,R=25,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(G=255,R=25,A=255))
         FadeOutStartTime=0.224000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_al.SpriteEmitter2'

     Begin Object Class=BeamEmitter Name=BeamEmitter4
         BeamDistanceRange=(Min=250.000000,Max=250.000000)
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
         ColorScale(1)=(RelativeTime=0.303571,Color=(B=64,G=255,R=25,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,R=25,A=25))
         FadeOutStartTime=0.216000
         CoordinateSystem=PTCS_Relative
         MaxParticles=12
         DetailMode=DM_High
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=35.000000),Y=(Min=20.000000,Max=35.000000),Z=(Min=20.000000,Max=35.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
     End Object
     Emitters(1)=BeamEmitter'BWBP_JWC_Pro.IE_al.BeamEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.328571,Color=(B=64,G=255,R=25,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=25,A=255))
         FadeOutStartTime=0.082000
         CoordinateSystem=PTCS_Relative
         MaxParticles=28
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=10.000000)
         StartLocationRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=35.000000,Max=45.000000),Y=(Min=35.000000,Max=45.000000),Z=(Min=35.000000,Max=45.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=200.000000,Max=2000.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_JWC_Pro.IE_al.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Forward
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.178571,Color=(B=255,G=128,R=25,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=25,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.024000
         FadeInEndTime=0.024000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_High
         StartLocationOffset=(X=10.000000)
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.610000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=8.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.ElectroShock'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_JWC_Pro.IE_al.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-750.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=25))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=32,G=255,R=32))
         MaxParticles=30
         StartSizeRange=(X=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BWBP_JW_Tex.A73BMuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=200.000000),Y=(Min=-90.000000,Max=90.000000),Z=(Min=-150.000000,Max=350.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_JWC_Pro.IE_al.SpriteEmitter12'

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
         ColorScale(1)=(RelativeTime=0.342857,Color=(B=255,G=255,R=192,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128))
         FadeOutStartTime=0.090000
         FadeInEndTime=0.090000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=2.500000)
         SizeScale(1)=(RelativeTime=0.080000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=0.200000,RelativeSize=1.600000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000))
         InitialParticlesPerSecond=100000.000000
         Texture=Texture'BWBP_JW_Tex.A73BMuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(5)=SpriteEmitter'BWBP_JWC_Pro.IE_al.SpriteEmitter13'

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
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.467857,Color=(B=255,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=8.000000,Max=0.800000),Y=(Min=2.000000,Max=0.400000),Z=(Min=0.000000,Max=0.200000))
         FadeOutStartTime=0.028000
         MaxParticles=24
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.250000)
         StartSizeRange=(X=(Min=15.000000,Max=30.000000),Y=(Min=15.000000,Max=30.000000),Z=(Min=15.000000,Max=30.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Min=50.000000,Max=500.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-50.000000,Max=350.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBP_JWC_Pro.IE_al.SpriteEmitter15'

     AutoDestroy=True
}
