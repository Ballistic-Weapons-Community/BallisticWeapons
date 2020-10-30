class TeamArenaMaster extends Team_GameBase
    config;

/* general and misc */
var config bool     bDisableTeamCombos;
var config bool     bChallengeMode;

var config bool     bRandomPickups;
var Misc_PickupBase Bases[3];           // random pickup bases

var config bool     bPureRFF;
/* general and misc */

function InitGameReplicationInfo()
{
    Super.InitGameReplicationInfo();

    if(TAM_GRI(GameReplicationInfo) == None)
        return;

    TAM_GRI(GameReplicationInfo).bChallengeMode = bChallengeMode;
    TAM_GRI(GameReplicationInfo).bDisableTeamCombos = bDisableTeamCombos;
    TAM_GRI(GameReplicationInfo).bRandomPickups = bRandomPickups;
}

function GetServerDetails(out ServerResponseLine ServerState)
{
    Super.GetServerDetails(ServerState);

    AddServerDetail(ServerState, "Team Combos", !bDisableTeamCombos);
    AddServerDetail(ServerState, "Challenge Mode", bChallengeMode);
    AddServerDetail(ServerState, "Random Pickups", bRandomPickups);
}

static function FillPlayInfo(PlayInfo PI)
{
    Super.FillPlayInfo(PI);

    PI.AddSetting("3SPN", "bChallengeMode", "Challenge Mode", 0, 110, "Check");
    PI.AddSetting("3SPN", "bRandomPickups", "Random Pickups", 0, 176, "Check");
    PI.AddSetting("3SPN", "bDisableTeamCombos", "No Team Combos", 0, 199, "Check");
    PI.AddSetting("3SPN", "bPureRFF", "Pure RFF", 0, 300, "Check");
}

static event string GetDescriptionText(string PropName)
{ 
    switch(PropName)
    {
        case "bChallengeMode":      return "Round winners take a health/armor penalty.";
        case "bDisableTeamCombos":  return "Turns off team combos. Only the user gets the combo.";
        case "bRandomPickups":      return "Spawns three pickups which give random effect when picked up: Health +10/20, Shield +10/20 or Adren +10";
        case "bPureRFF":            return "All teammate damage is reflected back.";
    }

    return Super.GetDescriptionText(PropName);
}

function UnrealTeamInfo GetBlueTeam(int TeamBots)
{
    if(BlueTeamName != "")
        BlueTeamName = "3SPNv3141BW.TAM_TeamInfoBlue";
    return Super.GetBlueTeam(TeamBots);
}

function UnrealTeamInfo GetRedTeam(int TeamBots)
{
    if(RedTeamName != "")
        RedTeamName = "3SPNv3141BW.TAM_TeamInfoRed";
    return Super.GetRedTeam(TeamBots);
}

function ParseOptions(string Options)
{
    local string InOpt;

    Super.ParseOptions(Options);

    InOpt = ParseOption(Options, "ChallengeMode");
    if(InOpt != "")
        bChallengeMode = bool(InOpt);

    InOpt = ParseOption(Options, "DisableTeamCombos");
    if(InOpt != "")
        bDisableTeamCombos = bool(InOpt);

    InOpt = ParseOption(Options, "RandomPickups");
    if(InOpt != "")
        bRandomPickups = bool(InOpt);

    InOpt = ParseOption(Options, "PureRFF");
    if(InOpt != "")
        bPureRFF = bool(InOpt);
}

