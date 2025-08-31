class SHADRACHPlagueTrigger extends Trigger;

var byte Team;
var	Pawn						PawnOwner;
var   Controller				InstigatorController;
var SHADRACHPlagueEffect 	PlagueEffect;

function PostBeginPlay()
{
    Super.PostBeginPlay();

    PawnOwner = Pawn(Owner);
    
    if(PawnOwner == None)
    {
        Destroy();
        return;
    }

    Team = PawnOwner.GetTeamNum();

    SetBase(PawnOwner);
	
	SetTimer(0.35, false);
}

function Timer()
{
	local xPawn P;
	
	foreach CollidingActors(class'xPawn', P, CollisionRadius, Location)
	{
		if(P == Owner || P.Health < 1 || Level.TimeSeconds - P.SpawnTime < DeathMatch(Level.Game).SpawnProtectionTime)
			continue;
		TryPlague(P);
	}
}

function TryPlague(xPawn P)
{
	local byte InTeam;
	local SHADRACHPlagueEffect SPE;
		
	if (P.Controller != None)
	{
		InTeam = P.Controller.GetTeamNum();
		if (InTeam != 255 && InTeam != Team)
			return;
	}
	
	foreach P.BasedActors(class'SHADRACHPlagueEffect', SPE)
		break;

	if (SPE == None)
	{
		SPE = Spawn(class'SHADRACHPlagueEffect',P,,P.Location);// + vect(0,0,-30));
		SPE.Initialize(P);
		SPE.Duration = PlagueEffect.Duration;
		if (Instigator!=None)
		{
			SPE.Instigator = Instigator;
			SPE.InstigatorController = Instigator.Controller;
		}
	}
}

function Touch(Actor Other)
{
    if(Other == Owner || xPawn(Other) == None || xPawn(Other).Health < 1)
        return;
	
	TryPlague(xPawn(Other));
}

defaultproperties
{
     bHardAttach=True
     CollisionRadius=150.000000
     CollisionHeight=80.000000
}
