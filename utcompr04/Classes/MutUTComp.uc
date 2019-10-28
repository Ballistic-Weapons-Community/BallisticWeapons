class MutUTComp extends Mutator;

#exec OBJ LOAD FILE=Textures/minimegatex.utx PACKAGE=utcompr04

/* Nothing is replicated here: the class is only sent to get the default values */

/* config variables */
var config bool 	bEnableDoubleDamage;
var config byte 	EnableBrightSkinsMode;
var config bool 	bEnableClanSkins;
var config bool	bEnableTeamOverlay;
var config byte 	EnableHitSoundsMode;
var config bool 	bEnableScoreboard;
var config bool 	bShowTeamScoresInServerBrowser;
var config int 	NumGrenadesOnSpawn;
var config bool	bNoVehicleFarming;
var config bool 	bNoWeaponDropTeamsay;

var globalconfig bool   bEnableMusicDownload;
var globalconfig string MusicDownloadURL;

/* Info (static) */
var string Version;
var const string MyVersion;
var const string MyVersionSuffix;

/* replacement */
struct DeathMessageRepl
{
	var class<LocalMessage> OldClass;
	var class<LocalMessage> NewClass;
};

struct HUDRepl
{
	var class<HudBase> OldClass;
	var class<HudBase> NewClass;
};

struct ScoreBoardRepl
{
	var class<ScoreBoard> OldClass;
	var class<ScoreBoard> NewClass;
	var class<ScoreBoard> NewClassEnh;
};

var class<PlayerController> PlayerControllerType;
var class<Pawn> PawnType;
var class<AIController> BotType;

var class<UTComp_OverlayB> OverlayType;
var class<UTComp_OverlayUpdate> OverlayUpdateType;

var class<UTComp_PRI> PRIType;
var class<UTComp_SRI> SRIType;

var class<UTComp_GameRules> GameRulesType;

var array<DeathMessageRepl> DeathMsgType;
var array<HUDRepl> HudType;
var array<ScoreBoardRepl> ScoreBoardType;

/* state */ 
var string OriginalPlayerControllerClassName;
var class<PlayerController> OriginalPlayerControllerClass;
var bool bHasInteraction;

var UTComp_SRI UTCompSRI;
var UTComp_OverlayUpdate OverlayUpdater;

function PreBeginPlay()
{
	local int i;
	local SVehicleFactory Factory;
	
	Level.Game.DefaultPlayerClassName = string(PawnType);
	Level.Game.PlayerControllerClassName = string(PlayerControllerType);
  
  UTCompSRI = Spawn(SRIType, self);
	
	UTCompSRI.EnableBrightSkinsMode = Clamp(EnableBrightSkinsMode,1,3);
	UTCompSRI.bEnableClanSkins = bEnableClanSkins;
	UTCompSRI.bEnableTeamOverlay =  bEnableTeamOverlay;
	UTCompSRI.EnableHitSoundsMode = EnableHitSoundsMode;
	UTCompSRI.bEnableScoreboard = bEnableScoreboard;
	UTCompSRI.bEnableDoubleDamage = bEnableDoubleDamage;

 	if(bEnableTeamOverlay && Level.Game.bTeamGame)
  {
    OverlayUpdater = Spawn(OverlayUpdateType, self);
    OverlayUpdater.UTCompMutator = self;
    OverlayUpdater.InitializeOverlay();
  }
  
  //replacements
  for (i = 0; i < HudType.Length; i++)
  {
  	if(Level.Game.HudType ~= string(HUDType[i].OldClass) )
  	{
			Level.Game.HudType = string(HUDType[i].NewClass);
			break;
		}
  }
  
  for (i = 0; i < ScoreBoardType.Length; i++)
  {
  	if(Level.Game.ScoreBoardType ~= string(ScoreBoardType[i].OldClass) )
  	{  		
  		if (bEnableScoreBoard)
				Level.Game.ScoreBoardType = string(ScoreBoardType[i].NewClassEnh);
			else
				Level.Game.ScoreBoardType = string(ScoreBoardType[i].NewClass);	
			
			UTCompSRI.NormalScoreBoardType = string(ScoreBoardType[i].NewClass);
			UTCompSRI.EnhancedScoreBoardType = string(ScoreBoardType[i].NewClassEnh);
			
			break;
		}
  }
  
  for (i = 0; i < DeathMsgType.Length; i++)
  {
  	if(Level.Game.DeathMessageClass == DeathMsgType[i].OldClass)
  	{
			Level.Game.DeathMessageClass = DeathMsgType[i].NewClass;
			break;
		}
  }

	foreach AllActors(class'SVehicleFactory', Factory)
	{
  	if (Factory.VehicleClass == class'ONSMobileAssaultStation')
  		Factory.VehicleClass = class'UTComp_MobileAssaultStation';
	}
    
	Super.PreBeginPlay();
}

