class XOXOLoveModeGlow extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=LuvLuvHeartz
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=250.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.250000))
         Opacity=0.840000
         FadeOutStartTime=0.230000
         FadeInEndTime=0.090000
         MaxParticles=20
         StartLocationRange=(X=(Min=-22.000000,Max=22.000000),Y=(Min=-22.000000,Max=22.000000),Z=(Min=-44.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=4.000000,Max=12.000000),Y=(Min=4.000000,Max=12.000000),Z=(Min=4.000000,Max=12.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_OP_Tex.XOXO.hearteffect'
         LifetimeRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.XOXOLoveModeGlow.LuvLuvHeartz'

     Begin Object Class=SpriteEmitter Name=LuvLuvSmoke
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,R=255,A=255))
         Opacity=0.260000
         FadeOutStartTime=1.100000
         FadeInEndTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationRange=(X=(Min=-16.000000,Max=16.000000),Y=(Min=-16.000000,Max=16.000000),Z=(Min=-44.000000,Max=-44.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         LifetimeRange=(Min=1.500000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.XOXOLoveModeGlow.LuvLuvSmoke'

     Begin Object Class=MeshEmitter Name=SuperHeart
         StaticMesh=StaticMesh'BWBP_OP_Static.XOXO.Heart'
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(Z=60.000000)
         SpinCCWorCW=(X=1.000000,Y=1.000000,Z=1.000000)
         SpinsPerSecondRange=(X=(Min=0.500000,Max=0.500000))
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=MeshEmitter'BWBPOtherPackPro.XOXOLoveModeGlow.SuperHeart'

     Begin Object Class=SpriteEmitter Name=LuvLuvGlow
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=160,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=64,R=255))
         ColorScaleRepeats=1.000000
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.400000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.400000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         DetailMode=DM_High
         StartLocationOffset=(Z=60.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=70.000000,Max=70.000000))
         ParticlesPerSecond=2.000000
         InitialParticlesPerSecond=2.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPOtherPackPro.XOXOLoveModeGlow.LuvLuvGlow'

     AmbientSound=Sound'GeneralAmbience.texture31'
     SoundVolume=255
     SoundRadius=256.000000
}
