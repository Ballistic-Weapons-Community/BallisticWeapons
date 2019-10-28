//=============================================================================
// BallisticBloodSet.
//
// This is a list of the various effects, decals and other properties that may
// vary depanding on the nature of the victim.
//
// Bloodsets are used by Ballistic gore systems. Each one is responsible for
// holding lists and controlling information for a certain type of victim.
// Gore systems can get the type of effect they want from a BloodSet without
// needing to know the color or other per-species properties.
// The appropriate parameters will be passed to bloodset static functions which
// can then decide what effect or whatever to return.
//
// BloodSets know the blood color and other per-speceis properties of the gore.
//	There should be a BloodSet for each type of victim.
// BloodManagers know the type of blood effects, decals, etc to ask for and
//	they know where and how to spawn them as well as alter certain species
//	insensetive properties.
//	There should be a Bloodmanager for each type of damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticBloodSet extends Object;

// ----------------------------------------------------------------------------
// Misc properties
var() string			MyBloodName;		// String containing some words that describe this blood
var() color				MyBloodColor;		// The color of the blood
// Body decals and effects
var() class<BallisticDecal>	BloodPool;		// Expanding Decal to use for blood pool
var() class<Emitter>	WaterBloodClass;	// Emtter to use for blood in water
var() class<Projector>	DragDecal;			// Decal to use for drag marks
var() class<Projector>	LowImpactDecal;		// Decal to use for Low Impacts
var() class<Projector>	HighImpactDecal;	// Decal to use for High Impacts
// Damage blood decals:
var() class<Projector>	BulletSplat;		// Default or Bullet blood
var() class<Projector>	ShotgunSplat;		// Shotgun sprayed blood
var() class<Projector>	ExplodeSplat;		// Exploded body blood
var() class<Projector>	SlashSplat;			// Slashed blood
var() class<Projector>	SawSplat;			// Blood from saws
// Damage blood and gore effects:
var() class<Actor>		BulletEffect;		// Bullets
var() class<Actor>		BulletHeadEffect;	// Bullet headshots
var() class<Actor>		ShotgunEffect;		// Shotgun spray
var() class<Actor>		ShotgunHeadEffect;	// Shotgun head spray
var() class<Actor>		ExplodeEffect;		// Explode damage and death blood (usually added over 'n above dismemberment effects)
var() class<Actor>		SlashEffect;		// Slashes
var() class<Actor>		SlashHeadEffect;	// Head slashes
var() class<Actor>		SawEffect;			// Spinning saw damage
var() class<Actor>		SawHeadEffect;		// Saw headshots
var() class<Actor>		BluntEffect;		// Blunt force
var() class<Actor>		BluntHeadEffect;	// Blunt force to head
var() class<Emitter>	WoundDripper;		// Attached blood dripper for wounds
// Dismemberment effects for:
var() class<Emitter>	HeadExplode;		// Head
var() class<Emitter>	TorsoExplode;		// Torso
var() class<Emitter>	ShoulderExplode;	// Upper and Lower Arms
var() class<Emitter>	ArmExplode;			// Upper and Lower Arms
var() class<Emitter>	HandExplode;		// Hands
var() class<Emitter>	LegExplode;			// Legs
var() class<Emitter>	FootExplode;		// Feet
var() class<Emitter>	PelvisExplode;		// Pelvis
var() class<Emitter>	ShoulderExplodeLeft;// Left Shoulder
var() class<Emitter>	ArmExplodeLeft;		// Left Arm
var() class<Emitter>	StumpDripper;		// Attached blood spurter for severed stumps
// Attached stumps for:
var() class<Actor>		DefaultStump;		// Standard dismembered limb
var() class<Actor>		CharredStump;		// Burnt type dismemberment
var() StaticMesh		AltStumpMesh;		// Stump mesh with narrow base. replaces normal stump's mesh in some situations
var() StaticMesh		AltCharStumpMesh;	// Charred alternative
// Sounds:
var() Sound				BulletHitSound;		// Sound when bullets hit victim
var() Sound				BulletHitHeadSound;	// Head hit sound
// Screen effects:
// Actors to spawn as an effect to appear stuck on the screens of victims, attackers and bystanders, like emitters (must handle attachment itself)
var() class<Actor>		ScreenEffectMisc;	// Blood for bullet injuries
var() class<Actor>		ScreenEffectSlice;	// Blood for slices n slashes
var() class<Actor>		ScreenEffectSaw;	// Blood for chainsaw style injuries

