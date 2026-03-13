//==============================================================================
// Single Player Ladder Info
//
// Written by Michiel Hendriks
// (c) 2003, 2004, Epic Games, Inc. All Rights Reserved
//==============================================================================

class UT2K4LadderInfo extends LadderInfo config;

var() editinline array<UT2K4MatchInfo> ASMatches;

/**
	New constants for ladder ids
	defined as vars for static outside access
*/
var int LID_DM, LID_TDM, LID_CTF, LID_BR, LID_DOM, LID_AS, LID_CHAMP;

/** custom ladders you can add to the game */
var config array< class<CustomLadderInfo> > AdditionalLadders;

/** challenge games */
var config array< class<ChallengeGame> > ChallengeGames;
// config breaks the array

/** for backward compatibility */
static function MatchInfo GetMatchInfo(int ladder, int rung)
{
	return GetUT2K4MatchInfo(ladder, rung, 0, true);
}

/**
	Retreives the match info and fills in the alternative map
	path is used as a constant random to define the path, should be a very large number
	if bSelect then path is the position in the AltLevels array to use
*/
static function UT2K4MatchInfo GetUT2K4MatchInfo(int ladder, int rung, optional int path, optional bool bSelect)
{
	local array<MatchInfo> matcharray;
	local UT2K4MatchInfo selmatch;
	local string tmp;
	local int i;

	//log("GetUT2K4MatchInfo"@ladder@rung@path);

	if (rung < 0)
	{
		Warn("rung < 0");
		return none;
	}

	switch (ladder)
	{
		case default.LID_DM:		matcharray = Default.DMMatches;	break;
		case default.LID_TDM:		matcharray = Default.TDMMatches; break;
		case default.LID_CTF:		matcharray = Default.CTFMatches; break;
		case default.LID_BR:		matcharray = Default.BRMatches; break;
		case default.LID_DOM:		matcharray = Default.DOMMatches; break;
		case default.LID_AS:		matcharray = Default.ASMatches;	break;
		case default.LID_CHAMP:		matcharray = Default.ChampionshipMatches; break;
		default:	if ((ladder >= 10) && (default.AdditionalLadders.length > (ladder-10)))
					{
						matcharray = default.AdditionalLadders[ladder-10].default.Matches;
					}
	}

	if ( matcharray.Length <= 0 )
	{
		Warn("matcharray.Length <= 0");
		return none;
	}

	if ( rung >= matcharray.Length ) selmatch = UT2K4MatchInfo(matcharray[matcharray.Length-1]);
		else selmatch = UT2K4MatchInfo(matcharray[rung]);

	if ((selmatch != none) && bSelect && (selmatch.AltLevels.length > 0))
	{
		tmp = selmatch.AltLevels[path % selmatch.AltLevels.length];
		if (tmp != "") selmatch.LevelName = tmp;
	}
	else if ((selmatch != none) && (selmatch.AltLevels.length > 0)) // select one from the list
	{
		path = abs(path + ((rung+1) * (ladder+1)));
		if (selmatch.Priority > 0) i = selmatch.Priority;
			else i = selmatch.AltLevels.length;
		tmp = selmatch.AltLevels[path % i];
		if (tmp != "") selmatch.LevelName = tmp;
		//Log("Set level name to:"@selmatch.LevelName);
	}
	if ( selmatch == none ) Warn("selmatch == none");
	return selmatch;
}