simulated function Tick(float DeltaTime)
{
	local UTComp_xPlayer PC;
	
	if(Level.NetMode != NM_DedicatedServer)
	{
		/* just in case */
		if(bHasInteraction)
			return;
			
    PC = UTComp_xPlayer(Level.GetLocalPlayerController());

    if(PC != None)
    {
			PC.Player.InteractionMaster.AddInteraction(string(OverlayType), PC.Player);
			PC.ClientLoadMusicDownloader();
			bHasInteraction = true;
			class'DamTypeLinkShaft'.default.bSkeletize = false;
			Disable('Tick');
    }
  }
  else
  	Disable('Tick');
}

function PostBeginPlay()
{
	local UTComp_GameRules G;

	Super.PostBeginPlay();

	G = Spawn(GameRulesType);
	G.UTCompMutator = self;

	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else
		Level.Game.GameRulesModifiers.AddGameRules(G);

	class'GrenadeAmmo'.default.InitialAmount = NumGrenadesOnSpawn;
}

simulated function PostNetBeginPlay()
{
	if (MyVersionSuffix != "")
  	class'MutUTComp'.default.Version = MyVersion @ MyVersionSuffix; 
  else
 	 	class'MutUTComp'.default.Version = MyVersion;
 	 	
 	Super.PostNetBeginPlay();
}

static final function string ReplOptions(string Opt, string Key, string NewValue)
{
    local int i, L;

    if((Opt ~= "") || Key ~= "")
        return Opt;
    i = InStr(Opt, Key);
    if(i < 0)
        return Opt;
    L = InStr(Mid(Opt, i), "?");
    if(L != -1)
        return ((Left(Opt, i) $ Key) $ NewValue) $ Mid(Opt, L);
    else
        return (Left(Opt, i) $ Key) $ NewValue;
    return Opt;   
}

function PlayerChangedClass(Controller C)
{
	Super.PlayerChangedClass(C);
	if (Bot(C) != None)
		Bot(C).PawnClass = PawnType;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local LinkedReplicationInfo lPRI;
	local UTComp_PRI uPRI;

	if(Weapon_LinkTurret(Other) != None)
		Weapon_LinkTurret(Other).FireModeClass[0] = class'UTComp_LinkTurret_Fire';
	else if (PlayerController(Other) != None)
		PlayerController(Other).PawnClass = PawnType;
	else if (Bot(Other) != None)
		Bot(Other).PreviousPawnClass = PawnType;
	else if (PlayerReplicationInfo(Other) != None)
	{
		uPRI = Spawn(PRIType, Other.Owner);		
		
		if(PlayerReplicationInfo(Other).CustomReplicationInfo != None)
		{
			lPRI = PlayerReplicationInfo(Other).CustomReplicationInfo;
		
			PlayerReplicationInfo(Other).CustomReplicationInfo = uPRI;
			
			if (uPRI.NextReplicationInfo != None)
				uPRI.NextReplicationInfo.NextReplicationInfo = lPRI;
			else
				uPRI.NextReplicationInfo = lPRI;
		}
		else
			PlayerReplicationInfo(Other).CustomReplicationInfo = uPRI;
	}
	
	if (Other.IsA('UDamagePack') && !bEnableDoubleDamage)
	   return false;
	
	return true;
}

function GetServerPlayers( out GameInfo.ServerResponseLine ServerState )
{
	local int i;
	
	if(!Level.Game.bTeamGame)
	  return;
	
	if(bShowTeamScoresInServerBrowser)
	{
		if(TeamGame(Level.Game).Teams[0]!=None)
		{
			i = ServerState.PlayerInfo.Length;
			ServerState.PlayerInfo.Length = i+1;
			ServerState.PlayerInfo[i].PlayerName = Chr(0x1B)$chr(10)$chr(245)$chr(10)$"Red Team Score";
			ServerState.PlayerInfo[i].Score = TeamGame(Level.Game).Teams[0].Score;
		}
		
		if(TeamGame(Level.Game).Teams[1]!=None)
		{
			i = ServerState.PlayerInfo.Length;
			ServerState.PlayerInfo.Length = i+1;
			ServerState.PlayerInfo[i].PlayerName =  Chr(0x1B)$chr(10)$chr(245)$chr(10)$"Blue Team Score";
			ServerState.PlayerInfo[i].Score = TeamGame(Level.Game).Teams[1].Score;
		}
	}
}

