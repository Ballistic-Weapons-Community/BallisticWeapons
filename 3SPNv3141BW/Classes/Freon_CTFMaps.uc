class Freon_CTFMaps extends Freon;

var xRedFlagBase RFB;
var xBlueFlagBase BFB;
var float FlagSepDist;
var config float MaxDistFactor;

// rate whether player should spawn at the chosen navigationPoint or not
function float RatePlayerStart(NavigationPoint N, byte Team, Controller Player)
{
	local NavigationPoint P;
    local float Score, NextDist;
    local Controller OtherPlayer;

    P = N;

    if ((P == None) || P.PhysicsVolume.bWaterVolume || Player == None)
        return -10000000;
        
    if (FlagSepDist > 0)
    {
	    if (Player.GetTeamNum() == 0 && VSize(P.Location - RFB.Location) > FlagSepDist * MaxDistFactor)
	    		return -10000000;
	    		
	    if (Player.GetTeamNum() == 1 && VSize(P.Location - BFB.Location) > FlagSepDist * MaxDistFactor)
	    		return -10000000;
    }

    Score = 1000000.0;

    if(bFirstSpawn && LastPlayerStartSpot != None)
    {
        NextDist = VSize(N.Location - LastPlayerStartSpot.Location);
        Score += (NextDist * (0.25 + 0.75 * FRand()));

	    if(N == LastStartSpot || N == LastPlayerStartSpot)
            Score -= 100000000.0;
        else if(FastTrace(N.Location, LastPlayerStartSpot.Location))
            Score -= 1000000.0;
    }

    for(OtherPlayer = Level.ControllerList; OtherPlayer != None; OtherPlayer = OtherPlayer.NextController)
    {
        if(OtherPlayer != None && OtherPlayer.bIsPlayer && (OtherPlayer.Pawn != None))
        {            
		    NextDist = VSize(OtherPlayer.Pawn.Location - N.Location);
            
		    if(NextDist < OtherPlayer.Pawn.CollisionRadius + OtherPlayer.Pawn.CollisionHeight)
                return 0.0;
            else
		    {
                // same team
			    if(OtherPlayer.GetTeamNum() == Player.GetTeamNum() && OtherPlayer != Player)
                {
                    if(FastTrace(OtherPlayer.Pawn.Location, N.Location))
                        Score += 10000.0;

                    if(NextDist > 1500)
				        Score -= (NextDist * 10);
                    else if (NextDist < 1000)
                        Score += (NextDist * 10);
                    else
                        Score += (NextDist * 20);
                }
                // different team
			    else if(OtherPlayer.GetTeamNum() != Player.GetTeamNum())
                {
                    if(FastTrace(OtherPlayer.Pawn.Location, N.Location))
                        Score -= 20000.0;       // strongly discourage spawning in line-of-sight of an enemy
                    
                    Score += (NextDist * 10);
                }
		    }
        }
    }

	return FMax(Score, 5);
} // RatePlayerStart()

simulated event PostBeginPlay()
{
	local xRealCTFBase FB;

	FixFlags();

	if (level.NetMode == NM_Client)
		Destroy();
		
	super.PostBeginPlay();
	
	foreach AllActors(class'xRealCTFBase', FB)
	{
		if (xRedFlagBase(FB) != None)
			RFB = xRedFlagBase(FB);
		else if (xBlueFlagBase(FB) != None)
			BFB = xBlueFlagBase(FB);
			
		if (BFB != None && RFB != None)
		{
			FlagSepDist = VSize(BFB.Location - RFB.Location);
			break;
		}
	}
}

simulated function FixFlags()
{
	local CTFFlag F;
	local xCTFBase B;

	ForEach AllActors(Class'CTFFlag', F)
	{
		f.HomeBase.bActive = false;
		F.Destroy();
	}

	if (level.NetMode != NM_DedicatedServer)
		ForEach AllActors(Class'xCTFBase', B)
			B.bHidden=true;
}

defaultproperties
{
     MaxDistFactor=0.250000
     MapPrefix="CTF"
     BeaconName="CTF"
     GameName="BallisticPro: Freon (CTF Maps)"
     Description="Freon on CTF maps. Freeze the other team to score a point. Chill well and serve."
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
