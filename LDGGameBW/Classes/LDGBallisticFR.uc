class LDGBallisticFR extends Freon;

//#define GAME_HAS_PRACTICE_ROUND
//#define BW_NO_HEALTH_OVERRIDE
//#define BW_FREON

//Common Code
//BEGIN_BW_GAME_DECL
//#ifndef BW_NO_LOADING_SCREENS
var private const array<Texture> LoadingScreens;
//#endif

var private const array< class<WeaponPickup> > PrecachePickups;

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
//var config int PlayerHealth;
//var config int PlayerSuperHealth;
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
function PlayerBecamingSpectator(Freon_Player_UTComp_LDG PC)
{
	PlayerLeaving(PC);
	if (TeamBalancer != None)
		TeamBalancer.PlayerBecamingSpectator(PC);
}
//#else
//function PlayerBecamingSpectator(UTComp_xPlayer PC)
//{
//	PlayerLeaving(PC);
//	if (TeamBalancer != None)
//		TeamBalancer.PlayerBecamingSpectator(PC);
//}
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
function PlayerBecameActive(Freon_Player_UTComp_LDG PC)
{
	AssignInfo(PC, GetPlayerFlags(PC));
	if (TeamBalancer != None)
		TeamBalancer.PlayerBecameActive(PC);
}
//#else
//function PlayerBecameActive(UTComp_xPlayer PC)
//{
//	AssignInfo(PC, GetPlayerFlags(PC));
//	if (TeamBalancer != None)
//		TeamBalancer.PlayerBecameActive(PC);
//}
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
//	if(p == None || p.Controller == None || p.Controller.PlayerReplicationInfo == None)
//		return;

//	p.Health = PlayerHealth;
//  p.HealthMax = PlayerHealth;
//  p.SuperHealthMax = PlayerSuperHealth;

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
//	PlayInfo.AddSetting(Default.GameGroup, "PlayerHealth", "Player Health", 0, 100, "Text", "3;0:999");
//	PlayInfo.AddSetting(Default.GameGroup, "PlayerSuperHealth", "Player SuperHealth", 0, 100, "Text", "3;0:999");
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
//	if (PropName == "PlayerHealth")
//		return "Player health at respawn.";

//	if (PropName == "PlayerSuperHealth")
//		return "Player super health.";
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

	if ( default.BWMutators[0] ~= "BallisticProV55.Mut_ConflictLoadout" )
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

	return "None";
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
function PlayerController Login(string Portal, string Options, out string Error)
{
	local PlayerController PC;

	PC = Super.Login(Portal, Options, Error);

	if (Freon_Player_UTComp_LDG(PC) != None)
	{
		Freon_Player_UTComp_LDG(PC).PlayerBecamingSpectator = PlayerBecamingSpectator;
		Freon_Player_UTComp_LDG(PC).PlayerBecameActive = PlayerBecameActive;
	}

	return PC;
}
//#else
//function PlayerController Login(string Portal, string Options, out string Error)
//{
//	local PlayerController PC;

//	PC = Super.Login(Portal, Options, Error);

//	if (UTComp_xPlayer(PC) != None)
//	{
//		UTComp_xPlayer(PC).PlayerBecamingSpectator = PlayerBecamingSpectator;
//		UTComp_xPlayer(PC).PlayerBecameActive = PlayerBecameActive;
//	}

//	return PC;
//}
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

//EndRound
function EndRound(PlayerReplicationInfo Scorer)
{
	bEndOfRound=True;
	
	if (IsPracticeRound() && TeamBalancer != None)
		TeamBalancer.MatchEvent("PracticeRoundEnded");
		
	Super.EndRound(Scorer);

    if(Scorer.Team.Score != GoalScore)
    {
		if (TeamBalancer != None)
			TeamBalancer.MatchEvent("RoundEnded");
	}
}

