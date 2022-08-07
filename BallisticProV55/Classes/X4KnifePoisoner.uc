//=============================================================================
// XMK5DartPoisoner.
//
// Actor attached to players to cause gradual poison damage.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class X4KnifePoisoner extends Actor
	placeable;

var   Actor				Victim;			// The poor guy being poisoned
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done
var() float				PoisonRate;		// How often to do damage
var() float				PoisonTime;		// How long does it last
var Controller	InstigatorController;

function Reset()
{
	Destroy();
}

function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(PoisonRate, true);

	SetBase(Victim);
}

event Timer()
{
	if(PoisonTime == -1)
		return;

	PoisonTime-=PoisonRate;

	if(PoisonTime <= 1)
		Destroy();

	if (Victim != None && Level.NetMode != NM_Client && PoisonTime > 1)
	{
		if(Instigator == None || Instigator.Controller == None)
			Victim.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt(Victim, Max(1,Damage * (PoisonTime/Default.PoisonTime)), Instigator, Location, vect(0,0,0), DamageType);
	}
}

simulated event Tick(float DT)
{
	Super.Tick(DT);

	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (Pawn(Victim) != None && Pawn(Victim).Health <= 0)
		Destroy();
	if (level.netMode == NM_DedicatedServer && PoisonTime <= 1)
		Destroy();
	if (PoisonTime == -1)
		return;
	else if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		SetBase(None);
		Destroy();
	}
}

defaultproperties
{
     DamageType=class'BallisticProV55.DTX4KnifePoison'
     Damage=4.000000
     PoisonRate=0.250000
     PoisonTime=5.000000
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     bHardAttach=True
}
