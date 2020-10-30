class ArenaMaster extends xDeathmatch
    config;

/* general and misc */
var config int      StartingHealth;
var config int      StartingArmor;
var config float    MaxHealth;

var float           AdrenalinePerDamage;    // adrenaline per 10 damage

var config bool     bDisableSpeed;
var config bool     bDisableBooster;
var config bool     bDisableInvis;
var config bool     bDisableBerserk;
var array<string>   EnabledCombos;

var config bool     bChallengeMode;
var config bool     bForceRUP;

var config bool     bRandomPickups;
var Misc_PickupBase Bases[3];               // random pickup bases

var string          NextMapString;          // used to save mid-game admin changes in the menu

var bool            bDefaultsReset;
var bool				bAllowBotRemoval;
/* general and misc */

/* overtime related */
var config int      MinsPerRound;           // the number of minutes before a round goes into OT
var int             RoundTime;              // number of seconds remaining before round-OT
var bool            bRoundOT;               // true if we're in round-OT
var int             RoundOTTime;            // how long we've been in round-OT
var config int      OTDamage;               // the amount of damage players take in round-OT every...
var config int      OTInterval;             // <OTInterval> seconds
/* overtime related */

/* camping related */
var config float    CampThreshold;          // area a player must stay in to be considered camping
var int             CampInterval;           // time between flagging the same player
var int 		MaxWaterCampChecks;  //number of times anticamp checks will tolerate player being in fog dense zone
var config bool     bKickExcessiveCampers;  // kick players that camp 4 consecutive times
/* camping related */

/* round related */
var bool            bEndOfRound;            // true if a round has just ended
var bool            bRespawning;            // true if we're respawning players
var int             RespawnTime;            // time left to respawn
var int             LockTime;               // time left until weapons get unlocked
var int             NextRoundTime;          // time left until the next round starts
var int             NextRoundDelay;  
var int             CurrentRound;           // the current round number (0 = game hasn't started)

var int             RoundsToWin;            // rounds needed to win
/* round related */

/* weapon related */
struct WeaponData
{
    var string WeaponName;
    var int Ammo[2];                        // 0 = primary ammo, 1 = alt ammo
    var float MaxAmmo[2];                   // 1 is only used for WeaponDefaults
};

var        WeaponData WeaponInfo[10];
var        WeaponData WeaponDefaults[10];
var config bool	      bModifyShieldGun;     // use the modified shield gun (higher shield jumps) 

var config int AssaultAmmo;
var config int AssaultGrenades;
var config int BioAmmo;
var config int ShockAmmo;
var config int LinkAmmo;
var config int MiniAmmo;
var config int FlakAmmo;
var config int RocketAmmo;
var config int LightningAmmo;

var bool			bWeaponsLocked;
/* added for an attempt to fix the weapon lock issue */
var bool		   bPendingCheckLocks;
var float		   NextCheckLockTime;
var config int CheckLockInterval;

var array<Misc_Player> unreceptiveControllers;
/* weapon related */

/* trial round */
var config bool		bPracticeRound;
var config int		PracticeRoundLength;

function InitGameReplicationInfo()
{
    Super.InitGameReplicationInfo();

    if(TAM_GRI(GameReplicationInfo) == None)
        return;

    TAM_GRI(GameReplicationInfo).RoundTime = MinsPerRound * 60;

    TAM_GRI(GameReplicationInfo).StartingHealth = StartingHealth;
    TAM_GRI(GameReplicationInfo).StartingArmor = StartingArmor;
    TAM_GRI(GameReplicationInfo).bChallengeMode = bChallengeMode;
    TAM_GRI(GameReplicationInfo).MaxHealth = MaxHealth;

    TAM_GRI(GameReplicationInfo).MinsPerRound = MinsPerRound;
    TAM_GRI(GameReplicationInfo).OTDamage = OTDamage;
    TAM_GRI(GameReplicationInfo).OTInterval = OTInterval;

    TAM_GRI(GameReplicationInfo).CampThreshold = CampThreshold;
    TAM_GRI(GameReplicationInfo).bKickExcessiveCampers = bKickExcessiveCampers;

    TAM_GRI(GameReplicationInfo).bDisableTeamCombos = true;
    TAM_GRI(GameReplicationInfo).bDisableSpeed = bDisableSpeed;
    TAM_GRI(GameReplicationInfo).bDisableInvis = bDisableInvis;
    TAM_GRI(GameReplicationInfo).bDisableBooster = bDisableBooster;
    TAM_GRI(GameReplicationInfo).bDisableBerserk = bDisableBerserk;

    TAM_GRI(GameReplicationInfo).bForceRUP = bForceRUP;
    TAM_GRI(GameReplicationInfo).bRandomPickups = bRandomPickups;

    TAM_GRI(GameReplicationInfo).GoalScore = RoundsToWin;

    bWeaponsLocked = true;
    Misc_BaseGRI(GameReplicationInfo).bWeaponsLocked = true;
    Misc_BaseGRI(GameReplicationInfo).NetUpdateTime = Level.TimeSeconds - 1;
}

function GetServerDetails(out ServerResponseLine ServerState)
{
    Super.GetServerDetails(ServerState);

    AddServerDetail(ServerState, "3SPN Version", class'TAM_GRI'.default.Version);
    AddServerDetail(ServerState, "Challenge Mode", bChallengeMode);
    AddServerDetail(ServerState, "Random Pickups", bRandomPickups);
}

static function FillPlayInfo(PlayInfo PI)
{
    Super.FillPlayInfo(PI);

    PI.AddSetting("3SPN", "StartingHealth", "Starting Health", 0, 100, "Text", "3;0:999");
    PI.AddSetting("3SPN", "StartingArmor", "Starting Armor", 0, 101, "Text", "3;0:999");
    PI.AddSetting("3SPN", "MaxHealth", "Max Health", 0, 102, "Text", "8;0.0:2.0");
    PI.AddSetting("3SPN", "bChallengeMode", "Challenge Mode", 0, 103, "Check");

    PI.AddSetting("3SPN", "MinsPerRound", "Minutes per Round", 0, 120, "Text", "3;0:999");
    PI.AddSetting("3SPN", "OTDamage", "Overtime Damage", 0, 121, "Text", "3;0:999");
    PI.AddSetting("3SPN", "OTInterval", "Overtime Damage Interval", 0, 122, "Text", "3;0:999");
	
	PI.AddSetting("3SPN", "bPracticeRound", "Practice Round", 0, 309, "Check",,, True);
    PI.AddSetting("3SPN", "PracticeRoundLength", "Practice Round Duration", 0, 310, "Text", "3;0:999",, True);

    PI.AddSetting("3SPN", "CampThreshold", "Camp Area", 0, 150, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "bKickExcessiveCampers", "Kick Excessive Campers", 0, 151, "Check",,, True);

    PI.AddSetting("3SPN", "bForceRUP", "Force Ready", 0, 175, "Check",,, True);
    PI.AddSetting("3SPN", "bRandomPickups", "Random Pickups", 0, 176, "Check");

    PI.AddSetting("3SPN", "bDisableSpeed", "Disable Speed", 0, 200, "Check");
    PI.AddSetting("3SPN", "bDisableInvis", "Disable Invis", 0, 201, "Check");
    PI.AddSetting("3SPN", "bDisableBerserk", "Disable Berserk", 0, 202, "Check");
    PI.AddSetting("3SPN", "bDisableBooster", "Disable Booster", 0, 203, "Check");

    PI.AddSetting("3SPN", "bModifyShieldGun", "Use Modified Shield Gun", 0, 299, "Check",,, True);
    PI.AddSetting("3SPN", "AssaultAmmo", "Assault Ammunition", 0, 300, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "AssaultGrenades", "Assault Grenades", 0, 301, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "BioAmmo", "Bio Ammunition", 0, 302, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "ShockAmmo", "Shock Ammunition", 0, 303, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "LinkAmmo", "Link Ammunition", 0, 304, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "MiniAmmo", "Mini Ammunition", 0, 305, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "FlakAmmo", "Flak Ammunition", 0, 306, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "RocketAmmo", "Rocket Ammunition", 0, 307, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "LightningAmmo", "Lightning Ammunition", 0, 308, "Text", "3;0:999",, True);
}

