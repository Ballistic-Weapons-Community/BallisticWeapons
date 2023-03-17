//=============================================================================
// Game_BWConflict.
//
// A new gametype where the objective is to kill all members of the enemy team.
// Players are spawned together in their team on opposite sides of the map to
// the other team. When players die, they do not respawn until the next round.
// The round ends when all the players of a team are dead. A point is awarded
// to the survivng team at the end of each round.
//
// Inventory is issued in a 'loadout' scheme, but each item takes up a certain
// amount of space, limiting how many of what items players can choose.
//
// -Rounds which end when one team is out
// -Players that die are out until one team has been killed
// -Players are reset at start of each round
// -Pre-round intermission period where players can't move or attack
// -Post-round period after a team has been killed
// -Players spawn together
// -Use the two playerstarts that are the furthest apart
// -Team score is rounds won, not total kills
// -Players select start equipment
// -Players can select armor, extra ammo, extra health
// -Game removes all pickups
// -Option to keep health, armor, generic ammo, powerup pickups
// -All projectiles and other actors are reset/removed at the end of each round
// -Option to keep projectiles, mines, etc and not reset all actors
// -Team limits available equipment
// -Options for pre and post round delays
// !Option to use standard UT or mutator inventory/pickup handling (so no inventory stuff)
// -Clients mustn't fire before round
// -Replace items with BW items
// -Use skill based loadout system...
// -Make correct team get score when suicide ends round
// -Red out the unavailable icons in the inventory
// -Add size var to standard Ballistic weapon and use that for size
// -Add info menu
// -Options:
//  -Keep health and armor pickups
//  -Generic ammo pickups at weapon spots
//  -Reset actors between rounds
//  -Spawn Distance Range
//  -Keep weapon pickups
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Game_BWConflict extends xTeamGame
	config(BallisticProV55)
	transient
	HideDropDown
	CacheExempt;

var int					RoundCounter, RoundWinner, RoundTime;
var NavigationPoint		StartA, StartB;
var int					RoundNum;				//Current round

var() globalconfig int		PreRoundDelay;			//Time at beginning of round
var() globalconfig int		PostRoundDelay;			//Time at end of round
var() globalconfig int		SpawnAreaAllowance;		//All spawn points within this distance from the furthest apart pair can be used
var() globalconfig bool		bKeepHealth;			//Keep health and armor pickups around
var() globalconfig bool		bKeepWeapons;			//Keep weapon and ammo pickups around
var() globalconfig bool		bPurgeActors;			//Purge all actors between rounds
var() globalconfig bool		bBallisticItems;		//Replace health, armor, etc pickups with BW style pickups
var() globalconfig bool		bAmmoPacks;				//Replace weapon pickups with BW ammo packs
var() globalconfig int		RoundLimit;				//Number of rounds to be played before match ends

var() localized string	DisplayText[12];
var() localized string	DescriptionText[12];
var() vector			StaticSpawnOffsets[25];

struct SafeSpawnPoints
{
	var() NavigationPoint	StartSpot;
	var() array<vector>		StartLocs;
};
var   array<SafeSpawnPoints>		SafeSpawns;

var class<DamageType>			LastDT;

var int					TotalMatchTime;

var	  globalconfig string	WeapListsVar;		// Dumb... I mean dummy var for the weapon lists button
var	  globalconfig string	ConfigMenuVar;		// another...

// Let the new battle begin
function BeginRound ()
{
	local Controller P;

	for ( P=Level.ControllerList; P!=None; P=P.NextController )
	{
		if ( P.bIsPlayer && !P.PlayerReplicationInfo.bOnlySpectator && P.Pawn != None)
		{
 			P.Pawn.bNoWeaponFiring = false;
			P.Pawn.GroundSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed;
			P.Pawn.WaterSpeed=P.Pawn.default.WaterSpeed;
			P.Pawn.AirSpeed=P.Pawn.default.AirSpeed;
			P.Pawn.LadderSpeed=P.Pawn.default.LadderSpeed;
			P.Pawn.JumpZ=P.Pawn.default.JumpZ;
		}
	}

//	BroadcastRoundStartMessage(3);
	GotoState('MatchInProgress');
}

state PendingRound
{
	function BeginState()
	{
        GameReplicationInfo.bStopCountDown = true;
		RoundNum++;
		RoundCounter = PreRoundDelay;
        BroadcastLocalizedMessage(class'EliminationMessage', RoundCounter);
	}

	event Timer ()
	{
		RoundCounter--;
//		BroadcastRoundStartMessage(3-RoundCounter);
		if (RoundCounter <= 0)
			BeginRound();
		else
        	BroadcastLocalizedMessage(class'EliminationMessage', RoundCounter);
	}
}