/**
	get the ID of the alternative level
	match priority has no relevance here
*/
static function byte GetAltLevel(int ladder, int rung, int path, int selected)
{
	local array<MatchInfo> matcharray;
	local UT2K4MatchInfo selmatch;
	local int origpath;

	if (rung < 0) return -1;

	switch (ladder)
	{
		case default.LID_DM:		matcharray = Default.DMMatches;	break;
		case default.LID_TDM:		matcharray = Default.TDMMatches; break;
		case default.LID_CTF:		matcharray = Default.CTFMatches; break;
		case default.LID_BR:		matcharray = Default.BRMatches; break;
		case default.LID_DOM:		matcharray = Default.DOMMatches; break;
		case default.LID_AS:		matcharray = Default.ASMatches;	break;
		case default.LID_CHAMP:		matcharray = Default.ChampionshipMatches; break;
		default:	if ((ladder >= 10) && (default.AdditionalLadders.length > (ladder-10)))
					{
						matcharray = default.AdditionalLadders[ladder-10].default.Matches;
					}
	}

	if ( matcharray.Length <= 0 ) return -1;

	if ( rung >= matcharray.Length ) selmatch = UT2K4MatchInfo(matcharray[matcharray.Length-1]);
		else selmatch = UT2K4MatchInfo(matcharray[rung]);

	if ((selmatch != none) && (selmatch.AltLevels.length > 0))
	{
		origpath = abs(path + ((rung+1) * (ladder+1)));
		if (selmatch.Priority > 0) origpath = origpath % selmatch.Priority;
			else origpath = origpath % selmatch.AltLevels.length;

		if (selected == origpath || selected == -1)
		{
			path = (abs(path + ((rung+1) * (ladder+1)))+1) % selmatch.AltLevels.length;
			if (path == origpath) path = (path + 1) % selmatch.AltLevels.length;
			//Log("GetAltLevel (path)"@path@origpath);
			return path;
		}
		//Log("GetAltLevel (orig)"@origpath@selected);
		return origpath;
	}
	return -1;
}

/** check if there is an alternative level */
static function bool HasAltLevel(int ladder, int rung)
{
	local array<MatchInfo> matcharray;
	local UT2K4MatchInfo selmatch;

	if (rung < 0) return false;

	switch (ladder)
	{
		case default.LID_DM:		matcharray = Default.DMMatches;	break;
		case default.LID_TDM:		matcharray = Default.TDMMatches; break;
		case default.LID_CTF:		matcharray = Default.CTFMatches; break;
		case default.LID_BR:		matcharray = Default.BRMatches; break;
		case default.LID_DOM:		matcharray = Default.DOMMatches; break;
		case default.LID_AS:		matcharray = Default.ASMatches;	break;
		case default.LID_CHAMP:		matcharray = Default.ChampionshipMatches; break;
		default:	if ((ladder >= 10) && (default.AdditionalLadders.length > (ladder-10)))
					{
						matcharray = default.AdditionalLadders[ladder-10].default.Matches;
					}
	}

	if ( matcharray.Length <= 0 ) return false;

	if ( rung >= matcharray.Length ) selmatch = UT2K4MatchInfo(matcharray[matcharray.Length-1]);
		else selmatch = UT2K4MatchInfo(matcharray[rung]);
	if (selmatch == none) return false;
	return (selmatch.AltLevels.length > 1);
}

static function MatchInfo GetCurrentMatchInfo(GameProfile G)
{
	if (UT2K4GameProfile(G) != none ) return G.GetMatchInfo(G.CurrentLadder, G.CurrentMenuRung);
	return GetUT2K4MatchInfo(G.CurrentLadder, G.CurrentMenuRung);
}

/**
	Get the number of matches in a ladder
*/
static function int LengthOfLadder(int ladder)
{
	switch (ladder)
	{
		case default.LID_DM:	return Default.DMMatches.Length;
		case default.LID_TDM:	return Default.TDMMatches.Length;
		case default.LID_CTF:	return Default.CTFMatches.Length;
		case default.LID_BR:	return Default.BRMatches.Length;
		case default.LID_DOM:	return Default.DOMMatches.Length;
		case default.LID_AS:	return Default.ASMatches.Length;
		case default.LID_CHAMP:	return Default.ChampionshipMatches.Length;
		default:	if ((ladder >= 10) && (default.AdditionalLadders.length > (ladder-10)))
					{
						return default.AdditionalLadders[ladder-10].default.Matches.Length;
					}
					return -1;
	}
}

