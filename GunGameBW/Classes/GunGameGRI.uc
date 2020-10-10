class GunGameGRI extends GameReplicationInfo;

//These variables define how the Scoreboard will be drawn
var byte VictoryCondition;
var byte HighestLevel;

replication
{
    reliable if( Role == ROLE_Authority && bNetInitial )
        VictoryCondition, HighestLevel;
}

defaultproperties
{
}
