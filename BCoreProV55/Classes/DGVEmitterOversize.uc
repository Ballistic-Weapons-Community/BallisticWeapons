//=============================================================================
// DGVEmitterOversize. Modified for larger arrays
//
// Directional/Gravitational Velocity Emitter.
// X Velocity makes particles move forward according to emitter rotation
// Y Velocity makes particles move Left/Right
// Z Is Up/Down no matter what angle the emitter is rotated
// Unfortunately this is only for the StartVelocityRange
// bAutoAlignVelocity can be used to automatically realign the StartVelocity
// if the emitter is rotated.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DGVEmitterOversize extends BallisticEmitter
	placeable;

var() bool				bAutoAlignVelocity;		//If true, StartVelocityRange is automatically realigned when emitter rotates
var	  Rotator			OldRotation;			//Last different rotation. Used to check if emitter rotated
var	  Range				SVX[14], SVY[14], SVZ[14];	//Arrays used to store initial StartVelocityRange values
var() Array<int>		DisableDGV;				//Disable DVG for individual emitter by entering a value
var() bool				bAutoInit;				//Disable to prevent InitDGV from being run from PostBeginPlay()
var() bool				bAlignOnTrigger;		//Align velocity when triggered
var() bool				bVerticalZ;				//Velocity Z is not relative, it moves particles along world Z axis (useful for simulating gravity)
var() bool				bYIsSpread;				//Y velocity applied to Z axis as emmiter aims up. Only works with bVerticalZ (removes flat looking spread)
var() bool				bModifyLossRange;		//Allow messing with VelocityLossRange...

simulated event PostBeginPlay ()
{
	Super.PostBeginPlay();
	if (bAutoInit)
		InitDGV();
}

simulated function InitDGV()
{
	local int i;

	for (i=0;i<Emitters.Length;i++)
	{
		if (DisableDGV.Length > i && DisableDGV[i] != 0)
			continue;
		//Remember some stuff...
		SVX[i] = Emitters[i].StartVelocityRange.X;
		SVY[i] = Emitters[i].StartVelocityRange.Y;
		SVZ[i] = Emitters[i].StartVelocityRange.Z;
	}

	//Set up for auto align
	if (bAutoAlignVelocity)
	{
		OldRotation = Rotation;
		SetTimer (0.1, True);
	}
	//Initial alignment
	AlignVelocity();
}

event Trigger( Actor Other, Pawn EventInstigator )
{
	if (bAlignOnTrigger)
		AlignVelocity();
	Super.Trigger (Other, EventInstigator);
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

// Check to see if we should realign StartVelocityRange every 0.1 seconds
simulated event timer ()
{
	if (!bAutoAlignVelocity)
		return;
	if (Rotation != OldRotation)
	{
		OldRotation = Rotation;
		AlignVelocity();
	}
}

defaultproperties
{
     bAutoInit=True
     bAlignOnTrigger=True
     bVerticalZ=True
     bYIsSpread=True
     bModifyLossRange=True
     bDirectional=True
}
