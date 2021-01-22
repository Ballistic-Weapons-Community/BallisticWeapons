//=============================================================================
// IE_XM20Impact.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_XM20BImpact extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[2].Disabled=true;
	if (Level.DetailMode < DM_High)
		Emitters[0].Disabled=true;

//	if ( !FastTrace(Location + Vector(Rotation)*8 ,Level.GetLocalPlayerController().Location) )
	if ( !FastTrace(Location + Vector(Rotation)*8 ,Level.GetLocalPlayerController().ViewTarget.Location) )
	{
		SetLocation(Location + Vector(Rotation)*8);
		Emitters[1].ZTest = true;
//		Emitters[2].ZTest = true;
	}
	Super.PreBeginPlay();
}

defaultproperties
{
     DisableDGV(1)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        UseCollision=True
        UseMaxCollisions=True
        UseColorScale=True
        RespawnDeadParticles=False
        UniformSize=True
        AutomaticInitialSpawning=False
        MaxCollisions=(Min=1.000000,Max=1.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=201,G=86,R=181))
        MaxParticles=5
      
        StartSizeRange=(X=(Min=1.000000,Max=3.000000))
        InitialParticlesPerSecond=50.000000
        Texture=Texture'BWBP_SKC_Tex.A48.A48MuzzleFlash'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SubdivisionStart=1
        SubdivisionEnd=1
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.301000,Max=0.301000)
        StartVelocityRange=(X=(Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
    End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.IE_XM20BImpact.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=0.332143,Color=(B=255,G=192,R=192,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128))
        FadeOutStartTime=0.090000
        FadeInEndTime=0.090000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        SizeScale(0)=(RelativeSize=1.200000)
        SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.700000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
        StartSizeRange=(X=(Min=20.000000,Max=30.000000))
        InitialParticlesPerSecond=100000.000000
        Texture=Texture'BWBP_SKC_Tex.A48.A48MuzzleFlash'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SubdivisionStart=1
        SubdivisionEnd=1
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.500000,Max=1.500000)
    End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.IE_XM20BImpact.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.530000
        FadeOutStartTime=0.495000
        FadeInEndTime=0.090000
        MaxParticles=5
      
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.300000)
        SizeScale(1)=(RelativeTime=0.550000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=5.000000,Max=5.000000))
        InitialParticlesPerSecond=5.000000
        DrawStyle=PTDS_Darken
        Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=30.000000))
        VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
    End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.IE_XM20BImpact.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
        UseDirectionAs=PTDU_Up
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-600.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.457143,Color=(B=255,G=128,R=128,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
        FadeOutStartTime=0.028000
        MaxParticles=12
      
        StartSpinRange=(X=(Min=0.250000,Max=0.250000))
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.350000,Max=0.350000)
        StartVelocityRange=(X=(Min=50.000000,Max=500.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-50.000000,Max=350.000000))
    End Object
     Emitters(3)=SpriteEmitter'BWBPOtherPackPro.IE_XM20BImpact.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=0.332143,Color=(B=27,G=137,R=237,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=6,G=6,R=253))
        FadeOutStartTime=0.090000
        FadeInEndTime=0.090000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        SizeScale(0)=(RelativeSize=1.200000)
        SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.700000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
        StartSizeRange=(X=(Min=10.000000,Max=15.000000))
        InitialParticlesPerSecond=100000.000000
        Texture=Texture'BWBP_SKC_Tex.A48.A48MuzzleFlash'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SubdivisionStart=1
        SubdivisionEnd=1
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=2.500000,Max=2.500000)
    End Object
     Emitters(4)=SpriteEmitter'BWBPOtherPackPro.IE_XM20BImpact.SpriteEmitter17'


     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=0.332143,Color=(B=255,G=192,R=192,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128))
        ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        Opacity=0.630000
        FadeOutStartTime=0.090000
        FadeInEndTime=0.090000
        CoordinateSystem=PTCS_Relative
        MaxParticles=5
      
        SpinsPerSecondRange=(X=(Max=1.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.200000)
        SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.700000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
        StartSizeRange=(X=(Min=5.000000,Max=25.000000))
        InitialParticlesPerSecond=100000.000000
        Texture=Texture'XEffects.LightningChargeT'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SubdivisionStart=1
        SubdivisionEnd=4
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
    End Object
     Emitters(5)=SpriteEmitter'BWBPOtherPackPro.IE_XM20BImpact.SpriteEmitter18'

     AutoDestroy=True
}
