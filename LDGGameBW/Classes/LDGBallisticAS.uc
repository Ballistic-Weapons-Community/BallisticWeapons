class LDGBallisticAS extends ASGameInfo;

//#define GAME_HAS_PRACTICE_ROUND

//Common Code
//BEGIN_BW_GAME_DECL
//#ifndef BW_NO_LOADING_SCREENS
var private const array<Texture> LoadingScreens;
//#endif

var private const array<string> LoadingScreenHints;
var private const string LoadoutHint;
var private const string ForumLink;

var private const array<string> BWMutators;
var color HintColor;
var color MapColor;

struct PlayerStats
{
	var string LDGHash;
	var bool bRecover;
  var ScoreRecoveryInfo AssociatedInfo;
};

var array<PlayerStats> PlayerStatsArray;
var LDGUserFlagsServer FlagsServer;
var LDGAbstractBalancer TeamBalancer;
var int NumReservedSpectators;

//#ifndef BW_NO_HEALTH_OVERRIDE
var config int PlayerHealth;
var config int PlayerSuperHealth;
//#endif
//Inserted 29 lines.
//END_BW_GAME_DECL

//BEGIN_BW_GAME_BASE
function bool BecomeSpectator(PlayerController P)
{
	if (TeamBalancer != None && !TeamBalancer.AllowBecomeSpectator(P))
		return false;

	// reserved slots -> check if we are being fucked off because number of slots is reached
	if ( (P.PlayerReplicationInfo != None) && GameReplicationInfo.bMatchHasBegun && !P.IsInState('GameEnded') && !P.IsInState('RoundEnded') )
		AcquireReservedSlot(P.GetPlayerIDHash());

	return Super.BecomeSpectator(P);
}

//#ifdef BW_FREON
//function PlayerBecamingSpectator(Freon_Player_UTComp_LDG PC)
//{
//	PlayerLeaving(PC);
//	if (TeamBalancer != None)
//		TeamBalancer.PlayerBecamingSpectator(PC);
//}
//#else
function PlayerBecamingSpectator(UTComp_xPlayer PC)
{
	PlayerLeaving(PC);
	if (TeamBalancer != None)
		TeamBalancer.PlayerBecamingSpectator(PC);
}
//#endif

function bool AllowBecomeActivePlayer(PlayerController P)
{
	local bool bResult;

	if (TeamBalancer != None && !TeamBalancer.AllowBecomeActivePlayer(P))
		return false;

	bResult = Super.AllowBecomeActivePlayer(P);

	if (bResult)
		DropReservedSlot(P.GetPlayerIDHash());

	return bResult;
}

function bool ChangeTeam(Controller Other, int N, bool bNewTeam)
{
	if (bNewTeam && PlayerController(Other) != None)
	{
		if (TeamBalancer != None && !TeamBalancer.AllowPlayerTeamChange(PlayerController(Other), N))
			return false;
	}

	return Super.ChangeTeam(Other, N, bNewTeam);
}

//#ifdef BW_FREON
//function PlayerBecameActive(Freon_Player_UTComp_LDG PC)
//{
//	AssignInfo(PC, GetPlayerFlags(PC));
//	if (TeamBalancer != None)
//		TeamBalancer.PlayerBecameActive(PC);
//}
//#else
function PlayerBecameActive(UTComp_xPlayer PC)
{
	AssignInfo(PC, GetPlayerFlags(PC));
	if (TeamBalancer != None)
		TeamBalancer.PlayerBecameActive(PC);
}
//#endif

function AcquireReservedSlot(string ID)
{
	if (class'LDGFlags'.static.CheckFlag(ID, "RESERVED_SLOT") || class'LDGFlags'.static.CheckFlag(ID, "PREMIUM"))
	{
		NumReservedSpectators++;
		MaxSpectators = Max(default.MaxSpectators + NumReservedSpectators, default.MaxSpectators);
	}
}

function DropReservedSlot(string ID)
{
	if (class'LDGFlags'.static.CheckFlag(ID, "RESERVED_SLOT") || class'LDGFlags'.static.CheckFlag(ID, "PREMIUM"))
	{
		NumReservedSpectators = Max(NumReservedSpectators - 1, 0);
		MaxSpectators = Max(default.MaxSpectators + NumReservedSpectators, default.MaxSpectators);
	}
}

