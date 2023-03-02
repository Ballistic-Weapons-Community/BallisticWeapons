class WrenchgunBleed extends Actor
	placeable;

var   Actor				Victim;			// The poor guy being poisoned
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done every 0.5 seconds
var() float				BleedTime, MaxBleedTime;		// How long does it last

const BleedInterval = 1.5f;
var Controller			InstigatorController;

function Reset()
{
	Destroy();
}

function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(BleedInterval, true);

	SetBase(Victim);
}

event Timer()
{
	if(BleedTime == -1)
		return;

	BleedTime-= BleedInterval;

	if(BleedTime < BleedInterval)
		Destroy();

	if (Victim != None && Level.NetMode != NM_Client && BleedTime >= BleedInterval)
	{
		if(Instigator == None || Instigator.Controller == None)
			Victim.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt(Victim, Damage, Instigator, Location, vect(0,0,0), DamageType);
	}
}

function AddTime(float TimeToAdd)
{
	BleedTime = Min(MaxBleedTime, BleedTime + TimeToAdd);
}

simulated event Tick(float DT)
{
	Super.Tick(DT);

	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (Pawn(Victim) != None && Pawn(Victim).Health <= 0)
		Destroy();
	if (level.netMode == NM_DedicatedServer && BleedTime <= BleedInterval)
		Destroy();
	if (BleedTime == -1)
		return;
	else if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		SetBase(None);
		Destroy();
	}
}

defaultproperties
{
     DamageType=Class'BWBP_APC_Pro.DTWrenchgunBleed'
     Damage=3
     BleedTime=4.000000
     MaxBleedTime=15.000000
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     bHardAttach=True
}
