//=============================================================================
// XMK5DartViewMesser.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class X4KnifeViewMesser extends Actor;

var PlayerController 	PC;
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
		PC = PlayerController(Owner);
	if (Role == ROLE_Authority && PC == None)
		Destroy();
}

simulated function SetupTimer()
{
	LifeSpan=4.0;
	SetTimer(1,true);
}

simulated event Timer()
{
	if (PC == None || PC.Pawn == None || PC.Pawn.bDeleteMe || PC.Pawn.Health <= 0)
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

	if (PC == None || xPawn(PC.Pawn) == None)
		return;

	PC.ClientFlash(FlashF+(1-Amount), FlashV);
	if (Amount > 0 )
		class'BC_MotionBlurActor'.static.DoMotionBlur(PC, 2.5 * Amount, 1 * Amount);
}

defaultproperties
{
     FlashF=0.300000
     FlashV=(Y=2000.000000)
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=4.000000
}
