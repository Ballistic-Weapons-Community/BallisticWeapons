class M7A3PlayerEffect extends DGVEmitter;

#exec OBJ LOAD File=BWBP_OP_Sounds.uax

simulated function StartSound()
{
	AmbientSound = default.AmbientSound;
}
simulated function StopSound()
{
	AmbientSound=None;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=255,G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.346429,Color=(B=255,G=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.125000
         MaxParticles=2
         StartLocationRange=(Z=(Min=-20.000000,Max=20.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JCF_Pro.M7A3PlayerEffect.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.214286,Color=(B=255,G=160,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         FadeOutStartTime=0.196000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationRange=(Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=24.000000,Max=34.000000),Y=(Min=24.000000,Max=34.000000),Z=(Min=24.000000,Max=34.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=100.000000,Max=600.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-100.000000,Max=300.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_JCF_Pro.M7A3PlayerEffect.SpriteEmitter21'

     Begin Object Class=BeamEmitter Name=BeamEmitter10
         BeamDistanceRange=(Min=100.000000,Max=200.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         HighFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HighFrequencyPoints=8
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.485714,Color=(B=255,G=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.900000,Max=0.900000))
         FadeOutStartTime=0.084000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-20.000000)
         StartLocationRange=(Z=(Min=-20.000000,Max=20.000000))
         StartSizeRange=(X=(Min=5.000000,Max=7.000000),Y=(Min=5.000000,Max=7.000000),Z=(Min=5.000000,Max=7.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(2)=BeamEmitter'BWBP_JCF_Pro.M7A3PlayerEffect.BeamEmitter10'

     AutoDestroy=True
     AmbientSound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazer'
     bFullVolume=True
     bHardAttach=True
     SoundVolume=150
     SoundRadius=128.000000
}
