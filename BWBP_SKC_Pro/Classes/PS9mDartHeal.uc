//=============================================================================
// PS9mDartHeal
//
// Actor attached to players to gradually heal
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class PS9mDartHeal extends Actor
	placeable;

var     Actor				Victim;			        // The poor guy being poisoned
var()   class<DamageType>	DamageType;		        // DamageType done to player
var()   int				    HealValue;		        // Damage done every 0.5 seconds
var()   int				    TickCount;		        // Number of ticks
var     Controller	        InstigatorController;

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
	if(TickCount == -2)
		return;

    if (Victim != None && Level.NetMode != NM_Client && TickCount > 0)
	{
		if(Instigator == None || Instigator.Controller == None)
			Victim.SetDelayedDamageInstigatorController( InstigatorController );
		if(BallisticPawn(Victim) != None)
			BallisticPawn(Victim).GiveAttributedHealth(HealValue, Pawn(Victim).HealthMax, Instigator);
		else Pawn(Victim).GiveHealth(HealValue, Pawn(Victim).HealthMax);
	}

	--TickCount;

	if(TickCount <= 0)
		Destroy();
}

simulated event Tick(float DT)
{
	Super.Tick(DT);

	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (Pawn(Victim) != None && Pawn(Victim).Health <= 0)
		Destroy();
	if (level.NetMode == NM_DedicatedServer && TickCount <= 0)
		Destroy();
	if (TickCount == -2)
		return;
	else if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		SetBase(None);
		Destroy();
	}
}

defaultproperties
{
     DamageType=Class'BWBP_SKC_Pro.DT_PS9mMedDart'
     HealValue=8
     TickCount=5
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     bHardAttach=True
}
