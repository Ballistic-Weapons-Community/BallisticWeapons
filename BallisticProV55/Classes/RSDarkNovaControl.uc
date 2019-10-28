//=============================================================================
// RSDarkNovaControl.
//
// An authority actor used to keep track of global nova/darkstar stuff.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkNovaControl extends Info;

var array<RSBlackHole>	BlackHoles;

function RSBlackHole GetNearestBlackHole(vector V, optional out float BestDist)
{
	local int i;
	local float Dist;
	local RSBlackHole Best;

	BestDist = 999999;
	for (i=0;i<BlackHoles.length;i++)
	{
		if (BlackHoles[i] == None)
			continue;
		Dist = VSize(BlackHoles[i].Location - V);
		if (Dist < BestDist && FastTrace(BlackHoles[i].Location, V))
		{
			Best = BlackHoles[i];
			BestDist = Dist;
		}
	}
	return Best;
}

function AddBlackHole(RSBlackHole BH)
{
	local int i;
	for (i=0;i<BlackHoles.length;i++)
		if (BlackHoles[i] == None)
		{
			BlackHoles[i] = BH;
			return;
		}
	BlackHoles[BlackHoles.length] = BH;
}

defaultproperties
{
}
