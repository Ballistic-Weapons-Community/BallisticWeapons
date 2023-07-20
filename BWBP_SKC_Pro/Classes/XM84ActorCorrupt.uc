//=============================================================================
// VSKActorPoison.
//
// Fire attached to players. This is spawned on server to do damage and on
// client for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM84ActorCorrupt extends BallisticEmitter
	placeable;

var   Actor				Victim;							// The guy on fire
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;						// Damage done every 0.25 seconds
var() float				BurnTime;						// How to burn for
var Controller	InstigatorController;

const FlashInterval = 2.0;
const FlashDelay = 2;

function Reset()
{
	Destroy();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(FlashDelay, true);

	SetLocation(Victim.Location - vect(0, 0, 1)*Victim.CollisionHeight);
	SetRotation(Victim.Rotation + rot(0, -16384, 0));
	SetBase(Victim);
}

simulated event Timer()
{
	if (BurnTime == -1)
		return;
	BurnTime-= FlashInterval;
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
	
	SetTimer(FlashInterval, False);
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
     DamageType=Class'BWBP_SKC_Pro.DTXM84AfterShock'
     Damage=5
     BurnTime=10.000000
     AutoDestroy=True
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
}
