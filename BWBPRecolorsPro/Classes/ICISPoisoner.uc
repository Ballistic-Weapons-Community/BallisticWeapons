//=============================================================================
// ICISPoisoner.
//
// A short lasting radiation poison. Does 20 damage every 5 seconds. 80 dmg in total
// 15 seconds before effects set in. 20 seconds of damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISPoisoner extends BallisticEmitter
	placeable;

var   Pawn				Victim;			// The guy on fire
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done every 1.5 seconds
var() float				BurnTime;		// How to burn for
var Controller	InstigatorController;

function Reset()
{
	Destroy();
}

simulated function Initialize(Pawn V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(1, true);
	SetLocation(Victim.Location - vect(0, 0, 1)*Victim.CollisionHeight);
	SetRotation(Victim.Rotation + rot(0, -16384, 0));
	SetBase(Victim);
	Victim.GiveHealth(10, Instigator.SuperHealthMax);
}

simulated event Timer()
{
	if (BurnTime == -1)
		return;
	BurnTime-=1;
	if (BurnTime <= 1)
	{
		BurnTime=-1;
		Kill();
	}
	if (Victim != None && Level.NetMode != NM_Client)
	{
		if (Instigator.bProjTarget)
			Victim.GiveHealth(10, Instigator.SuperHealthMax);
	}
}

simulated event Tick(float DT)
{
	Super.Tick(DT);
	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (level.netMode == NM_DedicatedServer && BurnTime <= 1)
		Destroy();
	if (BurnTime == -1)
		return;
	else if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		SetBase(None);
		Kill();
		BurnTime=-1;
	}
}

defaultproperties
{
     BurnTime=9.000000
     AutoDestroy=True
     bDynamicLight=True
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     bNotOnDedServer=False
}