event PreLogin(string Options, string Address, string PlayerID, out string Error,	out string FailCode)
{
	local bool bSpectator;
	local MasterServerUplink MSU;

	bSpectator = ( ParseOption( Options, "SpectatorOnly" ) ~= "1" );

	if (bSpectator)
		AcquireReservedSlot(PlayerID);

	if (AccessControl != None)
	    AccessControl.PreLogin(Options, Address, PlayerID,Error, FailCode, bSpectator);

	if (Error=="" && FailCode == "")
	{
		if (!bMSUplinkSet)
		{
			foreach AllActors(class'MasterServerUplink',MSU)
				MSUplink = MSU;
			bMSUplinkSet = true;
		}

		if (bMSUplinkSet && MSUplink!=None)
			MSUplink.ForceGameStateRefresh(5);

	}
}

function AddGameSpecificInventory(Pawn p)
{
  if ( AllowTransloc() )
  	p.CreateInventory("LDGGameBW.UT3Translocator");
  Super.AddGameSpecificInventory(p);

//#ifndef BW_NO_HEALTH_OVERRIDE
	if(p == None || p.Controller == None || p.Controller.PlayerReplicationInfo == None)
		return;

	p.Health = PlayerHealth;
  p.HealthMax = PlayerHealth;
  p.SuperHealthMax = PlayerSuperHealth;

//#endif
}

event InitGame( string Options, out string Error )
{
	local int i;

	Super.InitGame(Options, Error);
	class'LDGFlags'.static.AllowFlag("RESERVED_SLOT");
	class'LDGFlags'.static.AllowFlag("PREMIUM");

	for (i = 0; i < BWMutators.Length; i++)
		AddMutator(BWMutators[i], false);
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	local class<Mutator> MyMut;
	local int i;

//#ifdef BW_SUPER_TM
//	Super(xTeamGame).FillPlayInfo(PlayInfo);
//#else	
	Super.FillPlayInfo(PlayInfo);
//#endif

//#ifdef BW_CUST_PLAY_INFO
//	CustomFillPlayInfo(PlayInfo);	
//#endif

//#ifndef BW_NO_HEALTH_OVERRIDE
	PlayInfo.AddSetting(Default.GameGroup, "PlayerHealth", "Player Health", 0, 100, "Text", "3;0:999");
	PlayInfo.AddSetting(Default.GameGroup, "PlayerSuperHealth", "Player SuperHealth", 0, 100, "Text", "3;0:999");
//#endif	

	for (i = 0; i < default.BWMutators.Length; i++)
	{
		MyMut = class<Mutator>(DynamicLoadObject(default.BWMutators[i], class'Class'));
		if (MyMut != None)
			MyMut.static.FillPlayInfo(PlayInfo);
	}
}

static function string GetDescriptionText(string PropName)
{
	local class<Mutator> MyMut;
	local string MyText;
	local int i;

//#ifdef BW_CUST_PLAY_INFO
//	MyText = CustomGetDescriptionText(PropName);

//	if (MyText != "")
//		return MyText;

//#endif

	for (i = 0; i < default.BWMutators.Length; i++)
	{
		MyMut = class<Mutator>(DynamicLoadObject(default.BWMutators[i], class'Class'));
		if (MyMut != None)
		{
			MyText = MyMut.static.GetDescriptionText(PropName);

			if (MyText != "")
				return MyText;
		}
	}

//#ifndef BW_NO_HEALTH_OVERRIDE
	if (PropName == "PlayerHealth")
		return "Player health at respawn.";

	if (PropName == "PlayerSuperHealth")
		return "Player super health.";
//#endif

	return Super.GetDescriptionText(PropName);
}

static function array<string> GetAllLoadHints(optional bool bThisClassOnly)
{
	local int i;
	local array<string> Hints;

	if ( default.LoadingScreenHints.Length == 0  )
		Hints = Super.GetAllLoadHints();

	Hints.Length = default.LoadingScreenHints.Length;

	for ( i = 0; i < default.LoadingScreenHints.Length; i++ )
		Hints[i] = default.LoadingScreenHints[i];

	return Hints;
}

