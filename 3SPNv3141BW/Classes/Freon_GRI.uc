class Freon_GRI extends TAM_GRI;

var float AutoThawTime;
var float ThawSpeed;
var bool  bTeamHeal;

replication
{
    reliable if(bNetInitial && Role == ROLE_Authority)
        AutoThawTime, ThawSpeed, bTeamHeal;
}

defaultproperties
{
}
