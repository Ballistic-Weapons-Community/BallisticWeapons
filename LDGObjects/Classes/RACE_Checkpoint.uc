class RACE_Checkpoint extends Volume;

var(RaceCheckpoint) Name EnabledOnObjectiveTag, DisabledOnObjectiveTag;
var(RaceCheckpoint) byte	  Position;
var(RaceCheckpoint) edfindable Actor ResetActor;
var bool bForceDisabled;

enum EActiveStatus
{
	AS_Reject, 		//Resets all actors touching it.
	AS_Check, 			//Checks order.
	AS_Disabled, 		//Does nothing.
};

var(RaceCheckpoint) EActiveStatus 	ActiveState;

delegate NotifyTouched(Pawn P, RACE_Checkpoint RC);

function Touch(Actor Other)
{
	local Pawn P;

	Super.Touch(Other);
	
	P = Pawn(Other);
	
	if (bForceDisabled)
		return;
	
	if (ActiveState == AS_Disabled || P == None || P.Health < 1 || P.bCanFly || (Vehicle(P) != None && (Vehicle(P).bCanHover || Vehicle(P).bCanFly)) || RedeemerWarhead(P) != None)
		return;
		
	NotifyTouched(P, self);
}

function DisableCP()
{
	ActiveState = AS_Disabled;
}

function EnableCP()
{
	ActiveState = AS_Check;
}

defaultproperties
{
}
