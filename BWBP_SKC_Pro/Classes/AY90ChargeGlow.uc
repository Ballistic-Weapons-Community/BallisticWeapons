//=============================================================================
// A800MinigunChargeGlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90ChargeGlow extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[0].ZTest = true;
}


simulated function SetSize(float SizeX, float SizeY, float SizeZ) //Sizemore
{
	Emitters[0].StartSizeRange.X.Min = Lerp(30*SizeX, 0.4, 1.0); 	
	Emitters[0].StartSizeRange.X.Max = 30*SizeX;
	Emitters[0].StartSizeRange.Y.Min = Lerp(30*SizeY, 0.4, 1.0); 	
	Emitters[0].StartSizeRange.Y.Max = 30*SizeY;
	Emitters[0].StartSizeRange.Z.Min = Lerp(30*SizeZ, 0.4, 0.0); 	
	Emitters[0].StartSizeRange.Z.Max = 30*SizeZ;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.607143,Color=(B=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.260000,Max=0.360000),Y=(Min=0.260000,Max=0.360000),Z=(Min=0.960000,Max=0.960000))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=7
         DetailMode=DM_High
         StartLocationOffset=(X=-20.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=60.000000,Max=60.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.AY90ChargeGlow.SpriteEmitter6'

}