function SpawnRandomPickupBases()
{
    local int i;
    local float Score[3];
    local float eval;
    local NavigationPoint Best[3];
    local NavigationPoint N;

    for(i = 0; i < 100; i++)
        FRand();

    for(i = 0; i < 3; i++)
    {
        for(N = Level.NavigationPointList; N != None; N = N.NextNavigationPoint)
        {
            if(InventorySpot(N) == None || InventorySpot(N).myPickupBase == None)
                continue;

            eval = 0;

            if(i == 0)
                eval = FRand() * 5000.0;
            else
            {
                if(Best[0] != None)
                    eval = VSize(Best[0].Location - N.Location) * (0.8 + FRand() * 1.2);

                if(i > 1 && Best[1] != None)
                    eval += VSize(Best[1].Location - N.Location) * (1.5 + FRand() * 0.5);
            }

            if(Best[0] == N)
                eval = 0;
            if(Best[1] == N)
                eval = 0;
            if(Best[2] == N)
                eval = 0;

            if(Score[i] < eval)
            {
                Score[i] = eval;
                Best[i] = N;
            }
        }
    }

    if(Best[0] != None)
    {
        Bases[0] = Spawn(class'Misc_PickupBase',,, Best[0].Location, Best[0].Rotation);
        Bases[0].MyMarker = InventorySpot(Best[0]);
    }
    if(Best[1] != None)
    {
        Bases[1] = Spawn(class'Misc_PickupBase',,, Best[1].Location, Best[1].Rotation);
        Bases[1].MyMarker = InventorySpot(Best[1]);
    }
    if(Best[2] != None)
    {
        Bases[2] = Spawn(class'Misc_PickupBase',,, Best[2].Location, Best[2].Rotation);
        Bases[2].MyMarker = InventorySpot(Best[2]);
    }
}

event InitGame(string Options, out string Error)
{
    local Mutator mut;
    local bool bNoAdren;

    bAllowBehindView = true;

    Super.InitGame(Options, Error);

    if(bRandomPickups)
    {
        for(mut = BaseMutator; mut != None; mut = mut.NextMutator)
        {
            if(mut.IsA('MutNoAdrenaline'))
            {
                bNoAdren = true;   
                break;
            }
        }

        if(bNoAdren)
            class'Misc_PickupBase'.default.PickupClasses[4] = None;
        else
            class'Misc_PickupBase'.default.PickupClasses[4] = class'Misc_PickupAdren';
        SpawnRandomPickupBases();
    }

    // setup adren amounts
    AdrenalinePerDamage = 0.75;
    if(bRandomPickups)
        AdrenalinePerDamage -= 0.25;
    if(!bDisableTeamCombos)
        AdrenalinePerDamage += 0.25;
}

function RestartPlayer(Controller C)
{
    local int Team;

    Super.RestartPlayer(C);

    if(C == None)
        return;

    Team = C.GetTeamNum();
    if(Team == 255)
        return;

    if(TAM_TeamInfo(Teams[Team]) != None && TAM_TeamInfo(Teams[Team]).ComboManager != None)
        TAM_TeamInfo(Teams[Team]).ComboManager.PlayerSpawned(C);
    else if(TAM_TeamInfoRed(Teams[Team]) != None && TAM_TeamInfoRed(Teams[Team]).ComboManager != None)
        TAM_TeamInfoRed(Teams[Team]).ComboManager.PlayerSpawned(C);
    else if(TAM_TeamInfoBlue(Teams[Team]) != None && TAM_TeamInfoBlue(Teams[Team]).ComboManager != None)
        TAM_TeamInfoBlue(Teams[Team]).ComboManager.PlayerSpawned(C);
}

