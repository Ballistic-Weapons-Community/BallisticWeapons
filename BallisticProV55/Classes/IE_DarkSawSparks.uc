//=============================================================================
// IE_DarkSawSparks.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_DarkSawSparks extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(2)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.000000,Max=0.600000))
         FadeOutStartTime=0.197500
         FadeInEndTime=0.007500
         MaxParticles=15
         StartLocationOffset=(X=57.000000)
         StartLocationRange=(Z=(Min=-5.000000,Max=5.000000))
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         StartVelocityRange=(X=(Min=-50.000000,Max=1.010000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-800.000000,Max=-200.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_DarkSawSparks.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.000000,Max=0.500000))
         Opacity=0.730000
         FadeOutStartTime=0.037500
         FadeInEndTime=0.015000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=-5.000000)
         AddLocationFromOtherEmitter=0
         StartSizeRange=(X=(Min=0.700000,Max=1.000000),Y=(Min=10.000000,Max=40.000000),Z=(Min=10.000000,Max=40.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.150000)
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_DarkSawSparks.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         FadeOut=True
         ZTest=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.700000),Z=(Min=0.400000,Max=0.800000))
         FadeOutStartTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=57.000000)
         StartLocationRange=(Y=(Min=-1.000000,Max=1.000000),Z=(Min=-6.000000,Max=6.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=5.000000,Max=8.000000),Z=(Min=5.000000,Max=8.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.250000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_DarkSawSparks.SpriteEmitter13'

     AutoDestroy=True
}
