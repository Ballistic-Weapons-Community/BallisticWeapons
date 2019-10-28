//=============================================================================
// RSDarkFlameSpray.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkFlameSpray extends DGVEmitter;

state Terminated
{
	simulated function BeginState()
	{
		SetTimer(0.15, false);
	}
	event Timer()
	{
		Kill();
	}
}

simulated function SetFlameRange(float Range)
{
	local int i;
	if (Range > 600 && Emitters[0].UseCollision)
	{
		for (i=0;i<Emitters.length;i++)
			Emitters[i].UseCollision = false;
	}
	else if (!Emitters[0].UseCollision)
	{
		for (i=0;i<Emitters.length;i++)
			Emitters[i].UseCollision = true;
	}
/*	Emitters[0].LifetimeRange.Min = FMin(0.66, Range / 2727);
	Emitters[0].LifetimeRange.Max = Emitters[0].LifetimeRange.Min;
	Emitters[1].LifetimeRange.Min = FMin(0.6, Range / 3000);
	Emitters[1].LifetimeRange.Max = Emitters[1].LifetimeRange.Min;
	Emitters[3].LifetimeRange.Min = FMin(0.6, Range / 3000);
	Emitters[3].LifetimeRange.Max = Emitters[3].LifetimeRange.Min;
	Emitters[4].LifetimeRange.Min = FMin(0.6, Range / 3000);
	Emitters[4].LifetimeRange.Max = Emitters[4].LifetimeRange.Min;
*/
}

event Tick(float DT)
{
	local int i;
//	local RangeVector OV;
	super.Tick(DT);

	Emitters[0].StartSpinRange.X.Max = float(Rotation.Yaw)/65536;
	Emitters[0].StartSpinRange.X.Min = Emitters[0].StartSpinRange.X.Max;
	Emitters[0].StartSpinRange.Y.Max = float(Rotation.Pitch)/65536 + 0.5;
	Emitters[0].StartSpinRange.Y.Min = Emitters[0].StartSpinRange.Y.Max;
	if (Owner == None)
		return;

//	if (Rotation != OldRotation)
//	{
//		OldRotation = Rotation;
		AlignVelocity();
//	}
	for(i=0;i<Emitters.length;i++)
	{
		if (i == 4)
			continue;
		Emitters[i].StartVelocityRange.X.Max += Owner.Velocity.X;
		Emitters[i].StartVelocityRange.X.Min += Owner.Velocity.X;
		Emitters[i].StartVelocityRange.Y.Max += Owner.Velocity.Y;
		Emitters[i].StartVelocityRange.Y.Min += Owner.Velocity.Y;
		Emitters[i].StartVelocityRange.Z.Max += Owner.Velocity.Z;
		Emitters[i].StartVelocityRange.Z.Min += Owner.Velocity.Z;
	}
//	for(i=0;i<Emitters.length;i++)
//	{
/*		OV = VtoRV(Owner.Velocity, Owner.Velocity);
		SVX[i].Max = Emitters[i].default.StartVelocityRange.X.Max + OV.X.Max;
		SVX[i].Min = Emitters[i].default.StartVelocityRange.X.Min + OV.X.Min;
		SVY[i].Max = Emitters[i].default.StartVelocityRange.Y.Max + OV.Y.Max;
		SVY[i].Min = Emitters[i].default.StartVelocityRange.Y.Min + OV.Y.Min;
		SVZ[i].Max = Emitters[i].default.StartVelocityRange.Z.Max + OV.Z.Max;
		SVZ[i].Min = Emitters[i].default.StartVelocityRange.Z.Min + OV.Z.Min;
*/
//		Emitters[i].default.StartVelocityRange.X.Max += Owner.Velocity.X;
//		Emitters[i].default.StartVelocityRange.X.Min += Owner.Velocity.X;
//		Emitters[i].default.StartVelocityRange.Y.Max += Owner.Velocity.X;
//		Emitters[i].default.StartVelocityRange.Y.Min += Owner.Velocity.X;
//		Emitters[i].default.StartVelocityRange.Z.Max += Owner.Velocity.X;
//		Emitters[i].default.StartVelocityRange.Z.Min += Owner.Velocity.X;
//	}
}

