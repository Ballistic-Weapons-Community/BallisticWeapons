class LonghornClusterFlareDud extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         DrawStyle=PTDS_Modulated
         Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1f'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.LonghornClusterFlareDud.SpriteEmitter3'
	 
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=55,R=55,B=55,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=28,R=96,B=55,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.000000,Max=0.200000))
         Opacity=0.800000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-8.000000,Max=-8.000000))
         SpinsPerSecondRange=(X=(Min=0.300000,Max=0.300000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
         ParticlesPerSecond=2.000000
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.LonghornClusterFlareDud.SpriteEmitter1'

     AutoDestroy=True
     bHardAttach=True
     bDirectional=True
}
