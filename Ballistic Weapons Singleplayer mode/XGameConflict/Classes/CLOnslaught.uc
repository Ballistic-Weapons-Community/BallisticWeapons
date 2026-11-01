//==============================================================================
// Custom Ladder class: Onslaught
//
// Written by Michiel Hendriks
// (c) 2003, 2004, Epic Games, Inc. All Rights Reserved
//==============================================================================

class CLOnslaught extends CustomLadderInfo;

defaultproperties
{
	LadderName="Onslaught"

	EntryLabels(0)="Hit & Run"
	EntryLabels(1)="Roadkill"
	EntryLabels(2)="Drive-by shooting"
	EntryLabels(3)="Road warrior"
	EntryLabels(4)="Core meltdown"
	EntryLabels(5)="Vehicle slaughter"

	Begin Object Class=UT2K4MatchInfo Name=ONS1
		LevelName=""
		AltLevels(0)="ONS-FrostBite"
		AltLevels(1)="ONS-Primeval"
		EnemyTeamName=";xGame.UT2K4TeamRosterWeak;least"
		SpecialEvent=""
		DifficultyModifier=2
		GoalScore=1
		GameType="Onslaught.ONSOnslaughtGame"
		NumBots=5
		URLString="?TeamScreen=true"
		PrizeMoney=3000
		TimeLimit=16
	End Object
	Begin Object Class=UT2K4MatchInfo Name=ONS2
		LevelName=""
		AltLevels(0)="ONS-Dawn"
		AltLevels(1)="ONS-Torlan"
		EnemyTeamName=";xGame.UT2K4TeamRosterEasy;least"
		SpecialEvent=""
		DifficultyModifier=2.25
		GoalScore=1
		GameType="Onslaught.ONSOnslaughtGame"
		NumBots=5
		URLString="?TeamScreen=true"
		PrizeMoney=4000
		TimeLimit=18
	End Object
	Begin Object Class=UT2K4MatchInfo Name=ONS3
		LevelName=""
		AltLevels(0)="ONS-ArcticStronghold"
		AltLevels(1)="ONS-Crossfire"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=2.5
		GoalScore=1
		GameType="Onslaught.ONSOnslaughtGame"
		NumBots=7
		URLString="?TeamScreen=true"
		PrizeMoney=5000
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=ONS4
		LevelName="ONS-Dria"
		EnemyTeamName=";xGame.UT2K4TeamRosterMid;least"
		SpecialEvent=""
		DifficultyModifier=2.75
		GoalScore=1
		GameType="Onslaught.ONSOnslaughtGame"
		NumBots=7
		URLString="?TeamScreen=true"
		PrizeMoney=6000
		TimeLimit=20
	End Object
	Begin Object Class=UT2K4MatchInfo Name=ONS5
		LevelName="ONS-RedPlanet"
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;least"
		SpecialEvent=""
		DifficultyModifier=3
		GoalScore=2
		GameType="Onslaught.ONSOnslaughtGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=7000
		TimeLimit=25
	End Object
	Begin Object Class=UT2K4MatchInfo Name=ONS6
		LevelName="ONS-Severance"
		EnemyTeamName=";xGame.UT2K4TeamRosterStrong;least"
		SpecialEvent=""
		DifficultyModifier=3
		GoalScore=2
		GameType="Onslaught.ONSOnslaughtGame"
		NumBots=9
		URLString="?TeamScreen=true"
		PrizeMoney=8000
		TimeLimit=30
	End Object
	Matches(0)=ONS1
	Matches(1)=ONS2
	Matches(2)=ONS3
	Matches(3)=ONS4
	Matches(4)=ONS5
	Matches(5)=ONS6
}
