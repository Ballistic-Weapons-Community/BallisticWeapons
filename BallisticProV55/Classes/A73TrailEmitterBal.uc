//=============================================================================
// A73TrailEmitterBal.
//
// Small sparkly bits added.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A73TrailEmitterBal extends BallisticEmitter;

simulated function Tick (float DT)
{
    super.Tick(DT);
    if (Base == none)
        Destroy();

}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=120,G=32,R=120))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=240,G=64,R=240))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=0.000000)
         StartSizeRange=(X=(Min=40.000000,Max=70.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A73TrailEmitterBal.SpriteEmitter1'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=50.000000
         UseCrossedSheets=True
         PointLifeTime=0.400000
         FadeOut=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.350000,Max=0.450000))
         Opacity=0.400000
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSizeRange=(X=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=9999.000000,Max=9999.000000)
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.A73TrailEmitterBal.TrailEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.467857,Color=(B=255,G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.100000
         MaxParticles=9
         DetailMode=DM_SuperHigh
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=1.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=1.500000,Max=2.000000),Y=(Min=1.500000,Max=2.000000),Z=(Min=1.500000,Max=2.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BWBP_KBP_Tex.A73Purple.A73MuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.450000,Max=0.450000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.A73TrailEmitterBal.SpriteEmitter2'

     bNoDelete=False
     Physics=PHYS_Trailer
}
