//=============================================================================
// A73GlowFX.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A42AmbientFX extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) == None)
	{
		Emitters[7].Disabled=true;
		Emitters[8].Disabled=true;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(Y=-1.000000,Z=-0.100000)
         FadeIn=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.800000
         FadeInEndTime=0.056000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-125.000000,Y=-19.500000,Z=-8.000000)
         StartLocationRange=(Z=(Min=-3.000000,Max=7.000000))
         StartSpinRange=(X=(Min=0.750000,Max=0.750000))
         StartSizeRange=(X=(Min=6.000000,Max=14.000000),Y=(Min=6.000000,Max=14.000000),Z=(Min=6.000000,Max=14.000000))
         InitialParticlesPerSecond=400.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=40.000000,Max=40.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         ProjectionNormal=(Y=-1.000000,Z=0.000000)
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.500000
         FadeOutStartTime=0.350000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(X=-144.000000,Y=-20.000000,Z=-22.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=10.000000),Y=(Min=6.000000,Max=10.000000),Z=(Min=6.000000,Max=10.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Y=(Min=-30.000000,Max=-30.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=-1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=64,R=64,A=255))
         ColorScale(2)=(RelativeTime=0.146429,Color=(A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.330000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-225.000000,Z=7.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.270000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-150.000000,Max=-100.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         ProjectionNormal=(Y=-1.000000,Z=0.000000)
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.500000
         FadeOutStartTime=0.350000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(X=-61.000000,Y=-25.000000,Z=-2.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Y=(Min=-30.000000,Max=-30.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(Y=-1.000000,Z=-0.400000)
         FadeIn=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.800000
         FadeInEndTime=0.056000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-125.000000,Y=-17.000000,Z=-8.000000)
         StartLocationRange=(Z=(Min=-9.000000,Max=-4.000000))
         StartSpinRange=(X=(Min=0.750000,Max=0.750000))
         StartSizeRange=(X=(Min=6.000000,Max=14.000000),Y=(Min=6.000000,Max=14.000000),Z=(Min=6.000000,Max=14.000000))
         InitialParticlesPerSecond=400.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=40.000000,Max=40.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         ProjectionNormal=(Y=-1.000000,Z=0.000000)
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.500000
         FadeOutStartTime=0.350000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-144.000000,Y=20.000000,Z=-22.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=10.000000),Y=(Min=6.000000,Max=10.000000),Z=(Min=6.000000,Max=10.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Y=(Min=30.000000,Max=30.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         ProjectionNormal=(Y=-1.000000,Z=0.000000)
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.500000
         FadeOutStartTime=0.350000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-61.000000,Y=25.000000,Z=-2.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Y=(Min=30.000000,Max=30.000000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(Y=1.000000,Z=-0.100000)
         FadeIn=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.800000
         FadeInEndTime=0.056000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-125.000000,Y=19.500000,Z=-8.000000)
         StartLocationRange=(Z=(Min=-3.000000,Max=7.000000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=6.000000,Max=14.000000),Y=(Min=6.000000,Max=14.000000),Z=(Min=6.000000,Max=14.000000))
         InitialParticlesPerSecond=400.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=40.000000,Max=40.000000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(Y=1.000000,Z=-0.400000)
         FadeIn=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.800000
         FadeInEndTime=0.056000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-125.000000,Y=17.000000,Z=-8.000000)
         StartLocationRange=(Z=(Min=-9.000000,Max=-4.000000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=6.000000,Max=14.000000),Y=(Min=6.000000,Max=14.000000),Z=(Min=6.000000,Max=14.000000))
         InitialParticlesPerSecond=400.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=40.000000,Max=40.000000))
     End Object
     Emitters(8)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=-1.000000,Z=0.000000)
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.300000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-198.500000,Z=7.000000)
         StartSizeRange=(X=(Min=33.000000,Max=33.000000),Y=(Min=33.000000,Max=33.000000),Z=(Min=33.000000,Max=33.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(9)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=-1.000000,Z=0.000000)
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.300000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-207.500000,Z=7.000000)
         StartSizeRange=(X=(Min=31.000000,Max=31.000000),Y=(Min=31.000000,Max=31.000000),Z=(Min=31.000000,Max=31.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(10)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=-1.000000,Z=0.000000)
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.300000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-216.000000,Z=7.000000)
         StartSizeRange=(X=(Min=29.000000,Max=29.000000),Y=(Min=29.000000,Max=29.000000),Z=(Min=29.000000,Max=29.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(11)=SpriteEmitter'BallisticProV55.A42AmbientFX.SpriteEmitter12'

}
