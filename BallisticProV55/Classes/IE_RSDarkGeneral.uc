//=============================================================================
// IE_RSDarkGeneral.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RSDarkGeneral extends DGVEmitter
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

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(1)=1
     DisableDGV(2)=1
     DisableDGV(4)=1
     DisableDGV(5)=1
     EmitterZTestSwitches(5)=ZM_OffWhenVisible
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
         ColorScale(0)=(Color=(G=224,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.121429,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.703571,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         Opacity=0.830000
         FadeOutStartTime=0.148000
         FadeInEndTime=0.048000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.610000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BWBP4-Tex.DarkStar.DarkShock'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RSDarkGeneral.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         ProjectionNormal=(X=1.000000,Z=0.000000)
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.195000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         SpinCCWorCW=(X=1.000000)
         SpinsPerSecondRange=(X=(Min=0.400000,Max=0.400000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.FlareC1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RSDarkGeneral.SpriteEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP4-Hardware.NovaStaff.Nova-GlowChips'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=64,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.064286,Color=(B=64,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.171429,Color=(G=64,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         Opacity=0.710000
         FadeOutStartTime=2.360000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.300000,Max=0.400000),Y=(Min=0.300000,Max=0.400000),Z=(Min=0.300000,Max=0.400000))
         InitialParticlesPerSecond=5000.000000
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.IE_RSDarkGeneral.MeshEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-800.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.400000,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=1.095000
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSpinRange=(Y=(Min=-0.250000,Max=-0.250000))
         StartSizeRange=(X=(Min=0.300000,Max=0.500000),Y=(Min=0.300000,Max=0.500000),Z=(Min=0.500000))
         InitialParticlesPerSecond=5000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Max=100.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-100.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(3)=MeshEmitter'BallisticProV55.IE_RSDarkGeneral.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.250000,Max=0.250000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.520000
         FadeOutStartTime=0.150000
         FadeInEndTime=0.045000
         MaxParticles=80
         AddLocationFromOtherEmitter=3
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         AddVelocityFromOtherEmitter=3
         AddVelocityMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_RSDarkGeneral.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=192,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.185714,Color=(G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.646429,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.045000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.500000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_RSDarkGeneral.SpriteEmitter4'

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
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.114286,Color=(B=192,G=224,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(G=128,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.289286,Color=(G=128,R=255,A=255))
         ColorScale(4)=(RelativeTime=0.428571,Color=(G=32,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(R=255,A=255))
         Opacity=0.530000
         FadeOutStartTime=0.270000
         FadeInEndTime=0.050000
         MaxParticles=30
         StartLocationOffset=(X=6.000000,Z=4.000000)
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000))
         StartSpinRange=(X=(Min=0.480000,Max=0.520000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=0.370000,RelativeSize=0.750000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=15.000000
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=45.000000,Max=45.000000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_RSDarkGeneral.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
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
         ColorMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.150000,Max=0.150000))
         Opacity=0.720000
         FadeOutStartTime=0.740000
         FadeInEndTime=0.220000
         MaxParticles=20
         StartLocationOffset=(X=8.000000,Z=16.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=0.150000)
         SizeScale(2)=(RelativeTime=0.740000,RelativeSize=0.500000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
         InitialParticlesPerSecond=7.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticWeapons2.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=40.000000,Max=40.000000))
         VelocityLossRange=(Z=(Min=0.800000,Max=0.800000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.IE_RSDarkGeneral.SpriteEmitter9'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightBrightness=160.000000
     LightRadius=16.000000
     LightPeriod=3
}