//Azarael - per-map loading screens and load map title from level summary
static function string GetLoadingHint(PlayerController PlayerController, string MapName, Color ColorHint)
{
	local UT2K4ServerLoading UT2K4ServerLoading;
	local string hint;
	local Material MapLoadScreen;
	local LevelSummary LS;
	local LoadScreenRemovalInteraction myInteraction;
	
	ColorHint = default.HintColor;
	
	foreach PlayerController.AllObjects(Class'UT2K4ServerLoading', UT2K4ServerLoading)
	{
		//Use map's loading screen if it has one.
		MapLoadScreen = Material(DynamicLoadObject(MapName $ ".LoadingScreen", class'Material', True));
		//Don't want to modify standard maps so using a separate package for those.
		if (MapLoadScreen == None)
			MapLoadScreen = Material(DynamicLoadObject("StdMapLoadTex_DM."$ MapName, class'Material', True));
		if (MapLoadScreen == None)
			MapLoadScreen = default.LoadingScreens[Rand(default.LoadingScreens.Length)];
			
		DrawOpImage(UT2K4ServerLoading.Operations[0]).Image = MapLoadScreen;

		//Wide loading screen. Adjust properties and add corrective Interaction.
		if (MapLoadScreen.MaterialUSize() == 2048)
		{
			myInteraction = LoadScreenRemovalInteraction(PlayerController.Player.InteractionMaster.AddInteraction(String(class'LoadScreenRemovalInteraction'), PlayerController.Player));
			myInteraction.OpLoading = DrawOpImage(UT2k4ServerLoading.Operations[0]);
			DrawOpImage(UT2K4ServerLoading.Operations[0]).SubXL = 1820;
			DrawOpImage(UT2K4ServerLoading.Operations[0]).SubYL = 1024;
		}
		
		LS = LevelSummary(DynamicLoadObject(MapName$".LevelSummary", class'Object', True));
		if (LS != None && LS.Title != "" && LS.Title != "Untitled" && Len(LS.Title) < 64)
			DrawOpText(UT2K4ServerLoading.Operations[2]).Text = MakeColorCode(default.MapColor) $ LS.Title;
		else
			DrawOpText(UT2K4ServerLoading.Operations[2]).Text = MakeColorCode(default.MapColor) $ DrawOpText(UT2K4ServerLoading.Operations[2]).Text;
	}
  
	hint = Super.GetLoadingHint(PlayerController, MapName, ColorHint);

	if ( default.BWMutators[0] ~= "BallisticProV55.Mut_Outfitting" )
	hint = default.LoadoutHint $ "|" $ hint;


	hint = default.ForumLink $ "| |" $  hint;
	hint = Repl(hint, "#B#", MakeColorCode(default.BindColor));
	hint = Repl(hint, "#H#", MakeColorCode(ColorHint));

	hint = MakeColorCode(ColorHint) $ ParseBallisticBinds(hint, ColorHint);

	return hint; 
}

static function string ParseBallisticBinds(string hint, Color ColorHint)
{
	local string parsed_hint;

	parsed_hint = hint;

	parsed_hint = repl(parsed_hint, "#BB_SCOPE", MakeColorCode(default.BindColor) $ class'Interactions'.static.GetFriendlyName(class'BallisticProInteractions'.default.ADSKey) $ MakeColorCode(ColorHint));
	parsed_hint = repl(parsed_hint, "#BB_RELOAD", MakeColorCode(default.BindColor) $ class'Interactions'.static.GetFriendlyName(class'BallisticProInteractions'.default.ReloadKey) $ MakeColorCode(ColorHint));
	parsed_hint = repl(parsed_hint, "#BB_FIREMODE", MakeColorCode(default.BindColor) $ class'Interactions'.static.GetFriendlyName(class'BallisticProInteractions'.default.FireModeKey) $ MakeColorCode(ColorHint));
	parsed_hint = repl(parsed_hint, "#BB_SPECIAL", MakeColorCode(default.BindColor) $ class'Interactions'.static.GetFriendlyName(class'BallisticProInteractions'.default.WpnSpcKey) $ MakeColorCode(ColorHint));
	parsed_hint = repl(parsed_hint, "#BB_SPRINT", MakeColorCode(default.BindColor) $ class'Interactions'.static.GetFriendlyName(class'BallisticProInteractions'.default.SprintKey) $ MakeColorCode(ColorHint));
	parsed_hint = repl(parsed_hint, "#BB_DUAL", MakeColorCode(default.BindColor) $ class'Interactions'.static.GetFriendlyName(class'BallisticProInteractions'.default.DualSelectKey) $ MakeColorCode(ColorHint));
	parsed_hint = repl(parsed_hint, "#BB_LOADOUT", MakeColorCode(default.BindColor) $ class'Interactions'.static.GetFriendlyName(class'BallisticProInteractions'.default.LoadoutKey) $ MakeColorCode(ColorHint));
	parsed_hint = repl(parsed_hint, "#BB_KILLSTREAK", MakeColorCode(default.BindColor) $ class'Interactions'.static.GetFriendlyName(class'BallisticProInteractions'.default.StreakKey) $ MakeColorCode(ColorHint));

	return parsed_hint;
}