function GetServerDetails( out GameInfo.ServerResponseLine ServerState )
{
  local int i;
  super.GetServerDetails(ServerState);

	i = ServerState.ServerInfo.Length;
	ServerState.ServerInfo.Length = i + 1;
	ServerState.ServerInfo[i].Key = "UTComp Version";
	ServerState.ServerInfo[i].Value = class'MutUTComp'.default.Version;
}

function string CreateTimeString()
{
	local string HourDigits, MinuteDigits;
	
	if(Len(Level.hour) == 1)
	  HourDigits = "0" $ Level.Hour;
	else
	  HourDigits = Left(Level.Hour, 2);
	  
	if(Len(Level.minute) == 1)
	  MinuteDigits=  "0" $ Level.Minute;
	else
	  MinuteDigits = Left(Level.Minute, 2);
	
	return HourDigits $ "-" $ MinuteDigits;
}

simulated function string StripIllegalWindowsCharacters(string S)
{
   S = repl(S, ".", "-");
   S = repl(S, "*", "-");
   S = repl(S, ":", "-");
   S = repl(S, "|", "-");
   S = repl(S, "/", "-");
   S = repl(S, ";", "-");
   S = repl(S, "\\","-");
   S = repl(S, ">", "-");
   S = repl(S, "<", "-");
   S = repl(S, "+", "-");
   S = repl(S, " ", "-");
   S = repl(S, "?", "-");
   
   return S;
}

function ModifyPlayer(Pawn Other)
{
	local UTComp_PRI uPRI;
	
	uPRI = class'UTComp_Util'.static.GetUTCompPRI(Other.PlayerReplicationInfo);
	if (uPRI != None)
	{
		uPRI.InAVehicle = Other.DrivenVehicle != None;
		uPRI.VehicleExitTime = 0.0;
	}
	
	if ( NextMutator != None )
		NextMutator.ModifyPlayer(Other);
}

function DriverEnteredVehicle(Vehicle V, Pawn P)
{
	local UTComp_PRI uPRI;
	
	uPRI = class'UTComp_Util'.static.GetUTCompPRIForPawn(V);
	if (uPRI != None)
		uPRI.InAVehicle = true;
	
	if( NextMutator != None )
		NextMutator.DriverEnteredVehicle(V, P);
}

function DriverLeftVehicle(Vehicle V, Pawn P)
{
	local UTComp_PRI uPRI;
	
	uPRI = class'UTComp_Util'.static.GetUTCompPRIForPawn(P);
	if (uPRI != None)
	{
		uPRI.InAVehicle = false;
		uPRI.VehicleExitTime = Level.TimeSeconds;
	}
	
	if( NextMutator != None )
		NextMutator.DriverLeftVehicle(V, P);
}