state RoundEnded
{
	function BeginState()
	{
		local Controller P;

        GameReplicationInfo.bStopCountDown = true;
		GameReplicationInfo.RemainingMinute = RemainingTime;

		SortPlayerStarts ();
		RoundCounter = PostRoundDelay;

		if (RoundWinner == -1)	// Draw
		{
        	BroadcastLocalizedMessage(class'EliminationMessage', 95);
        }
		else if (RoundWinner == -2)	// Timelimit
		{
        	BroadcastLocalizedMessage(class'EliminationMessage', 96);
        }
		else if (RoundWinner == 0)
		{
			if (GameReplicationInfo.Teams[0].Score == GameReplicationInfo.Teams[1].Score)
				BroadcastLocalizedMessage(class'EliminationMessage', 103);	// Caught up
        	else if (GameReplicationInfo.Teams[0].Score >= GameReplicationInfo.Teams[1].Score + 5)
				BroadcastLocalizedMessage(class'EliminationMessage', 100);	// Decimating other team
        	else if (GameReplicationInfo.Teams[0].Score <= GameReplicationInfo.Teams[1].Score - 5)
				BroadcastLocalizedMessage(class'EliminationMessage', 105);	// Far behind
			else if (GameReplicationInfo.Teams[0].Score == GameReplicationInfo.Teams[1].Score + 1)
				BroadcastLocalizedMessage(class'EliminationMessage', 102);	// Just took the lead
        	else if (GameReplicationInfo.Teams[0].Score < GameReplicationInfo.Teams[1].Score)
				BroadcastLocalizedMessage(class'EliminationMessage', 104);	// Behind
        	else
				BroadcastLocalizedMessage(class'EliminationMessage', 101);	// Ahead
        }
		else if (RoundWinner == 1)
		{
			if (GameReplicationInfo.Teams[1].Score == GameReplicationInfo.Teams[0].Score)
				BroadcastLocalizedMessage(class'EliminationMessage', 113);	// Caught up
        	else if (GameReplicationInfo.Teams[1].Score >= GameReplicationInfo.Teams[0].Score + 5)
				BroadcastLocalizedMessage(class'EliminationMessage', 110);	// Decimating other team
        	else if (GameReplicationInfo.Teams[1].Score <= GameReplicationInfo.Teams[0].Score - 5)
				BroadcastLocalizedMessage(class'EliminationMessage', 115);	// Far behind
			else if (GameReplicationInfo.Teams[1].Score == GameReplicationInfo.Teams[0].Score + 1)
				BroadcastLocalizedMessage(class'EliminationMessage', 112);	// Just took the lead
        	else if (GameReplicationInfo.Teams[1].Score < GameReplicationInfo.Teams[0].Score)
				BroadcastLocalizedMessage(class'EliminationMessage', 114);	// Behind
        	else
				BroadcastLocalizedMessage(class'EliminationMessage', 111);	// Ahead
        }

		for ( P=Level.ControllerList; P!=None; P=P.NextController )
		{
			if ( P.bIsPlayer && !P.PlayerReplicationInfo.bOnlySpectator )
			{
				if (PlayerController(P) != None)
					PlayerController(P).ClientRoundEnded();
				P.RoundHasEnded();
			}
		}
	}
	event Timer ()
	{
		RoundCounter--;
		if (RoundCounter <= 0)
			StartRound();
	}
}

State MatchInProgress
{
    function BeginState()
    {
		bWaitingToStartMatch = false;
        StartupStage = 5;
        PlayStartupMessage();
        StartupStage = 6;
        GameReplicationInfo.bStopCountDown = false;
        RoundTime=0;
    }
	function Timer()
    {
        local Controller P;

        Global.Timer();
		if ( !bFinalStartup )
		{
			bFinalStartup = true;
			PlayStartupMessage();
		}
        if ( bForceRespawn )
            For ( P=Level.ControllerList; P!=None; P=P.NextController )
            {
                if ( (P.Pawn == None) && P.IsA('PlayerController') && !P.PlayerReplicationInfo.bOnlySpectator )
                    PlayerController(P).ServerReStartPlayer();
            }
        if ( NeedPlayers() && AddBot() && (RemainingBots > 0) )
			RemainingBots--;

        if ( bOverTime )
			EndGame(None,"TimeLimit");
        else if ( TimeLimit > 0 )
        {
            GameReplicationInfo.bStopCountDown = false;
            RemainingTime--;
            GameReplicationInfo.RemainingTime = RemainingTime;
            if ( RemainingTime % 60 == 0 )
                GameReplicationInfo.RemainingMinute = RemainingTime;
            if ( RemainingTime <= 0 )
            {
					RoundWinner=-2;
            		GotoState('RoundEnded');
			}
        }
        else if ( (MaxLives > 0) && (NumPlayers + NumBots != 1) )
			CheckMaxLives(none);

		RoundTime++;
        ElapsedTime++;
        GameReplicationInfo.ElapsedTime = ElapsedTime;

        TotalMatchTime++;
    }
}

