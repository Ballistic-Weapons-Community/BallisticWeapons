//=============================================================================
// BUtil.
//
// General purpose structs, functions, etc for Ballistic systems.
//
// Includes:
// -FullSound system: All sound props in one struct + functions to play a FullSound straight
// -InitEmitterFlash: To scale an emitter and InitDGV if its DGVEmitter
// -InitMuzzleFlash: To spawn, scale, Init and attach an emitter automatically (used for all kinds of, mainly weapon, effects in BW)
// -KillEmitterEffect: Lazy way to run Kill() if the actor is and emitter and Destroy() if not...
// -CleanTrace: Performs a trace, but automatically puts HitLocation at end of trace if no hit, corrects normal for backface hits and
//	corrects moves back HitLocation when hitting static meshes so HL is better aligned to the surf
// -AlignedOffset functions: Quick way to align a vector along the axes of a rotator (commonly used in BW)
// -Interpolation Functions: Shortcuts to Lerp and Smerp Vectors and Rotators
// -Loop + LoopFloat: Functions to increment an int or float and have them loop within a specified range
// -RotateAboutAxis: Gets a rotator rotated about the axis specified by another rotator
// -ConvertFOVs: Adjusts an input Vector to appear to be in the same spot when drawn with a diferent FOV
//  ( very very handy when things must appear linking two actors that are drawn seperately with different FOVs )
// -NormToByte:	Compresses a vector normal into a byte
// -ByteToNorm: Extract a vector normal from a byte. Bits 1-2-4 for X, 8-16-32 for Y, 64-128 for Z. Very low res...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BUtil extends Object
	exportstructs;

// These are a quick way for log entries to show the NetMode and Role
// Just use: class'BUtil'.default.NM[int(level.NetMode)]
// Or use: class'BUtil'.MyNetMode(level);
var() Array<String> NM;
var() Array<String> RL;

// Full sounds Are a simple way to set up and play sounds with detailed settings
// All the settings with wich to play the sound
struct FullSound
{
	var() Sound				Sound;		//Sound to use
	var() float				Volume;		//Volume to play it at (0 - 1)
	var() float				Radius;		//Radius to use
	var() Actor.ESoundSlot	Slot;		//Slot to use
	var() float				Pitch;		//0-1
	var() bool				bAtten;		//
	var() bool				bNoOverride;//
};

// Even quicker way to show the NetModes and Roles as easy to read strings
static function string MyNetMode(Levelinfo L)	{	return default.NM[L.NetMode];	}
static function string MyRole(Actor A)			{	return default.RL[A.Role];		}

// Handy function for playing a FullSound
// Use bOwned to play using PlayOwnedSound(), otherwise it will use PlaySound()
final simulated static function PlayFullSound (Actor A, FullSound Snd, optional bool bOwned)
{
	if (A == None)
	{
		log("PlayFullSound: tried to play "$Snd.Sound$" with no actor", 'Warning');
		return;
	}
	if (Snd.Sound == None)
	{
		log("PlayFullSound: "$A$" tried to play Null sound", 'Warning');
		return;
	}
	if (Snd.Pitch == 0)
		Snd.Pitch = 1;
	if (bOwned)
		A.PlayOwnedSound(Snd.Sound,Snd.Slot,Snd.Volume,Snd.bNoOverride,Snd.Radius,Snd.Pitch,Snd.bAtten);
	else
		A.PlaySound(Snd.Sound,Snd.Slot,Snd.Volume,Snd.bNoOverride,Snd.Radius,Snd.Pitch,Snd.bAtten);
}

// Scales Emitter flashes and inits DGVEmitter flashes
static function InitEmitterFlash (Emitter F, float FlashScale)
{
	if (F == None)
		return;
	class'BallisticEmitter'.static.ScaleEmitter(F, FlashScale);
	if (DGVEmitter(F) != None)
		DGVEmitter(F).InitDGV();
	return;
}
// Handy function for spawning, attaching and initializing emitter and non-emitter muzzle flashes
static function InitMuzzleFlash (out Actor Flash, class<actor> FlashClass, float FlashScale, Actor OwnedBy, name AttachBone)
{
	if (Flash != None || OwnedBy == None || FlashClass == None)
		return;
	// Spawn, Attach, Scale, Initialize emitter flashes
	Flash = OwnedBy.Spawn(FlashClass, OwnedBy);
	if (Emitter(Flash) != None)
		class'BUtil'.static.InitEmitterFlash(Emitter(Flash), FlashScale);
	Flash.SetDrawScale(FlashScale);
	OwnedBy.AttachToBone(Flash, AttachBone);
}

