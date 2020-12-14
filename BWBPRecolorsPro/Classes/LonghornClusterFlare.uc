class LonghornClusterFlare extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=196,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.800000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-8.000000,Max=-8.000000))
         SpinsPerSecondRange=(X=(Min=0.300000,Max=0.300000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
         ParticlesPerSecond=2.000000
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.LonghornClusterFlare.SpriteEmitter0'

     AutoDestroy=True
     bHardAttach=True
     bDirectional=True
}
