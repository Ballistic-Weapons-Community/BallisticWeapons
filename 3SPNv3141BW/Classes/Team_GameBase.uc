class Team_GameBase extends xTeamGame
	  dependson(BallisticPlayerReplicationInfo)
    abstract
    config;

#exec OBJ LOAD FILE=TeamSymbols.utx

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

var config bool     bForceRUP;              // force players to ready up after...
var config int      ForceSeconds;           // this many seconds

var Controller      DarkHorse;              // last player on a team when the other team has 3+
var string          NextMapString;          // used to save mid-game admin changes in the menu

var byte            Deaths[2];              // set to true if someone on a given team has died (not a flawless)

var bool            bDefaultsReset;
var bool			bAllowBotRemoval;
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

/* timeout related */
var config int      Timeouts;               // number of timeouts per team

var byte            TimeOutTeam;            // team that called timeout
var int             TeamTimeOuts[2];        // number of timeouts remaining per team
var int             TimeOutCount;           // time remaining in timeout
var float           LastTimeOutUpdate;      // keep track of the last update so timeout requests aren't spammed
/* timeout related */

/* spawn related */
var bool            bFirstSpawn;            // first spawn of the round
/* spawn related */

/* round related */
var bool            bEndOfRound;            // true if a round has just ended
var bool            bRespawning;            // true if we're respawning players
var int             RespawnTime;            // time left to respawn
var int             LockTime;               // time left until weapons get unlocked
var int             NextRoundTime;          // time left until the next round starts
var int             NextRoundDelay;         
var int             CurrentRound;           // the current round number (0 = game hasn't started)
/* round related */

/* weapon related */
struct WeaponData
{
    var string WeaponName;
    var int Ammo[2];                        // 0 = primary ammo, 1 = alt ammo
    var float MaxAmmo[2];                   // 1 is only used for WeaponDefaults
};

var WeaponData  WeaponInfo[10];
var WeaponData  WeaponDefaults[10];
var config bool	bModifyShieldGun;     // use the modified shield gun (higher shield jumps) 

var config int  AssaultAmmo;
var config int  AssaultGrenades;
var config int  BioAmmo;
var config int  ShockAmmo;
var config int  LinkAmmo;
var config int  MiniAmmo;
var config int  FlakAmmo;
var config int  RocketAmmo;
var config int  LightningAmmo;

var bool        bWeaponsLocked;
/* added for an attempt to fix the weapon lock issue */
var bool		   bPendingCheckLocks;
var float		   NextCheckLockTime;
var config int CheckLockInterval;

var array<Misc_Player> unreceptiveControllers;
/* weapon related */

/* trial round */
var config bool		bPracticeRound;
var config int		PracticeRoundLength;

/* ballistic precache */
var private const array< class<WeaponPickup> > PrecachePickups;


/* ctf map support */

var xRedFlagBase RFB;
var xBlueFlagBase BFB;
var float FlagSepDist;
var config float MaxDistFactor;

static function PrecacheGameTextures(LevelInfo MyLevel)
{
    class'xTeamGame'.static.PrecacheGameTextures(MyLevel);
}

static function PrecacheGameStaticMeshes(LevelInfo MyLevel)
{
    local int i;
    
    class'xDeathMatch'.static.PrecacheGameStaticMeshes(MyLevel);
    
    for (i=0; i< default.PrecachePickups.Length; i++)
        default.PrecachePickups[i].static.StaticPrecache(myLevel);
}

function InitGameReplicationInfo()
{
    Super.InitGameReplicationInfo();

    if(Misc_BaseGRI(GameReplicationInfo) == None)
        return;

    Misc_BaseGRI(GameReplicationInfo).RoundTime = MinsPerRound * 60;

    Misc_BaseGRI(GameReplicationInfo).StartingHealth = StartingHealth;
    Misc_BaseGRI(GameReplicationInfo).StartingArmor = StartingArmor;
    Misc_BaseGRI(GameReplicationInfo).MaxHealth = MaxHealth;

    Misc_BaseGRI(GameReplicationInfo).MinsPerRound = MinsPerRound;
    Misc_BaseGRI(GameReplicationInfo).OTDamage = OTDamage;
    Misc_BaseGRI(GameReplicationInfo).OTInterval = OTInterval;

    Misc_BaseGRI(GameReplicationInfo).CampThreshold = CampThreshold;
    Misc_BaseGRI(GameReplicationInfo).bKickExcessiveCampers = bKickExcessiveCampers;

    Misc_BaseGRI(GameReplicationInfo).bDisableSpeed = bDisableSpeed;
    Misc_BaseGRI(GameReplicationInfo).bDisableInvis = bDisableInvis;
    Misc_BaseGRI(GameReplicationInfo).bDisableBooster = bDisableBooster;
    Misc_BaseGRI(GameReplicationInfo).bDisableBerserk = bDisableBerserk;

    Misc_BaseGRI(GameReplicationInfo).bForceRUP = bForceRUP;

    Misc_BaseGRI(GameReplicationInfo).Timeouts = Timeouts;

    bWeaponsLocked = true;
    Misc_BaseGRI(GameReplicationInfo).bWeaponsLocked = true;
}

function GetServerDetails(out ServerResponseLine ServerState)
{
    Super.GetServerDetails(ServerState);

    AddServerDetail(ServerState, "3SPN Version", class'Misc_BaseGRI'.default.Version);
}

function GetServerPlayers(out ServerResponseLine ServerState)
{
    local int i;

    Super.GetServerPlayers(ServerState);

    if(Teams[0] == None || Teams[1] == None)
        return;

    i = ServerState.PlayerInfo.Length;
    ServerState.PlayerInfo.Length = i + 2;
    ServerState.PlayerInfo[i].PlayerName = "Red Team";
    ServerState.PlayerInfo[i].Score = Teams[0].Score;
    ServerState.PlayerInfo[i+1].PlayerName = "Blue Team";
    ServerState.PlayerInfo[i+1].Score = Teams[1].Score;
}

