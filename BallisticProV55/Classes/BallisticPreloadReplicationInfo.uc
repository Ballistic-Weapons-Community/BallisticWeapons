class BallisticPreloadReplicationInfo extends ReplicationInfo;

var() string CurrentName[255];
var() string MeshList[255];
var() int PreloadNum;

replication
{
    reliable if(Role == ROLE_Authority)
        CurrentName, PreloadNum;
   	reliable if(Role == ROLE_Authority)
   		MeshList;
}

defaultproperties
{
}
