class LDGBallisticFRTracked extends LDGBallisticFR;

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
var array<float> Skills;
var InterpCurve	ThawRateCurve;

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
	
	//Track skill for auto-thaw adjustment.
	//This compiler is so fucked - I'm forced to use a return in this loop
	if (Skills.Length == 0)
		Skills[0] = Skill;
	
	else
	{
		for (i=0; i < Skills.Length; i++)
		{
			if (Skill > Skills[i])
			{
				Skills.Insert(i,1);
				Skills[i] = Skill;
				return;
			}
		}
	}
	
	Skills[Skills.Length] = Skill;
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

function Logout(Controller Exiting)
{
	local UTComp_PRI_BW_FR_LDG uPRI;
	local int i;
	
	if(PlayerController(Exiting) != None) //no bots
	{
		uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PlayerController(Exiting).PlayerReplicationInfo));
		if (uPRI != None)
		{
			for(i=0; i<Skills.Length && uPRI.Skill != Skills[i]; ++i);
			
			if (i < Skills.Length)
				Skills.Remove(i, 1);
		}
	}

	Super.Logout(Exiting);
}

//END_TRACKED_IMPL

//Auto-thaw adjustment to let weaker players benefit from faster ambient thaw.
//Maybe I should incorporate the average skill in here somewhere...
function float GetAutoThawRate(Controller C)
{
	local float InSkill, TopSkill;
	local UTComp_PRI_BW_FR_LDG uPRI;
	
	if (AIController(C) != None)
		InSkill = class'LDGBWFreonDataTracking'.default.AverageEfficiency * 10;
	else
	{
		uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(C.PlayerReplicationInfo));
		if (uPRI == None || uPRI.Skill == 0)
			InSkill = class'LDGBWFreonDataTracking'.default.AverageEfficiency * 10;
		else InSkill = uPRI.Skill;
	}
	
	if (Skills.Length == 0)
		TopSkill = class'LDGBWFreonDataTracking'.default.AverageEfficiency * 10;
	else TopSkill = Skills[0];
	
	//log(C.PlayerReplicationInfo.PlayerName$": Skill is:"@InSkill@"with top skill of "@TopSkill);
		
	if (InSkill >= TopSkill)
		return 1;

	return FMax(1, InterpCurveEval(ThawRateCurve, InSkill) / InterpCurveEval(ThawRateCurve, TopSkill) );
}