static function FillPlayInfo(PlayInfo PI)
{
    Super.FillPlayInfo(PI);

    PI.AddSetting("3SPN", "StartingHealth", "Starting Health", 0, 100, "Text", "3;0:999");
    PI.AddSetting("3SPN", "StartingArmor", "Starting Armor", 0, 101, "Text", "3;0:999");
    PI.AddSetting("3SPN", "MaxHealth", "Max Health", 0, 102, "Text", "8;1.0:2.0");

    PI.AddSetting("3SPN", "MinsPerRound", "Minutes per Round", 0, 120, "Text", "3;0:999");
    PI.AddSetting("3SPN", "OTDamage", "Overtime Damage", 0, 121, "Text", "3;0:999");
    PI.AddSetting("3SPN", "OTInterval", "Overtime Damage Interval", 0, 122, "Text", "3;0:999");

    PI.AddSetting("3SPN", "bPracticeRound", "Practice Round", 0, 309, "Check",,, True);
    PI.AddSetting("3SPN", "PracticeRoundLength", "Practice Round Duration", 0, 310, "Text", "3;0:999",, True);

    PI.AddSetting("3SPN", "CampThreshold", "Camp Area", 0, 150, "Text", "3;0:999",, True);
    PI.AddSetting("3SPN", "bKickExcessiveCampers", "Kick Excessive Campers", 0, 151, "Check",,, True);

    PI.AddSetting("3SPN", "bForceRUP", "Force Ready", 0, 175, "Check",,, True);
    PI.AddSetting("3SPN", "ForceSeconds", "Force Time", 0, 176, "Text", "3;0:999",, True);

    PI.AddSetting("3SPN", "bDisableSpeed", "Disable Speed", 0, 200, "Check");
    PI.AddSetting("3SPN", "bDisableInvis", "Disable Invis", 0, 201, "Check");
    PI.AddSetting("3SPN", "bDisableBerserk", "Disable Berserk", 0, 202, "Check");
    PI.AddSetting("3SPN", "bDisableBooster", "Disable Booster", 0, 203, "Check");

    PI.AddSetting("3SPN", "Timeouts", "TimeOuts Per Team", 0, 220, "Text", "3;0:999",, True);

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

        case "bForceRUP":           return "Force players to ready up after a set amount of time";
        case "ForceSeconds":        return "The amount of time players have to ready up before the game starts automatically";

        case "Timeouts":            return "Number of Timeouts a team can call in one game.";

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

    InOpt = ParseOption(Options, "Timeouts");
    if(InOpt != "")
        Timeouts = int(InOpt);
}

event InitGame(string Options, out string Error)
{
    local Mutator M;

    Super.InitGame(Options, Error);
    ParseOptions(Options);

    class'xPawn'.Default.ControllerClass = class'Misc_Bot';

    MaxLives = 1;
    bForceRespawn = true;
    bAllowWeaponThrowing = true;
    SpawnProtectionTime = 0.000000;

    TimeOutCount = 0;
    TeamTimeOuts[0] = TimeOuts;
    TeamTimeOuts[1] = TimeOuts;

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
}

static function bool AllowMutator(string MutatorClassName)
{
    if(MutatorClassName == "")
        return false;

    return Super.AllowMutator(MutatorClassName);
}

//===================================================
// CTF map support
//===================================================
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

        // force ready after 60-ish seconds
        if(!bReady && bForceRUP && bPlayersMustBeReady && (ElapsedTime >= ForceSeconds))
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

/* timeouts */
// get the state of timeouts (-1 = N/A, 0 = none pending, 1 = one pending on same team, 2 = one pending on other team, 3 = timeouts disabled, 4 = out of timeouts)
function int GetTimeoutState(PlayerController caller)
{
	if(bWaitingToStartMatch)
		return -1;
	
	if (IsPracticeRound())
		return -1;

	if(caller == None || caller.PlayerReplicationInfo == None)
		return -1;

    if(caller.PlayerReplicationInfo.bAdmin) // admins can always call timeouts
        return 0;

    if(Level.TimeSeconds - LastTimeOutUpdate < 3.0)
        return -1;

    if(caller.PlayerReplicationInfo.Team == None)
        return -1;

	if(caller.PlayerReplicationInfo.bOnlySpectator)
		return -1;

	// check if timeouts are even enabled
	if(TimeOuts == 0)
		return 3;

	if(TimeOutTeam == caller.PlayerReplicationInfo.Team.TeamIndex)	
		return 1;
	
    if(TimeOutCount > 0 || TimeOutTeam != 255)
		return 2;

	if(TeamTimeOuts[caller.PlayerReplicationInfo.Team.TeamIndex] <= 0)
		return 4;

    return 0;
}		


// check if a team has timeouts left, and if so, pause the game at the end of the current round
function CallTimeout(PlayerController caller)
{
	local Controller C;
	local int toState;

	toState = GetTimeoutState(caller);

	if(toState == -1)
		return;

    LastTimeOutUpdate = Level.TimeSeconds;

	if(caller.PlayerReplicationInfo == None || (caller.PlayerReplicationInfo.Team == None && !caller.PlayerReplicationInfo.bAdmin))
		return;
	else if(toState == 3)
	{
		caller.ClientMessage("Timeouts are disabled on this server");
		return;
	}
	else if(toState == 1)
	{
		if(TimeOutCount > 0)
		{
			caller.ClientMessage("You can not cancel a Timeout once it takes effect.");
		}		
		else
		{
			EndTimeout();

			for(C = Level.ControllerList; C != None; C = C.NextController)
			{
				if(C != None && C.IsA('PlayerController'))
				{
					if(caller.PlayerReplicationInfo.Team.TeamIndex == 0)
						PlayerController(C).ClientMessage("Red Team canceled the Timeout");
					else
						PlayerController(C).ClientMessage("Blue Team canceled the Timeout");
				}
			}
		}

		return;
	}
	else if(toState == 2)
	{
		caller.ClientMessage("A Timeout is already pending");
		return;
	}
    else if(toState == 4)
    {
        caller.ClientMessage("Your team has no Timeouts remaining");
        return;
    }

    if(caller.PlayerReplicationInfo.bAdmin)
    {
        if(TimeOutCount > 0)
        {
            EndTimeout();

            for(C = Level.ControllerList; C != None; C = C.NextController)
			{
				if(C != None && C.IsA('PlayerController'))
				{
					PlayerController(C).ClientMessage("Admin canceled the Timeout");
				}
			}
        }
        else
        {
            //TimeOutCount = default.TimeOutCount;
            TimeOutTeam = 3;

            for(C = Level.ControllerList; C != None; C = C.NextController)
	        {
		        if(C != None && C.IsA('PlayerController'))
		        {
				    PlayerController(C).ClientMessage("Admin called a Timeout");
		        }
	        }
        }
    }
    else
    {
        //TimeOutCount = default.TimeOutCount;
		TimeOutTeam = caller.PlayerReplicationInfo.Team.TeamIndex;

	    for(C = Level.ControllerList; C != None; C = C.NextController)
	    {
		    if(C != None && C.IsA('PlayerController'))
		    {
			    if(TimeOutTeam == 0)
				    PlayerController(C).ClientMessage("Red Team called a Timeout");
			    else
				    PlayerController(C).ClientMessage("Blue Team called a Timeout");
		    }
	    }
    }
}

