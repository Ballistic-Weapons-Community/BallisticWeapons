//=============================================================================
// BloodSet_DefaultFemale.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodSet_DefaultFemale extends BloodSetDefault;

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
			NewStump.SetDrawScale(1.75);
			NewStump.SetDrawScale3D(vect(1.225,0.625,1.0));
			NewStump.Prepivot.X = 1.75;
			NewStump.Prepivot.Y = 1.0;
			NewStump.Prepivot.Z = 0.5;
			break;
		case 'pelvis'	:
			Victim.AttachToBone(NewStump, 'spine');
			NewStump.SetRelativeRotation(rot(32768,0,0));
			NewStump.SetDrawScale(1.75);
			NewStump.SetDrawScale3D(vect(1.0,0.625,1.0));
			NewStump.Prepivot.X = 1.75;
			NewStump.Prepivot.Y = 1;
			break;
		case 'lthigh'		:
		case 'rthigh'		:
			NewStump.SetDrawScale(0.8);
			NewStump.SetDrawScale3D(vect(1.3,1.0,1.0));
			NewStump.Prepivot.X = 7.0;
			NewStump.Prepivot.Y = -1.0;
			NewStump.Prepivot.Z = 0.5;
			break;
		case 'lfarm'		:
		case 'rfarm'		:
			if (bCharred)
			{	if (default.AltCharStumpMesh != None)
					NewStump.SetStaticMesh(default.AltStumpMesh);	}
			else if (default.AltStumpMesh != None)
				NewStump.SetStaticMesh(default.AltStumpMesh);
			NewStump.SetDrawScale(0.5);
			NewStump.SetDrawScale3D(vect(1.25,1.0,1.0));
			NewStump.Prepivot.X = 1.0;
			NewStump.Prepivot.Y = 1.0;
			break;
		case 'lfoot'		:
		case 'rfoot'		:
			NewStump.SetDrawScale3D(vect(1.3,1.0,1.0));
			NewStump.SetDrawScale(0.875);
			NewStump.Prepivot.X = 1.0;
			break;
		case 'lshoulder'	:
			NewStump.SetDrawScale3D(vect(1.4,1.0,1.0));
			NewStump.Prepivot.X = -2.0;
			NewStump.Prepivot.Y = 1;
			NewStump.Prepivot.Z = 3.0;
			break;
		case 'rshoulder'	:
			NewStump.SetDrawScale3D(vect(1.4,1.0,1.0));
			NewStump.Prepivot.X = -2.0;
			NewStump.Prepivot.Y = 1;
			NewStump.Prepivot.Z = -3.0;
			break;
	}
	if (Bone != 'pelvis')
		Victim.AttachToBone(NewStump, Bone);
	return NewStump;
}

defaultproperties
{
}