function StartRound ()
{
	local Controller C;
	local actor A;

	GotoState('PendingRound');

	for (C = Level.ControllerList; C != None; C = C.NextController)
	{
		if (PlayerController(C) != None)
			PlayerController(C).ClientReset();
		C.Reset();
		if (C.PlayerReplicationInfo != None)
			C.PlayerReplicationInfo.bOutOfLives = false;
		if (ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo)) != None)
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo)).ClientPurge(bPurgeActors);
	}

    RemainingTime = 60 * TimeLimit;
	GameReplicationInfo.RemainingTime = RemainingTime;
    GameReplicationInfo.RemainingMinute = RemainingTime;
	GameReplicationInfo.NetUpdateTime	= Level.TimeSeconds - 1;

	foreach AllActors(class'Actor', A)
	{
		if (!A.bDeleteMe && ((!bPurgeActors && A.IsA('Pawn')) || (bPurgeActors && !A.IsA('Controller') && !A.IsA('Info'))) )
			A.Reset();
	}
	for (C = Level.ControllerList; C != None; C = C.nextController)
		if (C.PlayerReplicationInfo != None && !C.PlayerReplicationInfo.bOnlySpectator)
			RestartPlayer(C);
}

function StartMatch()
{
    local bool bTemp;
	local int Num;

	SortPlayerStarts ();

//    GotoState('');
//    GotoState('MatchInProgress');
	GotoState('PendingRound');

    if ( Level.NetMode == NM_Standalone )
        RemainingBots = InitialBots;
    else
        RemainingBots = 0;
    GameReplicationInfo.RemainingMinute = RemainingTime;
    Super(GameInfo).StartMatch();

    bTemp = bMustJoinBeforeStart;
    bMustJoinBeforeStart = false;
    while ( NeedPlayers() && (Num<16) )
    {
		if ( AddBot() )
			RemainingBots--;
		Num++;
    }
    bMustJoinBeforeStart = bTemp;
    log("START MATCH");

//	GotoState('PendingRound');

//	StartRound();
}

function ResetLevel()
{
	local Actor A;

	foreach AllActors(class'Actor', A)
	{
		if (!A.IsA('Controller') && !A.IsA('ReplicationInfo') && !A.IsA('Info'))
			A.Reset();
	}
}

function ScoreKill(Controller Killer, Controller Other)
{
	local PlayerReplicationInfo OtherPRI;

	OtherPRI = Other.PlayerReplicationInfo;
    if (OtherPRI != None)
        OtherPRI.bOutOfLives = true;

	Super.ScoreKill (Killer, Other);
	CheckScore(Killer.PlayerReplicationInfo);
}

function Logout(Controller Exiting)
{
	super.Logout(Exiting);
	CheckMaxLives(none);
}

function bool CheckMaxLives(PlayerReplicationInfo Scorer)
{
    local Controller C;
    local PlayerReplicationInfo Living;
    local bool bNoneLeft;

	if ( (Scorer != None) && !Scorer.bOutOfLives )
		Living = Scorer;
	bNoneLeft = true;
	for ( C=Level.ControllerList; C!=None; C=C.NextController )
		if ( (C.PlayerReplicationInfo != None) && C.bIsPlayer
			&& !C.PlayerReplicationInfo.bOutOfLives
			&& !C.PlayerReplicationInfo.bOnlySpectator )
		{
			if ( Living == None )
				Living = C.PlayerReplicationInfo;
			else if ( (C.PlayerReplicationInfo != Living) && (C.PlayerReplicationInfo.Team != Living.Team) )
			{
				bNoneLeft = false;
				break;
			}
	}
	if ( bNoneLeft )
	{
		if ( Living != None )
		{
			RoundWinner = Living.Team.TeamIndex;
		}
		else
			RoundWinner = -1;
		if (IsInState('MatchInProgress') && RoundWinner > -1)
		{
			GameReplicationInfo.Teams[RoundWinner].Score += 1;
			GameReplicationInfo.Teams[RoundWinner].NetUpdateTime = Level.TimeSeconds - 1;
			TeamScoreEvent(RoundWinner, 1, "tdm_frag");
			if (RoundLimit > 0 && GameReplicationInfo.Teams[RoundWinner].Score >= RoundLimit)
				EndGame(Scorer, "RoundLimit");
			else
			    GotoState('RoundEnded');
		}
		else
		{
//			if (RoundLimit > 0 && RoundNum >= RoundLimit)
//				EndGame(Scorer, "RoundLimit");
//			else
	    		GotoState('RoundEnded');
	    }
		return true;
	}
    return false;
}

function CheckScore(PlayerReplicationInfo Scorer)
{
	if (IsInState('MatchOver'))
		return;
	if (IsInState('RoundEnded'))
		return;
	if (CheckMaxLives(Scorer))
		return;
	Super.CheckScore(Scorer);
}

