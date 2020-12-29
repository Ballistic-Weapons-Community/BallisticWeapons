//=============================================================================
// IE_A500BlastImpact.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_A500BlastImpact extends DGVEmitter
	placeable;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter44
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(X=-25.000000,Y=-50.000000,Z=-50.000000)
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=0.207143,Color=(G=255,R=96,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=96,A=255))
         FadeOutStartTime=0.495000
         MaxParticles=4
         StartLocationOffset=(X=5.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=2.000000,Max=3.250000),Y=(Min=2.000000,Max=3.250000),Z=(Min=2.000000,Max=3.250000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaBubbleA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=50.000000,Max=400.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_A500BlastImpact.SpriteEmitter44'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter45
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=0.521429,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=170,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.137500
         FadeInEndTime=0.075000
         MaxParticles=40
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=3.000000,Max=6.000000),Y=(Min=4.000000,Max=15.000000),Z=(Min=3.000000,Max=6.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidDrops01'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_A500BlastImpact.SpriteEmitter45'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter46
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.235714,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=255,A=255))
         FadeOutStartTime=0.116000
         FadeInEndTime=0.036000
         MaxParticles=2
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.250000)
         StartSizeRange=(X=(Min=20.000000,Max=35.000000),Y=(Min=20.000000,Max=35.000000),Z=(Min=20.000000,Max=35.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidSplash01'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Max=20.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_A500BlastImpact.SpriteEmitter46'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=0.521429,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=170,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.216000
         FadeInEndTime=0.018000
         MaxParticles=25
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=4.000000,Max=10.000000),Z=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidDrops01'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=50.000000,Max=200.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_A500BlastImpact.SpriteEmitter18'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=54
     LightSaturation=100
     LightBrightness=150.000000
     LightRadius=8.000000
     LightPeriod=3
}
