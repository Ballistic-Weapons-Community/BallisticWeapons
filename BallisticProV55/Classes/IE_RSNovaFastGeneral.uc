//=============================================================================
// IE_RSNovaFastGeneral.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RSNovaFastGeneral extends DGVEmitter
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
     DisableDGV(1)=1
     DisableDGV(2)=1
     DisableDGV(5)=1
     EmitterZTestSwitches(1)=ZM_OffWhenVisible
     Begin Object Class=SpriteEmitter Name=SpriteEmitter32
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
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.457143,Color=(B=255,G=64,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.045000
         StartSpinRange=(X=(Min=0.240000,Max=0.260000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         StartVelocityRange=(X=(Min=100.000000,Max=700.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-200.000000,Max=250.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RSNovaFastGeneral.SpriteEmitter32'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.385714,Color=(B=255,G=96,R=96,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=64,R=64,A=255))
         FadeOutStartTime=0.045000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=50.000000,Max=80.000000),Y=(Min=50.000000,Max=80.000000),Z=(Min=50.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RSNovaFastGeneral.SpriteEmitter33'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter34
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
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=255,G=64,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=64,R=64,A=255))
         FadeOutStartTime=0.650000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=1.000000)
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=0.400000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=13.000000,Max=15.000000),Y=(Min=13.000000,Max=15.000000),Z=(Min=13.000000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_RSNovaFastGeneral.SpriteEmitter34'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter35
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=128,R=64,A=255))
         ColorScale(1)=(RelativeTime=0.289286,Color=(B=255,G=212,R=192,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000))
         Opacity=0.330000
         FadeOutStartTime=1.020000
         FadeInEndTime=0.120000
         MaxParticles=15
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=4.000000,Z=4.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
         InitialParticlesPerSecond=12.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=100.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=4.000000,Max=4.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_RSNovaFastGeneral.SpriteEmitter35'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
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
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.317857,Color=(B=64,G=224,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         FadeOutStartTime=0.045000
         MaxParticles=6
         StartSpinRange=(X=(Min=0.240000,Max=0.260000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         StartVelocityRange=(X=(Min=100.000000,Max=700.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-200.000000,Max=250.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_RSNovaFastGeneral.SpriteEmitter26'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.214286,Color=(B=64,G=224,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=64,R=255,A=255))
         FadeOutStartTime=2.520000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.200000),Y=(Min=0.100000,Max=0.200000),Z=(Min=0.100000,Max=0.200000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(5)=MeshEmitter'BallisticProV55.IE_RSNovaFastGeneral.MeshEmitter2'

     AutoDestroy=True
}