function AssignInfo(PlayerController PC, string PlayerFlags)
{
	local int i;

	if (PlayerFlags ~= "None")
		return;

	for(i=0; i<PlayerStatsArray.Length; i++)
	{
		if(PlayerStatsArray[i].LDGHash == PlayerFlags)   	//Player's name matches, so it's him.
		{
			if (PlayerStatsArray[i].bRecover)
			{
				PlayerStatsArray[i].AssociatedInfo.RecoverStats(PC);
				PlayerStatsArray[i].bRecover = false;
			}
			else /* joining from spectating */
				PC.PlayerReplicationInfo.StartTime = Level.Game.GameReplicationInfo.ElapsedTime;

			return;
		}
	}

	// New player
	AddToArray(PC, PlayerFlags);
}

function AddToArray(PlayerController PC, string Hash)
{
	local ScoreRecoveryInfo NewInfo;
	local int i;

	NewInfo = Spawn(class'ScoreRecoveryInfo');
	NewInfo.PC = PC;

	//put in array
	i = PlayerStatsArray.Length;
	PlayerStatsArray.Length = i+1;

	PlayerStatsArray[i].LDGHash = Hash;
	PlayerStatsArray[i].AssociatedInfo = NewInfo;
	PC.PlayerReplicationInfo.StartTime = Level.Game.GameReplicationInfo.ElapsedTime;
}

function SaveScore(PlayerController PC)
{
	local int i;
	local string PlayerFlags;

	if (FlagsServer == None)
		return;

	PlayerFlags = FlagsServer.GetFor(PC);
	if (PlayerFlags == "None")
		return;

	for(i=0; i<PlayerStatsArray.Length; i++)
		if(PlayerStatsArray[i].LDGHash == PlayerFlags)			
			PlayerStatsArray[i].AssociatedInfo.SaveStats();
}

function RemoveFromArray(ScoreRecoveryInfo DeleteInfo)
{
	local int i;

	for(i=0; i<PlayerStatsArray.Length; i++)
		if(PlayerStatsArray[i].AssociatedInfo == DeleteInfo)
		{
			PlayerStatsArray.Remove(i, 1);
			return;
		}
}

function PlayerLeaving(PlayerController PC)
{
	local int i;
	local string PlayerFlags;

//#ifdef GAME_HAS_PRACTICE_ROUND
	if (IsPracticeRound() || FlagsServer == None)
		return;
//#else
//	if (FlagsServer == None)
//		return;
//#endif

	PlayerFlags = FlagsServer.GetFor(PC);
	if (PlayerFlags == "None")
		return;

	for(i=0; i<PlayerStatsArray.Length; i++)
		if(PlayerStatsArray[i].LDGHash == PlayerFlags) //found associated info
		{
			if (!PlayerStatsArray[i].bRecover)
			{
				PlayerStatsArray[i].AssociatedInfo.SaveStats();
				PlayerStatsArray[i].bRecover = true;
				break;
			}
		}
}

function ReceivedPlayerFlags(PlayerController PC, string PlayerFlags)
{
	AssignInfo(PC, PlayerFlags);
}

function string GetPlayerFlags(PlayerController PC)
{
	if (FlagsServer != None)
		return FlagsServer.GetFor(PC);

	return "";
}

function RestartPlayer(Controller aPlayer)
{	
	if (PlayerController(aPlayer) != None && GetPlayerFlags(PlayerController(aPlayer)) ~= "None")
		return;

	Super.RestartPlayer(aPlayer);
}