//Threshold for RFF. Assumes lower skilled players are actively blocking you.
function int ReduceDamage(int Damage, pawn injured, pawn instigatedBy, vector HitLocation, 
                          out vector Momentum, class<DamageType> DamageType)
{
	local Misc_PRI PRI;
	local int OldDamage;
	local int NewDamage;
	local float Score;
	local float RFF;
	local vector EyeHeight;
	local float injuredskill, assailantskill;
	
	if(LockTime > 0)
		return 0;
	
	if(bEndOfRound)
	{
		Momentum *= 2.0;
		return 0;
	}
	
	if(DamageType == Class'DamTypeSuperShockBeam')
		return Super(xTeamGame).ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
	
	if((Misc_Pawn(instigatedBy) != None || BallisticTurret(instigatedBy) != None) && instigatedBy.Controller != None && injured.GetTeamNum() != 255 && instigatedBy.GetTeamNum() != 255)
	{
		PRI = Misc_PRI(instigatedBy.PlayerReplicationInfo);
		if(PRI == None)
			return Super(xTeamGame).ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
		
		/* same teams */
		if(injured.GetTeamNum() == instigatedBy.GetTeamNum() && FriendlyFireScale > 0.0)
		{
			if(injured == instigatedBy)
				return Super(xTeamGame).ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
				
			if (!ClassIsChildOf(DamageType, class'DT_BWExplode') && Freon_Player_UTComp_LDG(instigatedBy.Controller) != None && Freon_Player_UTComp_LDG(injured.Controller) != None)
			{
				assailantSkill = Freon_Player_UTComp_LDG(instigatedBy.Controller).UTCompPRI.Skill;
				if (Freon_Player_UTComp_LDG(injured.Controller) != None)
					injuredSkill = Freon_Player_UTComp_LDG(injured.Controller).UTCompPRI.Skill;
				
				if (assailantSkill > injuredSkill + 1)
				{
					Momentum = vect(0,0,0);
					return 0;
				}
			}
			
			RFF = PRI.ReverseFF * class'LDGBallisticRFFExceptions'.static.GetRFF(string(DamageType));
		
			if(RFF > 0.0)
			{
				if (Vehicle(instigatedBy) != None && Vehicle(instigatedBy).Driver != None)
					Vehicle(instigatedBy).Driver.TakeDamage(Damage * RFF * FriendlyFireScale, BallisticTurret(instigatedBy).Driver, HitLocation, vect(0,0,0), DamageType);
				else
					instigatedBy.TakeDamage(Damage * RFF * FriendlyFireScale, instigatedBy, HitLocation, vect(0,0,0), DamageType);
			}
		
			if(RFF < 1.0)
			{
				RFF = FMin(RFF + (Damage * 0.0015), 1.0);
				GameEvent("RFFChange", string(RFF - PRI.ReverseFF), PRI);
				PRI.ReverseFF = RFF;
			}
			
			Score = Damage * RFF * FriendlyFireScale;

			if(Score > 0.0)
			{		
				EyeHeight.z = instigatedBy.EyeHeight;
				if(Misc_Player(instigatedBy.Controller) != None)
				{
					if (FastTrace(injured.Location, instigatedBy.Location + EyeHeight))
						Misc_Player(instigatedBy.Controller).HitDamage -= Score;                        

					Misc_Player(instigatedBy.Controller).NewFriendlyDamage += Score * 0.01;
			
					if(Misc_Player(instigatedBy.Controller).NewFriendlyDamage >= 1.0)
					{
						ScoreEvent(PRI, -int(Misc_Player(instigatedBy.Controller).NewFriendlyDamage), "FriendlyDamage");
						Misc_Player(instigatedBy.Controller).NewFriendlyDamage -= int(Misc_Player(instigatedBy.Controller).NewFriendlyDamage);
					}
				}
				
				PRI.Score -= Score * 0.01;
				instigatedBy.Controller.AwardAdrenaline((-Score * 0.10) * AdrenalinePerDamage);
			}
			
			Momentum = vect(0,0,0);
			return 0;
		}
		else if(injured.GetTeamNum() != instigatedBy.GetTeamNum()) // different teams
		{
			OldDamage = PRI.EnemyDamage;
			NewDamage = OldDamage + Damage;
			PRI.EnemyDamage = NewDamage;
		
			Score = NewDamage - OldDamage;
			if(Score > 0.0)
			{
				if(Misc_Player(instigatedBy.Controller) != None)
				{
					Misc_Player(instigatedBy.Controller).NewEnemyDamage += Score * 0.01;
					if(Misc_Player(instigatedBy.Controller).NewEnemyDamage >= 1.0)
					{
						ScoreEvent(PRI, int(Misc_Player(instigatedBy.Controller).NewEnemyDamage), "EnemyDamage");
						Misc_Player(instigatedBy.Controller).NewEnemyDamage -= int(Misc_Player(instigatedBy.Controller).NewEnemyDamage);
					}
		
					EyeHeight.z = instigatedBy.EyeHeight;
					if(FastTrace(injured.Location, instigatedBy.Location + EyeHeight))
						Misc_Player(instigatedBy.Controller).HitDamage += Score;
						
					if(class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.bSnipingDamage)
						Misc_Player(instigatedBy.Controller).NextCampCheckTime = Level.TimeSeconds + 25;
					else
						Misc_Player(instigatedBy.Controller).NextCampCheckTime = Level.TimeSeconds + 10;
				}
				
				PRI.Score += Score * 0.01;
				instigatedBy.Controller.AwardAdrenaline((Score * 0.10) * AdrenalinePerDamage);		
			}
		
			if(Damage > (injured.Health + injured.ShieldStrength + 50) && Damage / (injured.Health + injured.ShieldStrength) > 2)
			{
				PRI.OverkillCount++;
				SpecialEvent(PRI, "Overkill");
		
				if(Misc_Player(instigatedBy.Controller) != None)
					Misc_Player(instigatedBy.Controller).ReceiveLocalizedMessage(class'Message_Overkill'); // overkill
			}
		}
	}
	
	return Super(xTeamGame).ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
}

defaultproperties
{
     ThawRateCurve=(Points=((OutVal=5.000000),(InVal=2.000000,OutVal=3.000000),(InVal=3.500000,OutVal=2.400000),(InVal=4.000000,OutVal=2.000000),(InVal=5.000000,OutVal=1.660000),(InVal=6.000000,OutVal=1.330000),(InVal=7.000000,OutVal=1.150000),(InVal=8.000000,OutVal=1.000000),(InVal=10.000000,OutVal=1.000000)))
	 BWMutators(0)="LDGGameBW.LDGMut_ConflictLoadout"
	 BWMutators(1)="LDGGameBW.LDGMut_Killstreak"
     DefaultPlayerClassName="LDGGameBW.Freon_Pawn_Tracked"
     MapListType="LDGGameBW.LDGBallisticFRTrackedMapList"
     GameName="LDG Ballistic Freon (Tracked, DM Maps)"
}
