//=============================================================================
// AH104FireHit.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AH104FireHit extends DGVEmitter
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

	Emitters[0].StartSpinRange.X.Max = float(Rotation.Yaw)/65536;
	Emitters[0].StartSpinRange.X.Min = Emitters[0].StartSpinRange.X.Max;
	Emitters[0].StartSpinRange.Y.Max = float(Rotation.Pitch)/65536;
	Emitters[0].StartSpinRange.Y.Min = Emitters[0].StartSpinRange.Y.Max;

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
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.FBlast'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.161000
         FadeInEndTime=0.119000
         MaxParticles=4
         StartLocationRange=(Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=3.000000),Y=(Min=4.000000,Max=5.000000),Z=(Min=4.000000,Max=5.000000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.700000)
     End Object
     Emitters(0)=MeshEmitter'BWBP_SKC_Pro.AH104FireHit.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.215000
         FadeInEndTime=0.105000
         MaxParticles=40
         StartLocationOffset=(X=40.000000)
         StartSizeRange=(X=(Min=50.000000,Max=80.000000),Y=(Min=50.000000,Max=80.000000),Z=(Min=50.000000,Max=80.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.450000,Max=0.550000)
         StartVelocityRange=(Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.AH104FireHit.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.300000
         FadeInEndTime=0.204000
         MaxParticles=2
         StartLocationOffset=(X=40.000000)
         StartLocationRange=(Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         StartSizeRange=(X=(Min=180.000000,Max=220.000000),Y=(Min=180.000000,Max=220.000000),Z=(Min=180.000000,Max=220.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.AH104FireHit.SpriteEmitter4'

     AutoDestroy=True
}