function int GetIntOption( string Options, string ParseString, int CurrentValue)
{
	//Hack to override joining team
	if (TeamBalancer != None && ParseString ~= "Team")
		return TeamBalancer.SetPlayerTeam(Super.GetIntOption(Options, ParseString, CurrentValue));

	return Super.GetIntOption(Options, ParseString, CurrentValue);
}

//#ifdef BW_FREON
//function PlayerController Login(string Portal, string Options, out string Error)
//{
//	local PlayerController PC;

//	PC = Super.Login(Portal, Options, Error);

//	if (Freon_Player_UTComp_LDG(PC) != None)
//	{
//		Freon_Player_UTComp_LDG(PC).PlayerBecamingSpectator = PlayerBecamingSpectator;
//		Freon_Player_UTComp_LDG(PC).PlayerBecameActive = PlayerBecameActive;
//	}

//	return PC;
//}
//#else
function PlayerController Login(string Portal, string Options, out string Error)
{
	local PlayerController PC;

	PC = Super.Login(Portal, Options, Error);

	if (UTComp_xPlayer(PC) != None)
	{
		UTComp_xPlayer(PC).PlayerBecamingSpectator = PlayerBecamingSpectator;
		UTComp_xPlayer(PC).PlayerBecameActive = PlayerBecameActive;
	}

	return PC;
}
//#endif

function Logout(Controller Exiting)
{
	if(PlayerController(Exiting) != None) //no bots
	{
		PlayerLeaving(PlayerController(Exiting));

		if (PlayerController(Exiting).PlayerReplicationInfo.bOnlySpectator)
			DropReservedSlot(PlayerController(Exiting).GetPlayerIDHash());
	}

	Super.Logout(Exiting);
}

function BroadcastDeathMessage(Controller Killer, Controller Other, class<DamageType> damageType)
{
    if ( (Killer == Other) || (Killer == None) )
        BroadcastLocalized(self,DeathMessageClass, 1, None, Other.PlayerReplicationInfo, damageType);
    else if (Killer.Pawn != None && BallisticWeapon(Killer.Pawn.Weapon) != None && BallisticWeapon(Killer.Pawn.Weapon).bScopeView)
		BroadcastLocalized(self,DeathMessageClass, 2, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);
    else BroadcastLocalized(self,DeathMessageClass, 0, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);
}

function GetServerInfo( out ServerResponseLine ServerState )
{
	Super.GetServerInfo(ServerState);
	if(Level.Title != "Untitled" && Len(Level.Title) < 64)
		ServerState.MapName = Level.Title;
}
//Inserted 492 lines.
//END_BW_GAME_BASE

function PracticeRoundEnded()
{
	local Controller	C;
	local UTComp_PRI uPRI;
	
	// Practice Round Ended, reset scores!
	for ( C = Level.ControllerList; C != None; C = C.NextController )
		if ( C.PlayerReplicationInfo != None )
		{
			C.PlayerReplicationInfo.Kills = 0;
			C.PlayerReplicationInfo.Score	= 0;
			C.PlayerReplicationInfo.Deaths= 0;

			if ( TeamPlayerReplicationInfo(C.PlayerReplicationInfo) != None )
				TeamPlayerReplicationInfo(C.PlayerReplicationInfo).Suicides = 0;

			if ( ASPlayerReplicationInfo(C.PlayerReplicationInfo) != None )
			{
				ASPlayerReplicationInfo(C.PlayerReplicationInfo).DisabledObjectivesCount = 0;
				ASPlayerReplicationInfo(C.PlayerReplicationInfo).DisabledFinalObjective	= 0;
			}
			
			uPRI = class'UTComp_Util'.static.GetUTCompPRI(C.PlayerReplicationInfo);
			
			if (uPRI != None)
			{
				uPRI.RealKills = 0;
				uPRI.RealDeaths = 0;
			}
			
			uPRI = None;
		}

	bFirstBlood = false;
	Teams[0].Score = 0;
	Teams[1].Score = 0;
	Teams[0].NetUpdateTime = Level.TimeSeconds - 1;
	Teams[1].NetUpdateTime = Level.TimeSeconds - 1;
}

