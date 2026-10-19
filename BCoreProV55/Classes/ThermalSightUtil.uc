//=============================================================================
// ThermalSightUtil.
//
// What the weapons whose thermal sight shows players through walls have in common: drawing a player in the sight's
// colour, which players such a sight shows, and the server's part in getting those players to the holder's machine.
//=============================================================================
class ThermalSightUtil extends Object;

// what DrawPawn changes on a thing fixed to the pawn, to be put back afterwards
struct AttachedLook
{
	var array<Material>		Skins;
	var Actor.EDrawType		DrawType;
};

// P drawn over everything in the sight's material M: all its own materials, and those of the pawns and vehicle weapons
// fixed to it (a driver, a turret), are swapped for M and it is drawn unlit; anything else fixed to it (its weapon,
// effects) is hidden. All of it is put back as it was: every skin and how many there were, unlit and draw type.
static final function DrawPawn(Canvas C, Pawn P, Material M)
{
	local array<Material> Skins;
	local array<AttachedLook> Saved;
	local bool bWasUnlit;
	local Actor A;
	local int i, j;

	Skins = P.Skins;
	bWasUnlit = P.bUnlit;
	for (i = 0; i < Max(2, Skins.Length); i++)
		P.Skins[i] = M;
	P.bUnlit = true;

	Saved.Length = P.Attached.Length;
	for (i = 0; i < Saved.Length; i++)
	{
		A = P.Attached[i];
		if (A == None)
			continue;
		Saved[i].Skins = A.Skins;
		Saved[i].DrawType = A.DrawType;
		if (Pawn(A) != None || A.IsA('ONSWeapon'))
		{
			for (j = 0; j < Max(2, A.Skins.Length); j++)
				A.Skins[j] = M;
		}
		else if (A.DrawType != DT_None)
			A.SetDrawType(DT_None);
	}

	C.DrawActor(P, false, true);

	P.Skins = Skins;
	P.bUnlit = bWasUnlit;
	for (i = 0; i < Saved.Length && i < P.Attached.Length; i++)
	{
		A = P.Attached[i];
		if (A == None)
			continue;
		A.Skins = Saved[i].Skins;
		if (A.DrawType != Saved[i].DrawType)
			A.SetDrawType(Saved[i].DrawType);
	}
}

// Anyone not on the holder's team; pawns of no team (vehicles, turrets, bodies) count
static final function bool IsEnemy(Pawn Holder, Pawn P)
{
	if (P == None || P == Holder || P.bDeleteMe)
		return false;
	if (P.PlayerReplicationInfo == None || P.PlayerReplicationInfo.Team == None)
		return true;
	return Holder.PlayerReplicationInfo == None || Holder.PlayerReplicationInfo.Team == None
		|| P.PlayerReplicationInfo.Team.TeamIndex != Holder.PlayerReplicationInfo.Team.TeamIndex;
}

// How far through walls a sight of range Range shows P: up to 2000 further while P moves at a run
static final function float RangeFor(Pawn P, float Range)
{
	return Range + 2000 * FMin(1, VSize(P.Velocity) / 450);
}

// How closely a player behind a wall must be aimed at to show: the dot product of the aim and the way from the eye to
// the player must be above this. About ten degrees close by, closing to none at the end of the range.
static final function float FocusDot(float Dist, float Range)
{
	return 0.984 + 0.016 * (Dist / Range);
}

// Server, for a holder on another machine: the engine only sends that machine the players its eye can see, so a player
// behind a wall never got to the sight. These are the players the sight could show there, with room to spare for the time
// the holder's aim takes to reach the server: ten percent more range and some degrees more cone.
static final function bool WantedThroughWalls(Pawn Holder, Pawn P, float Range)
{
	local float Dist;

	if (P.Health <= 0 || P.bTearOff)
		return false;
	Range = RangeFor(P, Range) * 1.1;
	Dist = VSize(P.Location - Holder.Location);
	if (Dist > Range)
		return false;
	return Normal(P.Location - (Holder.Location + Holder.EyePosition())) Dot vector(Holder.GetViewRotation()) > FocusDot(Dist, Range) - 0.008;
}

// Server: the pawns in Wanted are made relevant (to every machine: the engine has no way to send an actor to only one),
// those this sight made so and no longer wants are let go. Marked holds the ones this sight made relevant; a pawn relevant
// for another reason (or by another sight) is left alone.
static final function SetRelevant(out array<Pawn> Marked, array<Pawn> Wanted, float TimeSeconds)
{
	local int i, j;

	for (i = Marked.Length - 1; i >= 0; i--)
	{
		if (Marked[i] != None)
		{
			for (j = 0; j < Wanted.Length; j++)
				if (Wanted[j] == Marked[i])
					break;
			if (j < Wanted.Length)
				continue;
			Marked[i].bAlwaysRelevant = false;
		}
		Marked.Remove(i, 1);
	}

	for (j = 0; j < Wanted.Length; j++)
		if (Wanted[j] != None && !Wanted[j].bAlwaysRelevant)
		{
			Wanted[j].bAlwaysRelevant = true;
			// sent at once
			Wanted[j].NetUpdateTime = TimeSeconds - 1;
			Marked[Marked.Length] = Wanted[j];
		}
}

// Server: every pawn this sight made relevant is let go
static final function ClearRelevant(out array<Pawn> Marked)
{
	local int i;

	for (i = 0; i < Marked.Length; i++)
		if (Marked[i] != None)
			Marked[i].bAlwaysRelevant = false;
	Marked.Length = 0;
}
