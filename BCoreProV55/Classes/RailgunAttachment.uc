//=============================================================================
// RailgunAttachment.
//
// 3rd person weapon attachment for Railguns
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RailgunAttachment extends BallisticAttachment;

var vector		WallEntrys[4];	// Exit and Entry Effect positions
var vector		WallExits[4];

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		WallEntrys, WallExits;
}

simulated event ThirdPersonEffects()
{
	local int i;
    if ( Level.NetMode == NM_Client && Instigator != None)
	{
		for (i=0;i<4;i++)
		{
			if (WallEntrys[i] != vect(0,0,0))
				RailgunWallEnter(WallEntrys[i]);
			if (WallExits[i] != vect(0,0,0))
				RailgunWallExit(WallExits[i]);
		}
	}
	super.ThirdPersonEffects();
}
function UpdateWallEntrys (array<vector> EntryLocations)
{
	local int i;
	for (i=0;i<4;i++)
		if (i >= EntryLocations.length)
			WallEntrys[i] = vect(0,0,0);
		else
			WallEntrys[i] = EntryLocations[i];
}
function UpdateWallExits (array<vector> ExitLocations)
{
	local int i;
	for (i=0;i<4;i++)
		if (i >= ExitLocations.length)
			WallExits[i] = vect(0,0,0);
		else
			WallExits[i] = ExitLocations[i];
}

simulated function RailgunWallEnter (vector HitLocation, optional vector HitNormal, optional int HitSurf, optional vector X, optional actor other)
{
	local vector Start;
	local Material HitMat;
	if (level.NetMode == NM_Client)
	{
		Start = Instigator.Location + Instigator.EyePosition();
		X = Normal(HitLocation-Start);
		Other = Trace(HitLocation, HitNormal, HitLocation + X*10, HitLocation - X * 5, false, ,HitMat);
		if (Other == None)
			return;
		if (HitMat == None)HitSurf = int(Other.SurfaceType);
		else HitSurf = int(HitMat.SurfaceType);
	}
	if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, HitNormal, HitSurf, instigator);
}
simulated function RailgunWallExit (vector HitLocation, optional vector HitNormal, optional int HitSurf, optional vector X, optional actor other)
{
	local vector Start;
	local Material HitMat;
	if (level.NetMode == NM_Client)
	{
		Start = Instigator.Location + Instigator.EyePosition();
		X = Normal(HitLocation-Start);
		Other = Trace(HitLocation, HitNormal, HitLocation - X*10, HitLocation + X * 5, false, ,HitMat);
		if (Other == None)
			return;
		if (HitMat == None)HitSurf = int(Other.SurfaceType);
		else HitSurf = int(HitMat.SurfaceType);
	}
	if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, HitNormal, HitSurf, instigator);
}

defaultproperties
{
}