static event string GetDescriptionText(string PropName)
{ 
    switch(PropName)
    {
        case "StartingHealth":      return "Base health at round start.";
        case "StartingArmor":       return "Base armor at round start.";
        case "bChallengeMode":      return "Round winners take a health/armor penalty.";

        case "MinsPerRound":        return "Round time-limit before overtime.";
        case "OTDamage":            return "The amount of damage all players while in OT.";
        case "OTInterval":          return "The interval at which OT damage is given.";
		
		case "bPracticeRound":      return "Whether to have a practice round at the beginning.";
        case "PracticeRoundLength":    return "Practice run duration in seconds.";
            
        case "MaxHealth":           return "The maximum amount of health and armor a player can have.";

        case "CampThreshold":       return "The area a player must stay in to be considered camping.";
        case "bKickExcessiveCampers": return "Kick players that camp 4 consecutive times.";
            
        case "bDisableSpeed":       return "Disable the Speed adrenaline combo.";
        case "bDisableInvis":       return "Disable the Invisibility adrenaline combo.";
        case "bDisableBooster":     return "Disable the Booster adrenaline combo.";
        case "bDisableBerserk":     return "Disable the Berserk adrenaline combo.";

        case "bForceRUP":           return "Force players to ready up after 45 seconds.";
        case "bRandomPickups":      return "Spawns three pickups which give random effect when picked up: Health +15, Shield +15 or Adren +10";

        case "bModifyShieldGun":    return "The Shield Gun will have more kick back for higher shield jumps";
        case "AssaultAmmo":         return "Amount of Assault Ammunition to give in a round.";
        case "AssaultGrenades":     return "Amount of Assault Grenades to give in a round.";
        case "BioAmmo":             return "Amount of Bio Rifle Ammunition to give in a round.";
        case "LinkAmmo":            return "Amount of Link Gun Ammunition to give in a round.";
        case "ShockAmmo":           return "Amount of Shock Ammunition to give in a round.";
        case "MiniAmmo":            return "Amount of Mini Ammunition to give in a round.";
        case "FlakAmmo":            return "Amount of Flak Ammunition to give in a round.";
        case "RocketAmmo":          return "Amount of Rocket Ammunition to give in a round.";
        case "LightningAmmo":       return "Amount of Lightning Ammunition to give in a round.";
    }

    return Super.GetDescriptionText(PropName);
}

function ParseOptions(string Options)
{
    local string InOpt;

    InOpt = ParseOption(Options, "StartingHealth");
    if(InOpt != "")
        StartingHealth = int(InOpt);

    InOpt = ParseOption(Options, "StartingArmor");
    if(InOpt != "")
        StartingArmor = int(InOpt);

    InOpt = ParseOption(Options, "ChallengeMode");
    if(InOpt != "")
        bChallengeMode = bool(InOpt);

    InOpt = ParseOption(Options, "MaxHealth");
    if(InOpt != "")
        MaxHealth = float(InOpt);

    InOpt = ParseOption(Options, "MinsPerRound");
    if(InOpt != "")
        MinsPerRound = int(InOpt);

    InOpt = ParseOption(Options, "OTDamage");
    if(InOpt != "")
        OTDamage = int(InOpt);

    InOpt = ParseOption(Options, "OTInterval");
    if(InOpt != "")
        OTInterval = int(InOpt);

    InOpt = ParseOption(Options, "CampThreshold");
    if(InOpt != "")
        CampThreshold = float(InOpt);

    InOpt = ParseOption(Options, "ForceRUP");
    if(InOpt != "")
        bForceRUP = bool(InOpt);

    InOpt = ParseOption(Options, "KickExcessiveCampers");
    if(InOpt != "")
        bKickExcessiveCampers = bool(InOpt);

    InOpt = ParseOption(Options, "DisableSpeed");
    if(InOpt != "")
        bDisableSpeed = bool(InOpt);

    InOpt = ParseOption(Options, "DisableInvis");
    if(InOpt != "")
        bDisableInvis = bool(InOpt);

    InOpt = ParseOption(Options, "DisableBerserk");
    if(InOpt != "")
        bDisableBerserk = bool(InOpt);

    InOpt = ParseOption(Options, "DisableBooster");
    if(InOpt != "")
        bDisableBooster = bool(InOpt);

    InOpt = ParseOption(Options, "RandomPickups");
    if(InOpt != "")
        bRandomPickups = bool(InOpt);
}

