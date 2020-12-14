class IE_XOXOSmall extends DGVEmitter placeable;

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

		//There's a GetAxes call which is missing from the original function here. I wonder?
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
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=IE_XOXOSmallEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(X=-25.000000,Y=-50.000000,Z=-50.000000)
         ColorScale(0)=(Color=(B=192,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.178571,Color=(B=200,G=96,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=200,R=255,A=255))
         FadeOutStartTime=0.495000
         MaxParticles=4
         StartLocationOffset=(X=5.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=50.000000,Max=400.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.IE_XOXOSmall.IE_XOXOSmallEmitter0'

     Begin Object Class=SpriteEmitter Name=IE_XOXOSmallEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=200,G=150,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=150,G=100,R=255,A=255))
         FadeOutStartTime=0.137500
         FadeInEndTime=0.075000
         MaxParticles=40
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=3.000000,Max=10.000000),Z=(Min=1.000000,Max=2.000000))
         InitialParticlesPerSecond=60.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.IE_XOXOSmall.IE_XOXOSmallEmitter1'

     Begin Object Class=SpriteEmitter Name=IE_XOXOSmallEmitter2
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.400000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.162000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=35.000000,Max=40.000000),Y=(Min=35.000000,Max=40.000000),Z=(Min=35.000000,Max=40.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.IE_XOXOSmall.IE_XOXOSmallEmitter2'

     Begin Object Class=SpriteEmitter Name=IE_XOXOSmallEmitter3
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=1.440000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(Z=2.000000)
         SpinsPerSecondRange=(X=(Max=0.010000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=2.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.400000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPOtherPackPro.IE_XOXOSmall.IE_XOXOSmallEmitter3'

     Begin Object Class=SpriteEmitter Name=IE_XOXOSmallEmitter4
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.630000
         FadeInEndTime=0.070000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(Z=2.000000)
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=10.000000,Max=14.000000),Y=(Min=10.000000,Max=14.000000),Z=(Min=10.000000,Max=14.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'AW-2004Particles.Energy.EclipseCircle'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPOtherPackPro.IE_XOXOSmall.IE_XOXOSmallEmitter4'

     AutoDestroy=True
}