function EndGame(PlayerReplicationInfo Winner, string Reason )
{
    if ( (Reason ~= "triggered") ||
         (Reason ~= "LastMan")   ||
         (Reason ~= "TimeLimit") ||
         (Reason ~= "FragLimit") ||
         (Reason ~= "TeamScoreLimit") ||
		 (Reason ~= "RoundLimit") )
    {
        Super(GameInfo).EndGame(Winner,Reason);
        if ( bGameEnded )
            GotoState('MatchOver');
    }
}


function SortPlayerStarts ()
{
    local NavigationPoint N, P, BestStart, Other;
    local float D, Dist;

    for (N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint)
    {
   	    if (PlayerStart(N) == None)
   	    	continue;
    	for (P=Level.NavigationPointList; P!=None; P=P.NextNavigationPoint)
    	{
    		if (PlayerStart(P) == None || P==N || (P==BestStart && N==Other) )
    			continue;
    		D = VSize(N.Location - P.Location);
// 			if (D > Dist)
    		if (Dist == 0 || D - Dist > Rand(SpawnAreaAllowance))
   			{
   				Dist = D;
	            BestStart = N;
   				Other = P;
    		}
    	}
    }
    if (FRand() > 0.5)
    {
    	StartA = BestStart;
    	StartB = Other;
    }
    else
    {
    	StartA = Other;
    	StartB = BestStart;
    }
}

// 0: Good location
// 1: Touching safe? physics volume
// 2: Touching water
// 3: Touching painful physics volume
// 4: Not close to ground
// 5: Touching destructive physics volume
// 6: Touching other actor or world
function byte SpawnLocQuality (Controller P, vector Loc, out vector HitLoc, out vector HitNorm)
{
	local Actor T;

	// First check the player's extent around the location
	bTraceWater=true;
	T = Trace(HitLoc, HitNorm, Loc-vect(0,0,20), Loc+vect(0,0,50), true, vect(20,20,0));
	bTraceWater=false;
	if (T != None)
	{
		if (FluidSurfaceInfo(T) != None)
			return 2;	// Water
		if (PhysicsVolume(T) != None)
		{
			if (PhysicsVolume(T).bPainCausing)
				return 3;	// Painful
			if (PhysicsVolume(T).bDestructive)
				return 5;	// Destructive
			if (PhysicsVolume(T).bWaterVolume)
				return 2;	// Water
			return 1;	// Unknown physics volume, hopefully its safe...
		}
		if (normal(HitLoc - (Loc+vect(0,0,50))) Dot HitNorm > 0.0)
			HitNorm *= -1;
		return 6;	// Solid or actor
	}
	// Find out whats below
	bTraceWater=true;
	T = Trace(HitLoc, HitNorm, Loc-vect(0,0,384), Loc, false, vect(25,25,44));
	bTraceWater=false;
	if (T==None)
		return 4;	// Not near ground
	if (PhysicsVolume(T) != None)
	{
		if (PhysicsVolume(T).bPainCausing)
			return 3;	// Painful
		if (PhysicsVolume(T).bDestructive)
			return 5;	// Destructive
		if (PhysicsVolume(T).bWaterVolume)
			return 1;
	}

	if (normal(HitLoc - Loc) Dot HitNorm > 0.0)
		HitNorm *= -1;
	return 0;	// Safe location
}

