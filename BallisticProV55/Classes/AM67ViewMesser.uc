//=============================================================================
// AM67ViewMesser.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67ViewMesser extends Actor;

var PlayerController 	PC;
var float	FlashF;
var vector	FlashV;
var float	AltFlashF;
var vector	AltFlashV;

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

simulated function AddImpulse(float Amount)
{
	if (PC == None || xPawn(PC.Pawn) == None)
		return;
	if (class'BallisticDamageType'.default.bLessDisruptiveFlash)
		PC.ClientFlash(AltFlashF+(1-Amount), AltFlashV);
	else
		PC.ClientFlash(FlashF+(1-Amount), FlashV);
	if (Amount > 0 )
		class'BC_MotionBlurActor'.static.DoMotionBlur(PC, 5.0 * Amount, 10 * Amount);
}

defaultproperties
{
     FlashF=-1.200000
     FlashV=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     AltFlashF=-1.800000
     AltFlashV=(X=500.000000,Y=500.000000,Z=500.000000)
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=15.000000
}