static function FillPlayInfo (PlayInfo PlayInfo)
{
	PlayInfo.AddClass(Default.Class);
  PlayInfo.AddSetting("UTComp Settings", "EnableBrightSkinsMode", "Brightskins Mode", 1, 1, "Select", "0;Disabled;1;Epic Style;2;BrighterEpic Style;3;UTComp Style ");
  PlayInfo.AddSetting("UTComp Settings", "EnableHitSoundsMode", "Hitsounds Mode", 1, 1, "Select", "0;Disabled;1;Line Of Sight;2;Everywhere");
  PlayInfo.AddSetting("UTComp Settings", "bEnableDoubleDamage", "Enable Double Damage", 1, 1, "Check");
  PlayInfo.AddSetting("UTComp Settings", "bEnableTeamOverlay", "Enable Team Overlay", 1, 1, "Check");
  PlayInfo.AddSetting("UTComp Settings", "NumGrenadesOnSpawn", "Number of grenades on spawn.",255, 1, "Text","2;0:32");
	PlayInfo.AddSetting("UTComp Settings", "bEnableScoreboard", "Enable Enhanced Scoreboard", 1, 1,"Check");
	PlayInfo.AddSetting("UTComp Settings", "bEnableClanSkins", "Enable Clan Skins", 1, 1,"Check");
	PlayInfo.AddSetting("UTComp Settings", "bShowTeamScoresInServerBrowser", "Show Team Score In Server Browser", 1, 1, "Check");
	PlayInfo.AddSetting("UTComp Settings", "bNoVehicleFarming", "No Vehicle Farming", 1, 1, "Check");
	PlayInfo.AddSetting("UTComp Settings", "bNoWeaponDropTeamsay", "No Weapon Name Parsing In Teamsay", 1, 1, "Check");
	PlayInfo.AddSetting("UTComp Settings", "bEnableMusicDownload", "Enable Music Download", 255, 1, "Check");
	PlayInfo.AddSetting("UTComp Settings", "MusicDownloadURL", "Music Download URL", 255, 1, "Text", "100");

  PlayInfo.PopClass();
  Super.FillPlayInfo(PlayInfo);
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{		
		case "bEnableDoubleDamage":
			return "Check this to enable the double damage.";
			
		case "EnableBrightSkinsMode":
			return "Sets whether the server allows brightskins mode.";
			
		case "EnableHitSoundsMode":
			return "Sets whether the server allows hitsound mode.";
			
		case "bEnableAutoDemoRec":
			return "Check this to enable a recording of every map, beginning as warmup ends.";
			
		case "NumGrenadesOnSpawn":
			return "Set this to the number of Assault Rifle grenades you wish a player to spawn with.";
	
		case "bEnableScoreboard":
			return "Check this to enable UTComp's enhanced scoreboard.";
			
		case "bEnableTeamOverlay":
			return "Check this to enable the team overlay.";
		
		case "bShowTeamScoresInServerBrowser":	
			return "Check this to show team scores in server browser.";
			
		case "bEnableClanSkins":
			return "Check this to enable clan skins.";
			
		case "bNoVehicleFarming":
			return "Check this to disallow vehicles from granting kills and net points.";
			
		case "bNoWeaponDropTeamsay":
			return "For public servers. This will drop any messages containing %w.";

		case "bEnableMusicDownload":
			return "Whether to enable music download to clients.";

		case "MusicDownloadURL":
			return "Base URL for music downloads.";
	}
	
	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
     bEnableDoubleDamage=True
     EnableBrightSkinsMode=3
     bEnableClanSkins=True
     bEnableTeamOverlay=True
     EnableHitSoundsMode=1
     bEnableScoreboard=True
     bShowTeamScoresInServerBrowser=True
     NumGrenadesOnSpawn=4
     bNoVehicleFarming=True
     MyVersion="R04"
     PlayerControllerType=Class'utcompr04.UTComp_xPlayer'
     PawnType=Class'utcompr04.UTComp_xPawn'
     OverlayType=Class'utcompr04.UTComp_OverlayB'
     OverlayUpdateType=Class'utcompr04.UTComp_OverlayUpdate'
     PRIType=Class'utcompr04.UTComp_PRI'
     SRIType=Class'utcompr04.UTComp_SRI'
     GameRulesType=Class'utcompr04.UTComp_GameRules'
     DeathMsgType(0)=(OldClass=Class'XGame.xDeathMessage',NewClass=Class'utcompr04.UTComp_xDeathMessageB')
     HUDType(0)=(OldClass=Class'XInterface.HudCDeathmatch',NewClass=Class'utcompr04.UTComp_HudWDeathmatch')
     HUDType(1)=(OldClass=Class'XInterface.HudCTeamDeathMatch',NewClass=Class'utcompr04.UTComp_HudWTeamDeathmatch')
     HUDType(2)=(OldClass=Class'XInterface.HudCDoubleDomination',NewClass=Class'utcompr04.UTComp_HudWDoubleDomination')
     HUDType(3)=(OldClass=Class'XInterface.HudCCaptureTheFlag',NewClass=Class'utcompr04.UTComp_HudWCaptureTheFlag')
     HUDType(4)=(OldClass=Class'XInterface.HudCBombingRun',NewClass=Class'utcompr04.UTComp_HudWBombingRun')
     ScoreBoardType(0)=(OldClass=Class'XInterface.ScoreBoardDeathMatch',NewClass=Class'utcompr04.UTComp_ScoreBoard_DM',NewClassEnh=Class'utcompr04.UTComp_ScoreBoard_NEW')
     ScoreBoardType(1)=(OldClass=Class'XInterface.ScoreBoardTeamDeathMatch',NewClass=Class'utcompr04.UTComp_ScoreBoard_TDM',NewClassEnh=Class'utcompr04.UTComp_ScoreBoard_NEW')
     bAddToServerPackages=True
     FriendlyName="UTComp Version R04"
     Description="A mutator for warmup, brightskins, hitsounds, and various other features."
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
