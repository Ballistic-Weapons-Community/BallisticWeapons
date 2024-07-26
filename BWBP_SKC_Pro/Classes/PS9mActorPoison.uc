//=============================================================================
// PS9mActorPoison.
//
// Tox effect attached to players. This is spawned on server to do damage 
// and on client for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PS9mActorPoison extends BallisticEmitter
	placeable;

var   Actor				Victim;			// The guy on fire
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done every 0.5 seconds
var() float				BurnTime;		// How to burn for
var Controller	InstigatorController;

function Reset()
{
	Destroy();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(1, true);

	SetLocation(Victim.Location - vect(0, 0, 1)*Victim.CollisionHeight);
	SetRotation(Victim.Rotation + rot(0, -16384, 0));
	SetBase(Victim);
}

simulated event Timer()
{
	if (BurnTime == -1)
		return;
	BurnTime-=0.5;
	if (BurnTime <= 2)
	{
		BurnTime=-1;
		Kill();
	}
	if (Victim != None && Level.NetMode != NM_Client && BurnTime > 1)
	{
		if ( Instigator == None || Instigator.Controller == None )
			Victim.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (Victim, Damage, Instigator, Location, vect(0,0,0), DamageType);
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
     DamageType=Class'BWBP_SKC_Pro.DT_PS9mTranqPsn'
     Damage=5
     BurnTime=2.500000
     AutoDestroy=True
     bNoDelete=False
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
}