/**
	Update the ladder
*/
static function string UpdateLadders(GameProfile G, int CurrentLadder)
{
	local string SpecialEvent;
	local UT2K4GameProfile GP;
	local int i,j;

	GP = UT2K4GameProfile(G);
	if (GP == none)
	{
		Warn("PC Load Letter"); // wtf does that mean?
		return "";
	}

	if (GP.bIsChallenge) return GP.ChallengeInfo.SpecialEvent;

	if (CurrentLadder < 10)
	{
		if ( GP.LadderProgress[CurrentLadder] > G.CurrentMenuRung )
		{
			// they've chosen to play a match they've completed previously
			return "";
		}
	}

	// updates ladder rungs appropriately
	switch( CurrentLadder )
	{
		case default.LID_DM:
			SpecialEvent = Default.DMMatches[GP.LadderProgress[CurrentLadder]].SpecialEvent;
			break;
		case default.LID_TDM:
			SpecialEvent = Default.TDMMatches[GP.LadderProgress[CurrentLadder]].SpecialEvent;
			break;
		case default.LID_CTF:
			SpecialEvent = Default.CTFMatches[GP.LadderProgress[CurrentLadder]].SpecialEvent;
			break;
		case default.LID_BR:
			SpecialEvent = Default.BRMatches[GP.LadderProgress[CurrentLadder]].SpecialEvent;
			break;
		case default.LID_DOM:
			SpecialEvent = Default.DOMMatches[GP.LadderProgress[CurrentLadder]].SpecialEvent;
			break;
		case default.LID_AS:
			SpecialEvent = Default.ASMatches[GP.LadderProgress[CurrentLadder]].SpecialEvent;
			break;
		case default.LID_CHAMP:
			SpecialEvent = Default.ChampionshipMatches[GP.LadderProgress[CurrentLadder]].SpecialEvent;
			break;
		default:	i = CurrentLadder-10;
					if ((i >= 0) && (default.AdditionalLadders.length > i))
					{
						j = GP.GetCustomLadderProgress(string(default.AdditionalLadders[i]));
						if ( j > G.CurrentMenuRung ) return "";
						SpecialEvent = default.AdditionalLadders[i].default.Matches[j].SpecialEvent;
						GP.SetCustomLadderProgress(string(default.AdditionalLadders[i]), 1);
						return SpecialEvent;
					}
					return "";
	}

	GP.LadderProgress[CurrentLadder] += 1;
	return SpecialEvent;
}

/**
	Return the friendly name of the current match's gametype
*/
static function string GetMatchDescription (GameProfile G)
{
	return GetLadderDescription(G.CurrentLadder, G.CurrentMenuRung);
}

static function string GetLadderDescription(int LadderId, optional int MatchId)
{
	local string retval;
	local CacheManager.GameRecord gr;

	switch (LadderId)
	{
		case default.LID_DM:
			retval = default.DMMatches[MatchId].GameType;
			break;
		case default.LID_TDM:
			retval = default.TDMMatches[MatchId].GameType;
			break;
		case default.LID_CTF:
			retval = default.CTFMatches[MatchId].GameType;
			break;
		case default.LID_BR:
			retval = default.BRMatches[MatchId].GameType;
			break;
		case default.LID_DOM:
			retval = default.DOMMatches[MatchId].GameType;
			break;
		case default.LID_AS:
			retval = default.ASMatches[MatchId].GameType;
			break;
		case default.LID_CHAMP:
			retval = default.ChampionshipMatches[MatchId].GameType;
			break;
		default:	if ((LadderId >= 10) && (default.AdditionalLadders.length > (LadderId-10)))
					{
						retval = default.AdditionalLadders[LadderId-10].default.Matches[MatchId].GameType;
					}
					else return "";
	}
	gr = class'CacheManager'.static.GetGameRecord(retval);
	return gr.GameName;
}

/** return the id of a random ladder */
static function int GetRandomLadder(optional bool bIncludeChamp)
{
	// +1 because DM will never be returned
	if (bIncludeChamp) return rand(default.LID_CHAMP)+1;
		else return rand(default.LID_AS)+1;
}

