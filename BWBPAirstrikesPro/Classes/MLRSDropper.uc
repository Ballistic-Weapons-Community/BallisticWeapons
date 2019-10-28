// Drops a bomb after a certain time
class MLRSDropper extends Actor;

var class<Projectile> BombClass;
var float					 DropDelay;
var int						BombsLeft;
var int						DispersionRadius;

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
	GoToState('Bombard');
}

state Bombard
{
	function Timer()
	{
		local Vector Displacement;
		
		Displacement.X = (Rand(DispersionRadius * 2) - DispersionRadius) * Sqrt(FRand());
		Displacement.Y = (Rand(DispersionRadius * 2) - DispersionRadius) * Sqrt(FRand());
		Spawn(BombClass,,, Location + Displacement - ((CollisionHeight + BombClass.default.CollisionHeight) * vect(0,0,2)), rotator(vect(0,0,-1)));
		BombsLeft--;
		if (BombsLeft < 1)
			Destroy();
	}
	
	Begin:
		SetTimer(0.75, true);

}
	

defaultproperties
{
     BombClass=Class'BWBPAirstrikesPro.MLRSProjectile'
     DropDelay=6.000000
     BombsLeft=12
     DispersionRadius=3072
     bHidden=True
     bAlwaysRelevant=True
}
