class TraceEmitter_M763Gas extends BCTraceEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=M763GasConeEmitter
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=5.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.520000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.900000
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
         StartLocationRange=(X=(Min=5.000000,Max=500.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Max=0.010000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=75.000000),Y=(Min=75.000000),Z=(Min=75.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(Z=(Min=-10.000000))
         VelocityLossRange=(X=(Max=11.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.TraceEmitter_M763Gas.M763GasConeEmitter'

     Begin Object Class=SpriteEmitter Name=M763LingeringGas
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.250000
         FadeOutStartTime=0.320000
         FadeInEndTime=0.180000
         CoordinateSystem=PTCS_Relative
         MaxParticles=50
         StartLocationRange=(X=(Min=-64.000000,Max=64.000000))
         SpinsPerSecondRange=(X=(Max=0.350000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.040000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=55.000000,Max=75.000000),Y=(Min=55.000000,Max=75.000000),Z=(Min=55.000000,Max=75.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=5.000000,Max=3000.000000),Y=(Min=-120.000000,Max=120.000000),Z=(Min=-120.000000,Max=120.000000))
         VelocityLossRange=(X=(Max=11.000000),Y=(Max=3.000000),Z=(Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.TraceEmitter_M763Gas.M763LingeringGas'

}
