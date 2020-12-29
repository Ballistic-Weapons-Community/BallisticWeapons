//=============================================================================
// IE_A500BlobImpact.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_A500BlobImpact extends DGVEmitter
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
     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
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
         MaxParticles=8
         StartLocationOffset=(X=5.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=2.000000,Max=3.250000),Y=(Min=2.000000,Max=3.250000),Z=(Min=2.000000,Max=3.250000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaBubbleA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=75.000000,Max=500.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_A500BlobImpact.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
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
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=5.000000,Max=6.000000),Y=(Min=5.000000,Max=25.000000),Z=(Min=5.000000,Max=6.000000))
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
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_A500BlobImpact.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
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
         ColorScale(1)=(RelativeTime=0.228571,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=255,A=255))
         FadeOutStartTime=0.112000
         FadeInEndTime=0.032000
         MaxParticles=2
         SpinsPerSecondRange=(X=(Max=0.250000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=15.000000,Max=45.000000),Y=(Min=15.000000,Max=45.000000),Z=(Min=15.000000,Max=45.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidSplash01'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=75.000000,Max=125.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_A500BlobImpact.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter48
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
         FadeOutStartTime=0.385000
         MaxParticles=20
         StartLocationOffset=(X=5.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.250000)
         StartSizeRange=(X=(Min=1.500000,Max=2.500000),Y=(Min=1.500000,Max=2.500000),Z=(Min=1.500000,Max=2.500000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaBubbleA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=150.000000,Max=500.000000),Y=(Min=-350.000000,Max=350.000000),Z=(Min=-350.000000,Max=350.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_A500BlobImpact.SpriteEmitter48'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter49
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(X=-250.000000)
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=0.521429,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=170,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.137500
         FadeInEndTime=0.075000
         MaxParticles=50
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=8.000000,Max=35.000000),Z=(Min=6.000000,Max=8.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidDrops01'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.450000,Max=0.450000)
         StartVelocityRange=(X=(Min=250.000000,Max=750.000000),Y=(Min=-350.000000,Max=350.000000),Z=(Min=-350.000000,Max=350.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_A500BlobImpact.SpriteEmitter49'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter50
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(X=-1500.000000)
         ColorScale(0)=(Color=(G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.228571,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=255,A=255))
         FadeOutStartTime=0.246000
         FadeInEndTime=0.030000
         MaxParticles=12
         SpinsPerSecondRange=(X=(Min=0.200000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=15.000000,Max=45.000000),Y=(Min=15.000000,Max=45.000000),Z=(Min=15.000000,Max=45.000000))
         InitialParticlesPerSecond=35.000000
         Texture=Texture'BallisticBloodPro.DeRez.Wisp2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=300.000000,Max=750.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_A500BlobImpact.SpriteEmitter50'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter51
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
         ColorScale(1)=(RelativeTime=0.228571,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=255,A=255))
         Opacity=0.760000
         FadeOutStartTime=0.246000
         FadeInEndTime=0.030000
         MaxParticles=20
         StartLocationRange=(Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         SpinsPerSecondRange=(X=(Max=0.600000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
         InitialParticlesPerSecond=25.000000
         Texture=Texture'BallisticBloodPro.DeRez.Wisp1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_A500BlobImpact.SpriteEmitter51'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter52
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(X=-800.000000)
         ColorScale(0)=(Color=(G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.521429,Color=(G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=170,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.337500
         FadeInEndTime=0.036000
         MaxParticles=100
         StartLocationRange=(Y=(Min=-35.000000,Max=35.000000),Z=(Min=-35.000000,Max=35.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=4.000000,Max=6.000000),Y=(Min=4.000000,Max=15.000000),Z=(Min=4.000000,Max=6.000000))
         InitialParticlesPerSecond=85.000000
         Texture=Texture'BW_Core_WeaponTex.Reptile.AcidDrops01'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.450000,Max=0.450000)
         StartVelocityRange=(X=(Min=250.000000,Max=750.000000),Y=(Min=-350.000000,Max=350.000000),Z=(Min=-350.000000,Max=350.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.IE_A500BlobImpact.SpriteEmitter52'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=54
     LightSaturation=100
     LightBrightness=150.000000
     LightRadius=24.000000
     LightPeriod=3
}
