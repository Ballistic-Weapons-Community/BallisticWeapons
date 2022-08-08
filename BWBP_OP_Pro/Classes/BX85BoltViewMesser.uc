//=============================================================================
// BX85BoltViewMesser.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BX85BoltViewMesser extends Actor;

var PlayerController 	PC;
var Pawn OriginalPawn;
var float	FlashF;
var vector	FlashV;

replication
{
	unreliable if (Role == ROLE_Authority)
		AddImpulse;
}

simulated function PostNetBeginPlay()
{
	PC = level.GetLocalPlayerController();
	if (Owner != None && PlayerController(Owner) != None)
	{
		PC = PlayerController(Owner);
		OriginalPawn = PC.Pawn;
	}
	if (Role == ROLE_Authority && (PC == None || OriginalPawn == None))
		Destroy();
}

simulated function SetupTimer()
{
	LifeSpan=6.0;
	SetTimer(1.5,true);
}

simulated event Timer()
{
	if (PC == None || PC.Pawn == None || PC.Pawn != OriginalPawn || PC.Pawn.bDeleteMe || PC.Pawn.Health <= 0)
	{
		Destroy();
		return;
	}

	AddImpulse(1.0);
}

simulated function AddImpulse(float Amount)
{
	if (PC == None || PC.Pawn == None || PC.Pawn.bDeleteMe || PC.Pawn.Health <= 0)
	{
		Destroy();
		return;
	}

	if (xPawn(PC.Pawn) == None)
		return;

	PC.ClientFlash(FlashF+(1-Amount), FlashV);
	if (Amount > 0 )
		class'BC_MotionBlurActor'.static.DoMotionBlur(PC, 3.0 * Amount, 2 * Amount);
}

defaultproperties
{
     FlashF=-0.150000
     FlashV=(X=5.000000,Y=900.000000,Z=5.000000)
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=6.000000
}
