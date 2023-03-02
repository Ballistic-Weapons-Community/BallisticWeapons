//=============================================================================
// MRS138ViewMesser.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class syr_view extends Actor;

// Deriving this from XMK5 view messer rather than MRS138 since it calls for things in the Damage Type otherwise not present.

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
	LifeSpan=5;
	SetTimer(1.5,true);
}

simulated event Timer()
{
	if (PC == None || OriginalPawn == None || PC.Pawn.bDeleteMe || PC.Pawn.Health <= 0)
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
		class'BC_MotionBlurActor'.static.DoMotionBlur(PC, 5.0 * Amount, 2 * Amount);
}

defaultproperties
{
     FlashF=-0.150000
     FlashV=(X=825.000000,Y=900.000000,Z=825.000000)
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=5.000000
}
