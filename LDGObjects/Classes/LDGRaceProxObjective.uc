//=============================================================================
// RaceProxObjective.
//=============================================================================
class LDGRaceProxObjective extends ProximityObjective
	placeable;

var(LDG) string VehicleTypeTag;
var(LDG) bool bAllowRespawnToBase;
var(LDG) bool bRenderObjective;

function PreBeginPlay()
{
	local int i;
	
	Super.PreBeginPlay();
	
	if (VehicleTypeTag == "")
		return;
	
	for (i = 0; i < class'VehicleTags'.default.VTags.Length; i++)
	{
		if (class'VehicleTags'.default.VTags[i].TypeTag ~= VehicleTypeTag)
		{
			ConstraintPawnClass = class<Pawn>(DynamicLoadObject(class'VehicleTags'.default.VTags[i].TypeClass, class'Class'));
			return;
		}
	}
}

function bool IsRelevant( Pawn P, bool bAliveCheck )
{
	if ( !IsActive() || !UnrealMPGameInfo(Level.Game).CanDisableObjective( Self ) )
		return false;

	if ( !ClassIsChildOf(P.Class, ConstraintPawnClass) )
		return false;

	Instigator = FindInstigator( P );
	if ( (Instigator.GetTeam() == None) )
		return false;

	if ( bAliveCheck )
	{
		if ( Instigator.Health < 1 || Instigator.bDeleteMe || !Instigator.IsPlayerPawn() )
			return false;
	}

	if ( bBotOnlyObjective && (PlayerController(Instigator.Controller) != None) )
		return false;

	return true;
}

function SetCriticalStatus( bool bNewCriticalStatus ); //pointless in RACE

defaultproperties
{
     bAllowRespawnToBase=True
     bRenderObjective=True
}