defaultproperties
{
     LoadingScreens(0)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen1'
     LoadingScreens(1)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen2'
     LoadingScreens(2)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen3'
     LoadingScreens(3)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen4'
     LoadingScreens(4)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen5'
     LoadingScreens(5)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen6'
     LoadingScreens(6)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen7'
     LoadingScreens(7)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen8'
     LoadingScreens(8)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen9'
     LoadingScreens(9)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen10'
     LoadingScreens(10)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen11'
     LoadingScreens(11)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen12'
     LoadingScreens(12)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen13'
     LoadingScreens(13)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen14'
     LoadingScreens(14)=Texture'LDGGameBW_rc.LoadingScreen.BWLoadingScreen15'
     LoadingScreenHints(0)="Can't aim well? Press #BB_SCOPE to switch to scope view or ironsights for a better aim."
     LoadingScreenHints(1)="Press #BB_RELOAD to reload your weapon when not in combat."
     LoadingScreenHints(2)="Press #BB_FIREMODE to cycle through weapon firemodes."
     LoadingScreenHints(3)="The #B#Nova Staff#H# or #B#Dark Star#H#, when fully charged, can provide powerful bonuses. Press #BB_SPECIAL to activate them."
     LoadingScreenHints(4)="Some weapons can be deployed into stationary cannon. Use %ALTFIRE% to deploy them or to pack them back when deployed."
     LoadingScreenHints(5)="Running slow? Press #BB_SPRINT to sprint."
     LoadingScreenHints(6)="Carrying two pistols? Switch to one of them and then press #BB_DUAL to select the other one."
     LoadingScreenHints(7)="The #B#Dark Star#H# and #B#Nova Staff#H# gain increased damage when energized with the souls of slain enemies."
     LoadingScreenHints(8)="Many weapons have a special function. Press #BB_SPECIAL to trigger it."
     LoadingScreenHints(9)="Bullets can penetrate walls. The bigger the gun, the further they will penetrate."
     LoadingScreenHints(10)="The #B#M-75 Railgun#H# has a thermal scope. Press #BB_SPECIAL when aiming through the scope to activate it."
     LoadingScreenHints(11)="The #B#E-23 ViPeR#H# has unique firemodes which vary significantly. Press #BB_FIREMODE to switch between them."
     LoadingScreenHints(12)="Headshots deal 50% more damage. Explosive weapons cannot deal headshot damage, but projectiles and shotguns can."
     LoadingScreenHints(13)="Some weapons have suppressors, which remove the flash and significantly reduce noise. Press #BB_SPECIAL to apply them."
     LoadingScreenHints(14)="The pin of a grenade can be removed by pressing #BB_SPECIAL."
     LoadingScreenHints(15)="You can make a reduced dodge while using your iron sights, but you cannot dodge jump."
     LoadingScreenHints(16)="You move 20 percent slower while aiming your weapon."
     LoadingScreenHints(17)="The longer you use automatic fire, the more erratic your weapon's aim will become."
     LoadingScreenHints(18)="Some melee weapons can block. To block, hold down #BB_SPECIAL."
     LoadingScreenHints(19)="Press %USE% to quickly release a deployed weapon, or to use a previously deployed weapon."
     LoadingScreenHints(20)="Pistols, shotguns and submachine guns deal less damage over long ranges."
     LoadingScreenHints(21)="The size of a weapon's crosshair provides a rough estimation of its hipfire spread."
     LoadingScreenHints(22)="Killing sprees grant bonus rewards. Press #BB_KILLSTREAK when notified to claim them. Set killstreak rewards in the loadout menu."
     LoadoutHint="Loadout game type: Press #BB_LOADOUT to open the loadout menu."
     ForumLink="Visit our forum on #B#www.ldg-gaming.eu#H#"
     BWMutators(0)="BallisticProV55.Mut_ConflictLoadout"
     BWMutators(1)="BallisticProV55.Mut_Regeneration"
     BWMutators(2)="BallisticProV55.Mut_Marathon"
     BWMutators(3)="LDGGameBW.MutUTCompBW_LDG"
     BWMutators(4)="BWInteractions3.MutBWInteractions"
     HintColor=(B=255,G=255,R=255,A=255)
     MapColor=(G=255,R=255,A=255)
     PlayerHealth=100
     PlayerSuperHealth=199
     MapListType="LDGGameBW.LDGBallisticASMapList"
     MutatorClass="LDGGameBW.LDGBWASMutator"
     GameName="LDG Ballistic Assault"
     BindColor=(G=255,R=255)
}
