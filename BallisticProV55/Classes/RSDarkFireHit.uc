//=============================================================================
// RSDarkFireHit.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkFireHit extends DGVEmitter
	placeable;

struct FlameHit
{
	var vector			HitLoc;	// Where it hit
	var vector			HitNorm;// Normal for hit
	var float			HitTime;// When to make it happen
};
var   array<FlameHit>		FlameHits;
var   float					KillFlameTime;
var   bool					bLost, bStarted;

simulated function AddHit(vector Loc, vector Norm, float Time)
{
	FlameHits.Length = FlameHits.Length + 1;
	FlameHits[FlameHits.Length-1].HitLoc = Loc;
	FlameHits[FlameHits.Length-1].HitNorm = Norm;
	FlameHits[FlameHits.Length-1].HitTime = Time;
	KillFlameTime = Time + 0.12;
}

simulated event Tick(float DT)
{
	local int i;
	for (i=0;i<FlameHits.length;i++)
	{
		if (level.TimeSeconds >= FlameHits[i].HitTime)
		{
			SetLocation(FlameHits[i].HitLoc);
			SetRotation(rotator(FlameHits[i].HitNorm));
			FlameHits.Remove(i,1);
			i--;
			if (!bStarted)
			{
				Emitters[0].AutomaticInitialSpawning=true;
				Emitters[1].AutomaticInitialSpawning=true;
				Emitters[2].AutomaticInitialSpawning=true;
				Emitters[3].AutomaticInitialSpawning=true;
				Emitters[4].AutomaticInitialSpawning=true;
				bStarted=true;
			}
		}
	}
	if (level.TimeSeconds >= KillFlameTime)
	{
		bLost=true;
		Kill();
	}

	super.Tick(DT);

	Emitters[2].StartSpinRange.X.Max = float(Rotation.Yaw)/65536;
	Emitters[2].StartSpinRange.X.Min = Emitters[2].StartSpinRange.X.Max;
	Emitters[2].StartSpinRange.Y.Max = float(Rotation.Pitch)/65536;
	Emitters[2].StartSpinRange.Y.Min = Emitters[2].StartSpinRange.Y.Max;

	if (Rotation != OldRotation)
	{
		OldRotation = Rotation;
		AlignVelocity();
	}
}

simulated event PostBeginPlay ()
{
	super.PostBeginPlay();
	SetTimer(0.25, true);
	Timer();
}

simulated event Timer ()
{
	if (!Level.GetLocalPlayerController().LineOfSightTo(self))
		Emitters[2].ZTest = true;
	else
		Emitters[2].ZTest = false;
}