// Structure to hold properties for a particular gib
struct GibInfo
{
	var() class<BallisticGib>	GibClass;		// Custom gib class
	var() StaticMesh			Mesh;			// Static mesh
	var() vector				Offset;			// Offset from spawn bone. Aligned along victim axes
	var() RangeVector			Velocity;		// Velocity (X = Force ray, Y = Victim Y, Z = World Z)
	var() rotator				Pivot;			// Start rotation relative to victim
	var() float					DrawScale;		// Gib drawscale (0 = Dont change scale)
};
var() class<BallisticGib> DefaultGibClass;	// Default type of gib to use if the gib info doesn't use a custom one
// Gib Lists:
var() array<GibInfo>	HeadGibs;			// Head gibs
var() array<GibInfo>	TorsoGibs;			// Torso gibs
var() array<GibInfo>	PelvsGibs;			// Pelvis gibs
var() array<GibInfo>	OtherGibs;			// Others, Ordered 0-8 as: lshoulder, rshoulder, lfarm, rfarm, lthigh, rthigh, lfoot, rfoot, righthand

//-----------------------------------------------------------------------

// Return gibinfos for a particular bone
static function array<GibInfo> GetGibInfoFor (name Bone)
{
	local array<GibInfo> Gibs;
	switch (Bone)
	{
	case 'head'	:	 return default.HeadGibs;
	case 'spine': 	 return default.TorsoGibs;
	case 'pelvis': 	 return default.PelvsGibs;
	case 'lshoulder':if (default.OtherGibs.length > 0) Gibs[Gibs.length] = default.OtherGibs[0]; break;
	case 'rshoulder':if (default.OtherGibs.length > 1) Gibs[Gibs.length] = default.OtherGibs[1]; break;
	case 'lfarm':	 if (default.OtherGibs.length > 2) Gibs[Gibs.length] = default.OtherGibs[2]; break;
	case 'rfarm':	 if (default.OtherGibs.length > 3) Gibs[Gibs.length] = default.OtherGibs[3]; break;
	case 'lthigh':	 if (default.OtherGibs.length > 4) Gibs[Gibs.length] = default.OtherGibs[4]; break;
	case 'rthigh':	 if (default.OtherGibs.length > 5) Gibs[Gibs.length] = default.OtherGibs[5]; break;
	case 'lfoot':	 if (default.OtherGibs.length > 6) Gibs[Gibs.length] = default.OtherGibs[6]; break;
	case 'rfoot':	 if (default.OtherGibs.length > 7) Gibs[Gibs.length] = default.OtherGibs[7]; break;
	case 'lhand':
	case 'rhand':
	case 'righthand': if (default.OtherGibs.length > 8) Gibs[Gibs.length] = default.OtherGibs[8]; break;
	}
	return Gibs;
}

// Take gibinfos and return spawned gibs initializaed and ready for action!
static function array<actor> MakeGibsFor (Pawn Victim, name Bone, vector HitRay, float GibPerterbation, float ForceScale, array<GibInfo> Gibs, optional bool bFlaming)
{
	local array<actor>	GibActors;
	local BallisticGib Gib;
	local class<BallisticGib> GibClass;
	local vector X,Y,Z, BoneLoc, GibRay;
	local int i, j;

	if (Gibs.length < 1)
		return GibActors;

	GetAxes(Victim.Rotation,X,Y,Z);
	BoneLoc = Victim.GetBoneCoords(Bone).Origin;
	for (i=0;i<Gibs.length;i++)
	{
		if (Gibs[i].Mesh != None)
		{
			if (Gibs[i].GibClass != None)
				GibClass = Gibs[i].GibClass;
			else
				GibClass = default.DefaultGibClass;

			for (j=0;j<class'BloodManager'.default.GibMultiplier;j++)
			{
				GibRay = class'butil'.static.VLerp(GibPerterbation-0.2, HitRay, VRand(), true);
				Gib = Victim.Spawn(GibClass,Victim,,BoneLoc + X*Gibs[i].Offset.X + Y*Gibs[i].Offset.Y + Z*Gibs[i].Offset.Z, Victim.Rotation+Gibs[i].Pivot);
				if (Gib != None)
				{
					Gib.Velocity =	GibRay * 	Lerp(FRand(), Gibs[i].Velocity.X.Min, Gibs[i].Velocity.X.Max)  * ForceScale +
									Y * 		Lerp(FRand(), Gibs[i].Velocity.Y.Min, Gibs[i].Velocity.Y.Max) +
									vect(0,0,1)*Lerp(FRand(), Gibs[i].Velocity.Z.Min, Gibs[i].Velocity.Z.Max);
					Gib.SetStaticMesh(Gibs[i].Mesh);
					if (Gibs[i].DrawScale != 0)
						Gib.SetDrawScale(Gibs[i].DrawScale);
					if (bFlaming)
					{
						Gib.bFiery=true;
						Gib.bNoTrailWhenStill=false;
					}
					GibActors[GibActors.length] = Gib;
				}
			}
		}
	}
	return GibActors;
}

