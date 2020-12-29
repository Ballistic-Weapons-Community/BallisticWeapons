//=============================================================================
// IE_RSDarkPlayerKill.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RSDarkPlayerKill extends DGVEmitter
	placeable;

simulated function AlignVelocity ()
{
//	local Range SV0;
	local int i;
	local vector X, Y, Z, VMax, VMin;

	for (i=0;i<Emitters.Length;i++)
	{
		if (DisableDGV.Length > i && DisableDGV[i] != 0)
			continue;
//		if (SVX[i] == SV0 && SVY[i] == SV0 && SVZ[i] == SV0)
//			continue;

		GetAxes(Rotation,X,Y,Z);
		//Adjust StartVelocityRange
		if (bVerticalZ)
		{
			VMax = X * SVX[i].Max + Y * SVY[i].Max + Vect(0,0,1) * SVZ[i].Max;
			VMin = X * SVX[i].Min + Y * SVY[i].Min + Vect(0,0,1) * SVZ[i].Min;
			if (bYIsSpread)
			{
				VMax = VMax + Z * SVY[i].Max * Abs(X.Z);
				VMin = VMin + Z * SVY[i].Min * Abs(X.Z);
			}
		}
		else
		{
			VMax = X * SVX[i].Max + Y * SVY[i].Max + Z * SVZ[i].Max;
			VMin = X * SVX[i].Min + Y * SVY[i].Min + Z * SVZ[i].Min;
		}
		Emitters[i].StartVelocityRange = VtoRV(VMax, VMin);

		//Adjust StartLocationRange
		VMax = X * default.Emitters[i].StartLocationRange.X.Max + Y * default.Emitters[i].StartLocationRange.Y.Max + Z * default.Emitters[i].StartLocationRange.Z.Max;
		VMin = X * default.Emitters[i].StartLocationRange.X.Min + Y * default.Emitters[i].StartLocationRange.Y.Min + Z * default.Emitters[i].StartLocationRange.Z.Min;
		Emitters[i].StartLocationRange = VtoRV(VMax, VMin);
		//Adjust StartLocationOffset
		Emitters[i].StartLocationOffset = X * default.Emitters[i].StartLocationOffset.X + Y * default.Emitters[i].StartLocationOffset.Y + Z * default.Emitters[i].StartLocationOffset.Z;

		//Adjust VelocityLossRange
//		VMax = X * default.Emitters[i].VelocityLossRange.X.Max + Y * default.Emitters[i].VelocityLossRange.Y.Max + Z * default.Emitters[i].VelocityLossRange.Z.Max;
//		VMin = X * default.Emitters[i].VelocityLossRange.X.Min + Y * default.Emitters[i].VelocityLossRange.Y.Min + Z * default.Emitters[i].VelocityLossRange.Z.Min;
//		Emitters[i].VelocityLossRange = VtoRV(VMax, VMin);
	}
}

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(1)=1
     DisableDGV(2)=1
     DisableDGV(3)=1
     DisableDGV(4)=1
     DisableDGV(7)=1
     EmitterZTestSwitches(2)=ZM_OffWhenVisible
     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=1.360000
         FadeInEndTime=0.180000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=120.000000,Max=120.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareC1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerKill.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.600000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.032500
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         InitialDelayRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerKill.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=192,G=224,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.250000,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.532143,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.750000,Max=0.750000))
         FadeOutStartTime=0.032500
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerKill.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.410000
         FadeInEndTime=0.090000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.DarkStar.HotFlareA2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerKill.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(G=96,R=192,A=255))
         ColorScale(2)=(RelativeTime=0.571429,Color=(A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         Opacity=0.690000
         FadeOutStartTime=0.320000
         FadeInEndTime=0.160000
         MaxParticles=30
         StartLocationOffset=(Z=2.000000)
         AlphaRef=48
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.200000)
         SizeScale(2)=(RelativeTime=0.620000,RelativeSize=0.800000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=10.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=80.000000,Max=80.000000))
         VelocityLossRange=(Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerKill.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-600.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.200000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=2.720000
         MaxParticles=15
         StartSizeRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.DarkStar.HotFlareA2'
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=5000.000000
         StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=100.000000,Max=200.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerKill.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-500.000000)
         ExtentMultiplier=(X=0.750000,Y=0.750000,Z=0.750000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=1.260000
         MaxParticles=3
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=9.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=200.000000
         LifetimeRange=(Min=1.500000,Max=2.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=60.000000,Max=140.000000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerKill.SpriteEmitter18'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.457143,Color=(G=64,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.230000
         FadeInEndTime=0.090000
         MaxParticles=100
         AddLocationFromOtherEmitter=5
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=3.500000,Max=3.500000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         AddVelocityFromOtherEmitter=5
         AddVelocityMultiplierRange=(X=(Min=0.050000,Max=0.050000),Y=(Min=0.050000,Max=0.050000),Z=(Min=0.050000,Max=0.050000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerKill.SpriteEmitter25'

     AutoDestroy=True
}