function int ReduceDamage(int Damage, pawn injured, pawn instigatedBy, vector HitLocation, 
                          out vector Momentum, class<DamageType> DamageType)
{
	local Misc_PRI PRI;
	local int OldDamage;
	local int NewDamage;
	local float Score;
	local float RFF;
	local vector EyeHeight;
	
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
		
			RFF = PRI.ReverseFF * class'LDGBallisticRFFExceptions'.static.GetRFF(string(DamageType));
		
			if(RFF > 0.0)
			{
				if (BallisticTurret(instigatedBy) != None && BallisticTurret(instigatedBy).Driver != None)
					BallisticTurret(instigatedBy).Driver.TakeDamage(Damage * RFF * FriendlyFireScale, BallisticTurret(instigatedBy).Driver, HitLocation, vect(0,0,0), DamageType);
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

function RespawnPlayers(optional bool bMoveAlive)
{
	if (TeamBalancer != None)
		TeamBalancer.MatchEvent("RoundReset");
	Super.RespawnPlayers(bMoveAlive);
}

//Precache literally everything.
static function PrecacheGameTextures(LevelInfo myLevel)
{
	local int i;
	
	Super.PrecacheGameTextures(myLevel);

	for (i=0; i< default.PrecachePickups.Length; i++)
		default.PrecachePickups[i].static.StaticPrecache(myLevel);
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
     PrecachePickups(0)=Class'BWBPRecolorsPro.A49Pickup'
     PrecachePickups(1)=Class'BWBPRecolorsPro.AH208Pickup'
     PrecachePickups(2)=Class'BWBPRecolorsPro.AH250Pickup'
     PrecachePickups(3)=Class'BWBPRecolorsPro.AK47Pickup'
     PrecachePickups(4)=Class'BWBPRecolorsPro.AS50Pickup'
     PrecachePickups(5)=Class'BWBPRecolorsPro.BulldogPickup'
     PrecachePickups(6)=Class'BWBPRecolorsPro.ChaffPickup'
     PrecachePickups(7)=Class'BWBPOtherPackPro.CX61Pickup'
     PrecachePickups(8)=Class'BWBPRecolorsPro.CYLOPickup'
     PrecachePickups(9)=Class'BWBPRecolorsPro.CYLOFirestormPickup'
     PrecachePickups(10)=Class'BWBPRecolorsPro.CoachGunPickup'
     PrecachePickups(11)=Class'BWBPOtherPackPro.DefibFistsPickup'
     PrecachePickups(12)=Class'BWBPRecolorsPro.DragonsToothPickup'
     PrecachePickups(13)=Class'BWBPRecolorsPro.F2000Pickup'
     PrecachePickups(14)=Class'BWBPRecolorsPro.FG50Pickup'
     PrecachePickups(15)=Class'BWBPRecolorsPro.FLASHPickup'
     PrecachePickups(16)=Class'BWBPRecolorsPro.G28Pickup'
     PrecachePickups(17)=Class'BallisticProV55.A42Pickup'
     PrecachePickups(18)=Class'BWBPRecolorsPro.ICISPickup'
     PrecachePickups(19)=Class'BWBPRecolorsPro.LAWPickup'
     PrecachePickups(20)=Class'BWBPRecolorsPro.LK05Pickup'
     PrecachePickups(21)=Class'BWBPRecolorsPro.LonghornPickup'
     PrecachePickups(22)=Class'BWBPRecolorsPro.LS14Pickup'
     PrecachePickups(23)=Class'BWBPRecolorsPro.M2020GaussPickup'
     PrecachePickups(24)=Class'BWBPRecolorsPro.MRDRPickup'
     PrecachePickups(25)=Class'BWBPRecolorsPro.MARSPickup'
     PrecachePickups(26)=Class'BWBPRecolorsPro.MGLPickup'
     PrecachePickups(27)=Class'BWBPRecolorsPro.MK781Pickup'
     PrecachePickups(28)=Class'BWBPRecolorsPro.PS9mPickup'
     PrecachePickups(29)=Class'BWBPRecolorsPro.SK410Pickup'
     PrecachePickups(30)=Class'BWBPRecolorsPro.SKASPickup'
     PrecachePickups(31)=Class'BWBPRecolorsPro.X82Pickup'
     PrecachePickups(32)=Class'BWBPRecolorsPro.X8Pickup'
     PrecachePickups(33)=Class'BWBPRecolorsPro.XM84Pickup'
     PrecachePickups(34)=Class'BallisticProV55.A42Pickup'
     PrecachePickups(35)=Class'BallisticProV55.A73Pickup'
     PrecachePickups(36)=Class'BallisticProV55.A500Pickup'
     PrecachePickups(37)=Class'BallisticProV55.A909Pickup'
     PrecachePickups(38)=Class'BallisticProV55.AM67Pickup'
     PrecachePickups(39)=Class'BallisticProV55.BOGPPickup'
     PrecachePickups(40)=Class'BallisticProV55.BX5Pickup'
     PrecachePickups(41)=Class'BallisticProV55.D49Pickup'
     PrecachePickups(42)=Class'BallisticProV55.E23Pickup'
     PrecachePickups(43)=Class'BallisticProV55.EKS43Pickup'
     PrecachePickups(44)=Class'BallisticProV55.Fifty9Pickup'
     PrecachePickups(45)=Class'BallisticProV55.FP7Pickup'
     PrecachePickups(46)=Class'BallisticProV55.FP9Pickup'
     PrecachePickups(47)=Class'BallisticProV55.G5Pickup'
     PrecachePickups(48)=Class'BallisticProV55.GRS9Pickup'
     PrecachePickups(49)=Class'BallisticProV55.HVCMk9Pickup'
     PrecachePickups(50)=Class'BallisticProV55.leMatPickup'
     PrecachePickups(51)=Class'BallisticProV55.M46Pickup'
     PrecachePickups(52)=Class'BallisticProV55.M50Pickup'
     PrecachePickups(53)=Class'BallisticProV55.M75Pickup'
     PrecachePickups(54)=Class'BallisticProV55.M290Pickup'
     PrecachePickups(55)=Class'BallisticProV55.M353Pickup'
     PrecachePickups(56)=Class'BallisticProV55.M763Pickup'
     PrecachePickups(57)=Class'BallisticProV55.M925Pickup'
     PrecachePickups(58)=Class'BallisticProV55.MACPickup'
     PrecachePickups(59)=Class'BallisticProV55.MarlinPickup'
     PrecachePickups(60)=Class'BallisticProV55.MD24Pickup'
     PrecachePickups(61)=Class'BallisticProV55.MRLPickup'
     PrecachePickups(62)=Class'BallisticProV55.MRS138Pickup'
     PrecachePickups(63)=Class'BallisticProV55.MRT6Pickup'
     PrecachePickups(64)=Class'BallisticProV55.NRP57Pickup'
     PrecachePickups(65)=Class'BallisticProV55.R9Pickup'
     PrecachePickups(66)=Class'BallisticProV55.R78Pickup'
     PrecachePickups(67)=Class'BallisticProV55.RiotPickup'
     PrecachePickups(68)=Class'BallisticProV55.RS8Pickup'
     PrecachePickups(69)=Class'BallisticProV55.RSDarkPickup'
     PrecachePickups(70)=Class'BallisticProV55.RSNovaPickup'
     PrecachePickups(71)=Class'BallisticProV55.RX22APickup'
     PrecachePickups(72)=Class'BallisticProV55.SARPickup'
     PrecachePickups(73)=Class'BallisticProV55.SRS900Pickup'
     PrecachePickups(74)=Class'BallisticProV55.T10Pickup'
     PrecachePickups(75)=Class'BallisticProV55.X3Pickup'
     PrecachePickups(76)=Class'BallisticProV55.X4Pickup'
     PrecachePickups(77)=Class'BallisticProV55.XK2Pickup'
     PrecachePickups(78)=Class'BallisticProV55.XMK5Pickup'
     PrecachePickups(79)=Class'BallisticProV55.XMV850Pickup'
     PrecachePickups(80)=Class'BallisticProV55.XRS10Pickup'
     PrecachePickups(81)=Class'BWBPOtherPackPro.PD97Pickup'
     PrecachePickups(82)=Class'BWBPAirstrikesPro.TargetDesignatorPickup'
     PrecachePickups(83)=Class'BWBPOtherPackPro.XOXOPickup'
     PrecachePickups(84)=Class'BWBPOtherPackPro.RaygunPickup'
     PrecachePickups(85)=Class'BWBPOtherPackPro.WrenchPickup'
	 PrecachePickups(86)=Class'BWBPSomeOtherPack.MAG78Pickup'
	 PrecachePickups(87)=Class'BWBPSomeOtherPack.TrenchGunPickup'
	 PrecachePickups(88)=Class'BWBPSomeOtherPack.XM20Pickup'
	 PrecachePickups(89)=Class'BallisticJiffyPack.ARPickup'
     LoadingScreenHints(0)="Can't aim well? Press #BB_SCOPE to switch to scope view or iron sights for a better aim."
     LoadingScreenHints(1)="Press #BB_RELOAD to reload your weapon when not in combat."
     LoadingScreenHints(2)="Press #BB_FIREMODE to cycle through weapon firemodes."
     LoadingScreenHints(3)="The #B#Nova Staff#H# or #B#Dark Star#H#, when fully charged, can provide powerful bonuses. Press #BB_SPECIAL to activate them."
     LoadingScreenHints(4)="Some weapons can be deployed. Use %ALTFIRE% to deploy them or to pack them back when deployed."
     LoadingScreenHints(5)="Running slow? Press #BB_SPRINT to sprint."
     LoadingScreenHints(6)="Carrying two pistols? Switch to one of them and then press #BB_DUAL to select the other one."
     LoadingScreenHints(7)="The #B#Riot Shield#H# is more effective at blocking enemy fire when you are crouching."
     LoadingScreenHints(8)="Many weapons have a special function. Press #BB_SPECIAL to trigger it."
     LoadingScreenHints(9)="Bullets can penetrate walls. The bigger the gun, the further they will penetrate."
     LoadingScreenHints(10)="The #B#M-75 Railgun#H# has a thermal scope. Press #BB_SPECIAL when aiming through the scope to activate it."
     LoadingScreenHints(11)="The #B#E-23 ViPeR#H# has unique firemodes which vary significantly. Press #BB_FIREMODE to switch between them."
     LoadingScreenHints(12)="Headshots deal 50% more damage. Explosive weapons cannot deal headshot damage, but projectiles and shotguns can."
     LoadingScreenHints(13)="Some weapons have suppressors, which remove the flash, reduce recoil and significantly reduce noise. However, damage is reduced. Press #BB_SPECIAL to apply them."
     LoadingScreenHints(14)="The pin of a grenade can be removed by pressing #BB_SPECIAL."
     LoadingScreenHints(15)="You can make a reduced dodge while using your iron sights, but you cannot dodge jump."
     LoadingScreenHints(16)="You move 10 percent slower while aiming your weapon."
     LoadingScreenHints(17)="The longer you use automatic fire, the more erratic your weapon's aim will become."
     LoadingScreenHints(18)="Some melee weapons can block. To block, hold down #BB_SPECIAL."
     LoadingScreenHints(19)="Press %USE% to quickly release a deployed weapon, or to use a previously deployed weapon."
     LoadingScreenHints(20)="Ballistic weapons deal less damage over long ranges. Energy weapons, however, often deal more damage per hit at range."
     LoadingScreenHints(21)="The size of a weapon's crosshair provides a rough estimation of its hipfire spread."
     LoadingScreenHints(22)="Killing sprees grant bonus rewards. Press #BB_KILLSTREAK when notified to claim them. Set killstreak rewards in the loadout menu."
     LoadoutHint="Loadout game type: Press #BB_LOADOUT to open the loadout menu."
     ForumLink="Visit our forum on #B#www.ldg-gaming.eu#H#"
     BWMutators(0)="BallisticProV55.Mut_ConflictLoadout"
	 BWMutators(1)="BallisticProV55.Mut_Killstreak"
     BWMutators(2)="BallisticProV55.Mut_ChargeSprinter"
     BWMutators(3)="LDGGameBW.MutThawProtection"
     BWMutators(4)="LDGGameBW.MutUTCompBW_LDG_FR"
     BWMutators(5)="BWInteractions3.MutBWInteractions"
     HintColor=(B=255,G=255,R=255,A=255)
     MapColor=(G=255,R=255,A=255)
     DefaultPlayerClassName="LDGGameBW.Freon_Pawn_Normal"
     MapListType="LDGGameBW.LDGBallisticFRMapList"
     MutatorClass="LDGGameBW.LDGBWFRMutator"
     GameName="LDG Ballistic Freon (DM Maps)"
     BindColor=(G=255,R=255)
}