// Return the appropriate stump dripper class
static function class<Emitter> GetStumpDripper (Pawn Victim, name Bone)
{
	return default.StumpDripper;
}

// Hand out a stump that's been spawned and adjusted for a certain area
static function Actor GetStumpFor (actor Victim, name Bone, bool bCharred)
{
	local Actor NewStump;

	if (bCharred)
		NewStump = Victim.Spawn(default.CharredStump, Victim);
	else
		NewStump = Victim.Spawn(default.DefaultStump, Victim);
	if (NewStump == None)
		return None;
	switch (Bone)
	{
		case 'head'		:
			NewStump.SetDrawScale(0.9);
			NewStump.Prepivot.X = 3;
			NewStump.Prepivot.Y = 0.5;
			break;
		case 'spine'		:
			NewStump.SetDrawScale(1.6);
			NewStump.SetDrawScale3D(vect(1.2,0.9,1.2));
			NewStump.Prepivot.X = -1;
			NewStump.Prepivot.Y = -1;
			break;
		case 'pelvis'	:
			Victim.AttachToBone(NewStump, 'spine');
			NewStump.SetRelativeRotation(rot(32768,0,0));
			NewStump.SetDrawScale(2);
			NewStump.SetDrawScale3D(vect(1.0,0.8,0.9));
			NewStump.Prepivot.X = 5;
			break;
		case 'lthigh'		:
		case 'rthigh'		:
			NewStump.SetDrawScale(0.8);
			NewStump.SetDrawScale3D(vect(1.5,1.0,1.0));
			NewStump.Prepivot.X = 1.2;
			NewStump.Prepivot.Z = 0.5;
			break;
		case 'lfarm'		:
		case 'rfarm'		:
			if (bCharred)
			{	if (default.AltCharStumpMesh != None)
					NewStump.SetStaticMesh(default.AltStumpMesh);	}
			else if (default.AltStumpMesh != None)
				NewStump.SetStaticMesh(default.AltStumpMesh);
			NewStump.SetDrawScale(0.6);
			NewStump.SetDrawScale3D(vect(1.5,1.2,1.0));
			NewStump.Prepivot.X = 1.5;
			NewStump.Prepivot.Y = -1;
			break;
		case 'lfoot'		:
		case 'rfoot'		:
			NewStump.SetDrawScale(0.8);
			NewStump.Prepivot.X = 2.25;
			break;
		case 'lshoulder'	:
			NewStump.Prepivot.X = -3.5;
			NewStump.Prepivot.Y = 1;
			NewStump.Prepivot.Z = 3.5;
			break;
		case 'rshoulder'	:
			NewStump.Prepivot.X = -3.5;
			NewStump.Prepivot.Y = 1;
			NewStump.Prepivot.Z = -3.5;
			break;
	}
	if (Bone != 'pelvis')
		Victim.AttachToBone(NewStump, Bone);
	return NewStump;
}

// Return teh correct dismemberment effect for the input bone
static function class<Emitter> GetDismemberEffectFor (Pawn Victim, name Bone)
{
	switch (Bone)
	{
	case 'head'		: return default.HeadExplode;
	case 'spine'	: return default.TorsoExplode;
	case 'pelvis'	: return default.PelvisExplode;
	case 'lshoulder': return default.ShoulderExplodeLeft;
	case 'rshoulder': return default.ShoulderExplode;
	case 'lfarm'	: return default.ArmExplodeLeft;
	case 'rfarm'	: return default.ArmExplode;
	case 'righthand':
	case 'lhand'	:
	case 'rhand'	: return default.HandExplode;
	case 'lthigh'	:
	case 'rthigh'	: return default.LegExplode;
	case 'lfoot'	:
	case 'rfoot'	: return default.FootExplode;
	default			: return default.ArmExplode;
	}
}

//-----------------------------------------------------------------------

defaultproperties
{
}