function vector GetStartLocation(Controller P, NavigationPoint StartSpot)
{
	local Vector Start, End, HitLoc, HitNorm, BestLoc, TestLoc, TestNorm;
	local Actor T;
	local rotator R;
	local int i, j, k, BestLocScore, TestScore;

	Start = StartSpot.Location;
//	R.Pitch = 8192;
	BestLoc = StartSpot.Location;
	BestLocScore = SpawnLocQuality(P, StartSpot.Location, TestLoc, TestNorm);

	for (i=0;i<SafeSpawns.length;i++)
	{
  		if (SafeSpawns[i].StartSpot == StartSpot)
		{
			k = Rand(SafeSpawns[i].StartLocs.length);
			for (j=0;j<SafeSpawns[i].StartLocs.length;j++)
			{
				T = Trace(HitLoc, HitNorm, SafeSpawns[i].StartLocs[j]-vect(0,0,20), SafeSpawns[i].StartLocs[j]+vect(0,0,50), true, vect(20,20,0));
				if (T == None || T.bWorldGeometry)
					Return SafeSpawns[i].StartLocs[j];
				k = class'BUtil'.static.Loop(k, 1, SafeSpawns[i].StartLocs.length-1, 0);
			}
		}
  	}

	// Try some static locations
	j = Rand(25);
	for (i=0;i<25;i++)
	{
		End = StartSpot.Location + StaticSpawnOffsets[j];
		T = Trace(HitLoc, HitNorm, End, Start, false, vect(8,8,8));
		if (T == None)	// No obstacles, test location
			TestScore = SpawnLocQuality(P, End, TestLoc, TestNorm);
		else			// Test a bit back from the hit location
		{
			if (normal(end - start) Dot HitNorm > 0.0)
				HitNorm *= -1;
			End = HitLoc + HitNorm*30;
//			End = HitLoc - vector(R)*30;
			TestScore = SpawnLocQuality(P, End, TestLoc, TestNorm);
		}
		// Test results...
		if (TestScore == 6)
		{	// In solid, try testing again right next to it
			End = TestLoc + TestNorm * 30;
			TestScore = SpawnLocQuality(P, End, TestLoc, TestNorm);
		}
		if (TestScore == 0)
			return End;	// A good location
		else if (TestScore < BestLocScore)
		{				// Dodgy location, but better than current best
			BestLocScore = TestScore;
			BestLoc = End;
		}
		j = class'BUtil'.static.Loop(j, 1, 24, 0);
	}

	// Try above
	if (TestScore >= 6)
	{
		End = Start + vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, Start, false, vect(25,25,44));
		if (T == None)
			HitLoc = End;
		Start = HitLoc;
		for (i=0;i<8;i++)
		{
			R.Yaw = Rand(65536);
			End = Start + vector(R) * (128 + Rand(256));
			T = Trace(HitLoc, HitNorm, End, Start, false);
			if (T == None)	// No obstacles, test location
				TestScore = SpawnLocQuality(P, End, TestLoc, TestNorm);
			else			// Test a bit back from the hit location
			{
				End = HitLoc - vector(R)*30;
				TestScore = SpawnLocQuality(P, End, TestLoc, TestNorm);
			}
			// Test results...
			if (TestScore == 6)
			{	// In solid, try testing again right next to it
				End = TestLoc + TestNorm * 30;
				TestScore = SpawnLocQuality(P, End, TestLoc, TestNorm);
			}
			if (TestScore == 0)
				return End;	// A good location
			else if (TestScore < BestLocScore)
			{				// Dodgy location, but better than current best
				BestLocScore = TestScore;
				BestLoc = End;
			}
		}
	}
	return BestLoc;
}

event InitGame( string Options, out string Error )
{
	Super.InitGame(Options, Error);
	
	AddMutator("BallisticProV55.Mut_SpatialLoadout", True);

	bForceRespawn = true;
}

function bool IsNearStartSpot( PlayerReplicationInfo PRI)
{
	if (Controller(PRI.Owner) == None || Controller(PRI.Owner).Pawn == None)
		return false;

	if (PRI.Team.TeamIndex == 0 && VSize(Controller(PRI.Owner).Pawn.Location - StartA.Location) < 512)
		return true;
	if (PRI.Team.TeamIndex == 1 && VSize(Controller(PRI.Owner).Pawn.Location - StartB.Location) < 512)
		return true;
	return false;
}

//
// Restart a player.
//