function PracticeRoundEnded()
{
	local Controller	C;
	local BallisticPlayerReplicationInfo BWPRI;
	local KillstreakLRI KLRI;
	local BallisticPlayerReplicationInfo.HitStat EmptyHitStat;
	local Misc_PRI MPRI;
	local int i;
	
	EmptyHitStat.Fired = 0;
	EmptyHitStat.Hit = 0;
	EmptyHitStat.Damage = 0;
	
	// Practice Round Ended, reset scores!
	for ( C = Level.ControllerList; C != None; C = C.NextController )
	{
		C.Adrenaline = 0;
		
		if ( C.PlayerReplicationInfo != None )
		{
			C.PlayerReplicationInfo.Kills = 0;
			C.PlayerReplicationInfo.Score	= 0;
			C.PlayerReplicationInfo.Deaths= 0;

			if ( TeamPlayerReplicationInfo(C.PlayerReplicationInfo) != None )
				TeamPlayerReplicationInfo(C.PlayerReplicationInfo).Suicides = 0;

			BWPRI = class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo);
		
			if (BWPRI != None)
			{
				for (i = 0; i < 10; i++)			
					BWPRI.HitStats[i] = EmptyHitStat;
					
				BWPRI.SGDamage = 0;
				BWPRI.HeadShots = 0;
				BWPRI.AveragePercent = 0;
			}
			
			KLRI = class'Mut_Killstreak'.static.GetKLRI(C.PlayerReplicationInfo);
			
			if (KLRI != None)
			{
				KLRI.RewardLevel = 0;
				KLRI.ActiveStreak = 0;
			}
			
			if (Misc_PRI(C.PlayerReplicationInfo) != None)
			{
				MPRI = Misc_PRI(C.PlayerReplicationInfo);
				
				MPRI.EnemyDamage = 0;
				MPRI.AllyDamage = 0;
				if (bPureRFF)
					MPRI.ReverseFF = 1;
				else
					MPRI.ReverseFF = 0;

				MPRI.FlawlessCount = 0;
				MPRI.OverkillCount = 0;
				MPRI.DarkHorseCount = 0;
				
				MPRI.DarkSoulPower = 0;
				MPRI.NovaSoulPower = 0;
				MPRI.XOXOLewdness = 0;
				
				MPRI.ReWarnTime = 0;
				MPRI.WaterReWarnTime = 0;
			}
		}
	}

	bFirstBlood = false;
	Teams[0].Score = 0;
	Teams[1].Score = 0;
	Teams[0].NetUpdateTime = Level.TimeSeconds - 1;
	Teams[1].NetUpdateTime = Level.TimeSeconds - 1;
	Misc_BaseGRI(GameReplicationInfo).bPracticeRound = false;
}

function SetupPlayer(Pawn P)
{
    local byte difference;
    local int health;
    local int armor;
    local float formula;

    Super.SetupPlayer(P);

    if(bChallengeMode)
    {
        difference = Max(0, Teams[p.GetTeamNum()].Score - Teams[int(!bool(p.GetTeamNum()))].Score);
        difference += Max(0, Teams[p.GetTeamNum()].Size - Teams[int(!bool(p.GetTeamNum()))].Size);

        if(GoalScore > 0)
            formula = 0.25 / GoalScore;
        else
            formula = 0.0;

        health = StartingHealth - (((StartingHealth * formula) * difference));
        armor = StartingArmor - (((StartingArmor * formula) * difference));

        p.Health = Max(40, health);
        p.HealthMax = health;
        p.SuperHealthMax = int(health * MaxHealth);
        
        xPawn(p).ShieldStrengthMax = Max(0, int(armor * MaxHealth));
        p.AddShieldStrength(Max(0, armor));
    }
    else
        p.AddShieldStrength(StartingArmor);

    if(TAM_TeamInfo(p.PlayerReplicationInfo.Team) != None)
        TAM_TeamInfo(p.PlayerReplicationInfo.Team).StartingHealth = p.Health + p.ShieldStrength;
    else if(TAM_TeamInfoBlue(p.PlayerReplicationInfo.Team) != None)
        TAM_TeamInfoBlue(p.PlayerReplicationInfo.Team).StartingHealth = p.Health + p.ShieldStrength;
    else if(TAM_TeamInfoRed(p.PlayerReplicationInfo.Team) != None)
        TAM_TeamInfoRed(p.PlayerReplicationInfo.Team).StartingHealth = p.Health + p.ShieldStrength;
}

function string SwapDefaultCombo(string ComboName)
{
    if(ComboName ~= "xGame.ComboSpeed")
        return "3SPNv3141BW.Misc_ComboSpeed";
    else if(ComboName ~= "xGame.ComboBerserk")
        return "3SPNv3141BW.Misc_ComboBerserk";

    return ComboName;
}

