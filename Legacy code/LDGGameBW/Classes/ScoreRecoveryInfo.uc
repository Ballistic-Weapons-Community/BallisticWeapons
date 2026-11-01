class ScoreRecoveryInfo extends Info
	dependson(BallisticPlayerReplicationInfo);

var PlayerController PC;

//In PlayerReplicationInfo (Adrenaline in PlayerController)
var int Score, Kills, GoalsScored;
var float Deaths, Adrenaline; //Why the heck is Deaths a float? Since when are players half death? >_<

//In TeamPlayerReplicationInfo
var int StartTime, FlagTouches, FlagReturns, Suicides, flakcount, combocount, headcount, ranovercount, DaredevilPoints;
var bool bFirstBlood;
var byte Spree[6], MultiKills[7], Combos[5];
var array<TeamPlayerReplicationinfo.WeaponStats> WeaponStatsArray;
var array<TeamPlayerReplicationinfo.VehicleStats> VehicleStatsArray;

//In ASPlayerReplicationInfo
var byte DisabledObjectivesCount, DisabledFinalObjective, DestroyedVehicles;

var string ColoredName; //only saved
var float MatchTime; // only saved

var int DamR;
var int DamG;
var int RealKills;
var int RealDeaths;
var int BalancerSwitches;

var int KillSpectrumIndex;
var array<float> KillSpectrum;

var float ThawPoints;
var bool bExcludedFromRanking;
var bool bAdminExcludedFromRanking;
var bool bHideSkill;

//BWPRI
var array<BallisticPlayerReplicationInfo.HitStat> HitStats[10];
var int SGDamage;
var int HeadShots;
var float AveragePercent;

var byte RewardLevel; // Streak in reserve
var byte ActiveStreak; // Currently active streak

//In Misc_PRI
var int EnemyDamage;            // damage done to enemies - NR
var int AllyDamage;             // damage done to allies and self - NR
var float ReverseFF;            // percentage of friendly fire that is returned - NR

var int FlawlessCount;          // number of flawless victories - NR
var int OverkillCount;          // number of overkills - NR
var int DarkHorseCount;         // number of darkhorses - NR

var float DarkSoulPower; 	// Dark Star soul power - NR
var float NovaSoulPower; 	// Nova Staff soul power - NR

var int JoinRound;              // the round the player joined on
var int	ReWarnTime;
var int WaterReWarnTime;