function RestartPlayer( Controller aPlayer )
{
    local NavigationPoint startSpot;
    local int TeamNum, i, j;
    local class<Pawn> DefaultPlayerClass;
	local Vehicle V, Best;
	local vector ViewDir;
	local float BestDist, Dist;
	local vector StartLocation;


	local TeamInfo BotTeam, OtherTeam;

	if ( (!bPlayersVsBots || (Level.NetMode == NM_Standalone)) && bBalanceTeams && (Bot(aPlayer) != None) && (!bCustomBots || (Level.NetMode != NM_Standalone)) )
	{
		BotTeam = aPlayer.PlayerReplicationInfo.Team;
		if ( BotTeam == Teams[0] )
			OtherTeam = Teams[1];
		else
			OtherTeam = Teams[0];

		if ( OtherTeam.Size < BotTeam.Size - 1 )
		{
			aPlayer.Destroy();
			return;
		}
	}

    if ( bMustJoinBeforeStart && (UnrealPlayer(aPlayer) != None)
        && UnrealPlayer(aPlayer).bLatecomer )
        return;

    if ( aPlayer.PlayerReplicationInfo.bOutOfLives )
        return;

    if ( aPlayer.IsA('Bot') && TooManyBots(aPlayer) )
    {
        aPlayer.Destroy();
        return;
    }


    if( bRestartLevel && Level.NetMode!=NM_DedicatedServer && Level.NetMode!=NM_ListenServer )
        return;

    if ( (aPlayer.PlayerReplicationInfo == None) || (aPlayer.PlayerReplicationInfo.Team == None) )
        TeamNum = 255;
    else
        TeamNum = aPlayer.PlayerReplicationInfo.Team.TeamIndex;

    startSpot = FindPlayerStart(aPlayer, TeamNum);
    if( startSpot == None )
    {
        log(" Player start not found!!!");
        return;
    }

    StartLocation = GetStartLocation(aPlayer, StartSpot);

    if (aPlayer.PreviousPawnClass!=None && aPlayer.PawnClass != aPlayer.PreviousPawnClass)
        BaseMutator.PlayerChangedClass(aPlayer);

    if ( aPlayer.PawnClass != None )
        aPlayer.Pawn = Spawn(aPlayer.PawnClass,,,StartLocation,StartSpot.Rotation);

    if( aPlayer.Pawn==None )
    {
        DefaultPlayerClass = GetDefaultPlayerClass(aPlayer);
        aPlayer.Pawn = Spawn(DefaultPlayerClass,,,StartLocation,StartSpot.Rotation);
    }
    if ( aPlayer.Pawn == None )
    {
        log("Couldn't spawn player '"$aPlayer.GetHumanReadableName()$"' of type "$aPlayer.PawnClass$" at "$StartSpot);
        aPlayer.GotoState('Dead');
        if ( PlayerController(aPlayer) != None )
			PlayerController(aPlayer).ClientGotoState('Dead','Begin');
        return;
    }


    for (i=0;i<SafeSpawns.length;i++)
    {
    	if (SafeSpawns[i].StartSpot == startSpot)
    	{
    		for (j=0;j<SafeSpawns[i].StartLocs.length;j++)
    		{
    			if (SafeSpawns[i].StartLocs[j] == StartLocation)
    				break;
    		}
    		if (j >= SafeSpawns[i].StartLocs.length)
	    		SafeSpawns[i].StartLocs[SafeSpawns[i].StartLocs.Length] = StartLocation;
    		break;
    	}
    }
    if (i >= SafeSpawns.length)
    {
    	SafeSpawns.length = SafeSpawns.length + 1;
    	SafeSpawns[SafeSpawns.length-1].StartSpot = startSpot;
    	SafeSpawns[SafeSpawns.length-1].StartLocs[SafeSpawns[SafeSpawns.length-1].StartLocs.length] = StartLocation;
    }

    if ( PlayerController(aPlayer) != None )
		PlayerController(aPlayer).TimeMargin = -0.1;
	aPlayer.Pawn.Anchor = startSpot;
	aPlayer.Pawn.LastStartSpot = PlayerStart(startSpot);
	aPlayer.Pawn.LastStartTime = Level.TimeSeconds;
    aPlayer.PreviousPawnClass = aPlayer.Pawn.Class;

    aPlayer.Possess(aPlayer.Pawn);
    aPlayer.PawnClass = aPlayer.Pawn.Class;

    aPlayer.Pawn.PlayTeleportEffect(true, true);
    aPlayer.ClientSetRotation(aPlayer.Pawn.Rotation);
    AddDefaultInventory(aPlayer.Pawn);
    TriggerEvent( StartSpot.Event, StartSpot, aPlayer.Pawn);

    if ( bAllowVehicles && (Level.NetMode == NM_Standalone) && (PlayerController(aPlayer) != None) )
    {
		// tell bots not to get into nearby vehicles for a little while
		BestDist = 2000;
		ViewDir = vector(aPlayer.Pawn.Rotation);
		for ( V=VehicleList; V!=None; V=V.NextVehicle )
			if ( V.bTeamLocked && (aPlayer.GetTeamNum() == V.Team) )
			{
				Dist = VSize(V.Location - aPlayer.Pawn.Location);
				if ( (ViewDir Dot (V.Location - aPlayer.Pawn.Location)) < 0 )
					Dist *= 2;
				if ( Dist < BestDist )
				{
					Best = V;
					BestDist = Dist;
				}
			}

		if ( Best != None )
			Best.PlayerStartTime = Level.TimeSeconds + 8;
	}

	if (IsInState('PendingRound'))
	{
 		aPlayer.Pawn.bNoWeaponFiring = true;
		aPlayer.Pawn.GroundSpeed=0;
		aPlayer.Pawn.WaterSpeed=0;
		aPlayer.Pawn.AirSpeed=0;
		aPlayer.Pawn.LadderSpeed=0;
		aPlayer.Pawn.JumpZ=0;
	}
	if (xPawn(aPlayer.Pawn) != None)
		xPawn(aPlayer.Pawn).RagdollLifeSpan = 600;

}

function NavigationPoint FindPlayerStart( Controller Player, optional byte InTeam, optional string incomingName )
{
    local NavigationPoint N, BestStart;
    local Teleporter Tel;
    local float BestRating, NewRating;
    local byte Team;

    // always pick StartSpot at start of match
    if ( GameRulesModifiers != None )
    {
        N = GameRulesModifiers.FindPlayerStart(Player,InTeam,incomingName);
        if ( N != None )
            return N;
    }

    // if incoming start is specified, then just use it
    if( incomingName!="" )
        foreach AllActors( class 'Teleporter', Tel )
            if( string(Tel.Tag)~=incomingName )
                return Tel;

    // use InTeam if player doesn't have a team yet
    if ( (Player != None) && (Player.PlayerReplicationInfo != None) )
    {
        if ( Player.PlayerReplicationInfo.Team != None )
            Team = Player.PlayerReplicationInfo.Team.TeamIndex;
        else
            Team = InTeam;
    }
    else
        Team = InTeam;

	if (Team == 0)
		BestStart = StartA;
	else
		BestStart = StartB;
		
    if ( (BestStart == None) || ((PlayerStart(BestStart) == None) && (Player != None) && Player.bIsPlayer) )
    {
        log("Warning - PATHS NOT DEFINED or NO PLAYERSTART with positive rating");
		BestRating = -100000000;
        ForEach AllActors( class 'NavigationPoint', N )
        {
            NewRating = RatePlayerStart(N,0,Player);
            if ( InventorySpot(N) != None )
				NewRating -= 50;
			NewRating += 20 * FRand();
            if ( NewRating > BestRating )
            {
                BestRating = NewRating;
                BestStart = N;
            }
        }
    }

    return BestStart;
}

