class Misc_PawnReplicationInfo extends ReplicationInfo;

var vector Position;

var byte Health;
var byte Shield;

var bool bInvis;

var Pawn MyPawn;

replication
{
    unreliable if(bNetDirty && Role == ROLE_Authority)
        Position, Health, Shield, bInvis;
}

function SetMyPawn(Pawn P)
{
    if(P == None)
    {
        Health = 0;
		Shield = 0;
        Position = vect(0,0,0);
        bInvis = false;

        NetUpdateFrequency = default.NetUpdateFrequency * 0.1;
        NetPriority = default.NetPriority * 0.1;

        MyPawn = None;
        SetTimer(0.0, false);
    }
    else
    {
        MyPawn = P;

        Health = MyPawn.Health;
		if (xPawn(MyPawn) != None)
		{
			Shield = xPawn(MyPawn).ShieldStrength;
			bInvis = xPawn(MyPawn).bInvis;
		}
        Position = MyPawn.Location;


        NetUpdateFrequency = default.NetUpdateFrequency;
        NetPriority = default.NetPriority;

        NetUpdateTime = Level.TimeSeconds - 5;

        SetTimer(0.2, true);
    }
}

event Timer()
{
    if(MyPawn == None)
    {
        SetMyPawn(None);
        return;
    }

    Position = MyPawn.Location;
	Health = Min(255, MyPawn.Health);
	if (xPawn(MyPawn) != None)
	{
		Shield = Min(255, xPawn(MyPawn).ShieldStrength);
		bInvis = xPawn(MyPawn).bInvis;
	}
}

defaultproperties
{
     NetUpdateFrequency=3.000000
     NetPriority=0.500000
}
