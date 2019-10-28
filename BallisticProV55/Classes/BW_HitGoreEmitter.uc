//=============================================================================
// BW_HitGoreEmitter.
//
// Added function InitHitForce() for aligning effects according to Hit Ray.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BW_HitGoreEmitter extends DGVEmitter
	placeable;

struct GibInfo
{
	var() StaticMesh	Mesh;
	var() vector		Offset;
	var() RangeVector	Velocity;
	var() rotator		Pivot;
	var() float			DrawScale;
};
var() array<GibInfo>	Gibs;

//simulated function InitHitForce(vector HitRay);

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
/*		if (bVerticalZ)
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
*/
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

simulated function InitHitForce(vector HitRay, float GibPerterbation)
{
	local BallisticGib Gib;
	local vector X,Y,Z, VMax, VMin, GibRay;
	local int i;

	GetAxes(Rotation,X,Y,Z);
	for (i=0;i<Gibs.length;i++)
	{
		if (Gibs[i].mesh != None)
		{
			GibRay = class'butil'.static.VLerp(GibPerterbation-0.2, HitRay, VRand(), true);
			Gib = Spawn(class'BallisticGib',Owner,,Location + X*Gibs[i].Offset.X + Y*Gibs[i].Offset.Y + Z*Gibs[i].Offset.Z, Rotation+Gibs[i].Pivot);
			Gib.Velocity =	GibRay * 	Lerp(FRand(), Gibs[i].Velocity.X.Min, Gibs[i].Velocity.X.Max) +
							Y * 		Lerp(FRand(), Gibs[i].Velocity.Y.Min, Gibs[i].Velocity.Y.Max) +
							vect(0,0,1)*Lerp(FRand(), Gibs[i].Velocity.Z.Min, Gibs[i].Velocity.Z.Max);
			Gib.SetStaticMesh(Gibs[i].Mesh);
			if (Gibs[i].DrawScale != 0)
				Gib.SetDrawScale(Gibs[i].DrawScale);
		}
	}
	GetAxes(rotator(HitRay),X,Y,Z);
	for (i=0;i<Emitters.length;i++)
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

		Emitters[i].StartVelocityRange.X.Max += Owner.Velocity.X*0.5;
		Emitters[i].StartVelocityRange.X.Min += Owner.Velocity.X*0.5;
		Emitters[i].StartVelocityRange.Y.Max += Owner.Velocity.Y*0.5;
		Emitters[i].StartVelocityRange.Y.Min += Owner.Velocity.Y*0.5;
		Emitters[i].StartVelocityRange.Z.Max += Owner.Velocity.Z*0.5;
		Emitters[i].StartVelocityRange.Z.Min += Owner.Velocity.Z*0.5;
	}
}

defaultproperties
{
}