static function FillPlayInfo(PlayInfo PI)
{
	Super.FillPlayInfo(PI);

	PI.AddSetting(default.GameGroup, "RoundLimit",			GetDisplayText("RoundLimit"),       	50, 1, "Text", "3;0:999",,     	,);
	PI.AddSetting(default.GameGroup, "PreRoundDelay",		GetDisplayText("PreRoundDelay"),		50, 1, "Text", "2;0:60"	,,     	,True);
	PI.AddSetting(default.GameGroup, "PostRoundDelay",		GetDisplayText("PostRoundDelay"),		50, 1, "Text", "2;0:60"	,,     	,True);
	PI.AddSetting(default.GameGroup, "SpawnAreaAllowance",	GetDisplayText("SpawnAreaAllowance"),	50, 3, "Text", "2;0:32768"	,,	,True);
	PI.AddSetting(default.RulesGroup, "bEvolutionMode",		GetDisplayText("bEvolutionMode"),       50, 1, "Check",         ,,		,);
	PI.AddSetting(default.RulesGroup, "bBallisticItems",	GetDisplayText("bBallisticItems"), 		50, 1, "Check",         ,,     	,);
	PI.AddSetting(default.RulesGroup, "bAmmoPacks",			GetDisplayText("bAmmoPacks"), 			50, 1, "Check",         ,,     	,);
	PI.AddSetting(default.RulesGroup, "bKeepHealth",		GetDisplayText("bKeepHealth"),     		50, 1, "Check",         ,,     	,);
	PI.AddSetting(default.RulesGroup, "bKeepWeapons",		GetDisplayText("bKeepWeapons"),			50, 1, "Check",         ,,		,);
	PI.AddSetting(default.RulesGroup, "bPurgeActors",		GetDisplayText("bPurgeActors"),         50, 1, "Check",         ,,		,True);
	PI.AddSetting(default.RulesGroup, "WeapListsVar",		GetDisplayText("WeapListsVar"), 		60, 2, "Custom", ";;BallisticProV55.BallisticConflictWeaponMenu");
	PI.AddSetting(default.GameGroup, "ConfigMenuVar",		GetDisplayText("ConfigMenuVar"), 		60, 2, "Custom", ";;BallisticProV55.ConfigMenu_Rules");
}

static event string GetDisplayText( string PropName )
{
	switch (PropName)
	{
	case "PreRoundDelay":		return default.DisplayText[0];
	case "PostRoundDelay":		return default.DisplayText[1];
	case "SpawnAreaAllowance":	return default.DisplayText[2];
	case "bKeepHealth":			return default.DisplayText[3];
	case "bKeepWeapons":		return default.DisplayText[4];
	case "bPurgeActors":		return default.DisplayText[5];
	case "bBallisticItems":		return default.DisplayText[6];
	case "bAmmoPacks":			return default.DisplayText[7];
	case "bEvolutionMode":		return default.DisplayText[8];
	case "WeapListsVar":		return default.DisplayText[9];
	case "ConfigMenuVar":		return default.DisplayText[10];
	case "RoundLimit":		return default.DisplayText[11];
	}
	return Super.GetDisplayText( PropName );
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
	case "PreRoundDelay":		return default.DescriptionText[0];
	case "PostRoundDelay":		return default.DescriptionText[1];
	case "SpawnAreaAllowance":	return default.DescriptionText[2];
	case "bKeepHealth":			return default.DescriptionText[3];
	case "bKeepWeapons":		return default.DescriptionText[4];
	case "bPurgeActors":		return default.DescriptionText[5];
	case "bBallisticItems":		return default.DescriptionText[6];
	case "bAmmoPacks":			return default.DescriptionText[7];
	case "bEvolutionMode":		return default.DescriptionText[8];
	case "WeapListsVar":		return default.DescriptionText[9];
	case "ConfigMenuVar":		return default.DescriptionText[10];
	case "RoundLimit":		return default.DescriptionText[11];
	}
	return Super.GetDescriptionText(PropName);
}

function InitializeBot(Bot NewBot, UnrealTeamInfo BotTeam, RosterEntry Chosen)
{
	super.InitializeBot(NewBot, BotTeam, Chosen);

	NewBot.Jumpiness-=0.5;
	NewBot.StrafingAbility-=1.0;
	NewBot.CombatStyle-=0.3;
}

