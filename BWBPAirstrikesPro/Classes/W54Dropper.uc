// Drops a bomb after a certain time
class W54Dropper extends Actor;

var class<Projectile> BombClass;
var float					 DropDelay;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Level.NetMode != NM_DedicatedServer)
	{
		Level.GetLocalPlayerController().PlayStatusAnnouncement('Incoming_air', 0, true);
	}
	
	SetTimer(DropDelay, false);
}

function Timer()
{
	Spawn(BombClass,,, Location - ((CollisionHeight + BombClass.default.CollisionHeight) * vect(0,0,2)), rotator(vect(0,0,-1)));
	Destroy();
}
	

defaultproperties
{
     BombClass=Class'BWBPAirstrikesPro.W54Projectile'
     DropDelay=4.000000
     bHidden=True
     bAlwaysRelevant=True
}