function SpawnRandomPickupBases()
{
    local float Score[3];
    local float eval;
    local NavigationPoint Best[3];
    local NavigationPoint N;

    for(N = Level.NavigationPointList; N != None; N = N.NextNavigationPoint)
    {
        if(InventorySpot(N) == None || InventorySpot(N).myPickupBase == None)
            continue;

        eval = FRand() * 5000.0;

        if(Best[0] != None)
            eval += VSize(Best[0].Location - N.Location) * (FRand() * 4.0 - 2.0);
        if(Best[1] != None)
            eval += VSize(Best[1].Location - N.Location) * (FRand() * 3.5 - 1.75);
        if(Best[2] != None)
            eval += VSize(Best[2].Location - N.Location) * (FRand() * 3.0 - 1.5);

        if(Best[0] == N)
            eval = 0;
        if(Best[1] == N)
            eval = 0;
        if(Best[2] == N)
            eval = 0;
            
        if(eval > Score[0])
        {
            Score[2] = Score[1];
            Score[1] = Score[0];
            Score[0] = eval;

            Best[2] = Best[1];
            Best[1] = Best[0];
            Best[0] = N;
        }
        else if(eval > Score[1])
        {
            Score[2] = Score[1];
            Score[1] = eval;

            Best[2] = Best[1];
            Best[1] = N;
        }
        else if(eval > Score[2])
        {
            Score[2] = eval;
            Best[2] = N;
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
    local Mutator M;

    bAllowBehindView = true;

    Super.InitGame(Options, Error);
    ParseOptions(Options);

    class'xPawn'.Default.ControllerClass = class'Misc_Bot';
    MaxLives = 1;
    bForceRespawn = true;
    bAllowWeaponThrowing = true;

    if(bRandomPickups)
        SpawnRandomPickupBases();

    /* combo related */
    if(!bDisableSpeed)
        EnabledCombos[EnabledCombos.Length] = "xGame.ComboSpeed";

    if(!bDisableBooster)
        EnabledCombos[EnabledCombos.Length] = "xGame.ComboDefensive";

    if(!bDisableBerserk)
        EnabledCombos[EnabledCombos.Length] = "xGame.ComboBerserk";

    if(!bDisableInvis)
        EnabledCombos[EnabledCombos.Length] = "xGame.ComboInvis";
    /* combo related */

    /* weapon related */

    for ( M=Level.Game.BaseMutator; M!=None; M=M.NextMutator )
    {
            if ( M.NextMutator == class'BallisticProV55.Mut_Outfitting' ) //don't bother using this if we're using Loadout
            	return;
    }

    saveconfig();

    RoundsToWin = GoalScore;
    GoalScore = 0;
}

function int ReduceDamage(int Damage, pawn injured, pawn instigatedBy, vector HitLocation, 
                          out vector Momentum, class<DamageType> DamageType)
{
    local Misc_PRI PRI;
    local int OldDamage;
    local int NewDamage;
    local int RealDamage;
    local float Score;
	
	local vector EyeHeight;

    if(bEndOfRound || LockTime > 0)
        return 0;

    if(DamageType == Class'DamTypeSuperShockBeam')
        return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

    if(Misc_Pawn(instigatedBy) != None)
    {
        PRI = Misc_PRI(instigatedBy.PlayerReplicationInfo);
        if(PRI == None)
            return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

        /* self-injury */
        if(injured == instigatedBy)
        {
            OldDamage = Misc_PRI(instigatedBy.PlayerReplicationInfo).AllyDamage;
            
            RealDamage = OldDamage + Damage;

            if(class<DamType_Camping>(DamageType) != None || class<DamType_Overtime>(DamageType) != None)
                return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

            if(class<DamTypeShieldImpact>(DamageType) != None)
                NewDamage = OldDamage;
            else
                NewDamage = RealDamage;

            PRI.AllyDamage = NewDamage;
            Score = NewDamage - OldDamage;
            if(Score > 0.0)
            {
                // log event
                if(Misc_Player(instigatedBy.Controller) != None)
                {
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

            return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
        }
        else if(instigatedBy != injured)
        {
            PRI = Misc_PRI(instigatedBy.PlayerReplicationInfo);
            if(PRI == None)
                return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

            OldDamage = PRI.EnemyDamage;
            NewDamage = OldDamage + Damage;
            PRI.EnemyDamage = NewDamage;

            Score = NewDamage - OldDamage;
            if(Score > 0.0)
            {
                // log event
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
                }
                PRI.Score += Score * 0.01;
                instigatedBy.Controller.AwardAdrenaline((Score * 0.10) * AdrenalinePerDamage);
                
                if(Misc_Player(instigatedBy.Controller) != None)
				{
					if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.bSnipingDamage)
						Misc_Player(instigatedBy.Controller).NextCampCheckTime = Level.TimeSeconds + 25;
                
					else Misc_Player(instigatedBy.Controller).NextCampCheckTime = Level.TimeSeconds + 10;
				}
				
				if (Misc_Player(injured.Controller) != None)
					Misc_Player(injured.Controller).NextCampCheckTime = Level.TimeSeconds + 10;
            }

            if(Damage > (injured.Health + injured.ShieldStrength + 50) && 
                Damage / (injured.Health + injured.ShieldStrength) > 2)
            {
                PRI.OverkillCount++;
                SpecialEvent(PRI, "Overkill");

                if(Misc_Player(instigatedBy.Controller) != None)
                    Misc_Player(instigatedBy.Controller).ReceiveLocalizedMessage(class'Message_Overkill');
                // overkill
            }

        }
    }

    return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
}

auto state PendingMatch
{
    function Timer()
    {
        local Controller P;
        local bool bReady;

        Global.Timer();

        // first check if there are enough net players, and enough time has elapsed to give people
        // a chance to join
        if ( NumPlayers == 0 )
			bWaitForNetPlayers = true;

        if ( bWaitForNetPlayers && (Level.NetMode != NM_Standalone) )
        {
            if ( NumPlayers >= MinNetPlayers )
                ElapsedTime++;
            else
                ElapsedTime = 0;

            if ( (NumPlayers == MaxPlayers) || (ElapsedTime > NetWait) )
            {
                bWaitForNetPlayers = false;
                CountDown = Default.CountDown;
            }
        }
        else if(bForceRUP && bPlayersMustBeReady)
            ElapsedTime++;

        if ( (Level.NetMode != NM_Standalone) && (bWaitForNetPlayers || (bTournament && (NumPlayers < MaxPlayers))) )
        {
       		PlayStartupMessage();
            return;
		}

		// check if players are ready
        bReady = true;
        StartupStage = 1;
        if ( !bStartedCountDown && (bTournament || bPlayersMustBeReady || (Level.NetMode == NM_Standalone)) )
        {
            for (P=Level.ControllerList; P!=None; P=P.NextController )
                if ( P.IsA('PlayerController') && (P.PlayerReplicationInfo != None)
                    && P.bIsPlayer && P.PlayerReplicationInfo.bWaitingPlayer
                    && !P.PlayerReplicationInfo.bReadyToPlay )
                    bReady = false;
        }

        // force ready after 90-ish seconds
        if(!bReady && bForceRUP && bPlayersMustBeReady && (ElapsedTime > 60))
                bReady = true;

        if ( bReady && !bReviewingJumpspots )
        {
			bStartedCountDown = true;
            CountDown--;
            if ( CountDown <= 0 )
                StartMatch();
            else
                StartupStage = 5 - CountDown;
        }
		PlayStartupMessage();
    }
}

function StartMatch()
{
    Super.StartMatch();
	
	if (Level.NetMode != NM_StandAlone && bPracticeRound)
	{
		CurrentRound = 0;
		RoundTime = PracticeRoundLength;
		Misc_BaseGRI(GameReplicationInfo).bPracticeRound = true;
	}
	else
	{
    	CurrentRound = 1;
    	RoundTime = 60 * MinsPerRound;
    }

    Misc_BaseGRI(GameReplicationInfo).CurrentRound = 0; //was 1
    GameEvent("NewRound", string(CurrentRound), none);

	Misc_BaseGRI(GameReplicationInfo).RoundMinute = RoundTime;
    Misc_BaseGRI(GameReplicationInfo).RoundTime = RoundTime;
    RespawnTime = 4;
    LockTime = default.LockTime;    

    bWeaponsLocked = true;
}

function StartNewRound()
{
    RespawnTime = 6;
    LockTime = default.LockTime;    

    bRoundOT = false;
    RoundOTTime = 0;
    RoundTime = 60 * MinsPerRound;

    bWeaponsLocked = true;
    bPendingCheckLocks=False;
    if(unreceptiveControllers.Length != 0)
    	unreceptiveControllers.Remove(0, unreceptiveControllers.Length);
    Misc_BaseGRI(GameReplicationInfo).bWeaponsLocked = true;
	
	if (bPracticeRound && CurrentRound == 0)
		PracticeRoundEnded();

    CurrentRound++;
    Misc_BaseGRI(GameReplicationInfo).CurrentRound = CurrentRound;
    bEndOfRound = false;
    TAM_GRI(GameReplicationInfo).bEndOfRound = false;

    TAM_GRI(GameReplicationInfo).RoundTime = RoundTime;
    TAM_GRI(GameReplicationInfo).RoundMinute = RoundTime;
    Misc_BaseGRI(GameReplicationInfo).NetUpdateTime = Level.TimeSeconds - 1;

    GameEvent("NewRound", string(CurrentRound), none);
}

function bool IsPracticeRound()
{
	return bPracticeRound && (CurrentRound == 0);
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
	Misc_BaseGRI(GameReplicationInfo).bPracticeRound = false;
	Misc_BaseGRI(GameReplicationInfo).NetUpdateTime = Level.TimeSeconds - 1;
}

function SetCamRoundEnded()
{
	local Controller	C;
	local PlayerController PC;
	
	for ( C = Level.ControllerList; C != None; C = C.NextController )
	{
		if (!C.PlayerReplicationInfo.bOnlySpectator)
		{
			PC = PlayerController(C);
			if ( PC != None )
				PC.ClientRoundEnded();
			C.RoundHasEnded();
		}
	}
}

function RespawnPlayers(bool bMoveAlive)
{
    local Controller C;

    for(c = Level.ControllerList; c != None; c = c.NextController)
    {
        if(c == None || c.PlayerReplicationInfo == None || c.PlayerReplicationInfo.bOnlySpectator)
            continue;

        if((c.Pawn == None) && PlayerController(c) != None)
        {
            c.PlayerReplicationInfo.bOutOfLives = false;
            c.PlayerReplicationInfo.NumLives = 1;
            
            PlayerController(c).ClientReset();
            RestartPlayer(c);
        }

        if(Bot(c) != None && bMoveAlive)
        {
            if(c.Pawn != None)
                c.Pawn.Destroy();

            c.PlayerReplicationInfo.bOutOfLives = false;
            c.PlayerReplicationInfo.NumLives = 1;
            RestartPlayer(c);
        }
    }
}

//Removed bot leave code
function RestartPlayer( Controller aPlayer )
{	
	if ( bMustJoinBeforeStart && (UnrealPlayer(aPlayer) != None)
        && UnrealPlayer(aPlayer).bLatecomer )
        return;

    if ( aPlayer.PlayerReplicationInfo.bOutOfLives )
        return;

	Super(UnrealMPGameInfo).RestartPlayer(aPlayer);
}

// modify player logging in
event PostLogin(PlayerController NewPlayer)
{
	local string GUID;
	
	Super.PostLogin(NewPlayer);

    if(!bRespawning && CurrentRound > 0)
    {
        NewPlayer.PlayerReplicationInfo.bOutOfLives = true;
        NewPlayer.PlayerReplicationInfo.NumLives = 0;
        NewPlayer.GotoState('Spectating');
    }
    else if(CurrentRound == 0) 
        RestartPlayer(NewPlayer);

    if(Misc_PRI(NewPlayer.PlayerReplicationInfo) != None)
	{
        Misc_PRI(NewPlayer.PlayerReplicationInfo).JoinRound = CurrentRound;
        if (RespawnTime > 0)
        	Misc_PRI(NewPlayer.PlayerReplicationInfo).JoinRound--;
	}
    if(Misc_Player(NewPlayer) != None)
        Misc_Player(NewPlayer).ClientKillBases();

    CheckMaxLives(None);
	
	//Michie nickname lock hardcode. Fuck that asshole.
	//If this is going to be a feature, then we'll implement it properly.
	GUID = newPlayer.GetPlayerIDHash();
	log("ChangeName: ID hash:"@GUID);
	if (GUID ~= "8ed9e8c8daf8aa03b703825bcac2bbf3")
	{
		if (newPlayer.PlayerReplicationInfo.PlayerName == "~Michie~")
			return;
		ChangeName(newPlayer, "~Michie~", false);
	}
} // PostLogin()

function Logout(Controller Exiting)
{
    Super.Logout(Exiting);
    CheckMaxLives(none);

    if(NumPlayers <= 0 && !bWaitingToStartMatch && !bGameEnded && !bGameRestarted)
        RestartGame();
}

function bool AllowBecomeActivePlayer(PlayerController P)
{
    local bool b;

    b = true;
    if(P.PlayerReplicationInfo == None || (NumPlayers >= MaxPlayers) || P.IsInState('GameEnded'))
    {
        P.ReceiveLocalizedMessage(GameMessageClass, 13);
        b = false;
    }

    if(b && Level.NetMode == NM_Standalone && NumBots > InitialBots)
    {
        RemainingBots--;
        bPlayerBecameActive = true;

        if(Misc_PRI(P.PlayerReplicationInfo) != None)
		{
            Misc_PRI(P.PlayerReplicationInfo).JoinRound = CurrentRound;
			if (RespawnTime > 0)
				Misc_PRI(P.PlayerReplicationInfo).JoinRound--;
		}
	}

    return b;
}

// add bot to the game
function bool AddBot(optional string botName)
{
	local Bot NewBot;

    NewBot = SpawnBot(botName);
	if ( NewBot == None )
	{
        warn("Failed to spawn bot.");
        return false;
    }

    // broadcast a welcome message.
    BroadcastLocalizedMessage(GameMessageClass, 1, NewBot.PlayerReplicationInfo);

    NewBot.PlayerReplicationInfo.PlayerID = CurrentID++;
    NumBots++;

	if(!bRespawning && CurrentRound > 0)
	{
		NewBot.PlayerReplicationInfo.bOutOfLives = true;
		NewBot.PlayerReplicationInfo.numLives = 0;
    	
		if ( Level.NetMode == NM_Standalone )
			RestartPlayer(NewBot);
		else
			NewBot.GotoState('Dead','MPStart');
	}
	else
		RestartPlayer(NewBot);

    //NewBot.bAdrenalineEnabled = bAllowAdrenaline;

    CheckMaxLives(none);

	return true;
} // AddBot()

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

function AddGameSpecificInventory(Pawn P)
{
    Super.AddGameSpecificInventory(P);

    if(p == None || p.Controller == None || p.Controller.PlayerReplicationInfo == None)
        return;

    SetupPlayer(P);
    GiveWeapons(P);
    GiveAmmo(P);

    // sort-of hackfix to reduce the chances of the dreaded 'no-weapon bug'...only slightly works
    if(Misc_Player(P.Controller) != None)
        Misc_Player(P.Controller).ServerThrowWeapon();
}

function SetupPlayer(Pawn P)
{
    local byte won;
    local int health;
    local int armor;
    local float formula;

    if(bChallengeMode)
    {
        won = int(P.PlayerReplicationInfo.Score / 10000);
        
        if(RoundsToWin > 0)
            formula = (0.5 / RoundsToWin);
        else
            formula = 0.0;

        health = StartingHealth - ((StartingHealth * formula) * won);
        armor = StartingArmor - ((StartingArmor * formula) * won);

        p.Health = Max(40, health);
        p.HealthMax = Max(40, health);
        p.SuperHealthMax = int(health * MaxHealth);
        
        xPawn(p).ShieldStrengthMax = int(armor * MaxHealth);
        p.AddShieldStrength(Max(0, armor));
    }
    else
    {
        p.Health = StartingHealth;
        p.HealthMax = StartingHealth;
        p.SuperHealthMax = StartingHealth * MaxHealth;

        xPawn(p).ShieldStrengthMax = StartingArmor * MaxHealth;
        p.AddShieldStrength(StartingArmor);
    }

    if(Misc_Player(p.Controller) != None)
        xPawn(p).Spree = Misc_Player(p.Controller).Spree;

    if(!bWeaponsLocked)
        LockWeaponsFor(P.Controller, false);
}

function GiveWeapons(Pawn P)
{
    local int i;

    for(i = 0; i < ArrayCount(WeaponInfo); i++)
    {
        if(WeaponInfo[i].WeaponName == "" || WeaponInfo[i].Ammo[0] <= 0)
            continue;
        
        p.GiveWeapon(WeaponInfo[i].WeaponName);
    }
}

function GiveAmmo(Pawn P)
{
    local Inventory inv;
    local int i;

    for(inv = P.Inventory; inv != None; inv = inv.Inventory)
    {
        if(Weapon(inv) == None)
            continue;

        for(i = 0; i < ArrayCount(WeaponInfo); i++)
        {
            if(WeaponInfo[i].WeaponName == "" || (WeaponInfo[i].Ammo[0] <= 0 && WeaponInfo[i].Ammo[1] <= 0))
                continue;

            if(string(inv.Class) ~= WeaponInfo[i].WeaponName)
            {
                if(WeaponInfo[i].Ammo[0] > 0)
                    Weapon(inv).AmmoCharge[0] = WeaponInfo[i].Ammo[0];

                if(WeaponInfo[i].Ammo[1] > 0)
                    Weapon(inv).AmmoCharge[1] = WeaponInfo[i].Ammo[1];

                break;
            }
        }
    }
}

function SendCountdownMessage(int time)
{
    local Controller c;

    for(c = Level.ControllerList; c != None; c = c.NextController)
    {
        if(PlayerController(c) != None)
            PlayerController(c).ReceiveLocalizedMessage(class'Message_WeaponsLocked', time);
    }
}

function LockWeapons(bool bLock)
{
    local Controller c;

    if(bWeaponsLocked != bLock)
    {
        bWeaponsLocked = bLock;
        Misc_BaseGRI(GameReplicationInfo).bWeaponsLocked = bLock;
        GameReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
    }

    for(c = Level.ControllerList; c != None; c = c.NextController)
        LockWeaponsFor(c, bLock);
		
	if (!bLock)
    {
    	bPendingCheckLocks = True;
    	NextCheckLockTime = Level.TimeSeconds + CheckLockInterval;
    }
}

function LockWeaponsFor(Controller c, bool bLock)
{
    if(xPawn(c.Pawn) != None)
    {
        xPawn(c.Pawn).bNoWeaponFiring = bLock;

        if(Misc_Player(c) != None)
            Misc_Player(c).ClientLockWeapons(bLock);
    }
}

state MatchInProgress
{
    function Timer()
    {
        local Actor Reset;
        local Controller c;

        if(NextRoundTime > 0)
        {
            GameReplicationInfo.bStopCountDown = true;
            NextRoundTime--;

            if(NextRoundTime == 0)
                StartNewRound();
            else
            {
                if(NextRoundTime == 5 && !IsPracticeRound())
                    AnnounceBest();
                if(NextRoundTime == 3)
                {
                	for  (C = Level.ControllerList; C != None; C = C.NextController)
                	{
                		if (UnrealPlayer(C) != None)
                			UnrealPlayer(C).ClientDelayedAnnouncementNamed('NewRoundIn', 18);
                	}
                }

                Super.Timer();
                return;
            }
        }
        else if(bRoundOT)
        {
            RoundOTTime++;

            if(RoundOTTime % OTInterval == 0)
            {
                for(c = Level.ControllerList; c != None; c = c.NextController)
                {
                    if(c.Pawn == None)
                        continue;

                    if(c.Pawn.Health <= OTDamage && c.Pawn.ShieldStrength <= 0)
                        c.Pawn.TakeDamage(1000, c.Pawn, Vect(0,0,0), Vect(0,0,0), class'DamType_Overtime');
                    else
                    {                           
                        if(int(c.Pawn.ShieldStrength) > 0)
                            c.Pawn.ShieldStrength = int(c.Pawn.ShieldStrength) - Min(c.Pawn.ShieldStrength, OTDamage);
                        else
                            c.Pawn.Health -= OTDamage;
                        c.Pawn.TakeDamage(0.01, c.Pawn, Vect(0,0,0), Vect(0,0,0), class'DamType_Overtime');
                    }
                }
            }
        }
        else if(LockTime > 0)
        {
            LockTime--;
            SendCountdownMessage(LockTime);
            
            if(LockTime == 0)
            {
                LockWeapons(false);
                GameReplicationInfo.bStopCountdown = false;
            }
        }
        else if(RoundTime > 0)
        {
            RoundTime--;
            TAM_GRI(GameReplicationInfo).RoundTime = RoundTime;
            if(RoundTime % 60 == 0)
                TAM_GRI(GameReplicationInfo).RoundMinute = RoundTime;
            if(RoundTime == 0)
            {
            	if (IsPracticeRound())
            		EndRound(None);
            	else
                bRoundOT = true;
            }
        }
		
		if (bPendingCheckLocks && NextCheckLockTime < Level.TimeSeconds)
        	CheckLocks();

        if(RespawnTime > 0)
        {
            RespawnTime--;
            bRespawning = RespawnTime > 0;

            if(RespawnTime == 5)
            {
                for(c = Level.ControllerList; c != None; c = c.NextController)
                {
                    if(Misc_Player(c) != None)
                    {
                        Misc_Player(c).Spree = 0;
                        //Misc_Player(c).ClientEnhancedTrackAllPlayers(false, true, false);
                        Misc_Player(c).ClientResetClock(MinsPerRound * 60);
                    }

                    if(c.PlayerReplicationInfo == None || c.PlayerReplicationInfo.bOnlySpectator)
                        continue;
                    
                    if(xPawn(c.Pawn) != None)
                    {
                        c.Pawn.RemovePowerups();

                        if(Misc_Player(c) != None)
                            Misc_Player(c).Spree = xPawn(c.Pawn).Spree;

                        c.Pawn.Destroy();
                    }

                    c.PlayerReplicationInfo.bOutOfLives = false;
                    c.PlayerReplicationInfo.NumLives = 1;
                    
                    if(PlayerController(c) != None)
                        PlayerController(c).ClientReset();
                    c.Reset();
                    if(PlayerController(c) != None)
                        PlayerController(c).GotoState('Spectating');                     
                }

                ForEach AllActors(class'Actor', Reset)
                {
                    if(DestroyActor(Reset))
                        Reset.Destroy();
                    else if(ResetActor(Reset))
                        Reset.Reset();
                }
                
              if (!bRespawning)
								RespawnKillFailed();
            }

            if(RespawnTime <= 5)
                RespawnPlayers(false);
        }
        
        CheckForCampers();

        Super.Timer();
    }    
}

function CheckLocks()
{
	local int i;
	local Controller C;
	
	if (unreceptiveControllers.Length == 0) {
		for(C = Level.ControllerList; C != None; C = C.NextController) {
			if (Misc_Player(C) == None || C.Pawn == None || C.PlayerReplicationInfo == None || C.PlayerReplicationInfo.bOnlySpectator)
				continue;
			if (Misc_Player(C).bClientAcknowledgedUnlock)
				continue;
			unreceptiveControllers[unreceptiveControllers.Length] = Misc_Player(C);
		}
		
		if(unreceptiveControllers.Length == 0)	{
			bPendingCheckLocks = False;
			return;
		}
	
		else {
			for (i = 0;	i < unreceptiveControllers.Length; i++)
				unreceptiveControllers[i].ClientLockWeapons(false);
		
			NextCheckLockTime = Level.TimeSeconds + CheckLockInterval;
			return;
		}
	}
	
	else{
		for (i=0; i<unreceptiveControllers.Length; i++){
			if (unreceptiveControllers[i] == None || unreceptiveControllers[i].Pawn == None || unreceptiveControllers[i].bClientAcknowledgedUnlock) {
				unreceptiveControllers.Remove(i, 1);
				i--;
				continue;
			}
			unreceptiveControllers[i].ClientLockWeapons(false);
		}
		
		if(unreceptiveControllers.Length == 0)
			bPendingCheckLocks=False;
		
		else NextCheckLockTime = Level.TimeSeconds + CheckLockInterval;
	}
}

function RespawnKillFailed()
{
	local Controller C;
	
	if (IsPracticeRound())
		return;
	
	for (C = Level.ControllerList; C != None; C = C.NextController)
	{		
		if (C.PlayerReplicationInfo != None)
		{
			if (C.Pawn != None)
				continue;
			
			C.PlayerReplicationInfo.bOutOfLives = true;
      C.PlayerReplicationInfo.NumLives = 0;
		
			if (PlayerController(C) != None)
				PlayerController(C).GoToState('Spectating');
		}
	}
}

function bool DestroyActor(Actor A)
{
    if(Projectile(A) != None)
        return true;
    else if(Sandbag(A) != None)
    	return true;
   	else if(BallisticTurret(A) != None)
 		return true;
    else if(xPawn(A) != None && xPawn(A).Health > 0 && (xPawn(A).Controller == None || xPawn(A).PlayerReplicationInfo == None))
        return true;

    return false;
}

function bool ResetActor(Actor A)
{
    if(Mover(A) != None || DECO_ExplodingBarrel(A) != None)
        return true;

    return false;
}

function CheckForCampers()
{
  local Controller c;
  local Box HistoryBox;
  local float MaxDim;
  local int i;
  local Misc_PRI P;

  for(C = Level.ControllerList; C != None; C = c.NextController)
  {
  	P = Misc_PRI(C.PlayerReplicationInfo);
  	
		if (P == None)
			continue;
  	  	
		if(C.PlayerReplicationInfo.bOnlySpectator || C.PlayerReplicationInfo.bOutOfLives || C.Pawn == None)
		{
			P.NextLocHistSlot = 0;
			P.bWarmedUp = false;
			
			P.bWarned = false;
			P.bWaterWarned = false;
			P.ConsecutiveCampCount = 0;
			P.WaterCampCount = 0;
			P.ReWarnTime = 0;		
			P.WaterReWarnTime = 0;		
			continue;
    }


    P.LocationHistory[P.NextLocHistSlot] = C.Pawn.Location;
    P.NextLocHistSlot++;

    if(P.NextLocHistSlot == 10)
    {
		P.NextLocHistSlot = 0;
		P.bWarmedUp = true;
    }

		if(P.bWarmedUp)
		{
			HistoryBox.Min.X = P.LocationHistory[0].X;
			HistoryBox.Min.Y = P.LocationHistory[0].Y;
			HistoryBox.Min.Z = P.LocationHistory[0].Z;
			
			HistoryBox.Max.X = p.LocationHistory[0].X;
			HistoryBox.Max.Y = p.LocationHistory[0].Y;
			HistoryBox.Max.Z = p.LocationHistory[0].Z;

			for(i = 1; i < 10; i++)
			{
				HistoryBox.Min.X = FMin(HistoryBox.Min.X, p.LocationHistory[i].X);
				HistoryBox.Min.Y = FMin(HistoryBox.Min.Y, p.LocationHistory[i].Y);
				HistoryBox.Min.Z = FMin(HistoryBox.Min.Z, p.LocationHistory[i].Z);

				HistoryBox.Max.X = FMax(HistoryBox.Max.X, p.LocationHistory[i].X);
				HistoryBox.Max.Y = FMax(HistoryBox.Max.Y, p.LocationHistory[i].Y);
				HistoryBox.Max.Z = FMax(HistoryBox.Max.Z, p.LocationHistory[i].Z);
			}
	
			MaxDim = FMax(FMax(HistoryBox.Max.X - HistoryBox.Min.X, HistoryBox.Max.Y - HistoryBox.Min.Y), HistoryBox.Max.Z - HistoryBox.Min.Z);
			//see if this works down here.
			if (Misc_Player(C) != None && Misc_Player(C).NextCampCheckTime >= Level.TimeSeconds)
			{
			  P.bWarned = false;
			  P.ConsecutiveCampCount = 0;
			  P.ReWarnTime = 0;	
				continue;
			}

			//added block to deal with players using fog-dense water volumes.
			//they are given a fair bit of grace with this, but players will be notified that they are in a fog-dense water volume specifically if this is triggered
			if (C.Pawn != None && C.Pawn.PhysicsVolume.bWaterVolume && C.Pawn.PhysicsVolume.DistanceFogEnd < 7000 && P.WaterReWarnTime == 0)
			{
				if (P.WaterCampCount > MaxWaterCampChecks)
				{
					PunishWaterCamper(C);
				}
				P.WaterCampCount++;
				P.WaterReWarnTime = CampInterval - 1;
			}
			
			else if (C.Pawn != None && !C.Pawn.PhysicsVolume.bWaterVolume && P.WaterReWarnTime == 0) //prevent quick jumping out of water and back in
			{
				P.bWaterWarned = false;
				P.WaterReWarnTime = 0;
				P.WaterCampCount = MaxWaterCampChecks;
			}

			else if (p.WaterReWarnTime > 0)
				P.WaterReWarnTime--;	

			if(MaxDim < CampThreshold && P.ReWarnTime == 0)
			{
				PunishCamper(C);
				P.ReWarnTime = CampInterval - 1;
			}
			else if(MaxDim > CampThreshold)
			{
				P.bWarned = false;
				P.ConsecutiveCampCount = 0;
				P.ReWarnTime = 0;
			}
			else if(p.ReWarnTime > 0)
				P.ReWarnTime--;
		}
	}
}

function PunishCamper(Controller C)
{	
	local Misc_PRI P;
	local Pawn Camper;
	
	SendCamperWarning(C);
	
	P = Misc_PRI(C.PlayerReplicationInfo);
	if (P == None)
		return;
	
	if(!P.bWarned)
  {
		P.bWarned = true;
		return;
  }
  
  Camper = C.Pawn;
  
  if (Camper.IsA('Vehicle') && Vehicle(Camper).Driver != None)
  	Camper = Vehicle(Camper).Driver;
		
	if(Camper.Health <= (10 * (P.CampCount + 1)) && Camper.ShieldStrength <= 0)
	  Camper.TakeDamage(1000,Camper, Vect(0,0,0), Vect(0,0,0), class'DamType_Camping');
	else
	{                           
	  if(int(Camper.ShieldStrength) > 0)
			Camper.ShieldStrength = Max(0, Camper.ShieldStrength - (10 * (P.CampCount + 1)));
	  else
			Camper.Health -= 10 * (P.CampCount + 1);
			
	  Camper.TakeDamage(0.01, Camper, Vect(0,0,0), Vect(0,0,0), class'DamType_Camping');
	}
	
  if(Level.NetMode == NM_DedicatedServer && P.Ping * 4 < 999)
  {
		P.CampCount++;
		P.ConsecutiveCampCount++;    

		if(bKickExcessiveCampers && PlayerController(C) != None && P.ConsecutiveCampCount >= 4)
		{
			AccessControl.DefaultKickReason = AccessControl.IdleKickReason;
			AccessControl.KickPlayer(PlayerController(C));
			AccessControl.DefaultKickReason = AccessControl.Default.DefaultKickReason;
		}
	}
}

function PunishWaterCamper(Controller C)
{	
	local Misc_PRI P;
	local Pawn Camper;

	SendWaterCamperWarning(C);
	
	P = Misc_PRI(C.PlayerReplicationInfo);
	if (P == None)
		return;
	
	if(!P.bWaterWarned)
  {
		P.bWaterWarned = true;
		return;
  }
  
  Camper = C.Pawn;
  
  if (Camper.IsA('Vehicle') && Vehicle(Camper).Driver != None)
  	Camper = Vehicle(Camper).Driver;
		
	if(Camper.Health <= (10 * (P.WaterCampCount + 1 - MaxWaterCampChecks)) && Camper.ShieldStrength <= 0)
	  Camper.TakeDamage(1000,Camper, Vect(0,0,0), Vect(0,0,0), class'DamType_Camping');
	else
	{                           
	  if(int(Camper.ShieldStrength) > 0)
			Camper.ShieldStrength = Max(0, Camper.ShieldStrength - (10 * (P.WaterCampCount - MaxWaterCampChecks)));
	  else
			Camper.Health -= 10 * (P.WaterCampCount - MaxWaterCampChecks);
			
	  Camper.TakeDamage(0.01, Camper, Vect(0,0,0), Vect(0,0,0), class'DamType_Camping');
	}
	
  if(Level.NetMode == NM_DedicatedServer && P.Ping * 4 < 999)
  {
    if(bKickExcessiveCampers && PlayerController(C) != None && P.ConsecutiveCampCount >= 4)
    {
      AccessControl.DefaultKickReason = AccessControl.IdleKickReason;
      AccessControl.KickPlayer(PlayerController(C));
      AccessControl.DefaultKickReason = AccessControl.Default.DefaultKickReason;
    }
  }
}

function SendCamperWarning(Controller Camper)
{
	local Controller C;

	for(C = Level.ControllerList; C != None; C = C.NextController)
	{
		if (PlayerController(C) != None)
			PlayerController(C).ReceiveLocalizedMessage(class'Message_Camper', int(C != Camper), Camper.PlayerReplicationInfo);
	}
}

function SendWaterCamperWarning(Controller Camper)
{
	local Controller C;

	for(C = Level.ControllerList; C != None; C = C.NextController)
	{
		if (PlayerController(C) != None)
			PlayerController(C).ReceiveLocalizedMessage(class'Message_WaterCamper', int(C != Camper), Camper.PlayerReplicationInfo);
	}
}

function Killed(Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> DamageType)
{
    Super.Killed(Killer, Killed, KilledPawn, DamageType);

    if(Killed != None && Killed.PlayerReplicationInfo != None)
    {
        if(bRespawning)
        {
            Killed.PlayerReplicationInfo.bOutOfLives = false;
            Killed.PlayerReplicationInfo.NumLives = 1;
            return;
        }
        else
        {
            Killed.PlayerReplicationInfo.bOutOfLives = true;
            Killed.PlayerReplicationInfo.NumLives = 0;
        }
		
		Misc_PRI(Killed.PlayerReplicationInfo).DarkSoulPower = 0;
        Misc_PRI(Killed.PlayerReplicationInfo).NovaSoulPower = 0;
		Misc_PRI(Killed.PlayerReplicationInfo).XOXOLewdness = 0;
    }
}

// used to show 'player is out' message
function NotifyKilled(Controller Killer, Controller Other, Pawn OtherPawn)
{
	Super.NotifyKilled(Killer, Other, OtherPawn);
	SendPlayerIsOutText(Other);
} // NotifyKilled()

// shows 'player is out' message
function SendPlayerIsOutText(Controller Out)
{
	local Controller c;

	if(Out == None)
		return;

	for(c = Level.ControllerList; c != None; c = c.nextController)
        if(PlayerController(c) != None)
            PlayerController(c).ReceiveLocalizedMessage(class'Message_PlayerIsOut', int(PlayerController(c) != PlayerController(Out)), Out.PlayerReplicationInfo);
} // SendPlayerIsOutText()

function bool CanSpectate(PlayerController Viewer, bool bOnlySpectator, actor ViewTarget)
{
    if(xPawn(ViewTarget) == None && (Controller(ViewTarget) == None || xPawn(Controller(ViewTarget).Pawn) == None))
        return false;

    if(bOnlySpectator)
    {
        if(Controller(ViewTarget) != None)
            return (Controller(ViewTarget).PlayerReplicationInfo != None && ViewTarget != Viewer);
        else
            return (xPawn(ViewTarget).IsPlayerPawn());
    }

    if(bRespawning || (NextRoundTime <= 1 && bEndOfRound))
        return false;

    if(Controller(ViewTarget) != None)
        return (Controller(ViewTarget).PlayerReplicationInfo != None && ViewTarget != Viewer);
    else
        return (xPawn(ViewTarget).IsPlayerPawn() && xPawn(ViewTarget).PlayerReplicationInfo != None);
}

// check if all other players are out
function bool CheckMaxLives(PlayerReplicationInfo Scorer)
{
    local Controller C;
    local PlayerReplicationInfo Living;
    local bool bNoneLeft;

    if(bWaitingToStartMatch || bEndOfRound || bWeaponsLocked || IsPracticeRound())
        return false;

	if((Scorer != None) && !Scorer.bOutOfLives)
		Living = Scorer;
    
    bNoneLeft = true;
    for(C = Level.ControllerList; C != None; C = C.NextController)
    {
        if((C.PlayerReplicationInfo != None) && C.bIsPlayer
            && (!C.PlayerReplicationInfo.bOutOfLives)
            && !C.PlayerReplicationInfo.bOnlySpectator)
        {
			if(Living == None)
				Living = C.PlayerReplicationInfo;
			else if(C.PlayerReplicationInfo != Living)
			{
    	        bNoneLeft = false;
	            break;
			}
        }
    }

    if(bNoneLeft)
    {
		if(Living != None)
			EndRound(Living);
		else
			EndRound(Scorer);
		return true;
	}

    return false;
}

function EndRound(PlayerReplicationInfo Scorer)
{
    local Controller c;
    local PlayerController PC;

    bEndOfRound = true;
    TAM_GRI(GameReplicationInfo).bEndOfRound = true;
	
	RemoveExcessBots();

	if (IsPracticeRound())
	{
		SetCamRoundEnded();
		NextRoundTime = NextRoundDelay;
		return;
	}

    if(Scorer == None)
    {
        NextRoundTime = NextRoundDelay;
        return;
    }

    Scorer.Score += 10000;
    ScoreEvent(Scorer, 0, "ObjectiveScore");

    if(int(Scorer.Score / 10000) >= RoundsToWin)
    {
        AnnounceBest();
        EndGame(Scorer, "LastMan");
    }
    else
    {
        for(c = Level.ControllerList; c != None; c = c.NextController)
        {
            PC = PlayerController(c);

            if(PC != None && PC.PlayerReplicationInfo != None)
            {
                if(PC.PlayerReplicationInfo == Scorer || (PC.PlayerReplicationInfo.bOnlySpectator && 
                    (xPawn(PC.ViewTarget) != None && xPawn(PC.ViewTarget).PlayerReplicationInfo == Scorer) || 
                    (Controller(PC.ViewTarget) != None && Controller(PC.ViewTarget).PlayerReplicationInfo == Scorer)))
                    PC.ReceiveLocalizedMessage(class'Message_YouveXTheRound', 1);
                else
                    PC.ReceiveLocalizedMessage(class'Message_YouveXTheRound', 0);
            }
        }

        NextRoundTime = NextRoundDelay;
    }
}


//===========================================================================
// RemoveExcessBots
//===========================================================================
function RemoveExcessBots()
{
	local Controller aPlayer, PendingController;
	
	bAllowBotRemoval = True;
	
	aPlayer=Level.ControllerList;
	
	while (aPlayer != None)
	{		
		if (Bot(aPlayer) == None)
		{
			aPlayer = aPlayer.NextController;
			continue;
		}

		if (TooManyBots(aPlayer) )
		{
			PendingController = aPlayer.NextController;
			aPlayer.Destroy();
			aPlayer = PendingController;
			continue;
		}
		
		break;
	}
	
	bAllowBotRemoval = False;
}

function bool TooManyBots(Controller Questioned)
{
	if (!bAllowBotRemoval)
		return false;
	
	return Super.TooManyBots(Questioned);
}


function AnnounceBest()
{
    local Controller C;

    local string acc;
    local string dam;
    local string kd;
	local string de;

    local Misc_PRI PRI;
    local BallisticPlayerReplicationInfo BWPRI;
    
    local Misc_PRI accuracy;
    local Misc_PRI damage;
    local Misc_PRI kill_eff, damage_eff;

    local BallisticPlayerReplicationInfo accuracyBW;

    local string Text;
    local string Green;
    local Color  color;

    color.r = 100;
    color.g = 200;
    color.b = 100;
    Green = class'DMStatsScreen'.static.MakeColorCode(color);

    color.b = 210;
    color.r = 210;
    color.g = 210;
    Text = class'DMStatsScreen'.static.MakeColorCode(color);

    for(C = Level.ControllerList; C != None; C = C.NextController)
	{
		PRI = Misc_PRI(C.PlayerReplicationInfo);

		if(PRI == None || PRI.bOnlySpectator)
			continue;

		BWPRI = class'Mut_Ballistic'.static.GetBPRI(PRI);
	
		if (BWPRI == None)
			continue;

		BWPRI.ProcessHitStats();
		
		if(accuracyBW == None || (accuracyBW.AveragePercent < BWPRI.AveragePercent))
		{
			accuracy = PRI;
			accuracyBW = BWPRI;
		}

		if(damage == None || (damage.EnemyDamage < PRI.EnemyDamage))
            damage = PRI;
            
        if(kill_eff == None || kill_eff.CalcKillEfficiency() < PRI.CalcKillEfficiency())
            kill_eff = PRI;

        if (damage_eff == None || kill_eff.CalcDamageEfficiency() < PRI.CalcDamageEfficiency())
            damage_eff = PRI;
	}

    if(accuracy != None && accuracyBW.AveragePercent > 0.0)
        acc = Text$"Most Accurate:"@Green$accuracy.PlayerName$Text$";"@accuracyBW.AveragePercent$"%";

    if(damage != None && damage.EnemyDamage > 0)
        dam = Text$"Most Damage:"@Green$damage.PlayerName$Text$";"@damage.EnemyDamage;

    if(kill_eff != None && kill_eff.Kills > 0)
    {
        kd = Text$"Highest Kill Efficiency:"@Green$kill_eff.PlayerName$Text$";"@kill_eff.CalcKillEfficiency();
    }

    if(damage_eff != None && damage_eff.EnemyDamage > 0)
    {
        de = Text$"Highest Damage Efficiency:"@Green$damage_eff.PlayerName$Text$";"@damage_eff.CalcDamageEfficiency();
    }

	for(C = Level.ControllerList; C != None; C = C.NextController)
		if(Misc_Player(c) != None)
			Misc_Player(c).ClientListBest(acc, dam, kd, de);
}

function SetMapString(Misc_Player Sender, string s)
{
    if(Level.NetMode == NM_Standalone || Sender.PlayerReplicationInfo.bAdmin)
        NextMapString = s;
}

function EndGame(PlayerReplicationInfo PRI, string Reason)
{
    Super.EndGame(PRI, Reason);
    ResetDefaults();
}

function RestartGame()
{
    ResetDefaults();
    Super.RestartGame();
}

function ProcessServerTravel(string URL, bool bItems)
{
    ResetDefaults();
    Super.ProcessServerTravel(URL, bItems);
}

function ResetDefaults()
{
    local int i;
    local class<Weapon> WeaponClass;

    if(bDefaultsReset)
        return;
    bDefaultsReset = true;

    GoalScore = RoundsToWin;

    // apply changes made by an admin
    if(NextMapString != "")
    {
        ParseOptions(NextMapString);
        saveconfig();
        NextMapString = "";
    }

    // set all defaults back to their original values
    Class'xPawn'.Default.ControllerClass = class'XGame.xBot';
    Class'XGame.ComboSpeed'.default.Duration = 16;

    for(i = 0; i < ArrayCount(WeaponDefaults); i++)
    {
        if(WeaponDefaults[i].WeaponName ~= "")
            continue;

        WeaponClass = class<Weapon>(DynamicLoadObject(WeaponDefaults[i].WeaponName, class'Class'));

        if(WeaponClass == None)
            continue;

        // reset defaults
        if(class<Translauncher>(WeaponClass) != None && WeaponDefaults[i].Ammo[0] > 0)
        {
            Class'XWeapons.Translauncher'.default.AmmoChargeRate = WeaponDefaults[i].MaxAmmo[0]; 
		    Class'XWeapons.Translauncher'.default.AmmoChargeMax = WeaponDefaults[i].Ammo[0];
		    Class'XWeapons.Translauncher'.default.AmmoChargeF = WeaponDefaults[i].MaxAmmo[1];

            continue;
        }

        if(WeaponClass.default.FireModeClass[0].default.AmmoClass != None)
        {
            WeaponClass.default.FireModeClass[0].default.AmmoClass.default.InitialAmount = WeaponDefaults[i].Ammo[0];
            WeaponClass.default.FireModeClass[0].default.AmmoClass.default.MaxAmmo = WeaponDefaults[i].MaxAmmo[0];
        }

        if(WeaponClass.default.FireModeClass[1].default.AmmoClass != None && (WeaponClass.default.FireModeClass[0].default.AmmoClass != WeaponClass.default.FireModeClass[1].default.AmmoClass))
        {
            WeaponClass.default.FireModeClass[1].default.AmmoClass.default.InitialAmount = WeaponDefaults[i].Ammo[1];
            WeaponClass.default.FireModeClass[1].default.AmmoClass.default.MaxAmmo = WeaponDefaults[i].MaxAmmo[1];
        }
    }

    if(bModifyShieldGun)
	{
		Class'XWeapons.ShieldFire'.default.SelfForceScale = 1.000000;
		Class'XWeapons.ShieldFire'.default.SelfDamageScale = 0.300000;
		Class'XWeapons.ShieldFire'.default.MinSelfDamage = 8.000000;
	}

    class'FlakChunk'.default.MyDamageType = class'DamTypeFlakChunk';
    class'FlakShell'.default.MyDamageType = class'DamTypeFlakShell';
    class'BioGlob'.default.MyDamageType = class'DamTypeBioGlob';
}

function ChangeName(Controller Other, string S, bool bNameChange)
{
    local Controller APlayer, P;

    if ( S == "" )
        return;

	S = StripColor(s);	// Stip out color codes

    if (Other.PlayerReplicationInfo.playername~=S)
        return;

	S = Left(S,20);
    ReplaceText(S, " ", "_");
    ReplaceText(S, "|", "I");

	if ( bEpicNames && (Bot(Other) != None) )
	{
		if ( TotalEpic < 21 )
		{
			S = EpicNames[EpicOffset % 21];
			EpicOffset++;
			TotalEpic++;
		}
		else
		{
			S = NamePrefixes[NameNumber%10]$"CliffyB"$NameSuffixes[NameNumber%10];
			NameNumber++;
		}
	}

    for( APlayer=Level.ControllerList; APlayer!=None; APlayer=APlayer.nextController )
        if ( APlayer.bIsPlayer && (APlayer.PlayerReplicationInfo.playername~=S) )
        {
            if ( Other.IsA('PlayerController') )
            {
                PlayerController(Other).ReceiveLocalizedMessage( GameMessageClass, 8 );
				return;
			}
			else
			{
				if ( Other.PlayerReplicationInfo.bIsFemale )
				{
					S = FemaleBackupNames[FemaleBackupNameOffset%32];
					FemaleBackupNameOffset++;
				}
				else
				{
					S = MaleBackupNames[MaleBackupNameOffset%32];
					MaleBackupNameOffset++;
				}
				for( P=Level.ControllerList; P!=None; P=P.nextController )
					if ( P.bIsPlayer && (P.PlayerReplicationInfo.playername~=S) )
					{
						S = NamePrefixes[NameNumber%10]$S$NameSuffixes[NameNumber%10];
						NameNumber++;
						break;
					}
				break;
			}
            S = NamePrefixes[NameNumber%10]$S$NameSuffixes[NameNumber%10];
            NameNumber++;
            break;
        }

	if( bNameChange )
		GameEvent("NameChange",s,Other.PlayerReplicationInfo);

	if ( S ~= "CliffyB" )
		bEpicNames = true;
    Other.PlayerReplicationInfo.SetPlayerName(S);
    // notify local players
    if  ( bNameChange )
		Broadcast(self, Other.PlayerReplicationInfo.OldName@"is now known as"@Other.PlayerReplicationInfo.PlayerName$".");
}

defaultproperties
{
     StartingHealth=100
     StartingArmor=100
     MaxHealth=1.000000
     AdrenalinePerDamage=1.000000
     bDisableInvis=True
     bChallengeMode=True
     bForceRUP=True
     MinsPerRound=4
     OTDamage=5
     OTInterval=3
     CampThreshold=400.000000
     CampInterval=5
     MaxWaterCampChecks=2
     bKickExcessiveCampers=True
     LockTime=4
     NextRoundDelay=7
     WeaponInfo(0)=(WeaponName="xWeapons.AssaultRifle",Ammo[0]=999,Ammo[1]=5,MaxAmmo[0]=1.500000)
     WeaponInfo(1)=(WeaponName="xWeapons.BioRifle",Ammo[0]=20,MaxAmmo[0]=1.500000)
     WeaponInfo(2)=(WeaponName="xWeapons.ShockRifle",Ammo[0]=20,MaxAmmo[0]=1.500000)
     WeaponInfo(3)=(WeaponName="xWeapons.LinkGun",Ammo[0]=100,MaxAmmo[0]=1.500000)
     WeaponInfo(4)=(WeaponName="xWeapons.MiniGun",Ammo[0]=75,MaxAmmo[0]=1.500000)
     WeaponInfo(5)=(WeaponName="xWeapons.FlakCannon",Ammo[0]=12,MaxAmmo[0]=1.500000)
     WeaponInfo(6)=(WeaponName="xWeapons.RocketLauncher",Ammo[0]=12,MaxAmmo[0]=1.500000)
     WeaponInfo(7)=(WeaponName="xWeapons.SniperRifle",Ammo[0]=10,MaxAmmo[0]=1.500000)
     AssaultAmmo=999
     AssaultGrenades=5
     BioAmmo=20
     ShockAmmo=20
     LinkAmmo=100
     MiniAmmo=75
     FlakAmmo=12
     RocketAmmo=12
     LightningAmmo=10
     bWeaponsLocked=True
     CheckLockInterval=5
     PracticeRoundLength=20
     bForceRespawn=True
     ADR_MinorError=-5.000000
     LocalStatsScreenClass=Class'3SPNv3141BW.Misc_StatBoard'
     DefaultPlayerClassName="3SPNv3141BW.Misc_Pawn"
     ScoreBoardType="3SPNv3141BW.AM_Scoreboard"
     HUDType="3SPNv3141BW.AM_HUD"
     GoalScore=5
     MaxLives=1
     DeathMessageClass=Class'3SPNv3141BW.Misc_DeathMessage'
     MutatorClass="3SPNv3141BW.TAM_Mutator"
     PlayerControllerClassName="3SPNv3141BW.Misc_Player"
     GameReplicationInfoClass=Class'3SPNv3141BW.TAM_GRI'
     GameName="BallisticPro: ArenaMaster"
     Description="One life per round. Don't waste it."
     Acronym="AM"
}
