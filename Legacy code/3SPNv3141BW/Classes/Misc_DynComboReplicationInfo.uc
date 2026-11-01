class Misc_DynComboReplicationInfo extends ReplicationInfo;

struct ComboInfo
{
    var byte Type;      // type of combo
    var float Time;     // time remaining for combo
};

var bool      bRunning;
var ComboInfo Combos[4];

replication
{
    unreliable if(bNetDirty && Role == ROLE_Authority)
        bRunning;

    unreliable if(bNetDirty && bRunning && Role == ROLE_Authority)
        Combos;
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(Level.NetMode != NM_DedicatedServer)
        SetTimer(0.5, true);
}

simulated function Timer()
{
    local int i;

    if(bRunning)
    {
        for(i = 0; i < ArrayCount(Combos); i++)
            if(Combos[i].Time > 0.0)
                Combos[i].Time -= 0.5;
    }
}

defaultproperties
{
     NetUpdateFrequency=2.000000
     NetPriority=0.500000
}
