//=============================================================================
// LS440GlowFX.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20GlowFX extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
    FadeOut=True
    FadeIn=True
    ZTest=False
    UniformSize=True
    UseRandomSubdivision=True
    ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
    ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
    ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
    FadeOutStartTime=0.060000
    FadeInEndTime=0.042000
    CoordinateSystem=PTCS_Relative
    MaxParticles=3
    Name="SpriteEmitter0"
    StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-3.000000,Max=3.000000))
    StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
    Texture=Texture'BWBP_SKC_Tex.BFG.PlasmaSubdivide'
    TextureUSubdivisions=4
    TextureVSubdivisions=2
    SubdivisionScale(0)=2.000000
    SubdivisionScale(1)=8.000000
    SecondsBeforeInactive=0.000000
    LifetimeRange=(Min=0.201000,Max=0.201000)
    StartVelocityRange=(X=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.XM20GlowFX.SpriteEmitter2'

     bNoDelete=False
}