// Calculate the StartVelocityRange according to rotation
simulated function AlignVelocity ()
{
//	local Range SV0;
	local int i;
	local vector X, Y, Z, VMax, VMin;

	GetAxes(Rotation,X,Y,Z);
	for (i=0;i<Emitters.Length;i++)
	{
		if (DisableDGV.Length > i && DisableDGV[i] != 0)
			continue;
//		if (SVX[i] == SV0 && SVY[i] == SV0 && SVZ[i] == SV0)
//			continue;

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

		if (SpriteEmitter(Emitters[i])!=None)
		{
			// Adjust ProjectionNormal
			SpriteEmitter(Emitters[i]).ProjectionNormal = X * SpriteEmitter(default.Emitters[i]).ProjectionNormal.X + Y * SpriteEmitter(default.Emitters[i]).ProjectionNormal.Y + Z * SpriteEmitter(default.Emitters[i]).ProjectionNormal.Z;
		}

		//Adjust VelocityLossRange
		if (bModifyLossRange)
		{
//			VMax = Abs(X * default.Emitters[i].VelocityLossRange.X.Max) + Abs(Y * default.Emitters[i].VelocityLossRange.Y.Max) + Abs(Z * default.Emitters[i].VelocityLossRange.Z.Max);
//			VMin = Abs(X * default.Emitters[i].VelocityLossRange.X.Min) + Abs(Y * default.Emitters[i].VelocityLossRange.Y.Min) + Abs(Z * default.Emitters[i].VelocityLossRange.Z.Min);

			VMax.X = Abs(X.X * default.Emitters[i].VelocityLossRange.X.Max) + Abs(X.Y * default.Emitters[i].VelocityLossRange.X.Max) + Abs(X.Z * default.Emitters[i].VelocityLossRange.X.Max);
			VMax.Y = Abs(Y.X * default.Emitters[i].VelocityLossRange.Y.Max) + Abs(Y.Y * default.Emitters[i].VelocityLossRange.Y.Max) + Abs(Y.Z * default.Emitters[i].VelocityLossRange.Y.Max);
			VMax.Z = Abs(Z.X * default.Emitters[i].VelocityLossRange.Z.Max) + Abs(Z.Y * default.Emitters[i].VelocityLossRange.Z.Max) + Abs(Z.Z * default.Emitters[i].VelocityLossRange.Z.Max);

			VMin.X = Abs(X.X * default.Emitters[i].VelocityLossRange.X.Min) + Abs(X.Y * default.Emitters[i].VelocityLossRange.X.Min) + Abs(X.Z * default.Emitters[i].VelocityLossRange.X.Min);
			VMin.Y = Abs(Y.X * default.Emitters[i].VelocityLossRange.Y.Min) + Abs(Y.Y * default.Emitters[i].VelocityLossRange.Y.Min) + Abs(Y.Z * default.Emitters[i].VelocityLossRange.Y.Min);
			VMin.Z = Abs(Z.X * default.Emitters[i].VelocityLossRange.Z.Min) + Abs(Z.Y * default.Emitters[i].VelocityLossRange.Z.Min) + Abs(Z.Z * default.Emitters[i].VelocityLossRange.Z.Min);

			Emitters[i].VelocityLossRange = VtoRV(VMax, VMin);
		}
	}
}

defaultproperties
{
     bVerticalZ=False
     bYIsSpread=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.336000
         FadeInEndTime=0.154000
         MaxParticles=3
         StartLocationOffset=(X=4.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         Texture=Texture'BWBP4-Tex.DarkStar.Plasma-B-AlphaAdd'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSDarkFireHit.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.342857,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.878571,Color=(G=24,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(Z=(Min=0.150000,Max=0.150000))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.161000
         MaxParticles=3
         StartLocationOffset=(X=4.000000)
         AlphaRef=64
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         Texture=Texture'BWBP4-Tex.DarkStar.Plasma-A-AlphaAdd'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkFireHit.SpriteEmitter6'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.Effects.FBlast'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.180000
         FadeInEndTime=0.096000
         MaxParticles=3
         StartLocationRange=(Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=2.500000),Y=(Max=2.500000),Z=(Max=2.500000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.500000)
         StartVelocityRange=(Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.RSDarkFireHit.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.314286,Color=(G=128,R=192,A=255))
         ColorScale(2)=(RelativeTime=0.657143,Color=(R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.045000
         MaxParticles=25
         StartLocationOffset=(X=6.000000)
         StartLocationRange=(Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         SphereRadiusRange=(Min=40.000000,Max=40.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         Texture=Texture'BWBP4-Tex.DarkStar.Plasma-A-AlphaAdd'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRadialRange=(Min=-300.000000,Max=-300.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSDarkFireHit.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.303571,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.063000
         MaxParticles=2
         StartLocationOffset=(X=20.000000)
         StartLocationRange=(Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=200.000000,Max=240.000000),Y=(Min=200.000000,Max=240.000000),Z=(Min=200.000000,Max=240.000000))
         Texture=Texture'BallisticEffects.Particles.FlareC1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.700000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSDarkFireHit.SpriteEmitter1'

     AutoDestroy=True
}
