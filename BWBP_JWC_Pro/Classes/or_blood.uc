//=============================================================================
// VSKActorPoison.
//
// Fire attached to players. This is spawned on server to do damage and on
// client for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class or_blood extends BallisticEmitter
	placeable;

var   Actor				Victim;			// The guy on fire
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done every 0.5 seconds
var() int				HealValue;			// This is basically the same as Damage, only used if its to heal someone instead.
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
	local Pawn HealTarget; // Need to convert Victim to a pawn variable, probably not doing this well, but it works.
	
	HealTarget = Pawn(Victim); // Here we set Victim up as HealTarget.
	
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
			
		if(IsValidHealTarget(HealTarget))										// Added this here to heal if they are friendlies.
			Pawn(Victim).GiveHealth(Damage, Pawn(Victim).HealthMax);			// Note that HealValue is called, this allows it to heal whatever you set HealValue to be
																// You can replace HealValue with Damage to have it heal the same amount as it would otherwise hurt.
		else														// If they are not friendly, do this instead- normal damage rules.
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

function bool IsValidHealTarget(Pawn Target)
{
	if(Target==None||Target==Instigator)
		return False;

	if(Target.Health<=0)
		return False;

	if(!Level.Game.bTeamGame)
		return False;

	if(Vehicle(Target)!=None)
		return False;

	return (Target.Controller!=None&&Instigator.Controller.SameTeamAs(Target.Controller));
}

defaultproperties
{
     DamageType=Class'BWBP_JWC_Pro.DTorblood'
     Damage=4
     HealValue=5
     BurnTime=6.000000
     AutoDestroy=True
     bNoDelete=False
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
}
