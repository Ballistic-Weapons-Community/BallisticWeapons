//=============================================================================
// IE_NRP57Explosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_AcidExplosion extends BallisticEmitter
	placeable;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
}

simulated event PreBeginPlay()
{
	//if (Level.DetailMode < DM_SuperHigh)
	//	Emitters[3].Disabled=true;
	//if (Level.DetailMode < DM_High)
	//{
		//Emitters[1].Disabled=true;
		//Emitters[1].Disabled=true; //2
	//}
	Super.PreBeginPlay();
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}

/*

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=0,G=255,R=0,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=0,G=255,R=0,A=255))
         ColorMultiplierRange=(Y=(Min=0.700000,Max=0.800000),Z=(Min=0.700000,Max=0.800000))
         FadeOutStartTime=0.052500
         MaxParticles=3
         StartLocationRange=(X=(Min=-80.000000,Max=80.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=8.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         UseColorScale=True
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SWC_Pro.IE_AcidExplosion.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=0,G=255,R=0,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=0,G=255,R=0,A=255))
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         UseColorScale=True
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SWC_Pro.IE_AcidExplosion.SpriteEmitter19'
*/

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.700000,Max=0.800000),Z=(Min=0.700000,Max=0.800000))
         FadeOutStartTime=0.052500
         MaxParticles=3
         StartLocationRange=(X=(Min=-80.000000,Max=80.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=8.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SWC_Pro.IE_AcidExplosion.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,A=255))
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=2.500000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SWC_Pro.IE_AcidExplosion.SpriteEmitter19'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
     bNoDelete=False
}
