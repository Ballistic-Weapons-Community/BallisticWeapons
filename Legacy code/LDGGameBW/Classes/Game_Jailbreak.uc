class Game_Jailbreak extends Jailbreak;

//#define BW_NO_LOADING_SCREENS
//#define BW_SUPER_TM
//#define BW_CUST_PLAY_INFO

//Common Code
//BEGIN_BW_GAME_DECL
//#ifndef BW_NO_LOADING_SCREENS
//var private const array<Texture> LoadingScreens;
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

var config bool bReverseFF;

/* camping related */
var config int      CampThreshold;          // area a player must stay in to be considered camping
var int             CampInterval;           // time between flagging the same player
var config bool     bKickExcessiveCampers;  // kick players that camp 4 consecutive times
/* camping related */

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
	Super(xTeamGame).FillPlayInfo(PlayInfo);
//#else	
//	Super.FillPlayInfo(PlayInfo);
//#endif

//#ifdef BW_CUST_PLAY_INFO
	CustomFillPlayInfo(PlayInfo);	
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
	MyText = CustomGetDescriptionText(PropName);

	if (MyText != "")
		return MyText;

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
	local LevelSummary LS;

	ColorHint = default.HintColor;
	
	foreach PlayerController.AllObjects(Class'UT2K4ServerLoading', UT2K4ServerLoading)
	{
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
//	if (IsPracticeRound() || FlagsServer == None)
//		return;
//#else
	if (FlagsServer == None)
		return;
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

static function CustomFillPlayInfo(PlayInfo PlayInfo)
{			
	PlayInfo.AddSetting(Default.GameGroup, "bReverseFF", "Reversed Friendly Fire",    0, 60, "Check");
	PlayInfo.AddSetting(Default.GameGroup, "bEnableJailFights",    Default.TextWebAdminEnableJailFights,    0, 60, "Check");
  PlayInfo.AddSetting(Default.GameGroup, "bFavorHumansForArena", Default.TextWebAdminFavorHumansForArena, 0, 60, "Check");	
	PlayInfo.AddSetting(Default.GameGroup, "CampThreshold", "Camp Area", 0, 1, "Text", "3;0:999",, True);
	PlayInfo.AddSetting(Default.GameGroup, "bKickExcessiveCampers", "Kick Excessive Campers", 0, 1, "Check",,, True);
}

static event string CustomGetDescriptionText(string PropName)
{ 
	switch(PropName)
	{	
		case "CampThreshold":
			return "The area a player must stay in to be considered camping.";
			
		case "bKickExcessiveCampers":
			return "Kick players that camp 4 consecutive times.";
			
		case "bReverseFF":
			return "Friendly fire will be returned back to the instigator instead of the victim.";
	}
	
	return "";
}

function Timer()
{
	Super.Timer();
	
	if (GameReplicationInfo.bMatchHasBegun && !bGameEnded)
		CheckForCampers();
}

function int ReduceDamage(int Damage, Pawn PawnVictim, Pawn PawnInstigator, vector LocationHit, out vector MomentumHit, class<DamageType> ClassDamageType) 
{
  local JBTagPlayer TagPlayerInstigator;
  local JBTagPlayer TagPlayerVictim;

  if (PawnInstigator == None || PawnInstigator.Controller == PawnVictim.Controller)
  	return SuperReduceDamage(Damage, PawnVictim, PawnInstigator, LocationHit, MomentumHit, ClassDamageType);

  TagPlayerInstigator = Class'JBTagPlayer'.Static.FindFor(PawnInstigator.PlayerReplicationInfo);
  TagPlayerVictim     = Class'JBTagPlayer'.Static.FindFor(PawnVictim.PlayerReplicationInfo);

  if (TagPlayerInstigator == None || TagPlayerVictim == None)
    return SuperReduceDamage(Damage, PawnVictim, PawnInstigator, LocationHit, MomentumHit, ClassDamageType);

  if (TagPlayerVictim.GetArena() != TagPlayerInstigator.GetArena()) 
  {
    MomentumHit = vect(0,0,0);
    return 0;
  }

  if (TagPlayerVictim.IsInJail() && TagPlayerVictim.GetJail() == TagPlayerInstigator.GetJail() &&
     !TagPlayerVictim.GetJail().IsReleaseActive(PawnVictim.PlayerReplicationInfo.Team))
	{
    if (bEnableJailFights && Class'LDGJBBotSquadJail'.Static.IsPlayerFighting(TagPlayerInstigator.GetController(), True) &&
			Class'LDGJBBotSquadJail'.Static.IsPlayerFighting(TagPlayerVictim.GetController(), True))
      return Damage;
		else 
		{
			MomentumHit = vect(0,0,0);
			return 0;
		}
	}
	else if ((TagPlayerInstigator.IsInJail() && !TagPlayerInstigator.GetJail().IsReleaseActive(PawnInstigator.PlayerReplicationInfo.Team)) ||
					 (TagPlayerVictim.IsInJail() && !TagPlayerVictim.GetJail().IsReleaseActive(PawnVictim.PlayerReplicationInfo.Team)) )
	{
		MomentumHit = vect(0,0,0);
		return 0;
	}

  return SuperReduceDamage(Damage, PawnVictim, PawnInstigator, LocationHit, MomentumHit, ClassDamageType);
}

function int SuperReduceDamage( int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	local int InjuredTeam, InstigatorTeam;
	local controller InstigatorController;

	if ( InstigatedBy != None )
		InstigatorController = InstigatedBy.Controller;

	if ( InstigatorController == None )
	{
		if ( DamageType.default.bDelayedDamage )
			InstigatorController = injured.DelayedDamageInstigatorController;
		if ( InstigatorController == None )
			return Super(DeathMatch).ReduceDamage( Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
	}

	InjuredTeam = Injured.GetTeamNum();
	InstigatorTeam = InstigatorController.GetTeamNum();
	if ( InstigatorController != injured.Controller )
	{
		if ( (InjuredTeam != 255) && (InstigatorTeam != 255) )
		{
			if ( InjuredTeam == InstigatorTeam )
			{
				if ( class<WeaponDamageType>(DamageType) != None || class<VehicleDamageType>(DamageType) != None )
					Momentum *= TeammateBoost;
				if ( (Bot(injured.Controller) != None) && (InstigatorController.Pawn != None) )
					Bot(Injured.Controller).YellAt(InstigatorController.Pawn);
				else if ( (PlayerController(Injured.Controller) != None)
						&& Injured.Controller.AutoTaunt() )
					Injured.Controller.SendMessage(InstigatorController.PlayerReplicationInfo, 'FRIENDLYFIRE', Rand(3), 5, 'TEAM');

				if ( FriendlyFireScale==0.0 || (Vehicle(injured) != None && Vehicle(injured).bNoFriendlyFire) )
				{
					if ( GameRulesModifiers != None )
						return GameRulesModifiers.NetDamage( Damage, 0,injured,instigatedBy,HitLocation,Momentum,DamageType );
					else
						return 0;
				}
								
				if (bReverseFF)
				{
					Damage *= class'LDGBallisticRFFExceptions'.static.GetRFF(string(DamageType));
					if (BallisticTurret(instigatedBy) != None && BallisticTurret(instigatedBy).Driver != None)
      	  	BallisticTurret(instigatedBy).Driver.TakeDamage(Damage, BallisticTurret(instigatedBy).Driver, HitLocation, vect(0,0,0), DamageType);
      	  else
						instigatedBy.TakeDamage(Damage, instigatedBy, HitLocation, vect(0,0,0), DamageType);
					return 0;
				}
				else
					Damage *= FriendlyFireScale;
			}
			else if ( !injured.IsHumanControlled() && (injured.Controller != None)
					&& (injured.PlayerReplicationInfo != None) && (injured.PlayerReplicationInfo.HasFlag != None) )
				injured.Controller.SendMessage(None, 'OTHER', injured.Controller.GetMessageIndex('INJURED'), 15, 'TEAM');
		}
	}
	return Super(DeathMatch).ReduceDamage( Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
}

function CheckForCampers()
{
  local Controller c;
  local Box HistoryBox;
  local float MaxDim;
  local int i;
  local JBTagPlayer TagPlayer;
  local LDGJBPlayerReplicationInfo P;

  for(C = Level.ControllerList; C != None; C = c.NextController)
  {
  	P = LDGJBPlayerReplicationInfo(C.PlayerReplicationInfo);
  	
		if (P == None)
			continue;
  	  	
		if(C.PlayerReplicationInfo.bOnlySpectator || C.PlayerReplicationInfo.bOutOfLives || C.Pawn == None || JBGameReplicationInfo(GameReplicationInfo).bIsExecuting)
		{
			P.NextLocHistSlot = 0;
			P.bWarmedUp = false;
			
			P.bWarned = false;
		  P.ConsecutiveCampCount = 0;
		  P.ReWarnTime = 0;		
			continue;
    }

    TagPlayer = Class'JBTagPlayer'.Static.FindFor(C.PlayerReplicationInfo);

		if (TagPlayer != None && TagPlayer.IsInJail())
		{
			P.NextLocHistSlot = 0;
			P.bWarmedUp = false;
			
			P.bWarned = false;
		  P.ConsecutiveCampCount = 0;
		  P.ReWarnTime = 0;		
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
	local LDGJBPlayerReplicationInfo P;
	local Pawn Camper;
	
	SendCamperWarning(C);
	
	P = LDGJBPlayerReplicationInfo(C.PlayerReplicationInfo);
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

function bool NeedPlayers()
{
 	return Super(xTeamGame).NeedPlayers();
}

function SendCamperWarning(Controller Camper)
{
	local Controller C;

	for(C = Level.ControllerList; C != None; C = C.NextController)
	{
		if (PlayerController(C) != None)
			PlayerController(C).ReceiveLocalizedMessage(class'Message_Camper_JB', int(C != Camper), Camper.PlayerReplicationInfo);
	}
}
	

defaultproperties
{
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
     BWMutators(0)="LDGGameBW.MutUTCompBW_LDG" // ? Is it compatible?
     BWMutators(1)="BWInteractions3.MutBWInteractions"
     HintColor=(B=255,G=255,R=255,A=255)
     MapColor=(G=255,R=255,A=255)
     PlayerHealth=175
     PlayerSuperHealth=218
     CampThreshold=400
     CampInterval=5
     bKickExcessiveCampers=True
     MapListType="LDGGameBW.MapList_Jailbreak"
     MutatorClass="LDGGameBW.DefMut_Jailbreak"
     GameName="LDG Ballistic Jailbreak"
     BindColor=(G=255,R=255)
}