function Bot SpawnBot(optional string botName)
{
	local Bot B;

	B = Super.SpawnBot(botName);
	if (B != None && B.PawnClass == class'xPawn')
		B.PawnClass = class'BallisticPawn';

	return B;
}

event PlayerController Login( string Portal, string Options, out string Error )
{
	local PlayerController pc;

	pc = Super.Login(Portal, Options, Error);
	if (pc != None && pc.PawnClass == class'xPawn')
		pc.PawnClass = class'BallisticPawn';
	return pc;
}

defaultproperties
{
     PreRoundDelay=4
     PostRoundDelay=5
     SpawnAreaAllowance=768
     bPurgeActors=True
     bBallisticItems=True
     bAmmoPacks=True
     DisplayText(0)="Round Start Delay"
     DisplayText(1)="Round End Delay"
     DisplayText(2)="Spawn Distance Allowance"
     DisplayText(3)="Keep Health Pickups"
     DisplayText(4)="Keep Weapon Pickups"
     DisplayText(5)="Purge After Round"
     DisplayText(6)="Ballistic Items"
     DisplayText(7)="Ammo Packs"
     DisplayText(8)="Evolution Mode"
     DisplayText(9)="Choose weapons"
     DisplayText(10)="Ballistic Weapons Config"
     DisplayText(11)="Round Limit"
     DescriptionText(0)="Time before a round begins, during which players can't move or attack."
     DescriptionText(1)="Time round continues after a team has won before going to the next round."
     DescriptionText(2)="Teams start as far apart as possible, but can start this distance closer together."
     DescriptionText(3)="Keep health and armor pickups around."
     DescriptionText(4)="Keep weapons and ammo pickups"
     DescriptionText(5)="Clean out all projectiles, bombs and other actors between rounds."
     DescriptionText(6)="Replace health, armor, etc with Ballistic style items."
     DescriptionText(7)="Generic ammo packs are placed instead of normal weapon and ammo pickups"
     DescriptionText(8)="Use Evolution Loadout system which gives access to weapons depending on the skill level of players."
     DescriptionText(9)="Select the weapons that you want to be available to each team."
     DescriptionText(10)="Access the Ballistic Weapons config menu."
     DescriptionText(11)="Set how many rounds can be played before match ends."
     StaticSpawnOffsets(0)=(Y=60.000000)
     StaticSpawnOffsets(1)=(X=-60.000000,Y=60.000000)
     StaticSpawnOffsets(2)=(X=-60.000000)
     StaticSpawnOffsets(3)=(X=-60.000000,Y=-60.000000)
     StaticSpawnOffsets(4)=(Y=-60.000000)
     StaticSpawnOffsets(5)=(X=60.000000,Y=-60.000000)
     StaticSpawnOffsets(6)=(X=60.000000)
     StaticSpawnOffsets(7)=(X=60.000000,Y=60.000000)
     StaticSpawnOffsets(9)=(X=120.000000)
     StaticSpawnOffsets(10)=(X=120.000000,Y=60.000000)
     StaticSpawnOffsets(11)=(X=120.000000,Y=120.000000)
     StaticSpawnOffsets(12)=(X=60.000000,Y=120.000000)
     StaticSpawnOffsets(13)=(Y=120.000000)
     StaticSpawnOffsets(14)=(X=60.000000,Y=120.000000)
     StaticSpawnOffsets(15)=(X=-120.000000,Y=120.000000)
     StaticSpawnOffsets(16)=(X=-120.000000,Y=60.000000)
     StaticSpawnOffsets(17)=(X=-120.000000)
     StaticSpawnOffsets(18)=(X=-120.000000,Y=-60.000000)
     StaticSpawnOffsets(19)=(X=-120.000000,Y=-120.000000)
     StaticSpawnOffsets(20)=(X=-60.000000,Y=-120.000000)
     StaticSpawnOffsets(21)=(Y=-120.000000)
     StaticSpawnOffsets(22)=(X=60.000000,Y=-120.000000)
     StaticSpawnOffsets(23)=(X=120.000000,Y=-120.000000)
     StaticSpawnOffsets(24)=(X=120.000000,Y=-60.000000)
     bScoreTeamKills=False
     bAlwaysShowLoginMenu=True
     DefaultPlayerClassName="BallisticProV55.BallisticPawn"
     PlayerControllerClassName="BallisticProV55.BallisticPlayer"
     GameName="BallisticPro: Conflict"
     Description="Rival teams prepare for battle and must eliminate the entire enemy team to score!||A round based Ballistic Weapons game where teams start on opposite sides of the map and players have a chance to choose their starting loadout. Dead players don't respawn until the next round. When one team has been completely eliminated the round ends and teams are reset to a starting location.||www.runestorm.com"
     ScreenShotName="BW_Core_WeaponTex.ui.Conflict-Sequence"
     DecoTextName="BallisticProV55.Game_BWConflict"
     Acronym="BWCP"
}