function string RecommendCombo(string ComboName)
{
    local int i;
    local bool bEnabled;

    if(EnabledCombos.Length == 0)
        return Super.RecommendCombo(ComboName);

    for(i = 0; i < EnabledCombos.Length; i++)
    {
        if(EnabledCombos[i] ~= ComboName)
        {
            bEnabled = true;
            break;
        }
    }

    if(!bEnabled)
        ComboName = EnabledCombos[Rand(EnabledCombos.Length)];

    return SwapDefaultCombo(ComboName);
}

function StartNewRound()
{
    if(TAM_TeamInfo(Teams[0]) != None && TAM_TeamInfo(Teams[0]).ComboManager != None)
        TAM_TeamInfo(Teams[0]).ComboManager.ClearData();
    else if(TAM_TeamInfoRed(Teams[0]) != None && TAM_TeamInfoRed(Teams[0]).ComboManager != None)
        TAM_TeamInfoRed(Teams[0]).ComboManager.ClearData();

    if(TAM_TeamInfo(Teams[1]) != None && TAM_TeamInfo(Teams[1]).ComboManager != None)
        TAM_TeamInfo(Teams[1]).ComboManager.ClearData();
    else if(TAM_TeamInfoBlue(Teams[1]) != None && TAM_TeamInfoBlue(Teams[1]).ComboManager != None)
        TAM_TeamInfoBlue(Teams[1]).ComboManager.ClearData();

    Super.StartNewRound();
}