/** create a URL for a selected profile */
static function string MakeURLFor(GameProfile G)
{
	local string x;
    x = super.MakeURLFor(G);
    return x$"?mutator=BWInteractions3.MutBWInteractions,BallisticProV55.Mut_BallisticSwap,BallisticProV55.Mut_BloodyHell,BWBP_VPC_Pro.Mut_BWVehicles,HUDFix.MutHUDFix";
}

/** create a URL for the selected MatchInfo */
static function string MakeURLFoMatchInfo(MatchInfo M, GameProfile G)
{
	local string URL;

	if ( M == none ) {
		Warn("MatchInfo == none");
		return "";
	}

	G.EnemyTeam = M.EnemyTeamName;
	G.Difficulty = G.BaseDifficulty + M.DifficultyModifier;

	URL = M.LevelName$"?Name="$G.PlayerName$"?Character="$G.PlayerCharacter$"?SaveGame="$G.PackageName$M.URLString;
	if ( M.GoalScore != 0 )
		URL $= "?GoalScore="$M.GoalScore;
	if ( M.NumBots > 0 )
		URL $= "?NumBots="$M.NumBots;
	if ( M.GameType != "" )
		URL $= "?Game="$M.GameType;
	URL $= "?Team=1?NoSaveDefPlayer?ResetDefPlayer";
	// with ?NoSaveDefPlayer the DefaultPlayer properties won't be saved to the user.ini
	// with ?ResetDefPlayer the DefaultPlayer properties will be restored from the saved settings
	if (UT2K4MatchInfo(M) != none)
	{
		if (UT2K4MatchInfo(M).TimeLimit > 0)
		{
			URL $= "?TimeLimit="$string(UT2K4MatchInfo(M).TimeLimit);
		}
	}
	return URL;
}

/** return a random or selected challenge game */
static function class<ChallengeGame> GetChallengeGame(optional string ClassName, optional UT2K4GameProfile GP)
{
	local array< class<ChallengeGame> > chalgames;
	local int i;
	//log("GetChallengeGame"@ClassName);
	if (ClassName == "")
	{
		chalgames = default.ChallengeGames;
		while (chalgames.length > 0)
		{
			i = rand(chalgames.length);
			if (chalgames[i].static.canChallenge(GP)) return chalgames[i];
			chalgames.Remove(i, 1);
		}
		return none;
	}
	for (i = 0; i < default.ChallengeGames.length; i++)
	{
		if (string(default.ChallengeGames[i]) ~= ClassName)
		{
			if (default.ChallengeGames[i].static.canChallenge(GP)) return default.ChallengeGames[i];
			return none;
		}
	}
	return none;
}

