//=============================================================================
// BG_ArmExplodeLeftBot.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_ArmExplodeLeftBot extends BW_HitGoreEmitter
	placeable;

/*    Begin Object Class=MeshEmitter Name=MeshEmitter2
        StaticMesh=StaticMesh'XEffects.GibBotForearm'
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        SpinParticles=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-500.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        Name="Gib"
        SpinsPerSecondRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        StartSpinRange=(X=(Min=0.750000,Max=0.750000))
        StartSizeRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
        InitialParticlesPerSecond=100.000000
        MinSquaredVelocity=100.000000
        StartVelocityRange=(X=(Min=-500.000000,Max=-250.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=50.000000,Max=150.000000))
    End Object
    Emitters(4)=MeshEmitter'myLevel.BG_ArmExplode0.MeshEmitter2'
*/

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         ExtentMultiplier=(X=0.300000,Y=0.300000,Z=0.300000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.352500
         MaxParticles=25
         StartLocationRange=(Y=(Max=8.000000),Z=(Min=-8.000000))
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.250000)
         StartSizeRange=(X=(Min=15.000000,Max=35.000000),Y=(Min=15.000000,Max=35.000000),Z=(Min=15.000000,Max=35.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Bot.Bot-Saw2'
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=1000.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
         StartVelocityRange=(X=(Min=-50.000000,Max=250.000000),Y=(Min=-10.000000,Max=100.000000),Z=(Min=-50.000000,Max=150.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_ArmExplodeLeftBot.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.700000),Z=(Min=0.400000,Max=0.800000))
         Opacity=0.560000
         FadeOutStartTime=0.860000
         FadeInEndTime=0.220000
         MaxParticles=8
         StartLocationRange=(Y=(Max=8.000000),Z=(Min=-4.000000))
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=50.000000),Y=(Min=-10.000000,Max=40.000000),Z=(Min=-10.000000,Max=40.000000))
         VelocityLossRange=(X=(Min=1.800000,Max=1.800000),Y=(Min=1.800000,Max=1.800000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_ArmExplodeLeftBot.SpriteEmitter10'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_PointLife
         MaxPointsPerTrail=15
         DistanceThreshold=8.000000
         PointLifeTime=1.000000
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.600000),Z=(Min=0.600000))
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=5.000000)
         StartLocationRange=(Y=(Max=12.000000),Z=(Min=-4.000000))
         StartSizeRange=(X=(Min=2.000000,Max=5.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(X=(Max=400.000000),Y=(Min=-10.000000,Max=100.000000),Z=(Min=-20.000000,Max=150.000000))
     End Object
     Emitters(2)=TrailEmitter'BallisticProV55.BG_ArmExplodeLeftBot.TrailEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000),Z=(Min=0.700000,Max=0.800000))
         FadeOutStartTime=0.063000
         MaxParticles=25
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=6.000000,Max=12.000000),Y=(Min=6.000000,Max=12.000000),Z=(Min=6.000000,Max=12.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Min=50.000000,Max=500.000000),Y=(Min=-350.000000,Max=350.000000),Z=(Min=-100.000000,Max=300.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.BG_ArmExplodeLeftBot.SpriteEmitter11'

     AutoDestroy=True
}