function RecoverStats(PlayerController ThisPC)
{
	local TeamPlayerReplicationInfo TPRI;
	local ASPlayerReplicationInfo ASPRI;
	local BallisticPlayerReplicationInfo BWPRI;
	local KillstreakLRI KLRI;
	local Misc_PRI MPRI;
	local UTComp_PRI uPRI;
	local int i;

	PC = ThisPC;
	
	PC.PlayerReplicationInfo.Score = Score;
	PC.PlayerReplicationInfo.Kills = Kills;
	PC.PlayerReplicationInfo.Deaths = Deaths;
	PC.PlayerReplicationInfo.GoalsScored = GoalsScored;
	PC.Adrenaline += Min(Adrenaline, 100);

	PC.PlayerReplicationInfo.StartTime = Level.Game.GameReplicationInfo.ElapsedTime - StartTime;

	if(TeamPlayerReplicationInfo(PC.PlayerReplicationInfo) != None)
	{
		TPRI = TeamPlayerReplicationInfo(PC.PlayerReplicationInfo);

		TPRI.FlagTouches = FlagTouches;
		TPRI.FlagReturns = FlagReturns;
		TPRI.Suicides = Suicides;
		TPRI.flakcount = flakcount;
		TPRI.combocount = combocount;
		TPRI.headcount = headcount;
		TPRI.ranovercount = ranovercount;
		TPRI.DaredevilPoints = DaredevilPoints;
		TPRI.bFirstBlood = bFirstBlood;

		for(i=0; i<7; i++)
		{
			if(i < 5)
				TPRI.Combos[i] = Combos[i];
			if(i < 6)
				TPRI.Spree[i] = Spree[i];
			
			TPRI.MultiKills[i] = MultiKills[i];
		}

		for(i=0; i<WeaponStatsArray.Length; i++)
			TPRI.WeaponStatsArray[i] = WeaponStatsArray[i];
		
		for(i=0; i<VehicleStatsArray.Length; i++)
			TPRI.VehicleStatsArray[i] = VehicleStatsArray[i];

		if(ASPlayerReplicationInfo(TPRI) != None)
		{
			ASPRI = ASPlayerReplicationInfo(PC.PlayerReplicationInfo);
			
			ASPRI.DisabledObjectivesCount = DisabledObjectivesCount;
			ASPRI.DisabledFinalObjective = DisabledFinalObjective;
			ASPRI.DestroyedVehicles = DestroyedVehicles;
		}
		
		BWPRI = class'Mut_Ballistic'.static.GetBPRI(TPRI);
		
		if (BWPRI != None)
		{
			for (i = 0; i < 10; i++)
				BWPRI.HitStats[i] = HitStats[i];
				
			BWPRI.SGDamage = SGDamage;
			BWPRI.HeadShots = HeadShots;
			BWPRI.AveragePercent = AveragePercent;
		}
		
		KLRI = class'Mut_Killstreak'.static.GetKLRI(TPRI);
		
		if (KLRI != None)
		{
			KLRI.RewardLevel = RewardLevel;
		}
			
		if (Misc_PRI(TPRI) != None)
		{
			MPRI = Misc_PRI(TPRI);
			
			MPRI.EnemyDamage = EnemyDamage;
			MPRI.AllyDamage = AllyDamage;
			MPRI.ReverseFF = ReverseFF;

			MPRI.FlawlessCount = FlawlessCount;
			MPRI.OverkillCount = OverkillCount;
			MPRI.DarkHorseCount = DarkHorseCount;
			
			MPRI.DarkSoulPower = DarkSoulPower;
			MPRI.NovaSoulPower = NovaSoulPower;
			
			MPRI.JoinRound = JoinRound;
			
			MPRI.ReWarnTime = ReWarnTime;
			MPRI.WaterReWarnTime = WaterReWarnTime;
		}
	}
	
	uPRI = class'UTComp_Util'.static.GetUTCompPRI(PC.PlayerReplicationInfo);
	if (uPRI != None)
	{
		uPRI.DamR = DamR;
		uPRI.DamG = DamG;
		uPRI.RealKills = RealKills;
		uPRI.RealDeaths = RealDeaths;
		uPRI.BalancerSwitches = BalancerSwitches;
		
		if (UTComp_PRI_BW_FR_LDG(uPRI) != None)
		{
			UTComp_PRI_BW_FR_LDG(uPRI).ThawPoints = ThawPoints;
			UTComp_PRI_BW_FR_LDG(uPRI).bExcludedFromRanking = bExcludedFromRanking;
			UTComp_PRI_BW_FR_LDG(uPRI).bAdminExcludedFromRanking = bAdminExcludedFromRanking;
			UTComp_PRI_BW_FR_LDG(uPRI).bHideSkill = bHideSkill;
			
			UTComp_PRI_BW_FR_LDG(uPRI).KillSpectrumIndex = KillSpectrumIndex;
			UTComp_PRI_BW_FR_LDG(uPRI).KillSpectrum = KillSpectrum;
		}
	}
	
}

