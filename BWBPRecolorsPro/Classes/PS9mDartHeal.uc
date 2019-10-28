//=============================================================================
// PS9mDartHeal
//
// Actor attached to players to gradually heal
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class PS9mDartHeal extends Actor
	placeable;

var   Actor				Victim;			// The poor guy being poisoned
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done every 0.5 seconds
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
	SetTimer(1.0, true);

	SetBase(Victim);
}

event Timer()
{
	if(PoisonTime == -2)
		return;

	PoisonTime-=1.0;

	if(PoisonTime <= 0)
		Destroy();

	if (Victim != None && Level.NetMode != NM_Client && PoisonTime > 0)
	{
		if(Instigator == None || Instigator.Controller == None)
			Victim.SetDelayedDamageInstigatorController( InstigatorController );
		if(BallisticPawn(Victim) != None)
			BallisticPawn(Victim).GiveAttributedHealth(Damage, Pawn(Victim).HealthMax, Instigator);
		else Pawn(Victim).GiveHealth(Damage, Pawn(Victim).HealthMax);
	}
}

simulated event Tick(float DT)
{
	Super.Tick(DT);

	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (Pawn(Victim) != None && Pawn(Victim).Health <= 0)
		Destroy();
	if (level.netMode == NM_DedicatedServer && PoisonTime <= 0)
		Destroy();
	if (PoisonTime == -2)
		return;
	else if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		SetBase(None);
		Destroy();
	}
}

defaultproperties
{
     DamageType=Class'BWBPRecolorsPro.DT_PS9mMedDart'
     Damage=25
     PoisonTime=5.000000
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     bHardAttach=True
}
