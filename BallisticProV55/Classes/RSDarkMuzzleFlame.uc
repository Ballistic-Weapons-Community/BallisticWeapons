//=============================================================================
// RSDarkMuzzleFlame.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkMuzzleFlame extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
	{
		Emitters[0].ZTest = true;
		Emitters[2].ZTest = true;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ZTest=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.260000
         FadeInEndTime=0.090000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=40.000000)
         StartLocationRange=(Z=(Min=-2.000000,Max=2.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=16.000000,Max=20.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         Texture=Texture'BallisticEffects.Particles.DirtSpray'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=120.000000,Max=120.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSDarkMuzzleFlame.SpriteEmitter12'

     Begin Object Class=MeshEmitter Name=MeshEmitter3
         StaticMesh=StaticMesh'BallisticHardware2.M763.M763MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.750000,Max=0.750000))
         Opacity=0.870000
         FadeOutStartTime=0.116000
         FadeInEndTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=3.000000)
         StartSpinRange=(Z=(Min=0.230000,Max=0.270000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.300000,Max=0.700000),Y=(Min=0.200000,Max=0.250000),Z=(Min=0.400000,Max=0.500000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.RSDarkMuzzleFlame.MeshEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         FadeOut=True
         FadeIn=True
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.500000),Z=(Min=0.000000,Max=0.300000))
         Opacity=0.590000
         FadeOutStartTime=0.180000
         FadeInEndTime=0.115000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000)
         StartLocationRange=(X=(Max=10.000000))
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=30.000000,Max=40.000000),Z=(Min=30.000000,Max=40.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkMuzzleFlame.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseColorScale=True
         FadeIn=True
         ZTest=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.700000
         FadeOutStartTime=0.400000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=22.000000,Z=9.000000)
         StartSpinRange=(X=(Min=0.450000,Max=0.550000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.700000)
         StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=5.000000,Max=8.000000),Z=(Min=5.000000,Max=8.000000))
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=200.000000,Max=200.000000),Z=(Min=-80.000000,Max=-80.000000))
         VelocityLossRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSDarkMuzzleFlame.SpriteEmitter14'

}