// end el timeouto
function EndTimeOut()
{
    TimeOutCount = 0;
    TimeOutTeam = default.TimeOutTeam;
}
/* timeouts */

function int ReduceDamage(int Damage, pawn injured, pawn instigatedBy, vector HitLocation, 
                          out vector Momentum, class<DamageType> DamageType)
{
    local Misc_PRI PRI;
    local int OldDamage;
    local int NewDamage;
    local int RealDamage;
    local int Result;
    local float Score;
    local float RFF;
    local float FF;

    local vector EyeHeight;

    if(LockTime > 0)
        return 0;

    if(bEndOfRound)
    {
        Momentum *= 2.0;
        return 0;
    }
		
	if (Freon_Pawn(injured) != None && Freon_Pawn(injured).Controller == None && (Freon_Pawn(injured).DrivenVehicle == None || Freon_Pawn(injured).DrivenVehicle.Controller == None))
		return 0;

    if(DamageType == Class'DamTypeSuperShockBeam')
        return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
		
    if((Misc_Pawn(instigatedBy) != None || Vehicle(instigatedBy) != None) && instigatedBy.Controller != None && injured.GetTeamNum() != 255 && instigatedBy.GetTeamNum() != 255)
    {
        PRI = Misc_PRI(instigatedBy.PlayerReplicationInfo);
        if(PRI == None)
            return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

        /* same teams */
        if(injured.GetTeamNum() == instigatedBy.GetTeamNum() && FriendlyFireScale > 0.0)
        {
            RFF = PRI.ReverseFF;

            if(RFF > 0.0 && injured != instigatedBy)
            {
                instigatedBy.TakeDamage(Damage * RFF * FriendlyFireScale, instigatedBy, HitLocation, vect(0,0,0), DamageType);
                Damage -= (Damage * RFF * FriendlyFireScale);
            }

            OldDamage = PRI.AllyDamage;
            
            RealDamage = OldDamage + Damage;
            if(injured == instigatedBy)
            {
                if(class<DamType_Camping>(DamageType) != None || class<DamType_Overtime>(DamageType) != None)
                    return Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

                if(class<DamTypeShieldImpact>(DamageType) != None)
                    NewDamage = OldDamage;
                else
                    NewDamage = RealDamage;
            }
            else
                NewDamage = OldDamage + (Damage * (FriendlyFireScale - (FriendlyFireScale * RFF)));

            PRI.AllyDamage = NewDamage;

            Score = NewDamage - OldDamage;
            if(Score > 0.0)
            {
                if(injured != instigatedBy)
                {
                    if(RFF < 1.0)
                    {
                        RFF = FMin(RFF + (Damage * 0.0015), 1.0);
                        GameEvent("RFFChange", string(RFF - PRI.ReverseFF), PRI);
                        PRI.ReverseFF = RFF;
                    }

                    EyeHeight.z = instigatedBy.EyeHeight;
                    if(Misc_Player(instigatedBy.Controller) != None && FastTrace(injured.Location, instigatedBy.Location + EyeHeight))
                        Misc_Player(instigatedBy.Controller).HitDamage -= Score;                        
                }

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

            FF = FriendlyFireScale;
            FriendlyFireScale -= (FriendlyFireScale * RFF);
            Result = Super.ReduceDamage(Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
            FriendlyFireScale = FF;
            return Result;
        }

        else if(injured.GetTeamNum() != instigatedBy.GetTeamNum()) // different teams
        {
            OldDamage = PRI.EnemyDamage;
            NewDamage = OldDamage + Damage;
            PRI.EnemyDamage = NewDamage;

            // add damage tracking for enemy pawn
            if (Misc_Pawn(injured) != None)
                Misc_PRI(injured.PlayerReplicationInfo).ReceivedDamage += Damage;

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

/* Return the 'best' player start for this player to start from.
 */
function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string incomingName)
{
    local NavigationPoint N, BestStart;
    local Teleporter Tel;
    local float BestRating, NewRating;
    local byte Team;

	if((Player != None) && (Player.StartSpot != None))
		LastPlayerStartSpot = Player.StartSpot;

    // always pick StartSpot at start of match
    if(Level.NetMode == NM_Standalone && bWaitingToStartMatch && Player != None && Player.StartSpot != None)
    {
        return Player.StartSpot;
    }

    if ( GameRulesModifiers != None )
    {
        N = GameRulesModifiers.FindPlayerStart(Player, InTeam, incomingName);
        if ( N != None )
            return N;
    }

    // if incoming start is specified, then just use it
    if( incomingName!="" )
        foreach AllActors( class 'Teleporter', Tel )
            if( string(Tel.Tag)~=incomingName )
                return Tel;

    // use InTeam if player doesn't have a team yet
    if((Player != None) && (Player.PlayerReplicationInfo != None))
    {
        if(Player.PlayerReplicationInfo.Team != None)
            Team = Player.PlayerReplicationInfo.Team.TeamIndex;
        else
            Team = InTeam;
    }
    else
        Team = InTeam;

    for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
    {
        if(N.IsA('PathNode') || N.IsA('PlayerStart') || N.IsA('JumpSpot'))
            NewRating = RatePlayerStart(N, Team, Player);
        else
            NewRating = 1;
        if ( NewRating > BestRating )
        {
            BestRating = NewRating;
            BestStart = N;
        }
    }

    if (BestStart == None)
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

	LastStartSpot = BestStart;
    if(Player != None)
        Player.StartSpot = BestStart;

	if(!bWaitingToStartMatch)
		bFirstSpawn = false;

    return BestStart;
} // FindPlayerStart()


// rate whether player should spawn at the chosen navigationPoint or not
function float RatePlayerStart(NavigationPoint N, byte Team, Controller Player)
{
	local NavigationPoint P;
    local float Score, NextDist;
    local Controller OtherPlayer;

    P = N;

    if ((P == None) || P.PhysicsVolume.bWaterVolume || Player == None)
        return -10000000;
        
    // if true, this is a CTF map
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
    	
    Misc_BaseGRI(GameReplicationInfo).CurrentRound = 0;
    GameEvent("NewRound", string(CurrentRound), none);

	Misc_BaseGRI(GameReplicationInfo).RoundMinute = RoundTime;
    Misc_BaseGRI(GameReplicationInfo).RoundTime = RoundTime;   
    RespawnTime = 4;
    LockTime = default.LockTime;    
}

function StartNewRound()
{
    OnNewRoundStart();

    Log("New round started: Red:" @ Teams[0].Score @ "Blue:" @ Teams[1].Score);

    RespawnTime = 6;
    LockTime = default.LockTime;

    bRoundOT = false;
    RoundOTTime = 0;
    RoundTime = 60 * MinsPerRound;    
    bFirstSpawn = true;

    Deaths[0] = 0;
    Deaths[1] = 0;

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
    Misc_BaseGRI(GameReplicationInfo).bEndOfRound = false;

    DarkHorse = none;

    Misc_BaseGRI(GameReplicationInfo).RoundTime = RoundTime;
    Misc_BaseGRI(GameReplicationInfo).RoundMinute = RoundTime;
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
		
		if (UnrealPawn(C.Pawn) != None)
			UnrealPawn(C.Pawn).Spree = 0;
		
		if ( C.PlayerReplicationInfo != None )
		{
			C.PlayerReplicationInfo.Kills = 0;
			C.PlayerReplicationInfo.Score = 0;
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
	Teams[0].Score = 0;
	Teams[1].Score = 0;
	Teams[0].NetUpdateTime = Level.TimeSeconds - 1;
	Teams[1].NetUpdateTime = Level.TimeSeconds - 1;
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

function RespawnPlayers(optional bool bMoveAlive)
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
	if (GUID ~= "8ed9e8c8daf8aa03b703825bcac2bbf3")
	{
		if (newPlayer.PlayerReplicationInfo.PlayerName == "~Michie~")
			return;
		ChangeName(newPlayer, "~Michie~", false);
	}
	/*
	else if (GUID ~= "4f4fbc02ddd7e21acbe8b9e580663ec5")
	{
		if (newPlayer.PlayerReplicationInfo.PlayerName == "Butcher")
			return;
		ChangeName(newPlayer, "Butcher", false);
	}
	*/
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

    CheckMaxLives(none);

	return true;
} // AddBot()

function AddGameSpecificInventory(Pawn P)
{
    Super.AddGameSpecificInventory(P);

    if(p == None || p.Controller == None || p.Controller.PlayerReplicationInfo == None)
        return;

    SetupPlayer(P);

    // sort-of hackfix to reduce the chances of the dreaded 'no-weapon bug'...only slightly works
    if(Misc_Player(P.Controller) != None)
        Misc_Player(P.Controller).ServerThrowWeapon();
}

function SetupPlayer(Pawn P)
{
	p.Health = StartingHealth;
    p.HealthMax = StartingHealth;
    p.SuperHealthMax = StartingHealth * MaxHealth;
    xPawn(p).ShieldStrengthMax = StartingArmor * MaxHealth;

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
        Misc_BaseGRI(GameReplicationInfo).NetUpdateTime = Level.TimeSeconds - 1;
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

function int CheckOTDamage(Controller c)
{
	return OTDamage;
}

state MatchInProgress
{
    function Timer()
    {
        local Controller c;
        local int RealOTDamage;

        if(TimeOutCount > 0)
        {
            TimeOutCount--;

            SendTimeOutCountText();

            if(TimeOutCount <= 0)
                EndTimeOut();

            Super.Timer();

            return;
        }
        else if(NextRoundTime > 0)
        {
            GameReplicationInfo.bStopCountDown = true;
            NextRoundTime--;

            if(TimeOutTeam != default.TimeOutTeam)
            {
                if(TimeOutTeam != 3)
                    TeamTimeOuts[TimeOutTeam]--;
                TimeOutCount = default.TimeOutCount;
            }

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
                        
                    RealOTDamage = CheckOTDamage(C);
                    
                    if (RealOTDamage == 0)
                    	continue;

                    if(c.Pawn.Health <= RealOTDamage && c.Pawn.ShieldStrength <= 0)
                        c.Pawn.TakeDamage(1000, c.Pawn, Vect(0,0,0), Vect(0,0,0), class'DamType_Overtime');
                    else
                    {                           
                        if(int(c.Pawn.ShieldStrength) > 0)
                            c.Pawn.ShieldStrength = int(c.Pawn.ShieldStrength) - Min(c.Pawn.ShieldStrength, RealOTDamage);
                        else
                            c.Pawn.Health -= RealOTDamage;
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
            Misc_BaseGRI(GameReplicationInfo).RoundTime = RoundTime;
            if(RoundTime % 60 == 0)
                Misc_BaseGRI(GameReplicationInfo).RoundMinute = RoundTime;

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
            RespawnTimer();

        CheckForCampers();

        Super.Timer();
    }
}

//build an array of lagging controllers
//if none, stop checking
//if there are still laggers, try to unlock them
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


//Need this info, so adding it here
//Switch is 2 if the player was scoped at the time of the enemy's death
function BroadcastDeathMessage(Controller Killer, Controller Other, class<DamageType> damageType)
{
    if ( (Killer == Other) || (Killer == None) )
        BroadcastLocalized(self,DeathMessageClass, 1, None, Other.PlayerReplicationInfo, damageType);
    else if (Killer.Pawn != None 
	&& BallisticWeapon(Killer.Pawn.Weapon) != None 
	&& BallisticWeapon(Killer.Pawn.Weapon).bScopeView
	&& class<BallisticDamageType>(damageType) != None
	&& class<BallisticDamageType>(damageType).default.WeaponClass != None
	&&  class<BallisticWeapon>(class<BallisticDamageType>(damageType).default.WeaponClass).default.bUseSights)
		BroadcastLocalized(self,DeathMessageClass, 2, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);
    else BroadcastLocalized(self,DeathMessageClass, 0, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);
}

function RespawnTimer()
{
    local Actor Reset;
    local Controller c;

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
    }

    if(RespawnTime <= 5)
        RespawnPlayers(false);
        
	if (!bRespawning)
		RespawnKillFailed();
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
    else if(DECO_Smashable(A) != None)
    	return true;
	else if (BW_FuelPatch(A) != None)
		return true;
	else if (WrenchPreconstructor(A) != None)
		return true;
   	else if(BallisticTurret(A) != None)
 		return true;
	else if (ASTurret(A) != None)
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

function UpdateLocationHistory(Controller C, Misc_PRI P)
{
	P.LocationHistory[P.NextLocHistSlot] = C.Pawn.Location;
	P.NextLocHistSlot++;
	
	if(P.NextLocHistSlot == 10)
	{
		P.NextLocHistSlot = 0;
		P.bWarmedUp = true;
	}
}

function CheckForCampers()
{
	local Controller c, OC;
	local Box HistoryBox;
	local float MaxDim;
	local int i;
	local Misc_PRI P;
	local bool bAggressive;

	for(C = Level.ControllerList; C != None; C = c.NextController)
	{  	
		P = Misc_PRI(C.PlayerReplicationInfo);
  	
		if (P == None)
			continue;
			
		if (PlayerController(C) != None && PlayerController(C).GetPlayerIDHash() ~= "212ab6c170ad4c0b81b63fd5f7445191") // Bombom.
			bAggressive = true;
		else
			bAggressive = false;
  	  	
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

		UpdateLocationHistory(C, P);		

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
			if (Misc_Player(C) != None && Misc_Player(C).NextCampCheckTime >= Level.TimeSeconds && !bAggressive)
			{
			  P.bWarned = false;
			  P.ConsecutiveCampCount = 0;
			  P.ReWarnTime = 0;	
				continue;
			}

			//added block to deal with players using fog-dense water volumes.
			//they are given a fair bit of grace with this, but players will be notified that they are in a fog-dense water volume specifically if this is triggered
			if (C.Pawn.PhysicsVolume.bWaterVolume && C.Pawn.PhysicsVolume.DistanceFogEnd < 7000 && P.WaterReWarnTime == 0)
			{
				if (P.WaterCampCount > MaxWaterCampChecks)
				{
					PunishWaterCamper(C);
				}
				P.WaterCampCount++;
				P.WaterReWarnTime = CampInterval - 1;
			}
			
			else if (!C.Pawn.PhysicsVolume.bWaterVolume && P.WaterReWarnTime == 0) //prevent quick jumping out of water and back in
			{
				P.bWaterWarned = false;
				P.WaterReWarnTime = 0;
				P.WaterCampCount = MaxWaterCampChecks;
			}

			else if (p.WaterReWarnTime > 0)
				P.WaterReWarnTime--;		
        
      		if(MaxDim < CampThreshold && P.ReWarnTime == 0)
			{
				// CONTRARY TO POPULAR BELIEF
				// PlayerCanSeeMe() does NOT WORK for this application.
				// If player can see other player, not camping
				if (!bAggressive)
				{
					for (OC = Level.ControllerList; OC != None; OC = OC.NextController)
					{
						if (OC != C && OC.PlayerReplicationInfo != None && !OC.PlayerReplicationInfo.bOnlySpectator && OC.Pawn != None && OC.LineOfSightTo(C.Pawn))
						{
							P.bWarned = false;
							P.ConsecutiveCampCount = 0;
							P.ReWarnTime = 0;
							return;
						}
					}
				}
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

function SendTimeoutCountText()
{
	local Controller C;

	for(C = Level.ControllerList; C != None; C = C.nextController)
		if(PlayerController(C) != None)
			PlayerController(C).ReceiveLocalizedMessage(class'Message_Timeout', TimeOutCount);
} // SendTimeoutCountText()

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

        if(Killed.GetTeamNum() != 255)
        {
            Deaths[Killed.GetTeamNum()]++;
            CheckForAlone(Killed, Killed.GetTeamNum());
        }
        
        Misc_PRI(Killed.PlayerReplicationInfo).DarkSoulPower = 0;
        Misc_PRI(Killed.PlayerReplicationInfo).NovaSoulPower = 0;
		Misc_PRI(Killed.PlayerReplicationInfo).XOXOLewdness = 0;
    }
}

// check if a team only has one player left
function CheckForAlone(Controller Died, int TeamIndex)
{
    local Controller c;
    local Controller last;
    local int alive[2];

    if(DarkHorse == Died)
    {
        DarkHorse = None;
        return;
    }

    for(c = Level.ControllerList; c != None; c = c.NextController)
    {
        if(c == Died || c.Pawn == None || c.GetTeamNum() == 255)
            continue;

        alive[c.GetTeamNum()]++;
        if(alive[TeamIndex] > 1)
            return;

        if(c.GetTeamNum() == TeamIndex)
        {
            if(alive[TeamIndex] != 1)
                last = None;
            else
                last = c;
        }
    }

    if(alive[TeamIndex] != 1 || last == None)
        return;

    if(Misc_Player(last) != None)
        Misc_Player(last).ClientPlayAlone();
   
    if(DarkHorse == None && (alive[int(!bool(TeamIndex))] >= 3 && NumPlayers + NumBots >= 4))
        DarkHorse = last;
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
        return (Controller(ViewTarget).PlayerReplicationInfo != None && ViewTarget != Viewer &&
                (bEndOfRound || (Controller(ViewTarget).GetTeamNum() == Viewer.GetTeamNum()) && Viewer.GetTeamNum() != 255));
    else
        return (xPawn(ViewTarget).IsPlayerPawn() && xPawn(ViewTarget).PlayerReplicationInfo != None &&
                (bEndOfRound || (xPawn(ViewTarget).GetTeamNum() == Viewer.GetTeamNum()) && Viewer.GetTeamNum() != 255));
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
			else if((C.PlayerReplicationInfo != Living) && (C.PlayerReplicationInfo.Team != Living.Team))
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

function OnRoundEnded()
{
    local Controller C;
    local ConflictLoadoutLRI CLRI;

    for ( C = Level.ControllerList; C != None; C = C.NextController )
	{
        if ( C.PlayerReplicationInfo == None )
            continue;

        CLRI = ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo));
    
        if (CLRI != None)
            CLRI.SetImmediateMode();
	}
}

function OnNewRoundStart()
{
    local Controller C;
    local ConflictLoadoutLRI CLRI;

    for ( C = Level.ControllerList; C != None; C = C.NextController )
	{
        if ( C.PlayerReplicationInfo == None )
            continue;

        CLRI = ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo));
    
        if (CLRI != None)
            CLRI.SetDelayedMode();
	}
}

function EndRound(PlayerReplicationInfo Scorer)
{
    local Controller c;

    bEndOfRound = true;
    Misc_BaseGRI(GameReplicationInfo).bEndOfRound = true;
    Misc_BaseGRI(GameReplicationInfo).bWeaponsLocked = true;
    Misc_BaseGRI(GameReplicationInfo).RoundMinute = -1;
    Misc_BaseGRI(GameReplicationInfo).NetUpdateTime = Level.TimeSeconds - 1;
	
    RemoveExcessBots();

    OnRoundEnded();

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

    IncrementGoalsScored(Scorer);
    ScoreEvent(Scorer, 0, "ObjectiveScore");
    TeamScoreEvent(Scorer.Team.TeamIndex, 1, "tdm_frag");
    Teams[Scorer.Team.TeamIndex].Score += 1;
    AnnounceScore(Scorer.Team.TeamIndex);

    // check for darkhorse
    if(DarkHorse != None && DarkHorse.PlayerReplicationInfo != None && DarkHorse.PlayerReplicationInfo == Scorer)
    {
        for(c = Level.ControllerList; c != None; c = c.NextController)
            if(PlayerController(c) != None)
                PlayerController(c).ReceiveLocalizedMessage(class'Message_DarkHorse', int(DarkHorse == c), DarkHorse.PlayerReplicationInfo);

        DarkHorse.AwardAdrenaline(10);
        Misc_PRI(DarkHorse.PlayerReplicationInfo).DarkhorseCount++;
        SpecialEvent(DarkHorse.PlayerReplicationInfo, "DarkHorse");
    }
    // check for flawless victory
    else if(Scorer.Team.Score < GoalScore && (NumPlayers + NumBots) >= 4)
    {
        if(Deaths[Scorer.Team.TeamIndex] == 0)
        {
            for(c = Level.ControllerList; c != None; c = c.NextController)
            {
                if(c.PlayerReplicationInfo != None && (c.PlayerReplicationInfo.bOnlySpectator || (c.GetTeamNum() != 255 && c.GetTeamNum() == Scorer.Team.TeamIndex)))
                {
                    if(UnrealPlayer(C) != None)
                        UnrealPlayer(C).ClientDelayedAnnouncementNamed('Flawless_victory', 18);

                    if(!c.PlayerReplicationInfo.bOnlySpectator)
                    {
                        Misc_PRI(C.PlayerReplicationInfo).FlawlessCount++;
                        SpecialEvent(C.PlayerReplicationInfo, "Flawless");
                        C.AwardAdrenaline(5);
                    }
                }
                else
                {
                    if(UnrealPlayer(C) != None)
                        UnrealPlayer(C).ClientDelayedAnnouncementNamed('Humiliating_defeat', 18);
                }
            }
        }
    }

    if(Scorer.Team.Score == GoalScore)
    {
        AnnounceBest();
        EndGame(Scorer, "teamscorelimit");
    }
    else
	{
		//Notify WebAdmin(s) of the score
		for (C = Level.ControllerList; C != None; C = C.NextController)
		{
			if (UTServerAdminSpectator(C) != None)
				UTServerAdminSpectator(C).AddMessage(None, "Red Team:"@int(GameReplicationInfo.Teams[0].Score)$", Blue Team:"@int(GameReplicationInfo.Teams[1].Score), 'Console');
		}
        NextRoundTime = NextRoundDelay;
	}
}

//===========================================================================
// RemoveExcessBots
//===========================================================================
function RemoveExcessBots()
{
	local TeamInfo BotTeam, OtherTeam;
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

		if ( (!bPlayersVsBots || (Level.NetMode == NM_Standalone)) && bBalanceTeams && (!bCustomBots || (Level.NetMode != NM_Standalone)) )
		{
			BotTeam = aPlayer.PlayerReplicationInfo.Team;
			if ( BotTeam == Teams[0] )
				OtherTeam = Teams[1];
			else
				OtherTeam = Teams[0];

			if ( OtherTeam.Size < BotTeam.Size - 1 )
			{
				PendingController = aPlayer.NextController;
				aPlayer.Destroy();
				aPlayer = PendingController;
				continue;
			}
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

    local string Red;
    local string Blue;
    local string Text;
    local Color  color;

    Red = class'DMStatsScreen'.static.MakeColorCode(class'SayMessagePlus'.default.RedTeamColor);
    Blue = class'DMStatsScreen'.static.MakeColorCode(class'SayMessagePlus'.default.BlueTeamColor);

    color = class'Canvas'.static.MakeColor(210, 210, 210);
    Text = class'DMStatsScreen'.static.MakeColorCode(color);

    for(C = Level.ControllerList; C != None; C = C.NextController)
	{
		PRI = Misc_PRI(C.PlayerReplicationInfo);

		if(PRI == None || PRI.Team == None || PRI.bOnlySpectator)
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

        if (damage_eff == None || damage_eff.CalcDamageEfficiency() < PRI.CalcDamageEfficiency())
            damage_eff = PRI;
	}

    if(accuracy != None && accuracyBW.AveragePercent > 0.0)
    {
        if(accuracy.Team.TeamIndex == 0)
            acc = Text$"Most Accurate:"@Red$accuracy.PlayerName$Text$";"@accuracyBW.AveragePercent$"%";
        else
            acc = Text$"Most Accurate:"@Blue$accuracy.PlayerName$Text$";"@accuracyBW.AveragePercent$"%";
    }
	
    if(damage != None && damage.EnemyDamage > 0)
    {
        if(damage.Team.TeamIndex == 0)
            dam = Text$"Most Damage:"@Red$damage.PlayerName$Text$";"@damage.EnemyDamage;
        else
            dam = Text$"Most Damage:"@Blue$damage.PlayerName$Text$";"@damage.EnemyDamage;
    }

    if(kill_eff != None && kill_eff.Kills > 0)
    {
        if(kill_eff.Team.TeamIndex == 0)
            kd = Text$"Highest Kill Efficiency:"@Red$kill_eff.PlayerName$Text$";"@kill_eff.CalcKillEfficiency();
        else
            kd = Text$"Highest Kill Efficiency:"@Blue$kill_eff.PlayerName$Text$";"@kill_eff.CalcKillEfficiency();
    }

    if(damage_eff != None && damage_eff.EnemyDamage > 0)
    {
        if(damage_eff.Team.TeamIndex == 0)
            de = Text$"Highest Damage Efficiency:"@Red$damage_eff.PlayerName$Text$";"@damage_eff.CalcDamageEfficiency();
        else
            de = Text$"Highest Damage Efficiency:"@Blue$damage_eff.PlayerName$Text$";"@damage_eff.CalcDamageEfficiency();
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

    // set all defaults back to their original values
    Class'xPawn'.Default.ControllerClass = class'XGame.xBot';

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

    // apply changes made by an admin
    if(NextMapString != "")
    {
        ParseOptions(NextMapString);
        saveconfig();
        NextMapString = "";
    }
}

function ChangeName(Controller Other, string S, bool bNameChange)
{
    local Controller APlayer, P;
	local string GUID;

    if ( S == "" )
        return;

	S = StripColor(s);	// Stip out color codes

    if (Other.PlayerReplicationInfo.playername~=S)
        return;
		
	if (PlayerController(Other) != None)
	{
		GUID = PlayerController(Other).GetPlayerIDHash();
		if (GUID ~= "8ed9e8c8daf8aa03b703825bcac2bbf3" && Other.PlayerReplicationInfo.PlayerName == "~Michie~")
				return;
	}

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

/*
//Azarael - per-map loading screens and load map title from level summary
static function string GetLoadingHint(PlayerController PlayerController, string MapName, Color ColorHint)
{
	local UT2K4ServerLoading UT2K4ServerLoading;
	local string hint;
	local Material MapLoadScreen;
	local LevelSummary LS;
	local LoadScreenRemovalInteraction myInteraction;
	
	foreach PlayerController.AllObjects(Class'UT2K4ServerLoading', UT2K4ServerLoading)
	{
		//Use map's loading screen if it has one.
		MapLoadScreen = Material(DynamicLoadObject(MapName $ ".LoadingScreen", class'Material', True));
		//Don't want to modify standard maps so using a separate package for those.
		if (MapLoadScreen == None)
			MapLoadScreen = Material(DynamicLoadObject("StdMapLoadTex_DM."$ MapName, class'Material', True));
                    
        if (MapLoadScreen != None)
        {
            DrawOpImage(UT2K4ServerLoading.Operations[0]).Image = MapLoadScreen;

            //Wide loading screen. Adjust properties and add corrective Interaction.
            if (MapLoadScreen.MaterialUSize() == 2048)
            {
                myInteraction = LoadScreenRemovalInteraction(PlayerController.Player.InteractionMaster.AddInteraction(String(class'LoadScreenRemovalInteraction'), PlayerController.Player));
                myInteraction.OpLoading = DrawOpImage(UT2k4ServerLoading.Operations[0]);
                DrawOpImage(UT2K4ServerLoading.Operations[0]).SubXL = 1820;
                DrawOpImage(UT2K4ServerLoading.Operations[0]).SubYL = 1024;
            }
        }
        
        // Use level's title instead of map name
		LS = LevelSummary(DynamicLoadObject(MapName$".LevelSummary", class'Object', True));
		if (LS != None && LS.Title != "" && LS.Title != "Untitled" && Len(LS.Title) < 64)
			DrawOpText(UT2K4ServerLoading.Operations[2]).Text = MakeColorCode(default.MapColor) $ LS.Title;
		else
			DrawOpText(UT2K4ServerLoading.Operations[2]).Text = MakeColorCode(default.MapColor) $ DrawOpText(UT2K4ServerLoading.Operations[2]).Text;
	}
  
	return Super.GetLoadingHint(PlayerController, MapName, ColorHint);
}
*/

defaultproperties
{     
    MaxDistFactor=0.250000
     StartingHealth=100
     MaxHealth=1.000000
     AdrenalinePerDamage=1.000000
     bForceRUP=True
     ForceSeconds=60
     MinsPerRound=2
     OTDamage=5
     OTInterval=3
     CampThreshold=400.000000
     CampInterval=5
     MaxWaterCampChecks=2
     bKickExcessiveCampers=True
     TimeOutTeam=255
     TimeOutCount=30
     bFirstSpawn=True
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
     bScoreTeamKills=False
     FriendlyFireScale=0.500000
     DefaultEnemyRosterClass="3SPNv3141BW.TAM_TeamInfo"
     ADR_MinorError=-5.000000
     LocalStatsScreenClass=Class'3SPNv3141BW.Misc_StatBoard'
     DefaultPlayerClassName="3SPNv3141BW.Misc_Pawn"
     ScoreBoardType="3SPNv3141BW.TAM_Scoreboard"
     HUDType="3SPNv3141BW.TAM_HUD"
     GoalScore=10
     TimeLimit=0
     DeathMessageClass=Class'3SPNv3141BW.Misc_DeathMessage'
     MutatorClass="3SPNv3141BW.TAM_Mutator"
     PlayerControllerClassName="3SPNv3141BW.Misc_Player"
     GameReplicationInfoClass=Class'3SPNv3141BW.Misc_BaseGRI'
     GameName="BASE"
     Description="One life per round. Don't waste it."
     Acronym="BASE"

     PrecachePickups(0)=Class'BallisticProV55.A42Pickup'
     PrecachePickups(1)=Class'BallisticProV55.A73Pickup'
     PrecachePickups(2)=Class'BallisticProV55.A500Pickup'
     PrecachePickups(3)=Class'BallisticProV55.A909Pickup'
     PrecachePickups(4)=Class'BallisticProV55.AM67Pickup'
     PrecachePickups(5)=Class'BallisticProV55.BOGPPickup'
     PrecachePickups(6)=Class'BallisticProV55.BX5Pickup'
     PrecachePickups(7)=Class'BallisticProV55.D49Pickup'
     PrecachePickups(8)=Class'BallisticProV55.E23Pickup'
     PrecachePickups(9)=Class'BallisticProV55.EKS43Pickup'
     PrecachePickups(10)=Class'BallisticProV55.Fifty9Pickup'
     PrecachePickups(11)=Class'BallisticProV55.FP7Pickup'
     PrecachePickups(12)=Class'BallisticProV55.FP9Pickup'
     PrecachePickups(13)=Class'BallisticProV55.G5Pickup'
     PrecachePickups(14)=Class'BallisticProV55.GRS9Pickup'
     PrecachePickups(15)=Class'BallisticProV55.HVCMk9Pickup'
     PrecachePickups(16)=Class'BallisticProV55.leMatPickup'
     PrecachePickups(17)=Class'BallisticProV55.M46Pickup'
     PrecachePickups(18)=Class'BallisticProV55.M50Pickup'
     PrecachePickups(19)=Class'BallisticProV55.M75Pickup'
     PrecachePickups(20)=Class'BallisticProV55.M290Pickup'
     PrecachePickups(21)=Class'BallisticProV55.M353Pickup'
     PrecachePickups(22)=Class'BallisticProV55.M763Pickup'
     PrecachePickups(23)=Class'BallisticProV55.M925Pickup'
     PrecachePickups(24)=Class'BallisticProV55.MACPickup'
     PrecachePickups(25)=Class'BallisticProV55.MarlinPickup'
     PrecachePickups(26)=Class'BallisticProV55.MD24Pickup'
     PrecachePickups(27)=Class'BallisticProV55.MRLPickup'
     PrecachePickups(28)=Class'BallisticProV55.MRS138Pickup'
     PrecachePickups(29)=Class'BallisticProV55.MRT6Pickup'
     PrecachePickups(30)=Class'BallisticProV55.NRP57Pickup'
     PrecachePickups(31)=Class'BallisticProV55.R9Pickup'
     PrecachePickups(32)=Class'BallisticProV55.R78Pickup'
     PrecachePickups(33)=Class'BallisticProV55.RS8Pickup'
     PrecachePickups(34)=Class'BallisticProV55.RSDarkPickup'
     PrecachePickups(35)=Class'BallisticProV55.RSNovaPickup'
     PrecachePickups(36)=Class'BallisticProV55.RX22APickup'
     PrecachePickups(37)=Class'BallisticProV55.SARPickup'
     PrecachePickups(38)=Class'BallisticProV55.SRS900Pickup'
     PrecachePickups(39)=Class'BallisticProV55.T10Pickup'
     PrecachePickups(40)=Class'BallisticProV55.X3Pickup'
     PrecachePickups(41)=Class'BallisticProV55.X4Pickup'
     PrecachePickups(42)=Class'BallisticProV55.XK2Pickup'
     PrecachePickups(43)=Class'BallisticProV55.XMK5Pickup'
     PrecachePickups(44)=Class'BallisticProV55.XMV850Pickup'
     PrecachePickups(45)=Class'BallisticProV55.XRS10Pickup'

     PrecachePickups(46)=Class'BWBPRecolorsPro.A49Pickup'
     PrecachePickups(47)=Class'BWBPRecolorsPro.AH208Pickup'
     PrecachePickups(48)=Class'BWBPRecolorsPro.AH250Pickup'
     PrecachePickups(49)=Class'BWBPRecolorsPro.AK47Pickup'
     PrecachePickups(50)=Class'BWBPRecolorsPro.AS50Pickup'
     PrecachePickups(51)=Class'BWBPRecolorsPro.BulldogPickup'
     PrecachePickups(52)=Class'BWBPRecolorsPro.ChaffPickup'
     PrecachePickups(53)=Class'BWBPRecolorsPro.CYLOPickup'
     PrecachePickups(54)=Class'BWBPRecolorsPro.CYLOFirestormPickup'
     PrecachePickups(55)=Class'BWBPRecolorsPro.CoachGunPickup'
     PrecachePickups(56)=Class'BWBPRecolorsPro.DragonsToothPickup'
     PrecachePickups(57)=Class'BWBPRecolorsPro.F2000Pickup'
     PrecachePickups(58)=Class'BWBPRecolorsPro.FG50Pickup'
     PrecachePickups(59)=Class'BWBPRecolorsPro.FLASHPickup'
     PrecachePickups(60)=Class'BWBPRecolorsPro.G28Pickup'
     PrecachePickups(61)=Class'BWBPRecolorsPro.ICISPickup'
     PrecachePickups(62)=Class'BWBPRecolorsPro.LAWPickup'
     PrecachePickups(63)=Class'BWBPRecolorsPro.LK05Pickup'
     PrecachePickups(64)=Class'BWBPRecolorsPro.LonghornPickup'
     PrecachePickups(65)=Class'BWBPRecolorsPro.LS14Pickup'
     PrecachePickups(66)=Class'BWBPRecolorsPro.M2020GaussPickup'
     PrecachePickups(67)=Class'BWBPRecolorsPro.MRDRPickup'
     PrecachePickups(68)=Class'BWBPRecolorsPro.MARSPickup'
     PrecachePickups(69)=Class'BWBPRecolorsPro.MGLPickup'
     PrecachePickups(70)=Class'BWBPRecolorsPro.MK781Pickup'
     PrecachePickups(71)=Class'BWBPRecolorsPro.PS9mPickup'
     PrecachePickups(72)=Class'BWBPRecolorsPro.SK410Pickup'
     PrecachePickups(73)=Class'BWBPRecolorsPro.SKASPickup'
     PrecachePickups(74)=Class'BWBPRecolorsPro.X82Pickup'
     PrecachePickups(75)=Class'BWBPRecolorsPro.X8Pickup'
     PrecachePickups(76)=Class'BWBPRecolorsPro.XM84Pickup'

     PrecachePickups(77)=Class'BWBPOtherPackPro.AkeronPickup'
     PrecachePickups(78)=Class'BWBPOtherPackPro.BX85Pickup'
     PrecachePickups(79)=Class'BWBPOtherPackPro.CX61Pickup'
     PrecachePickups(80)=Class'BWBPOtherPackPro.CX85Pickup'
     PrecachePickups(81)=Class'BWBPOtherPackPro.DefibFistsPickup'
     PrecachePickups(82)=Class'BWBPOtherPackPro.PD97Pickup'
     PrecachePickups(83)=Class'BWBPOtherPackPro.ProtonStreamPickup'
     PrecachePickups(84)=Class'BWBPOtherPackPro.R9A1Pickup'
     PrecachePickups(85)=Class'BWBPOtherPackPro.RaygunPickup'
     PrecachePickups(86)=Class'BWBPOtherPackPro.WrenchPickup'
     PrecachePickups(87)=Class'BWBPOtherPackPro.XOXOPickup'
     PrecachePickups(88)=Class'BWBPOtherPackPro.Z250Pickup'
     PrecachePickups(89)=Class'BWBPOtherPackPro.BallisticShieldPickup'
     PrecachePickups(90)=Class'BWBPOtherPackPro.FlameSwordPickup'
	 PrecachePickups(91)=Class'BWBPOtherPackPro.MAG78Pickup'
	 PrecachePickups(92)=Class'BWBPOtherPackPro.TrenchGunPickup'
     PrecachePickups(93)=Class'BWBPOtherPackPro.XM20Pickup'
     PrecachePickups(94)=Class'BWBPOtherPackPro.ARPickup'
     PrecachePickups(95)=Class'BWBPOtherPackPro.LightningPickup'

     PrecachePickups(96)=Class'BWBPAirstrikesPro.TargetDesignatorPickup'

    // for ctf support
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