function SaveStats()
{
	local TeamPlayerReplicationInfo TPRI;
	local ASPlayerReplicationInfo ASPRI;
	local BallisticPlayerReplicationInfo BWPRI;
	local KillstreakLRI KLRI;
	local Misc_PRI MPRI;
	local UTComp_PRI uPRI;
	local int i;

	StartTime = Level.Game.GameReplicationInfo.ElapsedTime - PC.PlayerReplicationInfo.StartTime; //how long he's played
	if (!PC.PlayerReplicationInfo.bOnlySpectator)
		MatchTime = StartTime;

	Score = PC.PlayerReplicationInfo.Score;
	Kills = PC.PlayerReplicationInfo.Kills;
	Deaths = PC.PlayerReplicationInfo.Deaths;
	GoalsScored = PC.PlayerReplicationInfo.GoalsScored;
	Adrenaline = PC.Adrenaline;

	if(TeamPlayerReplicationInfo(PC.PlayerReplicationInfo) != None)
	{
		TPRI = TeamPlayerReplicationInfo(PC.PlayerReplicationInfo);

		FlagTouches = TPRI.FlagTouches;
		FlagReturns = TPRI.FlagReturns;
		Suicides = TPRI.Suicides;
		flakcount = TPRI.flakcount;
		combocount = TPRI.combocount;
		headcount = TPRI.headcount;
		ranovercount = TPRI.ranovercount;
		DaredevilPoints = TPRI.DaredevilPoints;
		bFirstBlood = TPRI.bFirstBlood;

		for(i=0; i<7; i++)
		{
			if(i < 5)
				Combos[i] = TPRI.Combos[i];
			if(i < 6)
				Spree[i] = TPRI.Spree[i];
				
			MultiKills[i] = TPRI.MultiKills[i];
		}

		for(i=0; i<TPRI.WeaponStatsArray.Length; i++)
			WeaponStatsArray[i] = TPRI.WeaponStatsArray[i];
		for(i=0; i<TPRI.VehicleStatsArray.Length; i++)
			VehicleStatsArray[i] = TPRI.VehicleStatsArray[i];

		if(ASPlayerReplicationInfo(TPRI) != None)
		{
			ASPRI = ASPlayerReplicationInfo(PC.PlayerReplicationInfo);
			
			DisabledObjectivesCount = ASPRI.DisabledObjectivesCount;
			DisabledFinalObjective = ASPRI.DisabledFinalObjective;
			DestroyedVehicles = ASPRI.DestroyedVehicles;
		}
		
		BWPRI = class'Mut_Ballistic'.static.GetBPRI(TPRI);
		
		if (BWPRI != None)
		{
			for (i = 0; i < 10; i++)
				HitStats[i] = BWPRI.HitStats[i];
				
			SGDamage = BWPRI.SGDamage;
			HeadShots = BWPRI.HeadShots;
			AveragePercent = BWPRI.AveragePercent;
		}
		
		KLRI = class'Mut_Killstreak'.static.GetKLRI(TPRI);
		
		if (KLRI != None)
		{
			RewardLevel = KLRI.RewardLevel;
		}
			
		if (Misc_PRI(TPRI) != None)
		{
			MPRI = Misc_PRI(TPRI);
			
			EnemyDamage = MPRI.EnemyDamage;
			AllyDamage = MPRI.AllyDamage;
			ReverseFF = MPRI.ReverseFF;

			FlawlessCount = MPRI.FlawlessCount;
			OverkillCount = MPRI.OverkillCount;
			DarkHorseCount = MPRI.DarkHorseCount;
			
			DarkSoulPower = MPRI.DarkSoulPower;
			NovaSoulPower = MPRI.NovaSoulPower;

			JoinRound = MPRI.JoinRound;
			
			ReWarnTime = MPRI.ReWarnTime;
			WaterReWarnTime = MPRI.WaterReWarnTime;
		}
		
	}
	
	uPRI = class'UTComp_Util'.static.GetUTCompPRI(PC.PlayerReplicationInfo);
	if (uPRI != None)
	{
		if (uPRI.ColoredName != "")
			ColoredName = uPRI.ColoredName;
		else
			ColoredName = TPRI.PlayerName;
		
	  DamR = uPRI.DamR;
	  DamG = uPRI.DamG;
	  RealKills = uPRI.RealKills;
	  RealDeaths = uPRI.RealDeaths;
	  BalancerSwitches = uPRI.BalancerSwitches;
	  
	  if (UTComp_PRI_BW_FR_LDG(uPRI) != None)
	  {
	  	ThawPoints = UTComp_PRI_BW_FR_LDG(uPRI).ThawPoints;
	  	bExcludedFromRanking = UTComp_PRI_BW_FR_LDG(uPRI).bExcludedFromRanking;
	  	bAdminExcludedFromRanking = UTComp_PRI_BW_FR_LDG(uPRI).bAdminExcludedFromRanking;
	  	bHideSkill = UTComp_PRI_BW_FR_LDG(uPRI).bHideSkill;
	  	
	  	KillSpectrumIndex = UTComp_PRI_BW_FR_LDG(uPRI).KillSpectrumIndex;
			KillSpectrum = UTComp_PRI_BW_FR_LDG(uPRI).KillSpectrum;
	  }
	}
}

defaultproperties
{
}
