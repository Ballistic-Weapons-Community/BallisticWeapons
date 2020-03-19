class LDGBallisticFR_CTFMapsTracked extends LDGBallisticFR_CTFMaps;

//BEGIN_TRACKED_IMPL
struct PendingControllers
{
	var PlayerController PC;
	var string PlayerFlags;
};

var array<PendingControllers> PendingPC;
var bool bAlreadySaved;
var string MatchStart;
var config bool bAllowViewingOfSkill;

event InitGame( string Options, out string Error )
{
	MatchStart = Right("0" $ Level.Hour, 2) $ ":" $ Right("0" $ Level.Minute, 2);
	Super.InitGame(Options, Error);
}

function ReceivedPlayerFlags(PlayerController PC, string PlayerFlags)
{
	local int db, NotFound;
	local int i, AvailableExclusionsFromRanking;
	local float Skill;
	local bool HideSkill, Deranked;
	local UTComp_PRI_BW_FR_LDG uPRI;

	Super.ReceivedPlayerFlags(PC, PlayerFlags);

	db = class'LDGBWFreonDataTracking'.static.BinarySearch(PlayerFlags, false, NotFound);
	if (db != -1)
	{
		Skill = class'LDGBWFreonDataTracking'.default.Database[db].Bayesian * 10;
		AvailableExclusionsFromRanking = class'LDGBWFreonDataTracking'.default.Database[db].AvailableEFR;
		HideSkill = class'LDGBWFreonDataTracking'.default.Database[db].HideSkill;
		Deranked = class'LDGBWFreonDataTracking'.default.Database[db].Deranked;
	}
	else
	{
		Skill = class'LDGBWFreonDataTracking'.default.AverageEfficiency * 10;
		AvailableExclusionsFromRanking = 0;
		HideSkill = false;
		Deranked = false;
	}

	uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PC.PlayerReplicationInfo));
	if (uPRI != None)
	{
		uPRI.Skill = Skill;
		uPRI.AvailableExclusionsFromRanking = AvailableExclusionsFromRanking;
		uPRI.bHideSkill = HideSkill;
		uPRI.bDeranked = Deranked;
		uPRI.SetStreakThresholds();
	}
	else
	{
		i = PendingPC.Length;
		PendingPC.Length = PendingPC.Length + 1;
		PendingPC[i].PC = PC;
		PendingPC[i].PlayerFlags = PlayerFlags;
	}
}

function string TeamBalancerPlayerVariable(PlayerController PC, string Variable)
{
	local UTComp_PRI_BW_FR_LDG uPRI;

	switch (Caps(Variable))
	{
		case "SKILL":
			uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PC.PlayerReplicationInfo));
			if (uPRI != None)
				return string(uPRI.Skill);
			break;
	}

	return "";
}

function CheckPendingPlayerController(PlayerController PC)
{
	local int i;

	for (i = 0; i < PendingPC.Length; i++)
	{
		if (PC == PendingPC[i].PC)
		{
			ReceivedPlayerFlags(PendingPC[i].PC, PendingPC[i].PlayerFlags);
			PendingPC.Remove(i, 1);
			break;
		}
	}
}