simulated function InitDGV()
{
	OldRotation = Rotation;
	super.InitDGV();
}
/*
// Calculate the StartVelocityRange according to rotation
simulated function AlignVelocity ()
{
	local int i;
	local vector X, Y, Z, VMax, VMin, OV;

	if (Owner != None)
		OV = Owner.Velocity;
	for (i=0;i<Emitters.Length;i++)
	{
		if (DisableDGV.Length > i && DisableDGV[i] != 0)
			continue;

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
			VMax = X * SVX[i].Max + Y * SVY[i].Max + Z * SVZ[i].Max + OV;
			VMin = X * SVX[i].Min + Y * SVY[i].Min + Z * SVZ[i].Min + OV;
		}
		Emitters[i].StartVelocityRange = VtoRV(VMax, VMin);

		//Adjust StartLocationRange
		VMax = X * Emitters[i].default.StartLocationRange.X.Max + Y * Emitters[i].default.StartLocationRange.Y.Max + Z * Emitters[i].default.StartLocationRange.Z.Max;
		VMin = X * Emitters[i].default.StartLocationRange.X.Min + Y * Emitters[i].default.StartLocationRange.Y.Min + Z * Emitters[i].default.StartLocationRange.Z.Min;
		Emitters[i].StartLocationRange = VtoRV(VMax, VMin);
		//Adjust StartLocationOffset
		Emitters[i].StartLocationOffset = X * Emitters[i].default.StartLocationOffset.X + Y * Emitters[i].default.StartLocationOffset.Y + Z * Emitters[i].default.StartLocationOffset.Z;

		//Adjust VelocityLossRange
		VMax = X * Emitters[i].default.VelocityLossRange.X.Max + Y * Emitters[i].default.VelocityLossRange.Y.Max + Z * Emitters[i].default.VelocityLossRange.Z.Max;
		VMin = X * Emitters[i].default.VelocityLossRange.X.Min + Y * Emitters[i].default.VelocityLossRange.Y.Min + Z * Emitters[i].default.VelocityLossRange.Z.Min;
		Emitters[i].VelocityLossRange = VtoRV(VMax, VMin);
	}
}
*/

defaultproperties
{
     DisableDGV(4)=1
     bVerticalZ=False
     bYIsSpread=False
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BallisticHardware2.M806.PistolMuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=64,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.125000,Color=(B=255,G=64,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.221429,Color=(B=255,G=64,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.000000),Z=(Min=0.000000))
         FadeOutStartTime=0.250000
         FadeInEndTime=0.030000
         MaxParticles=15000
         StartLocationOffset=(X=30.000000)
         SpinsPerSecondRange=(Z=(Max=1.000000))
         StartSpinRange=(Y=(Min=0.500000,Max=0.500000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.400000,Max=0.500000),Y=(Min=0.020000,Max=0.080000),Z=(Min=0.020000,Max=0.080000))
         InitialParticlesPerSecond=15.000000
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.550000,Max=0.550000)
         StartVelocityRange=(X=(Min=1200.000000,Max=1200.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RSDarkFlameSpray.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000),Y=(Min=0.250000,Max=0.300000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.270000
         FadeInEndTime=0.240000
         MaxParticles=2000
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.550000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=40.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BWBP4-Tex.DarkStar.Plasma-A'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=1200.000000,Max=1200.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkFlameSpray.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.000000,Max=0.050000),Z=(Min=0.000000,Max=0.400000))
         FadeOutStartTime=0.300000
         FadeInEndTime=0.120000
         MaxParticles=1000
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.390000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=120.000000,Max=120.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'BallisticEffects.Particles.FlareC1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.450000,Max=0.500000)
         StartVelocityRange=(X=(Min=1100.000000,Max=1250.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkFlameSpray.SpriteEmitter8'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.GlowChunk'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.370000
         MaxParticles=400
         StartLocationOffset=(X=10.000000)
         SpinsPerSecondRange=(X=(Max=3.000000),Y=(Max=3.000000),Z=(Max=3.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.300000,Max=0.600000),Y=(Min=0.300000,Max=0.600000),Z=(Min=0.300000,Max=0.600000))
         InitialParticlesPerSecond=8.000000
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=500.000000,Max=1200.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-80.000000,Max=200.000000))
     End Object
     Emitters(3)=MeshEmitter'BallisticProV55.RSDarkFlameSpray.MeshEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.200000,Max=0.600000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.168000
         FadeInEndTime=0.056000
         MaxParticles=4000
         AddLocationFromOtherEmitter=3
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=1.000000,Max=1.500000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         AddVelocityFromOtherEmitter=3
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSDarkFlameSpray.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseMaxCollisions=True
         UseColorScale=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.121429,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=0.257143,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         Opacity=0.540000
         FadeOutStartTime=0.500000
         FadeInEndTime=0.300000
         MaxParticles=1400
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=40.000000),Y=(Min=120.000000,Max=150.000000),Z=(Min=120.000000,Max=150.000000))
         InitialParticlesPerSecond=28.000000
         Texture=Texture'BWBP4-Tex.DarkStar.Plasma-A'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=1120.000000,Max=1250.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.RSDarkFlameSpray.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseMaxCollisions=True
         UseColorScale=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.121429,Color=(G=176,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.275000,Color=(G=160,R=192,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.180000
         MaxParticles=600
         AlphaRef=96
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=40.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=12.000000
         Texture=Texture'BWBP4-Tex.DarkStar.Plasma-A-AlphaAdd'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=1120.000000,Max=1250.000000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.RSDarkFlameSpray.SpriteEmitter1'

     AutoDestroy=True
     bHardAttach=True
}
