class IE_XOXOShockwave extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=IE_XOXOShockwaveEmitter0
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.150000,Max=0.150000))
         Opacity=0.070000
         FadeOutStartTime=0.252000
         CoordinateSystem=PTCS_Relative
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.401000,Max=0.401000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_OP_Pro.IE_XOXOShockwave.IE_XOXOShockwaveEmitter0'

     Begin Object Class=SpriteEmitter Name=IE_XOXOShockwaveEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_OP_Pro.IE_XOXOShockwave.IE_XOXOShockwaveEmitter1'

     Begin Object Class=SpriteEmitter Name=IE_XOXOShockwaveEmitter2
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ExtentMultiplier=(X=0.700000,Y=0.700000,Z=0.700000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000))
         FadeOutStartTime=1.120000
         MaxParticles=100
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=6.000000,Max=12.000000)
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=5.000000,Max=7.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BWBP_OP_Tex.XOXO.hearteffect'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=60.000000,Max=180.000000))
         StartVelocityRadialRange=(Min=-400.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=SpriteEmitter'BWBP_OP_Pro.IE_XOXOShockwave.IE_XOXOShockwaveEmitter2'

}
