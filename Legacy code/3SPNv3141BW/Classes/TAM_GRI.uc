class TAM_GRI extends Misc_BaseGRI;

var bool bChallengeMode;
var bool bDisableTeamCombos;
var bool bRandomPickups;

replication
{
    reliable if(bNetInitial && Role == ROLE_Authority)
        bDisableTeamCombos, bChallengeMode, bRandomPickups;
}

defaultproperties
{
}
