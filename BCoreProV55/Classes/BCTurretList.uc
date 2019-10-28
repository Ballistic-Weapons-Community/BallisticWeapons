//=============================================================================
// BCTurretList.
//
// This actor is spawned to link and list BWTurrets so they can be controlled
// and monitored as a group. This actor should be linked to by all new turrets
// so turret count limits can be implemented.
//
// InitTurretList():   static find BCTurretList actor or makes new one
// AutoInitTurret():   static initializes new turret by doing InitTurretList(), AddTurret() and CheckTurretLimit()
// CheckTurretLimit(): Check if there are more turrets than allowed and remove and old one if needed
// AddTurret():		   Add new turret to list
// RemoveTurret():	   Remove turret from list
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BCTurretList extends Info config(BallisticProV55);

var   array<BallisticTurret>	Turrets;		// List of turrets
var() globalconfig int			MaxTurrets;		// Max turrets allowed before old one start getting culled

// Find current BCTurretList or make one if needed
static function BCTurretList InitTurretList (actor A)
{
	local BCTurretList TL;

	if (A != None)
		foreach A.DynamicActors (class'BCTurretList', TL)
			return TL;
	TL = A.Spawn(class'BCTurretList');
	return TL;
}
// Quick easy way to initialize a new turret, get it listed and init the list itself if needed
static function bool AutoInitTurret (BallisticTurret T)
{
	if (T == None)
		return false;
	T.TurretList = InitTurretList(T.level);
	if (T.TurretList == None)
		return false;
	T.TurretList.AddTurret(T);
	T.TurretList.CheckTurretLimit();
	return true;
}

// Check how many turrets there are. If there are more than the limit, get rid of the one that has been unused for the longest
function CheckTurretLimit()
{
	local int i, j;
	local BallisticTurret T, Oldest;

	for (i=0;i<Turrets.length;i++)
	{
		if (Turrets[i] == None)
		{
			Turrets.remove(i, 1);
			i--;
			continue;
		}
		T = Turrets[i];
		if (!T.bIgnoreTurretLimit)
		{
			if (T.Controller==None && (Oldest == None || T.LastUsedTime < Oldest.LastUsedTime))
				Oldest = T;
			j++;
		}
	}
	if (j > default.MaxTurrets && Oldest!=None)
		Oldest.Retire();
}
// Add turret on to end of list
function AddTurret(BallisticTurret T)
{
	Turrets[Turrets.length] = T;
}
// Remove turret from list
function bool RemoveTurret(BallisticTurret T)
{
	local int i;
	if (T == None)
		return false;
	for (i=0;i<Turrets.length;i++)
		if (Turrets[i] == T)
		{
			Turrets.Remove(i, 1);
			return true;
		}
	return false;
}

defaultproperties
{
     MaxTurrets=16
}