function EndGame(PlayerReplicationInfo PRI, string Reason)
{
	local int i, j, db, NotFound, top;
	local float MatchTime, floor;
	local Controller C;
	local UTComp_PRI_BW_FR_LDG uPRI;

	Super.EndGame(PRI, Reason);

	if (bAlreadySaved)
		return;

	// First add inactivity
	MatchTime = Level.TimeSeconds / 3600.0;
	class'LDGBWFreonDataTracking'.static.AwardInactivity(MatchTime);

	//Update the database
	for (i = 0; i < PlayerStatsArray.Length; i++)
	{
		//save the stats if not up2date
		if (!PlayerStatsArray[i].bRecover)
			PlayerStatsArray[i].AssociatedInfo.SaveStats();

		// Store Skill Data 
		db = class'LDGBWFreonDataTracking'.static.BinarySearch(PlayerStatsArray[i].LDGHash, true, NotFound);

		if (PlayerStatsArray[i].AssociatedInfo.bExcludedFromRanking)
		{
			if (!PlayerStatsArray[i].AssociatedInfo.bAdminExcludedFromRanking && NotFound == 0)
			{
				class'LDGBWFreonDataTracking'.default.Database[db].AvailableEFR = Max(class'LDGBWFreonDataTracking'.default.Database[db].AvailableEFR - 1, 0);
				class'LDGBWFreonDataTracking'.default.Database[db].TakenEFR++;
			}
		}
		else
		{
			if (NotFound != 0)
			{
				class'LDGBWFreonDataTracking'.default.Database.Insert(db, 1);
				class'LDGBWFreonDataTracking'.default.Database[db].ID = PlayerStatsArray[i].LDGHash;
				class'LDGBWFreonDataTracking'.default.Database[db].Kills = PlayerStatsArray[i].AssociatedInfo.RealKills;
				class'LDGBWFreonDataTracking'.default.Database[db].Deaths = PlayerStatsArray[i].AssociatedInfo.RealDeaths;
				class'LDGBWFreonDataTracking'.default.Database[db].ThawPoints = PlayerStatsArray[i].AssociatedInfo.ThawPoints;
				class'LDGBWFreonDataTracking'.default.Database[db].TotalKills = PlayerStatsArray[i].AssociatedInfo.RealKills;
				class'LDGBWFreonDataTracking'.default.Database[db].TotalDeaths = PlayerStatsArray[i].AssociatedInfo.RealDeaths;
				class'LDGBWFreonDataTracking'.default.Database[db].TotalThawPoints = PlayerStatsArray[i].AssociatedInfo.ThawPoints;
				class'LDGBWFreonDataTracking'.default.Database[db].Inactivity = 0;

				for (j = 0; j < 11; j++)
					class'LDGBWFreonDataTracking'.default.Database[db].KillSpectrum[j] = 0;
			}
			else
			{
				class'LDGBWFreonDataTracking'.default.Database[db].Kills += PlayerStatsArray[i].AssociatedInfo.RealKills;
				class'LDGBWFreonDataTracking'.default.Database[db].Deaths += PlayerStatsArray[i].AssociatedInfo.RealDeaths;
				class'LDGBWFreonDataTracking'.default.Database[db].ThawPoints += PlayerStatsArray[i].AssociatedInfo.ThawPoints;
				class'LDGBWFreonDataTracking'.default.Database[db].TotalKills += PlayerStatsArray[i].AssociatedInfo.RealKills;
				class'LDGBWFreonDataTracking'.default.Database[db].TotalDeaths += PlayerStatsArray[i].AssociatedInfo.RealDeaths;
				class'LDGBWFreonDataTracking'.default.Database[db].TotalThawPoints += PlayerStatsArray[i].AssociatedInfo.ThawPoints;
				class'LDGBWFreonDataTracking'.default.Database[db].Inactivity = FMax(class'LDGBWFreonDataTracking'.default.Database[db].Inactivity - ((1 + class'LDGBWFreonDataTracking'.default.ActivityRatio) * PlayerStatsArray[i].AssociatedInfo.MatchTime), 0);
			}

			for (j = 0; j < PlayerStatsArray[i].AssociatedInfo.KillSpectrumIndex; j++)
			{
				top = int(PlayerStatsArray[i].AssociatedInfo.KillSpectrum[j]);
				if (top == 10)
				{
					class'LDGBWFreonDataTracking'.default.Database[db].KillSpectrum[10] += 1.0;
					continue;
				}
				else
				{
					floor = PlayerStatsArray[i].AssociatedInfo.KillSpectrum[j] - float(top);
					class'LDGBWFreonDataTracking'.default.Database[db].KillSpectrum[top] += 1 - floor;
					class'LDGBWFreonDataTracking'.default.Database[db].KillSpectrum[top + 1] += floor;
				}
			}
		}

		class'LDGBWFreonDataTracking'.default.Database[db].HideSkill = PlayerStatsArray[i].AssociatedInfo.bHideSkill;

		if (PlayerStatsArray[i].AssociatedInfo.ColoredName != "" && !PlayerStatsArray[i].AssociatedInfo.bHideSkill)
			class'LDGBWFreonDataTracking'.default.Database[db].EncPlayerName = class'LDGBWFreonDataTracking'.static.EncodeColoredName(PlayerStatsArray[i].AssociatedInfo.ColoredName);

		// Store Weapon Data
		db = class'LDGBWWeaponDataTracking'.static.BinarySearch(PlayerStatsArray[i].LDGHash, true, NotFound);

		if (NotFound != 0)
		{
			class'LDGBWWeaponDataTracking'.default.Database.Insert(db, 1);
			class'LDGBWWeaponDataTracking'.default.Database[db].ID = PlayerStatsArray[i].LDGHash;
			class'LDGBWWeaponDataTracking'.default.Database[db].MeleeDamage = PlayerStatsArray[i].AssociatedInfo.SGDamage;

			for (j = 0; j < 10; j++)
				class'LDGBWWeaponDataTracking'.default.Database[db].HitStats[j] = PlayerStatsArray[i].AssociatedInfo.HitStats[j];
		}
		else
		{
			class'LDGBWWeaponDataTracking'.default.Database[db].MeleeDamage += PlayerStatsArray[i].AssociatedInfo.SGDamage;

			for (j = 0; j < 10; j++)
			{
				class'LDGBWWeaponDataTracking'.default.Database[db].HitStats[j].Fired += PlayerStatsArray[i].AssociatedInfo.HitStats[j].Fired;
				class'LDGBWWeaponDataTracking'.default.Database[db].HitStats[j].Hit += PlayerStatsArray[i].AssociatedInfo.HitStats[j].Hit;
				class'LDGBWWeaponDataTracking'.default.Database[db].HitStats[j].Damage += PlayerStatsArray[i].AssociatedInfo.HitStats[j].Damage;
				class'LDGBWWeaponDataTracking'.default.Database[db].HitStats[j].Kills += PlayerStatsArray[i].AssociatedInfo.HitStats[j].Kills;
				class'LDGBWWeaponDataTracking'.default.Database[db].HitStats[j].DeathsWith += PlayerStatsArray[i].AssociatedInfo.HitStats[j].DeathsWith;
			}
		}

		if (PlayerStatsArray[i].AssociatedInfo.ColoredName != "")
			class'LDGBWWeaponDataTracking'.default.Database[db].EncPlayerName = class'LDGBWWeaponDataTracking'.static.EncodeColoredName(PlayerStatsArray[i].AssociatedInfo.ColoredName);
	}

	class'LDGBWFreonDataTracking'.static.DecayData();
	class'LDGBWFreonDataTracking'.static.Recalc(MatchStart);
	class'LDGBWWeaponDataTracking'.static.Store();

	bAlreadySaved = true;

	for (C = Level.ControllerList; C != None; C = C.NextController)
	{    
		if( xPlayer(C) != None)
			uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(C.PlayerReplicationInfo));

		if(uPRI == None || GetPlayerFlags(xPlayer(C)) ~= "None")
			continue;

		db = class'LDGBWFreonDataTracking'.static.BinarySearch(GetPlayerFlags(PlayerController(C)), false, NotFound);

		if (db == -1)
			continue;

		uPRI.NewSkill = class'LDGBWFreonDataTracking'.default.Database[db].Bayesian;
		uPRI.NewSkill *= 10.0f;
		uPRI.KillPoints = class'LDGBWFreonDataTracking'.default.Database[db].TotalKills;
		uPRI.DeathPoints = class'LDGBWFreonDataTracking'.default.Database[db].TotalDeaths;
		uPRI.NewThawPoints = int(class'LDGBWFreonDataTracking'.default.Database[db].TotalThawPoints); 

		uPRI.NewSkillReceiver = true;
	}
}

function PlayerController Login(string Portal, string Options, out string Error)
{
	local PlayerController PC;

	PC = Super.Login(Portal, Options, Error);

	if (Freon_Player_UTComp_LDG(PC) != None && bAllowViewingOfSkill)
		Freon_Player_UTComp_LDG(PC).bSkillMode = true;

	return PC;
}
//Inserted 244 lines.
//END_TRACKED_IMPL

defaultproperties
{
	 BWMutators(0)="LDGGameBW.LDGMut_Killstreak"
     DefaultPlayerClassName="LDGGameBW.Freon_Pawn_Tracked"
     MapListType="LDGGameBW.LDGBallisticFR_CTFMapsTrackedMapList"
     GameName="LDG Ballistic Freon (Tracked, CTF Maps)"
}
