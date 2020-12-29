//=============================================================================
// IE_RSNova1General.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RSNova1General extends DGVEmitter
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
     DisableDGV(6)=1
     EmitterZTestSwitches(0)=ZM_OffWhenVisible
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.357143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=130.000000,Max=130.000000),Y=(Min=130.000000,Max=130.000000),Z=(Min=130.000000,Max=130.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RSNova1General.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.096429,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.214286,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.439286,Color=(B=255,G=128,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.110000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=1.000000)
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.400000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=13.000000,Max=15.000000),Y=(Min=13.000000,Max=15.000000),Z=(Min=13.000000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RSNova1General.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=255,G=128,R=64,A=255))
         ColorScale(1)=(RelativeTime=0.289286,Color=(B=255,G=212,R=192,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         Opacity=0.530000
         FadeOutStartTime=1.410000
         FadeInEndTime=0.150000
         MaxParticles=15
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000,Z=10.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=35.000000,Max=40.000000),Y=(Min=35.000000,Max=40.000000),Z=(Min=35.000000,Max=40.000000))
         InitialParticlesPerSecond=12.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=100.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_RSNova1General.SpriteEmitter3'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.NovaStaff.Nova-GlowChips'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.346429,Color=(B=64,G=224,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         FadeOutStartTime=2.720000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartSpinRange=(Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.200000),Y=(Min=0.200000,Max=0.300000),Z=(Min=0.200000,Max=0.215000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(3)=MeshEmitter'BallisticProV55.IE_RSNova1General.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.207143,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.425000,Color=(B=255,G=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.056000
         FadeInEndTime=0.052000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=32.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=120.000000,Max=140.000000),Y=(Min=120.000000,Max=140.000000),Z=(Min=120.000000,Max=140.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         LifetimeRange=(Min=0.400000,Max=0.400000)
         InitialDelayRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_RSNova1General.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.164286,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=64,R=255,A=255))
         FadeOutStartTime=1.220000
         MaxParticles=15
         StartLocationOffset=(X=5.000000)
         StartSizeRange=(X=(Min=6.000000,Max=12.000000),Y=(Min=6.000000,Max=12.000000),Z=(Min=6.000000,Max=12.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-400.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_RSNova1General.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.260714,Color=(B=255,G=128,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         Opacity=0.880000
         FadeOutStartTime=0.210000
         FadeInEndTime=0.160000
         MaxParticles=150
         AddLocationFromOtherEmitter=5
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=120.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=5
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_RSNova1General.SpriteEmitter7'

     AutoDestroy=True
}