// Handy function that neatly Kill()s an actor if its an emitter or Destroy()s it if not
static function KillEmitterEffect (Actor Flash)
{
	if (Flash == None)
		return;
	if (Emitter(Flash) != None)
		Emitter(Flash).Kill();
	else
		Flash.Destroy();
}
// A trace that has the hitlocation set to the end if it hits nothing, the normal fixed if it hits the back of a face and
// the hitlocation moved 3 units towards the surface if it hits a static mesh...
static function Actor CleanTrace (Actor TraceOwner, Vector End, Vector Start, out Vector HitLocation, out Vector HitNormal, optional bool bTraceActors, optional vector Extent, optional out Material HitMaterial)
{
	local Actor T;
	T = TraceOwner.Trace(HitLocation, HitNormal, End, Start, bTraceActors, Extent, HitMaterial);
	if (T == None)
	{
		HitLocation = End;
		return None;
	}
	if (T.DrawType == DT_StaticMesh)
		HitLocation -= HitNormal*3;
	if (HitNormal Dot Normal(End - Start) > 0.0)
		HitNormal *= -1;
	return T;
}

//Returns the offset vector aligned to the axes of a rotator
static final function Vector AlignedOffset(Rotator R, Vector Offset)
{
	local Vector X,Y,Z;
	GetAxes(R,X,Y,Z);
	return (X*Offset.X + Y*Offset.Y + Z*Offset.Z);
}
//Returns the offset vector aligned to the view axes of a player(using a weapon's GetViewAxes() function)
static final function Vector ViewAlignedOffset(Weapon W, Vector Offset)
{
	local Vector X,Y,Z;
	W.GetViewAxes(X,Y,Z);
	return (X*Offset.X + Y*Offset.Y + Z*Offset.Z);
}

// Some handy interpolation functions. These are a quick way to interpolate wierd things like vectors...
// Vector Lerp.
static final function Vector VLerp(float Alpha, Vector A, Vector B, optional bool bClampRange)
{
	local Vector V;
	V.X = Lerp(Alpha, A.X, B.X, bClampRange);
	V.Y = Lerp(Alpha, A.Y, B.Y, bClampRange);
	V.Z = Lerp(Alpha, A.Z, B.Z, bClampRange);
	Return V;//A + (B-A) * Alpha;
}
// Vector Smerp
static final function Vector VSmerp(float Alpha, Vector A, Vector B)
{
	local Vector V;
	V.X = Smerp(Alpha, A.X, B.X);
	V.Y = Smerp(Alpha, A.Y, B.Y);
	V.Z = Smerp(Alpha, A.Z, B.Z);
	return V;
}
// Rotator Smerp
static final function Rotator RLerp (float Alpha, Rotator A, Rotator B, optional bool bClampRange)
{
	local Rotator R;
	R.Yaw	= Lerp(Alpha, A.Yaw, B.Yaw, bClampRange);
	R.Pitch	= Lerp(Alpha, A.Pitch, B.Pitch, bClampRange);
	R.Roll	= Lerp(Alpha, A.Roll, B.Roll, bClampRange);
	return R;
}
// Rotator Smerp
static final function Rotator RSmerp (float Time, Rotator Min, Rotator Max)
{
	local Rotator R;
	R.Yaw	= Smerp(Time, Min.Yaw, Max.Yaw);
	R.Pitch	= Smerp(Time, Min.Pitch, Max.Pitch);
	R.Roll	= Smerp(Time, Min.Roll, Max.Roll);
	return R;
}

// Increment an int and have it loop within a specified range
static final function int Loop(int It, int By, optional int Max, optional int Min)
{
	if (It + By > Max)
		return -1 + Min + It + By - Max;
//		return (Min-1) + By - (Max - It);
	if (It + By < Min)
		return 1 + Max + It + By - Min;
//		return (Max+1) + By - (Min - It);
	return It + By;
}
// Increment a float and have it loop within a specified range
static final function float LoopFloat(float It, float By, optional float Max, optional float Min)
{
	if (It + By > Max)
		return Min + It + By - Max;
//		return (Min-1) + By - (Max - It);
	if (It + By < Min)
		return Max + It + By - Min;
//		return (Max+1) + By - (Min - It);
	return It + By;
}

