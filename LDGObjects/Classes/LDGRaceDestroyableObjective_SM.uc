class LDGRaceDestroyableObjective_SM extends DestroyableObjective_SM
	placeable;

var(LDG) string VehicleTypeTag;
var(LDG) bool bAllowRespawnToBase;
var(LDG) bool bRenderObjective;

var(LDG) array< class<DamageType> > ResistantTo;
var(LDG) int MinDamage; 

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

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
						Vector momentum, class<DamageType> damageType)
{
	local int i;

	if ( !bActive || bDisabled || (Damage <= 0) || (MinDamage > Damage) || !UnrealMPGameInfo(Level.Game).CanDisableObjective( Self ) )
		return;
		
	for (i = 0; i < ResistantTo.Length; i++)
		if (ClassIsChildOf(damageType, ResistantTo[i]))
			return;

	if ( instigatedBy == None || instigatedBy.Controller == None || instigatedBy.Controller.PlayerReplicationInfo == None ||
		instigatedBy.Controller.PlayerReplicationInfo.Team == None || instigatedBy.Controller.PlayerReplicationInfo.Team.TeamIndex < 0 ||
		instigatedBy.Controller.PlayerReplicationInfo.Team.TeamIndex > 1)
		return;

	// Only a specific Pawn can deal damage to objective ?
	if ( !ClassIsChildOf(instigatedBy.Class, ConstraintPawnClass) )
		return;

	NetUpdateTime = Level.TimeSeconds - 1;
	AddScorer( InstigatedBy.Controller, 1.00 );
	DisableObjective( instigatedBy );
}

simulated function float GetObjectiveProgress()
{
	return 0;
}

defaultproperties
{
     bRenderObjective=True
     bReplicateHealth=False
     bMonitorUnderAttack=False
}
