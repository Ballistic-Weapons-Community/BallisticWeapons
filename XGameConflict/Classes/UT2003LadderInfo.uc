class UT2003LadderInfo extends LadderInfo;

/*
 * This class contains the single player ladder for UT2003 PC.
 * See Engine.LadderInfo for details.
 *
 * created by:  Capps 8/20/02
 */
 
// These are listed again here for convenience; they appear in Engine.LadderInfo
//const DMLadderIndex = 0;
//const TDMLadderIndex = 1;
//const DOMLadderIndex = 2;
//const CTFLadderIndex = 3;
//const BRLadderIndex = 4;
//const ChampionshipLadderIndex = 5;

defaultproperties {

/////////////////////////////// DM LADDER /////////////////////////////
	OpenNextLadderAtRung(0)=5
    Begin Object Class=MatchInfo Name=DM0
		LevelName="TUT-DM"
		MenuName="Deathmatch Tutorial"
		EnemyTeamName="xGame.DMRosterTrainingDay"
		SpecialEvent=""
		DifficultyModifier=0.0
		GoalScore=10
		NumBots=0
		GameType="xGame.xDeathmatch"	
		URLString="?Quickstart=true"
    End Object
    Begin Object Class=MatchInfo Name=DM1
		LevelName="DM-TrainingDay"
		EnemyTeamName="xGame.DMRosterTrainingDay"
		SpecialEvent=""
		DifficultyModifier=-0.3
		GoalScore=10
		NumBots=1
		GameType="xGame.xDeathmatch"	
		URLString="?WeaponStay=true"
    End Object
    Begin Object Class=MatchInfo Name=DM2
		LevelName="DM-Gael"
		EnemyTeamName="xGame.DMRosterGael"
		SpecialEvent=""
		DifficultyModifier=0.2
		GoalScore=10
		NumBots=1
		GameType="xGame.xDeathmatch"	
		URLString="?WeaponStay=true"
    End Object
    Begin Object Class=MatchInfo Name=DM3
		LevelName="DM-Leviathan"
		EnemyTeamName="xGame.DMRosterLeviathan"
		SpecialEvent=""
		DifficultyModifier=0.5
		GoalScore=15
		NumBots=2
		GameType="xGame.xDeathmatch"	
		URLString="?WeaponStay=true"
    End Object
    Begin Object Class=MatchInfo Name=DM4
		LevelName="DM-Oceanic"
		EnemyTeamName="xGame.DMRosterOceanic"
		SpecialEvent="DRAFT"
		DifficultyModifier=0.1  // very tough map at high skill levels
		GoalScore=15
		NumBots=4
		URLString="?WeaponStay=true"
		GameType="xGame.xDeathmatch"	
    End Object
    Begin Object Class=MatchInfo Name=DM5
		LevelName="DM-Phobos2"
		EnemyTeamName="xGame.DMRosterBeatTeam"
		SpecialEvent="TDM OPENED"
		DifficultyModifier=0.5
		GoalScore=20
		NumBots=7
		URLString="?WeaponStay=true"
		GameType="xGame.xDeathmatch"	
    End Object
    DMMatches(0)=MatchInfo'DM0'
    DMMatches(1)=MatchInfo'DM1'
    DMMatches(2)=MatchInfo'DM2'
    DMMatches(3)=MatchInfo'DM3'
    DMMatches(4)=MatchInfo'DM4'
    DMMatches(5)=MatchInfo'DM5'
	
/////////////////////////////// TDM LADDER ////////////////////////////
/*
	TDM1	Insidious	2v2	first to 10
	TDM2	Curse		2v2	first to 15
	TDM3	Antalus		3v3	first to 15
	TDM4	Plunge		4v4	first to 20
	TDM5	Asbestos	4v4	first to 20
	TDM6	Tokara		5v5	first to 25
*/
	
	OpenNextLadderAtRung(1)=3
    Begin Object Class=MatchInfo Name=TDM1
		LevelName="DM-Insidious"
		EnemyTeamName="xGame.TeamSupernova"
		SpecialEvent="TRADE Remus"
		DifficultyModifier=0.5
		GoalScore=10
		NumBots=3
		GameType="xGame.xTeamGame"	
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=TDM2
		LevelName="DM-Curse3"
		EnemyTeamName="xGame.TeamCrusaders"
		SpecialEvent=""
		DifficultyModifier=0.75
		GoalScore=15
		NumBots=7
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=TDM3
		LevelName="DM-Antalus"
		EnemyTeamName="xGame.TeamSunBlades"
		SpecialEvent="TRADE Cannonball"
		DifficultyModifier=1.0
		GoalScore=15
		NumBots=7
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=TDM4
		LevelName="DM-Plunge"
		EnemyTeamName="xGame.TeamDragonBreath"
		SpecialEvent="DOM OPENED"
		DifficultyModifier=1.25
		GoalScore=20
		NumBots=7
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=TDM5
		LevelName="DM-Asbestos"
		EnemyTeamName="xGame.TeamBoneCrushers"
		SpecialEvent="TRADE Horus"
		DifficultyModifier=1.5
		GoalScore=20
		NumBots=9
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=TDM6
		LevelName="DM-TokaraForest"
		EnemyTeamName="xGame.TeamVenom"
		SpecialEvent="TDM COMPLETE"
		DifficultyModifier=2.0
		GoalScore=25
		NumBots=9
		GameType="xGame.xTeamGame"
		URLString="?TeamScreen=true"
    End Object
    TDMMatches(0)=MatchInfo'TDM1'
    TDMMatches(1)=MatchInfo'TDM2'
    TDMMatches(2)=MatchInfo'TDM3'
    TDMMatches(3)=MatchInfo'TDM4'
    TDMMatches(4)=MatchInfo'TDM5'
    TDMMatches(5)=MatchInfo'TDM6'
    
/////////////////////////////// DOM LADDER ////////////////////////////
	OpenNextLadderAtRung(2)=2

    Begin Object Class=MatchInfo Name=DOM1
		LevelName="DOM-ScorchedEarth"
		EnemyTeamName="xGame.TeamWarCry"
		SpecialEvent="TRADE Damarus"
		DifficultyModifier=0.5
		GoalScore=3
		NumBots=5
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
	End Object	
    Begin Object Class=MatchInfo Name=DOM2
		LevelName="DOM-Core"
		EnemyTeamName="xGame.TeamBoneCrushers"
		SpecialEvent=""
		DifficultyModifier=0.75
		GoalScore=3
		NumBots=5
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
	End Object	
    Begin Object Class=MatchInfo Name=DOM3
		LevelName="DOM-SepukkuGorge"
		EnemyTeamName="xGame.TeamFirestorm"
		SpecialEvent="CTF OPENED"
		DifficultyModifier=1.25
		GoalScore=3
		NumBots=9
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
	End Object	
    Begin Object Class=MatchInfo Name=DOM4
		LevelName="DOM-Suntemple"
		EnemyTeamName="xGame.TeamApocalypse"
		SpecialEvent="TRADE Faraleth"
		DifficultyModifier=1.75
		GoalScore=4
		NumBots=9
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
	End Object	
    Begin Object Class=MatchInfo Name=DOM5
		LevelName="DOM-Outrigger"
		EnemyTeamName="xGame.TeamBlackLegion"
		SpecialEvent="DOM COMPLETE"
		DifficultyModifier=2.0
		GoalScore=4
		NumBots=9
		GameType="xGame.xDoubleDom"
		URLString="?TeamScreen=true"
	End Object	
	
	DOMMatches(0)=MatchInfo'DOM1'
    DOMMatches(1)=MatchInfo'DOM2'
    DOMMatches(2)=MatchInfo'DOM3'
    DOMMatches(3)=MatchInfo'DOM4'
    DOMMatches(4)=MatchInfo'DOM5'
/////////////////////////////// CTF LADDER ////////////////////////////
	OpenNextLadderAtRung(3)=3
    Begin Object Class=MatchInfo Name=CTF1
		LevelName="CTF-Maul"
		EnemyTeamName="xGame.TeamNightstalkers"
		SpecialEvent="TRADE Subversa"
		DifficultyModifier=0.5
		GoalScore=3
		GameType="xGame.xCTFGame"	
		NumBots=5
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=CTF2
		LevelName="CTF-Citadel"
		EnemyTeamName="xGame.TeamVenom"
		SpecialEvent=""
		DifficultyModifier=1.0
		GoalScore=3
		GameType="xGame.xCTFGame"	
		NumBots=7
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=CTF3
		LevelName="CTF-Chrome"
		EnemyTeamName="xGame.TeamBlackLegion"
		SpecialEvent="TRADE Lilith"
		DifficultyModifier=1.25
		GoalScore=3
		GameType="xGame.xCTFGame"	
		NumBots=7
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=CTF4
		LevelName="CTF-Geothermal"
		EnemyTeamName="xGame.TeamBloodFists"
		SpecialEvent="BR OPENED"
		DifficultyModifier=1.75
		GoalScore=4
		GameType="xGame.xCTFGame"	
		NumBots=7
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=CTF5
		LevelName="CTF-Lostfaith"
		EnemyTeamName="xGame.TeamIronGuard"
		SpecialEvent=""
		DifficultyModifier=2.0
		GoalScore=4
		GameType="xGame.xCTFGame"	
		NumBots=9
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=CTF6
		LevelName="CTF-Face3"
		EnemyTeamName="xGame.TeamColdSteel"
		SpecialEvent="CTF COMPLETE"
		DifficultyModifier=2.5
		GoalScore=4
		GameType="xGame.xCTFGame"	
		NumBots=9
		URLString="?TeamScreen=true"
    End Object
    CTFMatches(0)=MatchInfo'CTF1'
    CTFMatches(1)=MatchInfo'CTF2'
    CTFMatches(2)=MatchInfo'CTF3'
    CTFMatches(3)=MatchInfo'CTF4'
    CTFMatches(4)=MatchInfo'CTF5'
    CTFMatches(5)=MatchInfo'CTF6'
/////////////////////////////// BR LADDER /////////////////////////////
	OpenNextLadderAtRung(4)=2

    Begin Object Class=MatchInfo Name=BR1
		LevelName="BR-TwinTombs"
		EnemyTeamName="xGame.TeamVenom"
		SpecialEvent="TRADE Syzygy"
		DifficultyModifier=0.75
		GoalScore=15
		GameType="xGame.xBombingRun"	
		NumBots=5
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=BR2
		LevelName="BR-Disclosure"
		EnemyTeamName="xGame.TeamBlackLegion"
		SpecialEvent=""
		DifficultyModifier=1.0
		GoalScore=15
		GameType="xGame.xBombingRun"	
		NumBots=7
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=BR3
		LevelName="BR-Bifrost"
		EnemyTeamName="xGame.TeamColdSteel"
		SpecialEvent="TRADE Corrosion"
		DifficultyModifier=1.5
		GoalScore=20
		GameType="xGame.xBombingRun"	
		NumBots=7
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=BR4
		LevelName="BR-Anubis"
		EnemyTeamName="xGame.TeamBloodFists"
		SpecialEvent=""
		DifficultyModifier=2.0
		GoalScore=20
		GameType="xGame.xBombingRun"	
		NumBots=9
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=BR5
		LevelName="BR-Skyline"
		EnemyTeamName="xGame.TeamPainMachine"
		SpecialEvent="BR COMPLETE"
		DifficultyModifier=2.5
		GoalScore=20
		GameType="xGame.xBombingRun"	
		NumBots=9
		URLString="?TeamScreen=true"
    End Object

	BRMatches(0)=MatchInfo'BR1'
    BRMatches(1)=MatchInfo'BR2'
    BRMatches(2)=MatchInfo'BR3'
    BRMatches(3)=MatchInfo'BR4'
    BRMatches(4)=MatchInfo'BR5'
/////////////////////////////// CHAMPIONSHIP LADDER //////////////////////////
    Begin Object Class=MatchInfo Name=CHAMP1
		LevelName="DM-Compressed"  
		MenuName="Tournament Semi-Final"
		EnemyTeamName="xGame.ChampRosterSemiFinal"
		SpecialEvent=""
		DifficultyModifier=2.75
		GoalScore=20
		NumBots=5
		GameType="xGame.xTeamGame"	
		URLString="?TeamScreen=true"
    End Object
    Begin Object Class=MatchInfo Name=CHAMP2
		LevelName="DM-1on1-Serpentine"
		MenuName="Tournament Final"
		EnemyTeamName="xGame.ChampRosterFinal"
		SpecialEvent="CHAMPIONSHIP COMPLETE"
		DifficultyModifier=0.0
		GoalScore=10
		NumBots=1
		GameType="xGame.BossDM"	
		URLString="?TeamScreen=false"
    End Object
    ChampionshipMatches(0)=MatchInfo'CHAMP1'
    ChampionshipMatches(1)=MatchInfo'CHAMP2'
}