// Get a rotator rotated about the axis specified by another rotator
static final function rotator RotateAboutAxis (rotator Axis, rotator Offset)
{
	local vector X,Y,Z;
	GetAxes(Offset, X,Y,Z);
	return OrthoRotation(X>>Axis, Y>>Axis, Z>>Axis);
}

// 1		: X = 1				1
// 2		: X = -1			2
// 4		: X = 0.7			4
// 1+2		: X = 0.4			3
// 1+4		: X = -0.4			5
// 2+4		: X = -0.7			6
// 1+2+4	:					7
// !1+!2+!4	: X = 0				0

// 8			: Y = 1			8
// 16			: Y = -1		16
// 32			: Y = 0.7		32
// 8+16			: Y = 0.4		24
// 8+32			: Y = -0.4		40
// 16+32		: Y = -0.7		48
// 8+16+32		:				56
// !8+!16+!32	: Y = 0			0

// 64 			: Z = 1			64
// 128			: Z = -1		128
// !64 + !128	: Z = 0			0
// 64 + 128		: Z = 0.7		192

// Compress a vector normal into a single byte
static final function byte		NormToByte (vector V)
{
	local byte B;

	if (V.X > 0)		{
		if (V.X >= 1.0)
			B = 1;
		else if (V.X >= 0.7)
			B = 4;
		else if (V.X >= 0.4)
			B = 3;		}
	else if (V.X < 0)	{
		if (V.X <= -1.0)
			B = 2;
		else if (V.X <= -0.7)
			B = 6;
		else if (V.X <= -0.4)
			B = 5;		}

	if (V.Y > 0)		{
		if (V.Y >= 1.0)
			B = B | 8;
		else if (V.Y >= 0.7)
			B = B | 32;
		else if (V.Y >= 0.4)
			B = B | 24;		}
	else if (V.Y < 0)	{
		if (V.Y <= -1.0)
			B = B | 16;
		else if (V.Y <= -0.7)
			B = B | 48;
		else if (V.Y <= -0.4)
			B = B | 40;		}

	if (V.Z > 0)			{
		if (V.Z >= 0.75)
			B = B | 64;
		else if (V.Z >= 0.5)
			B = B | 192;		}
	else if (V.Z < 0.4)
		B = B | 128;

	return B;
}
// Extract a vector normal that has been compressed into a byte
static final function vector	ByteToNorm (byte B)
{
	local vector V;

	switch (B & 7)
	{	case 6:	V.X = -0.7;		break;
		case 5: V.X = -0.4;		break;
		case 4: V.X = 0.7;		break;
		case 3: V.X = 0.4;		break;
		case 2: V.X = -1;		break;
		case 1: V.X = 1;		break;
//		default : V.X = 0;		break;
	}
	switch (B & 56)
	{	case 8:	 V.Y = 1;		break;
		case 16: V.Y = -1;		break;
		case 24: V.Y = 0.4;		break;
		case 32: V.Y = 0.7;		break;
		case 40: V.Y = -0.4;	break;
		case 48: V.Y = -0.7;	break;
//		default : V.Y = 0;		break;
	}
	switch (B & 192)
	{	case 64:  V.Z = 1;		break;
		case 128: V.Z = -1;		break;
		case 192: V.Z = 0.7;	break;
//		default : V.Z = 0;		break;
	}
	return V;
}

// -Added: v2.1
// Very handy function to get a point adjusted to sit on the right spot to look like its drawn with a different FOV
// ( commonly used for 1st person weapon stuff like laser sights, flamer streams or wherever something must appear
//   aligned to two or more points that are drawn with different FOVs )
static final function vector ConvertFOVs (vector ViewLoc, rotator ViewRot, vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector Outvec, Dir, X, Y, Z;

	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}
// Simpler implementation to be used on weapons
static final  function vector WeaponConvertFOVs (Weapon Weap, vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Weap.Instigator.Location + Weap.Instigator.EyePosition();
	ViewRot = Weap.Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

defaultproperties
{
     NM(0)="NM_Standalone"
     NM(1)="NM_DedicatedServer"
     NM(2)="NM_ListenServer"
     NM(3)="NM_Client"
     RL(0)="ROLE_None"
     RL(1)="ROLE_DumbProxy"
     RL(2)="ROLE_SimulatedProxy"
     RL(3)="ROLE_AutonomousProxy"
     RL(4)="ROLE_Authority"
}
