class UTComp_SRI extends ReplicationInfo;

var byte EnableBrightSkinsMode;
var bool bEnableClanSkins;
var bool bEnableTeamOverlay;
var byte EnableHitSoundsMode;
var bool bEnableScoreboard;
var bool bEnableDoubleDamage;

var string NormalScoreBoardType;
var string EnhancedScoreBoardType;

replication
{
	reliable if(Role == ROLE_Authority && bNetInitial)
	  EnableBrightSkinsMode, bEnableClanSkins, bEnableTeamOverlay,
	  EnableHitSoundsMode, bEnableScoreboard, bEnableDoubleDamage,
	  NormalScoreBoardType, EnhancedScoreBoardType;
}

defaultproperties
{
}