//as teamgame, but awards a mag of ammo on a kill
function ScoreKill(Controller Killer, Controller Other)
{
	local Pawn Target;
	local BallisticWeapon KPW;

	if ( !Other.bIsPlayer || ((Killer != None) && !Killer.bIsPlayer) )
	{
		Super.ScoreKill(Killer, Other);
		if ( !bScoreTeamKills && (Killer != None) && Killer.bIsPlayer && (MaxLives > 0) )
			CheckScore(Killer.PlayerReplicationInfo);
		return;
	}

	if ( (Killer == None) || (Killer == Other)
		|| (Killer.PlayerReplicationInfo.Team != Other.PlayerReplicationInfo.Team) )
	{
		if ( (Killer!=None) && (Killer.Pawn != None) && (Killer.PlayerReplicationInfo.Team != Other.PlayerReplicationInfo.Team) )
		{
			KPW = BallisticWeapon(Killer.Pawn.Weapon);
			
			if(KPW != None)
			{				
				if( !KPW.bWT_Super)
				{
					if (class<BallisticAmmo>(KPW.GetAmmoClass(0)) != None)
					{
						if (!KPW.bUseSights || KPW.bScopeView)
							KPW.AddAmmo(class<BallisticAmmo>(KPW.GetAmmoClass(0)).static.GetKillResupplyAmmo(), 0);
						else KPW.AddAmmo(class<BallisticAmmo>(KPW.GetAmmoClass(0)).static.GetKillResupplyAmmo()/2, 0);
						
					}
					else
					{
						if (!KPW.bNoMag)
						{
							if (!KPW.bUseSights || KPW.bScopeView)
								KPW.AddAmmo(KPW.default.MagAmmo, 0);
							else KPW.AddAmmo(KPW.default.MagAmmo/2, 0);
						}
						else if (!KPW.bUseSights || KPW.bScopeView)
							KPW.AddAmmo(KPW.GetAmmoClass(0).default.InitialAmount/3, 0);
						else KPW.AddAmmo(KPW.GetAmmoClass(0).default.InitialAmount/6, 0);
					}
		
					if (KPW.GetAmmoClass(1) != None && KPW.GetAmmoClass(1) != KPW.GetAmmoClass(0))
						KPW.AddAmmo(Max(KPW.GetAmmoClass(1).default.InitialAmount / 2, 1), 1);
				}

				if ( Other.PlayerReplicationInfo.HasFlag != None )
				{
					Killer.AwardAdrenaline(ADR_MajorKill);
					GameObject(Other.PlayerReplicationInfo.HasFlag).bLastSecondSave = NearGoal(Other);
				}
			}
			

			// Kill Bonuses work as follows (in additional to the default 1 point
			//	+1 Point for killing an enemy targetting an important player on your team
			//	+2 Points for killing an enemy important player

			if ( CriticalPlayer(Other) )
			{
				Killer.PlayerReplicationInfo.Score+= 2;
				Killer.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
				ScoreEvent(Killer.PlayerReplicationInfo,1,"critical_frag");
			}

			if (bScoreVictimsTarget)
			{
				Target = FindVictimsTarget(Other);
				if ( (Target!=None) && (Target.PlayerReplicationInfo!=None) &&
				       (Target.PlayerReplicationInfo.Team == Killer.PlayerReplicationInfo.Team) && CriticalPlayer(Target.Controller) )
				{
					Killer.PlayerReplicationInfo.Score+=1;
					Killer.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
					ScoreEvent(Killer.PlayerReplicationInfo,1,"team_protect_frag");
				}
			}

		}
		Super.ScoreKill(Killer, Other);
	}
	else if ( GameRulesModifiers != None )
		GameRulesModifiers.ScoreKill(Killer, Other);

	if ( !bScoreTeamKills )
	{
		if ( Other.bIsPlayer && (Killer != None) && Killer.bIsPlayer && (Killer != Other)
			&& (Killer.PlayerReplicationInfo.Team == Other.PlayerReplicationInfo.Team) )
		{
			Killer.PlayerReplicationInfo.Score -= 1;
			Killer.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
			ScoreEvent(Killer.PlayerReplicationInfo, -1, "team_frag");
		}
		if ( MaxLives > 0 )
			CheckScore(Killer.PlayerReplicationInfo);
		return;
	}
	if ( Other.bIsPlayer )
	{
		if ( (Killer == None) || (Killer == Other) )
		{
			Other.PlayerReplicationInfo.Team.Score -= 1;
			Other.PlayerReplicationInfo.Team.NetUpdateTime = Level.TimeSeconds - 1;
			TeamScoreEvent(Killer.PlayerReplicationInfo.Team.TeamIndex, 1, "team_frag");
		}
		else if ( Killer.PlayerReplicationInfo.Team != Other.PlayerReplicationInfo.Team )
		{
			Killer.PlayerReplicationInfo.Team.Score += 1;
			Killer.PlayerReplicationInfo.Team.NetUpdateTime = Level.TimeSeconds - 1;
			TeamScoreEvent(Killer.PlayerReplicationInfo.Team.TeamIndex, 1, "tdm_frag");
		}
		else if ( FriendlyFireScale > 0 )
		{
			Killer.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
			Killer.PlayerReplicationInfo.Score -= 1;
			Killer.PlayerReplicationInfo.Team.Score -= 1;
			Killer.PlayerReplicationInfo.Team.NetUpdateTime = Level.TimeSeconds - 1;
			TeamScoreEvent(Killer.PlayerReplicationInfo.Team.TeamIndex, 1, "team_frag");
		}
	}

	// check score again to see if team won
    if ( (Killer != None) && bScoreTeamKills )
		CheckScore(Killer.PlayerReplicationInfo);
}

defaultproperties
{
     bDisableTeamCombos=True
     bChallengeMode=True
     StartingArmor=100
     MaxHealth=1.250000
     MinsPerRound=4
     bForceRespawn=True
     SpawnProtectionTime=0.000000
     GoalScore=8
     MaxLives=1
     GameReplicationInfoClass=Class'3SPNv3141BW.TAM_GRI'
     GameName="BallisticPro: Team ArenaMaster"
     Acronym="TAM"
}
