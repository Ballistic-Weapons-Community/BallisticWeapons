//=============================================================================
// IE_RSDarkPlayerHit.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RSDarkPlayerHit extends DGVEmitter
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
     DisableDGV(5)=1
     DisableDGV(6)=1
     EmitterZTestSwitches(1)=ZM_OffWhenVisible
     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.060000
         FadeInEndTime=0.015000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.050000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=70.000000,Max=80.000000),Y=(Min=70.000000,Max=80.000000),Z=(Min=70.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.DarkStar.DarkShock'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerHit.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.285714,Color=(G=64,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=128,A=255))
         FadeOutStartTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerHit.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.200000
         FadeInEndTime=0.120000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerHit.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-5.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.050000,Max=0.050000),Z=(Min=0.000000,Max=0.200000))
         Opacity=0.630000
         FadeOutStartTime=1.230000
         FadeInEndTime=0.180000
         MaxParticles=20
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.200000)
         SizeScale(2)=(RelativeTime=0.680000,RelativeSize=0.800000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=20.000000,Max=30.000000),Z=(Min=20.000000,Max=30.000000))
         InitialParticlesPerSecond=15.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=70.000000,Max=70.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerHit.SpriteEmitter14'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-600.000000)
         ExtentMultiplier=(X=0.700000,Y=0.700000,Z=0.700000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000),Z=(Min=0.500000))
         FadeOutStartTime=3.120000
         MaxParticles=12
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.300000),Y=(Min=0.100000,Max=0.300000),Z=(Min=0.100000,Max=0.300000))
         InitialParticlesPerSecond=5000.000000
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=500.000000
         StartVelocityRange=(X=(Min=-50.000000,Max=150.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Max=200.000000))
     End Object
     Emitters(4)=MeshEmitter'BallisticProV55.IE_RSDarkPlayerHit.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.720000
         FadeOutStartTime=0.160000
         FadeInEndTime=0.092000
         MaxParticles=72
         StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         AddLocationFromOtherEmitter=4
         StartSizeRange=(X=(Min=4.000000,Max=5.000000),Y=(Min=4.000000,Max=5.000000),Z=(Min=4.000000,Max=5.000000))
         InitialParticlesPerSecond=24.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerHit.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.500000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.600000))
         Opacity=0.720000
         FadeOutStartTime=0.160000
         FadeInEndTime=0.092000
         MaxParticles=36
         StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         AddLocationFromOtherEmitter=4
         StartSizeRange=(X=(Min=4.000000,Max=5.000000),Y=(Min=4.000000,Max=5.000000),Z=(Min=4.000000,Max=5.000000))
         InitialParticlesPerSecond=12.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_RSDarkPlayerHit.SpriteEmitter16'

     AutoDestroy=True
}
