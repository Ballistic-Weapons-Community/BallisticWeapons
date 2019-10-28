class UTComp_SRI_BW_FR_LDG extends ReplicationInfo;

var float ThawPointsConversionRatio;
var string MatchStart;

replication
{
	reliable if(Role == ROLE_Authority && bNetInitial)
		ThawPointsConversionRatio;
}

defaultproperties
{
}
