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

var     Pawn				Victim;			        // The guy on fire
var()   class<DamageType>	DamageType;		        // DamageType done to player
var()   int				    Damage;			        // Damage done every 1.5 seconds
var()   int				    Duration;		        // How to burn for
var     Controller	        InstigatorController;
var     float               Pwr;

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
	Victim.GiveHealth(5 * Pwr, Instigator.HealthMax);
}

simulated event Timer()
{
	if (Victim != None && Level.NetMode != NM_Client)
	{
		if (Instigator.bProjTarget)
			Victim.GiveHealth(5 * Pwr, Instigator.HealthMax);
	}

	--Duration;
    
	if (Duration == 0)
    {
        SetTimer(0.0, false);
		Kill();
    }
}

simulated event Tick(float DT)
{
	Super.Tick(DT);

	if (Victim == None || Victim.bDeleteMe)
		Destroy();

	if (level.NetMode == NM_DedicatedServer && Duration <= 1)
		Destroy();

	if (Duration == 0)
		return;

	if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		SetBase(None);
		Kill();
		Duration = 0;
	}
}

defaultproperties
{
     Duration=8
     AutoDestroy=True
     bDynamicLight=True
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     bNotOnDedServer=False
}