defaultproperties
{
	LID_DM=0
	LID_TDM=1
	LID_CTF=2
	LID_BR=3
	LID_DOM=4
	LID_AS=5
	LID_CHAMP=6

	// Single Player Qualification
	// Note: we always want ?TeamScreen=true in the url so our SP loading vignette will be used
	Begin Object Class=UT2K4MatchInfo Name=DM0
		LevelName="TUT-DM"
		MenuName="Deathmatch Tutorial"
		EnemyTeamName="xGame.UT2K4DMRoster"
		SpecialEvent=""
		DifficultyModifier=0.0
		GoalScore=10
		NumBots=0
		GameType="xGame.xDeathmatch"
		TimeLimit=15
		URLString="?Quickstart=true?TeamScreen=true"
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DM1
		LevelName="DM-1on1-Idoma"
		EnemyTeamName="xGame.UT2K4DMRoster"
		SpecialEvent=""
		DifficultyModifier=0.0
		GoalScore=10
		NumBots=1
		GameType="xGame.xDeathmatch"
		URLString="?WeaponStay=true?TeamScreen=true"
		PrizeMoney=150
		TimeLimit=10
		EntryFee=50
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DM2
		LevelName=""
		AltLevels(0)="DM-1on1-Spirit"
		AltLevels(1)="DM-1on1-Trite"
		EnemyTeamName="xGame.UT2K4DMRoster"
		SpecialEvent=""
		DifficultyModifier=0.2
		GoalScore=10
		NumBots=2
		GameType="xGame.xDeathmatch"
		URLString="?WeaponStay=true?TeamScreen=true"
		PrizeMoney=250
		TimeLimit=15
		EntryFee=75
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DM3
		LevelName=""
		AltLevels(0)="DM-1on1-Albatross"
		AltLevels(1)="DM-1on1-Roughinery"
		EnemyTeamName="xGame.UT2K4DMRoster"
		SpecialEvent=""
		DifficultyModifier=0.3
		GoalScore=15
		NumBots=2
		GameType="xGame.xDeathmatch"
		URLString="?WeaponStay=true?TeamScreen=true"
		PrizeMoney=500
		TimeLimit=15
		EntryFee=100
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DM4
		LevelName="DM-1on1-Desolation"
		EnemyTeamName="xGame.UT2K4DMRoster"
		SpecialEvent="BALANCE 2000;DRAFT" // get 1500 bonus from the sponsor to form a team
		DifficultyModifier=0.4
		GoalScore=15
		NumBots=4
		URLString="?WeaponStay=true?TeamScreen=true"
		GameType="xGame.xDeathmatch"
		PrizeMoney=650
		TimeLimit=15
		EntryFee=200
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DM5
		LevelName="DM-1on1-Irondust"
		EnemyTeamName="xGame.DMRosterBeatTeam"
		Requirements="FULLTEAM"
		SpecialEvent="OPEN TDM;QUALIFIED SINGLE"
		DifficultyModifier=0.5
		GoalScore=20
		NumBots=5
		URLString="?WeaponStay=true?TeamScreen=true"
		GameType="xGame.xDeathmatch"
		PrizeMoney=750
		TimeLimit=15
		EntryFee=250
	End Object
	DMMatches(0)=DM0
	DMMatches(1)=DM1
	DMMatches(2)=DM2
	DMMatches(3)=DM3
	DMMatches(4)=DM4
	DMMatches(5)=DM5

	/*
		Special info about the EnemyTeamName usage below:
		When the EnemyTeamName starts with a ';' it will apply special processing
		;<enemy team class>;<special flag>
		<enemy team class> has to be a subclass of xGame.UT2K4RosterGroup
		<special flag> is parsed in UT2K4GameProfile
	*/

	// Team Qualification
	Begin Object Class=UT2K4MatchInfo Name=TDM1
		LevelName=""
		AltLevels(0)="DM-Sulphur"
		AltLevels(1)="DM-Curse4"
		EnemyTeamName=";xGame.UT2K4TeamRosterEasy;least"
		SpecialEvent=""
		DifficultyModifier=0.5
		GoalScore=30
		NumBots=3
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
		TimeLimit=15
		PrizeMoney=500
	End Object
	Begin Object Class=UT2K4MatchInfo Name=TDM2
		LevelName=""
		AltLevels(0)="DM-Rankin"
		AltLevels(1)="DM-Rrajigar"
		EnemyTeamName=";xGame.UT2K4TeamRosterEasy;least"
		SpecialEvent=""
		DifficultyModifier=0.75
		GoalScore=40
		NumBots=5
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
		TimeLimit=20
		PrizeMoney=750
	End Object
	Begin Object Class=UT2K4MatchInfo Name=TDM3
		LevelName=""
		AltLevels(0)="DM-Corrugation"
		AltLevels(1)="DM-Antalus"
		EnemyTeamName=";xGame.UT2K4TeamRosterEasy;least"
		SpecialEvent=""
		Priority=1
		DifficultyModifier=1.0
		GoalScore=50
		NumBots=7
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
		TimeLimit=20
		PrizeMoney=1000
	End Object
	Begin Object Class=UT2K4MatchInfo Name=TDM4
		LevelName=""
		AltLevels(0)="DM-Morpheus3"
		AltLevels(1)="DM-Goliath"
		EnemyTeamName=";xGame.UT2K4TeamRosterEasy;best"
		SpecialEvent="OPEN DOM;QUALIFIED TEAM;UPDATETEAMS"
		DifficultyModifier=1.5
		GoalScore=60
		NumBots=9
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
		TimeLimit=20
		PrizeMoney=1250
	End Object
	TDMMatches(0)=TDM1
	TDMMatches(1)=TDM2
	TDMMatches(2)=TDM3
	TDMMatches(3)=TDM4

	// 8 CTF
	Begin Object Class=UT2K4MatchInfo Name=CTF1
		LevelName=""
		AltLevels(0)="CTF-FaceClassic"
		AltLevels(1)="CTF-Maul"
		AltLevels(2)="CTF-Citadel"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent=""
		DifficultyModifier=0.75
		GoalScore=2
		GameType="xGame.xCTFGame"
		NumBots=7
		URLString="?TeamScreen=true"
		PrizeMoney=1000
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=CTF2
		LevelName=""
		AltLevels(0)="CTF-Grendelkeep"
		AltLevels(1)="CTF-Magma"
		AltLevels(2)="CTF-Geothermal"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent="OPEN BR"
		DifficultyModifier=1.0
		GoalScore=2
		GameType="xGame.xCTFGame"
		NumBots=7
		URLString="?TeamScreen=true"
		PrizeMoney=1500
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=CTF3
		LevelName=""
		AltLevels(0)="CTF-Smote"
		AltLevels(1)="CTF-TwinTombs"
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent="UPDATETEAMS"
		DifficultyModifier=1.25
		GoalScore=3
		GameType="xGame.xCTFGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=1750
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=CTF4
		LevelName=""
		AltLevels(0)="CTF-Grassyknoll"
		AltLevels(1)="CTF-Avaris"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=1.5
		GoalScore=3
		GameType="xGame.xCTFGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=2000
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=CTF5
		LevelName=""
		AltLevels(0)="CTF-January"
		AltLevels(1)="CTF-Lostfaith"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=1.75
		GoalScore=3
		GameType="xGame.xCTFGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=2250
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=CTF6
		LevelName=""
		AltLevels(0)="CTF-MoonDragon"
		AltLevels(1)="CTF-Orbital2"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent="UPDATETEAMS"
		DifficultyModifier=2.0
		GoalScore=4
		GameType="xGame.xCTFGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=2500
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=CTF7
		LevelName="CTF-BridgeOfFate"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;least"
		SpecialEvent=""
		DifficultyModifier=2.25
		GoalScore=4
		GameType="xGame.xCTFGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=3000
		TimeLimit=25
	End Object
	Begin Object Class=UT2K4MatchInfo Name=CTF8
		LevelName=""
		AltLevels(0)="CTF-AbsoluteZero"
		AltLevels(1)="CTF-DoubleDammage"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;least"
		SpecialEvent="COMPLETED CTF;UPDATETEAMS"
		DifficultyModifier=2.5
		GoalScore=4
		GameType="xGame.xCTFGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=3500
		TimeLimit=25
	End Object
	CTFMatches(0)=CTF1
	CTFMatches(1)=CTF2
	CTFMatches(2)=CTF3
	CTFMatches(3)=CTF4
	CTFMatches(4)=CTF5
	CTFMatches(5)=CTF6
	CTFMatches(6)=CTF7
	CTFMatches(7)=CTF8

	// 6 DDOM
	Begin Object Class=UT2K4MatchInfo Name=DOM1
		LevelName=""
		AltLevels(0)="DOM-Atlantis"
		AltLevels(1)="DOM-ScorchedEarth"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent=""
		DifficultyModifier=0.75
		GoalScore=2
		NumBots=5
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
		PrizeMoney=1000
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DOM2
		LevelName=""
		AltLevels(0)="DOM-Renascent"
		AltLevels(1)="DOM-Junkyard"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent="OPEN CTF"
		DifficultyModifier=1.25
		GoalScore=2
		NumBots=5
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
		PrizeMoney=1500
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DOM3
		LevelName=""
		AltLevels(0)="DOM-Access"
		AltLevels(1)="DOM-Outrigger"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent="UPDATETEAMS"
		DifficultyModifier=1.75
		GoalScore=2
		NumBots=7
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
		PrizeMoney=2000
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DOM4
		LevelName=""
		AltLevels(0)="DOM-Ruination"
		AltLevels(1)="DOM-Suntemple"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=2.0
		GoalScore=3
		NumBots=9
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
		PrizeMoney=2500
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DOM5
		LevelName=""
		AltLevels(0)="DOM-Conduit"
		AltLevels(1)="DOM-Core"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent="UPDATETEAMS"
		DifficultyModifier=2.25
		GoalScore=3
		NumBots=9
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
		PrizeMoney=3000
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=DOM6
		LevelName=""
		AltLevels(0)="DOM-Aswan"
		AltLevels(1)="DOM-SepukkuGorge"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;least"
		SpecialEvent="COMPLETED DOM;UPDATETEAMS"
		DifficultyModifier=2.5
		GoalScore=3
		NumBots=9
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
		PrizeMoney=3500
		TimeLimit=20
	End Object
	DOMMatches(0)=DOM1
	DOMMatches(1)=DOM2
	DOMMatches(2)=DOM3
	DOMMatches(3)=DOM4
	DOMMatches(4)=DOM5
	DOMMatches(5)=DOM6

	// 8 BR
	Begin Object Class=UT2K4MatchInfo Name=BR1
		LevelName="BR-Serenity"
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent=""
		DifficultyModifier=0.75
		GoalScore=15
		GameType="xGame.xBombingRun"
		NumBots=5
		URLString="?TeamScreen=true"
		PrizeMoney=1000
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=BR2
		AltLevels(0)="BR-Bifrost"
		AltLevels(1)="BR-Anubis"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent="OPEN AS"
		DifficultyModifier=1.0
		GoalScore=15
		GameType="xGame.xBombingRun"
		NumBots=7
		URLString="?TeamScreen=true"
		PrizeMoney=1500
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=BR3
		LevelName=""
		AltLevels(0)="BR-Canyon"
		AltLevels(1)="BR-DE-ElecFields"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent="UPDATETEAMS"
		DifficultyModifier=1.25
		GoalScore=20
		GameType="xGame.xBombingRun"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=2000
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=BR4
		LevelName="BR-Disclosure"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=1.5
		GoalScore=20
		GameType="xGame.xBombingRun"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=2250
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=BR5
		LevelName="BR-TwinTombs"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=1.75
		GoalScore=25
		GameType="xGame.xBombingRun"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=2500
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=BR6
		LevelName="BR-IceFields"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent="UPDATETEAMS"
		DifficultyModifier=2.0
		GoalScore=25
		GameType="xGame.xBombingRun"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=2750
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=BR7
		AltLevels(0)="BR-Skyline"
		AltLevels(1)="BR-BridgeOfFate"
		Priority=1
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;least"
		SpecialEvent=""
		DifficultyModifier=2.25
		GoalScore=30
		GameType="xGame.xBombingRun"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=3000
		TimeLimit=25
	End Object
	Begin Object Class=UT2K4MatchInfo Name=BR8
		LevelName="BR-Colossus"
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;least"
		SpecialEvent="COMPLETED BR;UPDATETEAMS"
		DifficultyModifier=2.5
		GoalScore=30
		GameType="xGame.xBombingRun"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=3500
		TimeLimit=25
	End Object
	BRMatches(0)=BR1
	BRMatches(1)=BR2
	BRMatches(2)=BR3
	BRMatches(3)=BR4
	BRMatches(4)=BR5
	BRMatches(5)=BR6
	BRMatches(6)=BR7
	BRMatches(7)=BR8

	// 6 AS
	Begin Object Class=UT2K4MatchInfo Name=AS1
		LevelName="AS-FallenCity"
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent=""
		DifficultyModifier=0.75
		GoalScore=0
		GameType="UT2k4Assault.ASGameInfo"
		NumBots=9
		URLString="?TeamScreen=true?FirstAttackingTeam=1?RoundTimeLimit=10?ReinforcementsFreq=7?RoundLimit=1"
		PrizeMoney=1500
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=AS2
		LevelName="AS-RobotFactory"
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent="UPDATETEAMS"
		DifficultyModifier=1.25
		GoalScore=0
		GameType="UT2k4Assault.ASGameInfo"
		NumBots=9
		URLString="?TeamScreen=true?FirstAttackingTeam=1?RoundTimeLimit=11?ReinforcementsFreq=7?RoundLimit=1"
		PrizeMoney=1750
		TimeLimit=15
	End Object
	Begin Object Class=UT2K4MatchInfo Name=AS3
		LevelName="AS-Convoy"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=1.75
		GoalScore=0
		GameType="UT2k4Assault.ASGameInfo"
		NumBots=9
		URLString="?TeamScreen=true?FirstAttackingTeam=1?RoundTimeLimit=12?ReinforcementsFreq=7?RoundLimit=1"
		PrizeMoney=2000
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=AS4
		LevelName="AS-Glacier"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=2.0
		GoalScore=0
		GameType="UT2k4Assault.ASGameInfo"
		NumBots=9
		URLString="?TeamScreen=true?FirstAttackingTeam=1?RoundTimeLimit=13?ReinforcementsFreq=7?RoundLimit=1"
		PrizeMoney=2500
		TimeLimit=25
	End Object
	Begin Object Class=UT2K4MatchInfo Name=AS5
		LevelName="AS-Junkyard"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent="UPDATETEAMS"
		DifficultyModifier=2.25
		GoalScore=0
		GameType="UT2k4Assault.ASGameInfo"
		NumBots=9
		URLString="?TeamScreen=true?FirstAttackingTeam=1?RoundTimeLimit=14?ReinforcementsFreq=7?RoundLimit=1"
		PrizeMoney=3000
		TimeLimit=30
	End Object
	Begin Object Class=UT2K4MatchInfo Name=AS6
		LevelName="AS-MotherShip"
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;least"
		SpecialEvent="COMPLETED AS;UPDATETEAMS"
		DifficultyModifier=2.5
		GoalScore=0
		GameType="UT2k4Assault.ASGameInfo"
		NumBots=9
		URLString="?TeamScreen=true?FirstAttackingTeam=1?RoundTimeLimit=15?ReinforcementsFreq=7?RoundLimit=1"
		PrizeMoney=3500
		TimeLimit=30
	End Object
	ASMatches(0)=AS1
	ASMatches(1)=AS2
	ASMatches(2)=AS3
	ASMatches(3)=AS4
	ASMatches(4)=AS5
	ASMatches(5)=AS6

	// 2 Champ
	Begin Object Class=UT2K4MatchInfo Name=CHAMP1
		LevelName="DM-Deck17"
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;final"
		SpecialEvent=""
		DifficultyModifier=3.0
		GoalScore=35
		GameType="xGame.xTeamGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=5000
	End Object
	Begin Object Class=UT2K4MatchInfo Name=CHAMP2
		LevelName="DM-HyperBlast2"
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;final"
		SpecialEvent="COMPLETED CHAMP"
		DifficultyModifier=3.0 // gametype will take care of this
		GoalScore=20
		GameType="xGame.BossDM"
		NumBots=1
		URLString="?TeamScreen=true"
		PrizeMoney=10000
	End Object
	ChampionshipMatches(0)=CHAMP1
	ChampionshipMatches(1)=CHAMP2

	ChallengeGames(0)=class'xGame.BloodRites'
	ChallengeGames(1)=class'xGame.ManoEMano'

	//AdditionalLadders(0)=class'xGame.CLOnslaught' // if you find you may use it
}
