//=============================================================================
// GRSXXAmbientFX.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRSXXAmbientFX extends BallisticEmitter;

function SetReadyIndicator (bool bReady)
{
	Emitters[9].Disabled=!bReady;
}
function SetFireGlow (bool bFiring)
{
	if (bFiring)
	{
		Emitters[0].Opacity = 1;
		Emitters[1].Opacity = 1;
		Emitters[2].Opacity = 1;
		Emitters[3].Opacity = 1;
		Emitters[4].Opacity = 1;
		Emitters[5].Opacity = 1;
		Emitters[6].Opacity = 1;
		Emitters[7].Opacity = 1;
	}
	else
	{
		Emitters[0].Opacity = 0.35;
		Emitters[1].Opacity = 0.35;
		Emitters[2].Opacity = 0.35;
		Emitters[3].Opacity = 0.35;
		Emitters[4].Opacity = 0.35;
		Emitters[5].Opacity = 0.35;
		Emitters[6].Opacity = 0.35;
		Emitters[7].Opacity = 0.35;
	}
}
// 0 = Off
// 1 = Steady
// 2 = Flashing
function SetRedIndicator (byte Status)
{
	if (Status == 2)
	{
		Emitters[8].Disabled = false;
		Emitters[10].Disabled = true;
	}
	else if (Status == 1)
	{
		Emitters[8].Disabled = true;
		Emitters[10].Disabled = false;
	}
	else
	{
		Emitters[8].Disabled = true;
		Emitters[10].Disabled = true;
	}
}

function InvertZ()
{
	local int i;
	for (i=0;i<Emitters.length;i++)
	{
		Emitters[i].StartLocationOffset.Z *= -1;
//		Emitters[i].StartVelocityRange.Z.Max *= -1;
//		Emitters[i].StartVelocityRange.Z.Min *= -1;
	}
}
function InvertY()
{
	local int i;
	for (i=0;i<Emitters.length;i++)
	{
		Emitters[i].StartLocationOffset.Y *= -1;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.365000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-18.000000,Z=14.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.365000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-18.000000,Y=-10.000000,Z=10.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.365000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-18.000000,Y=-10.000000,Z=-10.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.365000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-18.000000,Y=-14.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.365000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-18.000000,Z=-14.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.365000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-18.000000,Y=10.000000,Z=-10.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter16'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.365000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-18.000000,Y=14.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(6)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.365000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-18.000000,Y=10.000000,Z=10.000000)
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter18'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         UseColorScale=True
         Disabled=True
         Backup_Disabled=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.364286,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.396429,Color=(B=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-80.000000,Y=-12.000000,Z=6.000000)
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(8)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter19'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-70.000000,Y=-12.000000,Z=6.000000)
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(9)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter23'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-80.000000,Y=-12.000000,Z=6.000000)
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(10)=SpriteEmitter'BWBP_SKCExp_Pro.GRSXXAmbientFX.SpriteEmitter20'

     bHidden=True
     bNoDelete=False
     bHardAttach=True
}
