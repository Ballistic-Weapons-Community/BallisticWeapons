//=============================================================================
// IE_BulletExpMetal.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletHE extends DGVEmitterOversize
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_High)
	{
		Emitters[2].Disabled=true;
		Emitters[6].Disabled=true;
		Emitters[7].Disabled=true;
	}

	if ( PhysicsVolume.bWaterVolume )
	{
		Emitters[0].Disabled=true;
		Emitters[2].Disabled=true;
	}
	Super.PreBeginPlay();
}

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(1)=1
     DisableDGV(2)=1
    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-20.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        Opacity=0.700000
        FadeOutStartTime=0.610000
        MaxParticles=3
      
        SpinsPerSecondRange=(X=(Max=0.100000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=0.340000,RelativeSize=0.500000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=20.000000,Max=45.000000),Y=(Min=20.000000,Max=45.000000),Z=(Min=20.000000,Max=45.000000))
        InitialParticlesPerSecond=10000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=60.000000,Max=100.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-5.000000,Max=20.000000))
        VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
    End Object
    Emitters(0)=SpriteEmitter'BWBPRecolorsPro.IE_BulletHE.SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        UseDirectionAs=PTDU_Up
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-100.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.314286,Color=(B=64,G=224,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=16,G=64,R=255,A=255))
        FadeOutStartTime=0.060000
        MaxParticles=3
      
        StartSpinRange=(X=(Min=0.250000,Max=0.250000))
        SizeScale(0)=(RelativeSize=0.700000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=5.000000,Max=12.000000),Y=(Min=5.000000,Max=12.000000),Z=(Min=5.000000,Max=12.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=50.000000,Max=300.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
    End Object
    Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_BulletHE.SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=128,G=255,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(G=192,R=255))
        ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.700000,Max=0.800000),Z=(Min=0.400000,Max=0.500000))
        FadeOutStartTime=1.000000
        FadeInEndTime=0.075000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        DetailMode=DM_High
        StartLocationOffset=(X=2.000000)
        SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=3.000000,Max=3.000000))
        InitialParticlesPerSecond=10000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=2.000000,Max=2.000000)
    End Object
    Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_BulletHE.SpriteEmitter13'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter14
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=5.000000)
        ColorScale(0)=(Color=(B=192,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.214286,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=0.346429,Color=(B=255,G=255,R=255,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=254,R=255,A=255))
        ColorMultiplierRange=(X=(Min=5.500000,Max=0.600000),Z=(Min=0.400000,Max=0.400000))
        Opacity=0.700000
        FadeOutStartTime=0.150000
        MaxParticles=5
      
        SpinsPerSecondRange=(X=(Max=0.100000))
        StartSpinRange=(X=(Min=0.450000,Max=0.550000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
        StartSizeRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
        TextureUSubdivisions=4
        TextureVSubdivisions=2
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.500000,Max=1.500000)
    End Object
    Emitters(3)=SpriteEmitter'BWBPRecolorsPro.IE_BulletHE.SpriteEmitter14'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter15
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.200000,Max=0.200000))
        FadeOutStartTime=0.200000
        MaxParticles=1
      
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=6.500000,Max=6.500000),Y=(Min=6.500000,Max=6.500000),Z=(Min=6.500000,Max=6.500000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.800000,Max=0.800000)
    End Object
    Emitters(4)=SpriteEmitter'BWBPRecolorsPro.IE_BulletHE.SpriteEmitter15'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter16
        UseDirectionAs=PTDU_Up
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-500.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(G=55,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000),Z=(Min=0.700000,Max=0.800000))
        FadeOutStartTime=0.063000
        MaxParticles=40
      
        DetailMode=DM_High
        StartSpinRange=(X=(Min=0.250000,Max=0.250000))
        StartSizeRange=(X=(Min=16.000000,Max=32.000000),Y=(Min=16.000000,Max=32.000000),Z=(Min=16.000000,Max=32.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.150000,Max=0.150000)
        StartVelocityRange=(X=(Max=900.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Min=-700.000000,Max=700.000000))
    End Object
    Emitters(5)=SpriteEmitter'BWBPRecolorsPro.IE_BulletHE.SpriteEmitter16'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter17
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
        Opacity=0.580000
        FadeOutStartTime=0.115000
        FadeInEndTime=0.035000
        MaxParticles=3
      
        DetailMode=DM_SuperHigh
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        StartSizeRange=(X=(Min=20.000000,Max=80.000000),Y=(Min=20.000000,Max=80.000000),Z=(Min=20.000000,Max=80.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
        TextureUSubdivisions=1
        TextureVSubdivisions=1
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.100000,Max=0.500000)
        StartVelocityRadialRange=(Min=-20.000000,Max=1.000000)
    End Object
    Emitters(6)=SpriteEmitter'BWBPRecolorsPro.IE_BulletHE.SpriteEmitter17'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter18
        UseDirectionAs=PTDU_Forward
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-500.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(G=55,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000),Z=(Min=0.700000,Max=0.800000))
        FadeOutStartTime=0.063000
        MaxParticles=5
      
        DetailMode=DM_High
        UseRotationFrom=PTRS_Offset
        SpinsPerSecondRange=(X=(Max=2.000000))
        StartSpinRange=(X=(Min=0.250000,Max=0.250000))
        StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
        TextureUSubdivisions=1
        TextureVSubdivisions=1
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.150000,Max=0.150000)
        StartVelocityRange=(X=(Min=700.000000,Max=900.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Max=700.000000))
    End Object
    Emitters(7)=SpriteEmitter'BWBPRecolorsPro.IE_BulletHE.SpriteEmitter18'
     AutoDestroy=True
}
