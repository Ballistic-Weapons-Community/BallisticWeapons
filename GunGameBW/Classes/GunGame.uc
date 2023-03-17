//////////////////////////////////////
// GunGame GameType - (c) by Mutant 
// Version 1.0 Final                
// modified for BW by Jiffy and Azarael
//////////////////////////////////////
class GunGame extends xDeathmatch
	config(System);

//Settings-related
var config int 					StartHealth;
var config int 					StartShield;
var config int 					MaxHealth;
var bool 						bAdrenalineOn;			//Disables adrenaline -> no combos
var config byte 				CureAward;				//Health for kills, heals player max. up to 'StartHealth'. Then Shield, max. up to 'StartShield'
var config byte 				IterationAward;			//Award amount for cycling through WeaponList (only valid for GoalScore/Lives mode)
var config byte 				VictoryCondition;		//0 = Reaching highest GunLevel ends the match; 1 = Reaching GoalScore ends the match; 2 = Last Man wins the match
var config byte 				AmmoHandling;			//Rule how to handle the ammo issue: 0 = unlimited ammo, 1 = limited ammo, so if out of ammo --> downgrade GunLevel
var config byte 				StdWeaponFeature;		//Defines how to handle standard weapon kills
var config byte 				StdWeaponFactor;		//Defines the value of the effect a standard weapon kill will cause
var config byte 				KillAmount;				//Defines how many kills are needed to level up

var bool 						bNoAdrenaline;       		   //Remove Adrenaline-Pickups
var bool 						bNoHealth;          		   //Remove Health-Pickups
var bool 						bNoShield;         		   //Remove Shield-Pickups
var bool 						bNoDoubleDamage;      		   //Remove DoubleDamage-Pickups

var array< class<Weapon> > 		WeaponList; 		//Load DefaultWeapons or Custom weapons in here, this is the actual weapon set GunGame works with
var array<GGRegistry> 			Registry;        	//Registry class, used to handle ammonition issues, and some other GG specific things (similar to a Controller class)
var int 						HighestLevel;        //Highest GunLevel
var array<PlayerStart> 			PlayerStarts;   	//Includes all playerstarts

var globalconfig string			InventoryMut, HUDFixMut;

var GunGamePRI 					timerKillerPRI;		//moving variables to Timer to execute weapon switching on a delay
var Controller 					timerKiller;
var bool 						bTimerCalled;

var Sound 						LvlUpSound;			//sounds to play upon killing & reaching the final weapon

//**********************************************FUNCTIONS****************************************************************//

static function FillPlayInfo(PlayInfo PlayInfo)
{
     Super.FillPlayInfo(PlayInfo);

     PlayInfo.AddSetting("GunGame", "StartHealth", "Start Health", 0, 0, "Text", "100;50:999");
     PlayInfo.AddSetting("GunGame", "StartShield", "Start Shield", 0, 2, "Text", "50;0:150");
	 PlayInfo.AddSetting("GunGame", "MaxHealth", "Max Health", 0, 4, "Text", "100;50:999");
     PlayInfo.AddSetting("GunGame", "CureAward", "Cure Award", 0, 6, "Text", "25;0:100");
     PlayInfo.AddSetting("GunGame", "IterationAward", "Iteration Award", 0, 8, "Text", "1;0:100");
     PlayInfo.AddSetting("GunGame", "VictoryCondition", "Victory Condition", 0, 10, "Select", "0;Gunlevel;1;Goalscore;2;Lives");
     PlayInfo.AddSetting("GunGame", "AmmoHandling", "Ammo Handling", 0, 12, "Select", "0;Unlimited;1;Downgrading");
     PlayInfo.AddSetting("GunGame", "StdWeaponFeature", "Std. Weapon Feature", 0, 14, "Select", "0;DecreaseFactor;1;StealFactor;2;IncreaseFactor;3;Normal");
     PlayInfo.AddSetting("GunGame", "StdWeaponFactor", "Std. Weapon Factor", 0, 16, "Text", "2;1:10");
     PlayInfo.AddSetting("GunGame", "KillAmount", "Kill Amount", 0, 18, "Text", "1;1:10");
}

static event string GetDescriptionText(string PropName)
{
     switch(PropName)
     {
          case "StartHealth":		return "Health amount all players start with.";
          case "StartShield":		return "Shield amount all players start with.";
		  case "MaxHealth":			return "Maximum health amount all players have.";
          case "CureAward":			return "Get Health/Shield for kills. Heals max. up to 'Start Health' amount. Then it gives Shield max. up to 'Start Shield'.";
          case "IterationAward":	return "Depending on 'VictoryCondition' one gets this extra amount to his/her lives or score value when he/her ran through the WeaponList. It does not influence the GunLevel.";
          case "VictoryCondition":	return "Defines which option leads to victory.";
          case "AmmoHandling":		return "Unlimited - unlimited ammo. Downgrading - weapons have some ammo, but if out of ammo downgrade GunLevel";
          case "StdWeaponFeature":	return "This defines how to handle kills done with the 'standard-weapon'. 'DecreaseFactor' affects the victim, 'IncreaseFactor' affects the killer, 'StealFactor' takes from victim and adds to killer, 'Normal' makes std. weapon act as all others.";
          case "StdWeaponFactor":	return "The 'Victory Condition' value of killer/victim will be altered by this value.";
          case "KillAmount":		return "Defines how many kills are needed to get the next weapon.";
	}

     return Super.GetDescriptionText(PropName);
}

static function PrecacheGameTextures(LevelInfo myLevel)
{
     local int i;

     Super.PrecacheGameTextures(myLevel);

     //Precache Pickups
     for ( i=0; i<Default.WeaponList.Length; i++ )
     {
          if ( Default.WeaponList[i] != None )
               if ( Default.WeaponList[i].Default.PickupClass != None )
                    Default.WeaponList[i].Default.PickupClass.static.StaticPrecache(myLevel);  //Kinda tricky but it works if weapon has been scripted properly
     }
}

//Get rid of useless settings/activate desired settings
static event bool AcceptPlayInfoProperty(string PropertyName)
{
     if ( PropertyName ~= "MaxLives" )
          return true;
     else if ( PropertyName ~= "bWeaponStay" )
          return false;
     else if ( PropertyName ~= "bAllowWeaponThrowing" )
          return false;
     else if ( PropertyName ~= "LateEntryLives" )
          return true;

     return Super.AcceptPlayInfoProperty(PropertyName);
}

event InitGame(string options, out string error)
{
     local string InOpt;
     local Mutator M;
     local int i;
     local Class<Weapon> W;
     local array<string> WeaponClasses;

     Super.InitGame(Options, Error);

     InOpt = ParseOption(Options, "StartHealth");
     if(InOpt != "")
          StartHealth = byte(InOpt);

     InOpt = ParseOption(Options, "StartShield");
     if(InOpt != "")
          StartShield = byte(InOpt);
		  
	 InOpt = ParseOption(Options, "MaxHealth");
     if(InOpt != "")
          MaxHealth = byte(InOpt);

     InOpt = ParseOption(Options, "bAdrenalineOn");
     if(InOpt != "")
          bAdrenalineOn = bool(InOpt);

     InOpt = ParseOption(Options, "CureAward");
     if(InOpt != "")
          CureAward = byte(InOpt);

     InOpt = ParseOption(Options, "IterationAward");
     if(InOpt != "")
          IterationAward = byte(InOpt);

     InOpt = ParseOption(Options, "bNoAdrenaline");
     if(InOpt != "")
          bNoAdrenaline = bool(InOpt);

     InOpt = ParseOption(Options, "bNoHealth");
     if(InOpt != "")
          bNoHealth = bool(InOpt);

     InOpt = ParseOption(Options, "bNoShield");
     if(InOpt != "")
          bNoShield = bool(InOpt);

     InOpt = ParseOption(Options, "bNoDoubleDamage");
     if(InOpt != "")
          bNoDoubleDamage = bool(InOpt);

     InOpt = ParseOption(Options, "VictoryCondition");
     if(InOpt != "")
          VictoryCondition = byte(InOpt);

     InOpt = ParseOption(Options, "AmmoHandling");
     if(InOpt != "")
          AmmoHandling = byte(InOpt);

     InOpt = ParseOption(Options, "StdWeaponFeature");
     if(InOpt != "")
          StdWeaponFeature = byte(InOpt);

     InOpt = ParseOption(Options, "StdWeaponFactor");
     if(InOpt != "")
          StdWeaponFactor = byte(InOpt);

     InOpt = ParseOption(Options, "KillAmount");
     if(InOpt != "")
          KillAmount = byte(InOpt);

     WeaponList.Remove(0, WeaponList.Length);  //Remove old WeaponList (for singleplayer games)
     Registry.Remove(0, Registry.Length);      //Remove old Registry (for singleplayer games)

	for ( i=0; i < class'GunGameConfig'.default.WeaponList.Length; i++ )
	{
		WeaponList.Insert(WeaponList.Length, 1);
		WeaponList[i] = class'GunGameConfig'.default.WeaponList[i];
		default.WeaponList[i] = WeaponList[i];
	}

     HighestLevel = WeaponList.Length;

     //Check validity of user inputs
     if ( VictoryCondition != 2 && MaxLives > 0 )  //Force no Lives, as players would still have lives even if VC != 2
          MaxLives = 0;
     else if ( VictoryCondition == 2 && MaxLives == 0 )  //At least 3 lives then
          MaxLives = 3;

     if ( IterationAward > 0 && VictoryCondition == 0 )  //When GunLevel is VC there is no sense in keeping an IterationAward as whe you cannot iterate through WeaponList several times
          IterationAward = 0;

     if ( !bAdrenalineOn && !bNoAdrenaline ) //There's no sense to keep adrenaline pickups when adrenaline is turned off
          bNoAdrenaline = true;

     if ( bNoAdrenaline )
     {
          for(M = BaseMutator; M != None; M = M.NextMutator)
          {
               if( MutNoAdrenaline(M) != None ) //Check if "No Adrenaline" mutator is active
               {
                    bNoAdrenaline = false; //"No Adrenaline" Mutator takes over the task to remove the adrenaline pickups
                    break;
               }
          }
     }

     SaveConfig();

     //Set up BaseMutator
     if ( GunGameMut(BaseMutator) != None )
     {
          GunGameMut(BaseMutator).bNoAdrenaline = bNoAdrenaline;
          GunGameMut(BaseMutator).bNoHealth = bNoHealth;
          GunGameMut(BaseMutator).bNoShield = bNoShield;
          GunGameMut(BaseMutator).bNoDoubleDamage = bNoDoubleDamage;
     }
	 
	 if (InventoryMut != "")
    	AddMutator(InventoryMut);
		
	 if (HUDFixMut != "")
    	AddMutator(HUDFixMut);
}

function InitGameReplicationInfo()
{
     Super.InitGameReplicationInfo();

     if ( GunGame(Level.Game) != None )
     {
          GunGameGRI(GameReplicationInfo).VictoryCondition = VictoryCondition;
          GunGameGRI(GameReplicationInfo).HighestLevel = HighestLevel;
     }
}

function GetServerDetails( out ServerResponseLine ServerState )
{
     Super.GetServerDetails( ServerState );
     switch(VictoryCondition)
     {
          case 0:  AddServerDetail( ServerState, "GG-VictoryCondition", "GunLevel" );
                   break;
          case 1:  AddServerDetail( ServerState, "GG-VictoryCondition", "GoalScore" );
                   break;
          case 2:  AddServerDetail( ServerState, "GG-VictoryCondition", "Lives" );
     }
     AddServerDetail( ServerState, "GG-AmmoHandling", Eval(AmmoHandling == 0, "Unlimited", "Downgrading") );
     AddServerDetail( ServerState, "GG-KillAmount", KillAmount );
}


function PostBeginPlay()
{
     local NavigationPoint np;

     //Get all playerstarts
     for (np = Level.NavigationPointList; np != None; np = np.NextNavigationPoint)
     {
          if ( PlayerStart(np) != None ) //Store all PlayerStarts in a list
          {
               PlayerStarts.Insert(PlayerStarts.Length, 1);
               PlayerStarts[PlayerStarts.Length-1] = PlayerStart(np);
          }
     }

     Super.PostBeginPlay();
}

function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string incomingName)
{
     local NavigationPoint np, other;
     local byte Team;
     local Teleporter Tel;
     local float NewRating, BestRating;
     local int i;

     if ( Player != None )
     {
          if((Player.StartSpot != None))
               LastPlayerStartSpot = Player.StartSpot;

          // always pick StartSpot at start of match
          if ( (Player.StartSpot != None) && (Level.NetMode == NM_Standalone)
              && (bWaitingToStartMatch || ((Player.PlayerReplicationInfo != None) && Player.PlayerReplicationInfo.bWaitingPlayer))  )
          {
               return Player.StartSpot;
          }

          // use InTeam if player doesn't have a team yet
          if ( (Player.PlayerReplicationInfo != None) )
          {
               if ( Player.PlayerReplicationInfo.Team != None )
                    Team = Player.PlayerReplicationInfo.Team.TeamIndex;
               else
                    Team = InTeam;
          }
          else
               Team = InTeam;
     }

     if ( GameRulesModifiers != None )
     {
          np = GameRulesModifiers.FindPlayerStart(Player, Team, incomingName);
          if ( np != None )
               return np;
     }

     // if incoming start is specified, then just use it
     if( incomingName!="" )
          foreach AllActors( class 'Teleporter', Tel )
               if( string(Tel.Tag)~=incomingName )
                   return Tel;

     for( i=0; i<PlayerStarts.Length; i++ )
     {
          if ( PlayerStarts[i].bEnabled )
          {
               NewRating = RatePlayerStart(PlayerStarts[i], Team, Player);

               if ( NewRating > BestRating )
               {
                         BestRating = NewRating;
                         other = PlayerStarts[i];
               }
          }
     }

     if ( other == None )
     {
          log("Warning - PATHS NOT DEFINED or NO PLAYERSTART with positive rating");
               BestRating = -100000000;

          ForEach AllActors( class 'NavigationPoint', np )
          {
               NewRating = RatePlayerStart(np ,0, Player);
               if ( InventorySpot(np) != None )
                    NewRating -= 50;

               NewRating += 20 * FRand();
               if ( NewRating > BestRating )
               {
                    BestRating = NewRating;
                    other = np;
               }
          }
     }
     
     if ( other != None )
     {
          LastStartSpot = other;
     }

     return other;
}

function float RatePlayerStart(NavigationPoint N, byte Team, Controller Player)
{
     local float Score, NextDist;
     local Controller OtherPlayer;

     Score = 5000000.0;

     if ( (N == LastStartSpot) || (N == LastPlayerStartSpot) )
         Score -= 10000.0;

     //Randomize
     Score += FRand() * 5000.0;

     for ( OtherPlayer=Level.ControllerList; OtherPlayer!=None; OtherPlayer=OtherPlayer.NextController)
     {
          if ( OtherPlayer.bIsPlayer && (OtherPlayer.Pawn != None) )
          {
               NextDist = VSize(OtherPlayer.Pawn.Location - N.Location);

               if ( NextDist <= 60.0 )   //Avoid that player spawns inside another one
                    Score -= 1000000.0;
               else if ( NextDist <= 3000.0 )
               {
                    if ( FastTrace(N.Location, OtherPlayer.Pawn.Location) )
                         Score -= (5000.0 - NextDist);
                    else
                         Score -= (3000.0 - NextDist);
               }
          }
     }

     return FMax(Score, 5.0);
}

function bool AllowBecomeActivePlayer(PlayerController P)
{
     local Controller C;
     local bool bGameTooFar;

     if ( MaxLives > 0 && Level.NetMode != NM_Standalone )
     {
          for ( C=Level.ControllerList; C!=None; C=C.NextController )
          {
               if ( C.PlayerReplicationInfo != None && C.PlayerReplicationInfo.NumLives > LateEntryLives )
               {
                    bGameTooFar = true;
                    break;
               }
          }
     }

     if ( (P.PlayerReplicationInfo == None) || !GameReplicationInfo.bMatchHasBegun || (NumPlayers >= MaxPlayers) || P.IsInState('GameEnded') || P.IsInState('RoundEnded') || bGameTooFar )
     {
          P.ReceiveLocalizedMessage(GameMessageClass, 13);
          return false;
     }
     else
     {
          if ( (Level.NetMode == NM_Standalone) && (NumBots > InitialBots) )
          {
               RemainingBots--;
               bPlayerBecameActive = true;
          }

          return true;
     }
}

//I need a function that is called on Players and on Bots to add a GGRegistry for each of them, assign the GunGameGRI and add whether adrenaline shall be enabled or not
//Login() for Players, SpawnBot() for AI
event PlayerController Login
(
    string Portal,
    string Options,
    out string Error
)
{
     local PlayerController P;
     P = Super.Login(Portal, Options, Error);

     if ( P != None )
     {
		  P.PawnClass = class'BallisticProV55.BallisticPawn';
          P.bAdrenalineEnabled = bAdrenalineOn;

          if ( GunGamePRI(P.PlayerReplicationInfo) != None && GunGamePRI(P.PlayerReplicationInfo).RegistryID == -1 )
          {
               Registry.Insert(Registry.Length, 1);
               Registry[Registry.Length-1] = Spawn(class'GGRegistry', P);

               if ( Registry[Registry.Length-1] != None )
               {
                    GunGamePRI(P.PlayerReplicationInfo).RegistryID = Registry.Length-1;
                    Registry[Registry.Length-1].StandardWeapon = WeaponList[0];
               }
               else
                    Registry.Remove(Registry.Length-1, 1);
          }
     }

     return P;
}

function Bot SpawnBot(optional string botName)
{
     local Bot B;
     B = Super.SpawnBot(botName);

     if ( B != None && B.bIsPlayer )
     {
		  B.PawnClass = class'BallisticProV55.BallisticPawn';
		  B.bAdrenalineEnabled = bAdrenalineOn;

		  if ( GunGamePRI(B.PlayerReplicationInfo) != None && GunGamePRI(B.PlayerReplicationInfo).RegistryID == -1 )
		  {
				Registry.Insert(Registry.Length, 1);
				Registry[Registry.Length-1] = Spawn(class'GGRegistry', B);

				if ( Registry[Registry.Length-1] != None )
				{
					GunGamePRI(B.PlayerReplicationInfo).RegistryID = Registry.Length-1;
					Registry[Registry.Length-1].StandardWeapon = WeaponList[0];
				}
				else
					Registry.Remove(Registry.Length-1, 1);
		  }
     }

     return B;
}

//Removed some things from here
function RestartPlayer( Controller aPlayer )
{    
     local NavigationPoint startSpot;
     local int TeamNum;
     local class<Pawn> DefaultPlayerClass;

     if ( bMustJoinBeforeStart && (UnrealPlayer(aPlayer) != None) && UnrealPlayer(aPlayer).bLatecomer )
          return;

     if ( aPlayer.PlayerReplicationInfo.bOutOfLives )
          return;

     if ( Bot(aPlayer) != None && TooManyBots(aPlayer) )
     {
          aPlayer.Destroy();
          return;
     }

     if( bRestartLevel && Level.NetMode != NM_DedicatedServer && Level.NetMode != NM_ListenServer )
          return;

     if ( (aPlayer.PlayerReplicationInfo == None) || (aPlayer.PlayerReplicationInfo.Team == None) )
          TeamNum = 255;
     else
          TeamNum = aPlayer.PlayerReplicationInfo.Team.TeamIndex;

     startSpot = FindPlayerStart(aPlayer, TeamNum);
     if( startSpot == None )
     {
          log(" Player start not found!!!");
          return;
     }

     if (aPlayer.PreviousPawnClass!=None && aPlayer.PawnClass != aPlayer.PreviousPawnClass)
          BaseMutator.PlayerChangedClass(aPlayer);

     if ( aPlayer.PawnClass != None )
          aPlayer.Pawn = Spawn(aPlayer.PawnClass,,,StartSpot.Location,StartSpot.Rotation);

     if( aPlayer.Pawn == None )
     {
          DefaultPlayerClass = GetDefaultPlayerClass(aPlayer);
          aPlayer.Pawn = Spawn(DefaultPlayerClass,,,StartSpot.Location,StartSpot.Rotation);
     }
     if ( aPlayer.Pawn == None )
     {
          log("Couldn't spawn player of type "$aPlayer.PawnClass$" at "$StartSpot);
          aPlayer.GotoState('Dead');
          if ( PlayerController(aPlayer) != None )
               PlayerController(aPlayer).ClientGotoState('Dead','Begin');
          return;
     }
     if ( PlayerController(aPlayer) != None )
          PlayerController(aPlayer).TimeMargin = -0.1;

     aPlayer.Pawn.Anchor = startSpot;
     aPlayer.Pawn.LastStartSpot = PlayerStart(startSpot);
     aPlayer.Pawn.LastStartTime = Level.TimeSeconds;
     aPlayer.PreviousPawnClass = aPlayer.Pawn.Class;

     aPlayer.Possess(aPlayer.Pawn);
     aPlayer.PawnClass = aPlayer.Pawn.Class;

     aPlayer.Pawn.PlayTeleportEffect(true, true);
     aPlayer.ClientSetRotation(aPlayer.Pawn.Rotation);
     AddDefaultInventory(aPlayer.Pawn);
     TriggerEvent( StartSpot.Event, StartSpot, aPlayer.Pawn);

     if ( PlayerController(aPlayer) != None )  //Avoid that player start in behindview mode, a bug that happens sometimes
     {
          PlayerController(aPlayer).ClientSetBehindView(false);
     }
}

//Removed the code to spawn the default inventory, spawn GunGame inventory
function AddDefaultInventory( Pawn PlayerPawn )
{
     local Weapon W;

     if ( GunGamePRI(PlayerPawn.PlayerReplicationInfo) != None )
     {
          if ( WeaponList[0] != None )
               PlayerPawn.CreateInventory( string(WeaponList[0]) );

          PlayerPawn.CreateInventory( string(WeaponList[GunGamePRI(PlayerPawn.PlayerReplicationInfo).GunLevel]) );
          W = FindCorrespondingWeapon(PlayerPawn, GunGamePRI(PlayerPawn.PlayerReplicationInfo).GunLevel);

          if ( W != None )
          {
               Registry[GunGamePRI(PlayerPawn.PlayerReplicationInfo).RegistryID].NewWeaponClass = W.Class;  //Set new WeaponClass, so that Registry always has the correct value stored
               Registry[GunGamePRI(PlayerPawn.PlayerReplicationInfo).RegistryID].ClientSetWeapon(W.Class);
          }
     }

     SetPlayerDefaults(PlayerPawn);
}

//Assign user settings such as health and shield
function SetPlayerDefaults(Pawn PlayerPawn)
{
     Super.SetPlayerDefaults(PlayerPawn);

     if ( !PlayerPawn.Controller.bIsPlayer )
          return;

     PlayerPawn.Health = StartHealth;
	 PlayerPawn.HealthMax = MaxHealth;
	 PlayerPawn.SuperHealthMax = MaxHealth;
	 
     PlayerPawn.ShieldStrength = float(StartShield);
     PlayerPawn.NetUpdateTime = Level.TimeSeconds - 1;
}

function Weapon FindCorrespondingWeapon(Pawn P, byte GunLevel)
{
     local Inventory Inv;

     if ( P == None && WeaponList[GunLevel] != None )
          return None;

     for ( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory )
     {
          if ( Inv.Class == WeaponList[GunLevel] && Weapon(Inv) != None )
               return Weapon(Inv);
     }

     return None;
}

function int ReduceDamage( int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
     if ( instigatedBy != None && injured != None && injured != instigatedBy && class<WeaponDamageType>(DamageType) != None )
     {
          if ( instigatedBy.PlayerReplicationInfo != None )
               Registry[GunGamePRI(instigatedBy.PlayerReplicationInfo).RegistryID].EnemyHit( injured.Controller, class<WeaponDamageType>(DamageType) );
     }

     return Super.ReduceDamage( Damage, injured, instigatedBy, HitLocation, Momentum, DamageType );
}

//Used to give extra health/shield to Killer, seperated form Killed() to make code more clearly
function NotifyKilled(Controller Killer, Controller Other, Pawn OtherPawn)
{
     local int Overflow; //used to calculate the Overflow (Pawn.Health + CureAward = StartHealth + Overflow) that will be given as Shield

     if ( CureAward > 0 && Killer != None )
     {
          if ( Killer.Pawn != None )
          {
               if ( Killer.Pawn.Health > 0 )  //KillerPawn is not meant to be dead
               {
                    Overflow = Max( CureAward-(StartHealth-Killer.Pawn.Health), 0 );
                    Killer.Pawn.GiveHealth(CureAward, StartHealth);

                    if ( Overflow > 0 )
                         Killer.Pawn.AddShieldStrength( Min(StartShield, Killer.Pawn.ShieldStrength + Overflow) - Killer.Pawn.ShieldStrength );  //Give Shield up to StartShield
               }
          }
     }

     Super.NotifyKilled(Killer, Other, OtherPawn);
}

//Used for GunGame functions: Increasse/Decrease GunLevels, decide if kills are valid and initialize new weapons.
//Moved function definitions from 'GameInfo' and 'Deathmatch' to optimize them for GunGame usage.
//bEnemyKill flag and checks removed, as they make no sense in GunGame.
function Killed( Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType )
{
     local GunGamePRI KillerPRI, KilledPRI;
     local class<WeaponDamageType> WDT;
     local bool bNoUpgrade;
     local float Overflow;

    // handle spree of dead pawn
     if ( KilledPawn != None && KilledPawn.GetSpree() > 4 )
     {
          if ( (Killer != None) )
               Killer.AwardAdrenaline(ADR_MajorKill);
          EndSpree(Killer, Killed);
     }

     if ( Killed != None && Killed.bIsPlayer )
     {
          KilledPRI = GunGamePRI(Killed.PlayerReplicationInfo);

          if ( Killer != None && Killer.bIsPlayer )
          {
              // kill of player by player
               KillerPRI = GunGamePRI(Killer.PlayerReplicationInfo);

               if ( UnrealPlayer(Killer) != None )
                    UnrealPlayer(Killer).LogMultiKills(ADR_MajorKill, true);

               DamageType.static.ScoreKill(Killer, Killed);

               if ( !bFirstBlood && (Killer != Killed) )
               {
                    Killer.AwardAdrenaline(ADR_MajorKill);
                    bFirstBlood = True;
                    if ( TeamPlayerReplicationInfo(Killer.PlayerReplicationInfo) != None )
                         TeamPlayerReplicationInfo(Killer.PlayerReplicationInfo).bFirstBlood = true;
                    BroadcastLocalizedMessage( class'FirstBloodMessage', 0, Killer.PlayerReplicationInfo );
                    SpecialEvent(Killer.PlayerReplicationInfo,"first_blood");
               }

               if ( Killer == Killed )
                    Killer.AwardAdrenaline(ADR_MinorError);
               else
               {
                    Killer.AwardAdrenaline(ADR_Kill);
                    if ( Killer.Pawn != None )
                    {
                         Killer.Pawn.IncrementSpree();
                         if ( Killer.Pawn.GetSpree() > 4 )
                              NotifySpree(Killer, Killer.Pawn.GetSpree());
                    }
               }
          }          

          Killed.PlayerReplicationInfo.Deaths += 1;
          Killed.PlayerReplicationInfo.NetUpdateTime = FMin(Killed.PlayerReplicationInfo.NetUpdateTime, Level.TimeSeconds + 0.3 * FRand());
          BroadcastDeathMessage(Killer, Killed, damageType);

          if ( (Killer == Killed) || (Killer == None) )
          {
               bNoUpgrade = true;

               if ( Killer == None )
                    KillEvent("K", None, Killed.PlayerReplicationInfo, DamageType);	//"SelfKill by Environment"
               else
                    KillEvent("K", Killer.PlayerReplicationInfo, Killed.PlayerReplicationInfo, DamageType);	//"SelfKill by Weapon"
          }
          else
               KillEvent("K", Killer.PlayerReplicationInfo, Killed.PlayerReplicationInfo, DamageType);	//"Kill"
     }

     //Here are GunGame's mechanics implemented
     if ( KillerPRI != None )
          KillerPRI.bStdWeaponKill = false;  //Reset StdWeaponKill

     //If bNoUpgrade is true right here, then a self kill happened, downgrade and skip the rest of the GunGame code
     if ( bNoUpgrade )
     {
         // Check for bullshit
         // if dead Pawn's PRI records more suicides than the current gun level, they're probably doing stupid shit.
         // stop that
         if (KilledPRI.Suicides < KilledPRI.GunLevel)
            KilledPRI.AdjustLevel( -1 );
     }
     else
     {
          //Here I get the very last weapondamage actively done to Killed. So I know when Killed has been pushed out, which weapon caused that
          if ( class<WeaponDamageType>(damageType) != None )
               WDT = class<WeaponDamageType>(damageType);
          else if ( damageType.Default.bCausedByWorld )
               WDT = Registry[KillerPRI.RegistryID].LastWeaponsDamageDoneTo(Killed);

          if ( WDT != None )
          {
               //If Damagetype belongs to std weapon and std weapon is not the current weapon in list, go on with special feature, otherwise skip this code
               //Standard weapon kill scoring system
               if ( ClassIsChildOf(WeaponList[0], WDT.Default.WeaponClass) && WeaponList[KillerPRI.GunLevel] != WeaponList[0] )
               {
                    bNoUpgrade = true;                //Do not upgrade std weapon kills by default
                    KillerPRI.bStdWeaponKill = true;  //Activate MultiKill block later -> one feauture award per shot, avoid massive feauture gaining (when Redeemer is std. weapon), avoid normal scoring
					
					PlayerController(Killer).PlayRewardAnnouncement('Denied',1, true);

                    //The std. weapon's special feature will be processed here
                    switch (StdWeaponFeature)
                    {
                         case 0:  switch (VictoryCondition)  //Decrease victim
                                  {
                                       case 0:  KilledPRI.AdjustLevel( StdWeaponFactor * -1 );
                                                break;

                                       case 1:  if ( KilledPRI.Score <= 0.0 )  //Don't be that rude and decrease furthermore
                                                     break;

                                                KilledPRI.Score = FMax((KilledPRI.Score-StdWeaponFactor), 0.0);
                                                break;

                                       case 2:  KilledPRI.NumLives = Min((KilledPRI.NumLives+StdWeaponFactor), MaxLives);
                                  }
                                  break;

                         case 1:  switch (VictoryCondition)  //One cannot steal points a victim does not have
                                  {
                                       case 0:  if ( (KilledPRI.GunLevel - StdWeaponFactor) >= 1 )
                                                {
                                                     Overflow = StdWeaponFactor;
                                                     KilledPRI.AdjustLevel( StdWeaponFactor * -1 );
                                                }
                                                else
                                                {
                                                     Overflow = KilledPRI.GunLevel - 1;  //Save the Overflow and add it to Killer's GunLevel later
                                                     KilledPRI.AdjustLevel( StdWeaponFactor * -1 );
                                                }

                                                KillerPRI.DelayedAdjustLevel( Overflow );  //Delayed level up to handle massive upgrades at the same time (Redeemer)
												if (PlayerController(Killer) != None)
													PlayerController(Killer).ClientPlaySound(default.LvlUpSound,True,3,SLOT_Talk);
													
                                                break;

                                       case 1:  if ( KilledPRI.Score <= 0.0 )  //When victim has nothing then killer doesn't get anything too!
                                                          break;

                                                if ( (KilledPRI.Score - StdWeaponFactor) >= 0.0 )
                                                {
                                                     Overflow = StdWeaponFactor;
                                                     KilledPRI.Score -= StdWeaponFactor;
                                                }
                                                else
                                                {
                                                     Overflow = KilledPRI.Score;
                                                     KilledPRI.Score = 0.0;
                                                }

                                                KillerPRI.Score += Overflow;
                                                break;

                                       case 2:  if ( (KilledPRI.NumLives + StdWeaponFactor) <= MaxLives )
                                                {
                                                     Overflow = StdWeaponFactor;
                                                     KilledPRI.NumLives += StdWeaponFactor;
                                                }
                                                else
                                                {
                                                     Overflow = MaxLives - KilledPRI.NumLives;
                                                     KilledPRI.NumLives = MaxLives;
                                                }

                                                if ( KillerPRI.NumLives != 0 )  //Skip when killer has full amount of lives
                                                     KillerPRI.NumLives = Max((KillerPRI.NumLives-Overflow), 0); //You don't get more than MaxLives
                                  }
                                  break;

                         case 2:  switch (VictoryCondition)  //Increase killer
                                  {
                                       case 0:  KillerPRI.DelayedAdjustLevel( StdWeaponFactor );  //Delayed level up to handle massive upgrades at the same time (Redeemer)
												if (PlayerController(Killer) != None)
													PlayerController(Killer).ClientPlaySound(default.LvlUpSound,True,3,SLOT_Talk);
													
                                                break;

                                       case 1:  KillerPRI.Score += StdWeaponFactor;
                                                break;

                                       case 2:  KillerPRI.NumLives = Max((KillerPRI.NumLives-StdWeaponFactor), 0); //You don't get more than MaxLives
                                  }
                                  break;

                         case 3:  bNoUpgrade = false;  //Normal weapon
                                  KillerPRI.bStdWeaponKill = false;
                    }

                    //Force update
                    KillerPRI.NetUpdateTime = Level.TimeSeconds - 1;
                    KilledPRI.NetUpdateTime = Level.TimeSeconds - 1;
               }
               else  //Normal weapon kills
               {
                    if ( !ClassIsChildOf(WeaponList[KillerPRI.GunLevel], WDT.Default.WeaponClass) )  //Check if killer's current weapon matches with the weapon caused the damage
                         bNoUpgrade = true;

                    if ( !bNoUpgrade )  //Kill with a valid weapon, but has it rly been done by the actual weapon? Determine this by considering the time (hit/kill and weapon switch)
                    {
                         if ( !Registry[KillerPRI.RegistryID].CheckKillValidity( Killed ) )
                              bNoUpgrade = true;
                    }
               }
          }
          else  //E.g. Killer crushed Victim by jumping onto him/her or telefragging
               bNoUpgrade = true;

          if ( !bNoUpgrade && !Registry[KillerPRI.RegistryID].bBlockMultiKills )  //Skip the rest of the code for one second when this player has already levelled.
          {
               //Now we know that it was a valid kill. Check if player is able to be updated
               if ( KillerPRI.ValidKill() )  //Whether player is able to level up
               {
					//If the player has killed with a guided akeron rocket, make use of DelayedAdjustLevel
					if (AkeronWarhead(Killer.Pawn) != None)
						KillerPRI.DelayedAdjustLevel( 1 );
					else
						KillerPRI.AdjustLevel( 1 );
					
					if (PlayerController(Killer) != None)
						PlayerController(Killer).ClientPlaySound(default.LvlUpSound,True,3,SLOT_Talk);
					
					//Eject player from any turret and destroy the turret - applies to weapons that deploy
					if (Vehicle(Killer.Pawn) != None)
					{
						if (BallisticTurret(Killer.Pawn) != None)
							BallisticTurret(Killer.Pawn).UndeployTurret();
						else
							Vehicle(Killer.Pawn).EjectDriver();
					}
					
					if ( VictoryCondition != 0 && KillerPRI.GunLevel == HighestLevel )  //Set up WeaponList rotation, if VC == 1 or 2 --> GoalScore/lives decides on who wins
					{
						if ( IterationAward > 0 )
						{
							if ( VictoryCondition == 1 )
								KillerPRI.Score += IterationAward;
							else if ( VictoryCondition == 2 )
								KillerPRI.NumLives = Max((KillerPRI.NumLives - IterationAward), 0); //MaxLives = limit, one won't get further lives
						}
						KillerPRI.AdjustLevel( -HighestLevel );
					}
					
					if ( KillerPRI.GunLevel < HighestLevel && !KillerPRI.bInDelayedProcess )
						SetEquipment(KillerPRI, Killer.Pawn);
				}
          }
     }
     //End

     if ( Killed != None )
          ScoreKill(Killer, Killed);

     DiscardInventory(KilledPawn);
     NotifyKilled(Killer,Killed,KilledPawn);
}

//Give Killer a new weapons and initialize deletion of old weapon
function SetEquipment(GunGamePRI KillerPRI, Pawn KillerPawn)
{
     local Weapon W;
	 local Inventory Inv;

     if ( HighestLevel < 3 || KillerPawn == None )
          return;

     //The block prevents possible multikill jumps with one shot (Redeemer). Just a safety measure as the code in Killed() should prevent this too, but this makes it more reliable.
     Registry[KillerPRI.RegistryID].SetTimer(1.0, false);
     Registry[KillerPRI.RegistryID].bBlockMultiKills = true;
     Registry[KillerPRI.RegistryID].bBlocked = true;  //Block Timer for level up time to avoid redundant and unexpected behaviour

     if ( WeaponList[KillerPRI.GunLevel] != WeaponList[0] )
     {
          if ( WeaponList[KillerPRI.OldGunLevel] != WeaponList[KillerPRI.GunLevel] )  //Next weapon is a weapon this player does not already have, so add new weapon
          {
               KillerPawn.CreateInventory( string(WeaponList[KillerPRI.GunLevel]) );
          }
          else  //Player does already have this weapon, so neither add it again nor delete it
          {
               W = FindCorrespondingWeapon(KillerPawn, KillerPRI.GunLevel);

               if ( W != None )
               {
                    if ( AmmoHandling == 1 )
                         W.FillToInitialAmmo();

                    Registry[KillerPRI.RegistryID].ClientSetWeapon(W.Class);
               }

               return;
          }
     }

     W = FindCorrespondingWeapon(KillerPawn, KillerPRI.OldGunLevel);

     if ( W != None )  //Initialize removal of old weapon
          Registry[KillerPRI.RegistryID].DisposeOfWeapon(W, WeaponList[KillerPRI.GunLevel]);
		  
     //Purge the sandbags
     for ( Inv=KillerPawn.Inventory; Inv!=None; Inv=Inv.Inventory )
     {
          if ( Inv.Class == class'SandbagLayer' && Weapon(Inv) != None )
               Registry[KillerPRI.RegistryID].DisposeOfWeapon(Weapon(Inv), WeaponList[KillerPRI.GunLevel]);
     }
}

//Accessed nones appeared here, so I had to role back the original code to fix that....
function ScoreKill(Controller Killer, Controller Other)
{
     local GunGamePRI OtherPRI;
     local GunGamePRI KillerPRI;

     OtherPRI = GunGamePRI(Other.PlayerReplicationInfo);
     KillerPRI = GunGamePRI(Killer.PlayerReplicationInfo);

     if ( OtherPRI != None )
     {
          if ( !KillerPRI.bStdWeaponKill )  //Std weapon kills does not influence the normal scoring system, they use its own by default -> check Killed() for details
               OtherPRI.NumLives++;

          if ( (MaxLives > 0) && (OtherPRI.NumLives >=MaxLives) )
               OtherPRI.bOutOfLives = true;
     }

     if ( bAllowTaunts && (Killer != None) && (Killer != Other) && Killer.AutoTaunt() && (Killer.PlayerReplicationInfo != None) && (Killer.PlayerReplicationInfo.VoiceType != None) )
     {
          if( Killer.IsA('PlayerController') )
               Killer.SendMessage(OtherPRI, 'AUTOTAUNT', Killer.PlayerReplicationInfo.VoiceType.static.PickRandomTauntFor(Killer, false, false), 10, 'GLOBAL');
          else
               Killer.SendMessage(OtherPRI, 'AUTOTAUNT', Killer.PlayerReplicationInfo.VoiceType.static.PickRandomTauntFor(Killer, false, true), 10, 'GLOBAL');
     }
     //GameInfo
     if( (Killer == Other) || (Killer == None) )
     {
          if ( (Other!=None) && (Other.PlayerReplicationInfo != None) )
          {
               Other.PlayerReplicationInfo.Score -= 1;
               Other.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
               ScoreEvent(Other.PlayerReplicationInfo,-1,"self_frag");
          }
     }
     else if ( Killer.PlayerReplicationInfo != None )
     {
          if ( !KillerPRI.bStdWeaponKill )  //Do not increase score for std weapon kills
          {
               Killer.PlayerReplicationInfo.Score += 1;
               Killer.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
          }

          Killer.PlayerReplicationInfo.Kills++;
          ScoreEvent(Killer.PlayerReplicationInfo,1,"frag");
     }

     if ( GameRulesModifiers != None )
          GameRulesModifiers.ScoreKill(Killer, Other);

     if ( Killer != None )
          CheckScore(Killer.PlayerReplicationInfo);
     else if ( MaxLives > 0 )
          CheckScore(None);
     //End GameInfo

     if ( (killer == None) || (Other == None) )
          return;

     if ( bAdjustSkill && (PlayerController(Killer) != None || PlayerController(Other) != None) )
     {
          if ( AIController(Killer) != None )
               AdjustSkill(AIController(Killer), PlayerController(Other),true);
          if ( AIController(Other) != None )
               AdjustSkill(AIController(Other), PlayerController(Killer),false);
     }
}

function CheckScore(PlayerReplicationInfo Scorer)
{
     local Controller C;

     if ( (GameRulesModifiers != None) && GameRulesModifiers.CheckScore(Scorer) )
          return;

     //Scorer can be None here, e.g. world kills cause that, but this also reduces victim's lives, so check that if VC==2 but skip when other cases are met
     switch(VictoryCondition)
     {
         case 0:  if ( Scorer != None )
                  {
                       if ( GunGamePRI(Scorer).GunLevel >= HighestLevel )  //GunLevel
                            EndGame(Scorer,"GunLevel");

                       else if ( bOverTime )
                       {
                            //If this Player has highest GunLevel than he wins
                            for ( C=Level.ControllerList; C!=None; C=C.NextController )
                            {
                                 if ( C != None )
                                 {
                                      if ( GunGamePRI(C.PlayerReplicationInfo) != None && C.bIsPlayer )
                                           if ( GunGamePRI(Scorer).GunLevel < GunGamePRI(C.PlayerReplicationInfo).GunLevel )
                                                return;
                                 }
                            }

                            EndGame(Scorer,"GunLevel");
                       }
                  }
                  break;

         case 1:  if ( Scorer != None )
                  {
                       if ( Scorer.Score >= GoalScore )  //GoalScore
                            EndGame(Scorer,"FragLimit");
                       else if ( bOverTime )
                       {
                            //If this Player has highest Score than he wins
                            for ( C=Level.ControllerList; C!=None; C=C.NextController )
                            {
                                 if ( C.PlayerReplicationInfo != None )
                                      if ( Scorer.Score < C.PlayerReplicationInfo.Score )
                                           return;
                            }

                            EndGame(Scorer,"FragLimit");
                       }
                  }
                  break;

         case 2:  CheckMaxLives(Scorer);  //Lives
     }
}

function bool CheckMaxLives(PlayerReplicationInfo Scorer)
{
     local Controller C;
     local PlayerReplicationInfo Living;
     local bool bNoneLeft;

     if ( MaxLives > 0 && VictoryCondition == 2 )
     {
          if ( (Scorer != None) && !Scorer.bOutOfLives )
               Living = Scorer;

          bNoneLeft = true;
          for ( C=Level.ControllerList; C!=None; C=C.NextController )
          {
               if ( (C.PlayerReplicationInfo != None) && C.bIsPlayer && !C.PlayerReplicationInfo.bOutOfLives && !C.PlayerReplicationInfo.bOnlySpectator )
               {
                    if ( Living == None )
                         Living = C.PlayerReplicationInfo;
                    else if ( C.PlayerReplicationInfo != Living )
                    {
                         bNoneLeft = false;
                         break;
                    }
               }
          }
          if ( bNoneLeft )
          {
               if ( Living != None )
                    EndGame(Living,"LastMan");
               else
                    EndGame(Scorer,"LastMan");

               return true;
          }
     }
     return false;
}

//"GunLevel" reason added
function EndGame(PlayerReplicationInfo Winner, string Reason )
{
     if ( (Reason ~= "triggered") ||
          (Reason ~= "LastMan")   ||
          (Reason ~= "TimeLimit") ||
          (Reason ~= "FragLimit") ||
          (Reason ~= "TeamScoreLimit") ||
          (Reason ~= "GunLevel") )
     {
          Super(GameInfo).EndGame(Winner,Reason);
          if ( bGameEnded )
               GotoState('MatchOver');
     }
}

//Adjust Overtime and some other small changes
function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason)
{
     local Controller P, NextController;
     local PlayerController Player;
     local bool bLastMan;

     if ( bOverTime )
     {
          if ( Numbots + NumPlayers == 0 )
               return true;

          bLastMan = true;
          for ( P=Level.ControllerList; P!=None; P=P.nextController )
          {
               if ( P.PlayerReplicationInfo != None && !P.PlayerReplicationInfo.bOutOfLives )
               {
                    bLastMan = false;
                    break;
               }
          }

          if ( bLastMan )
               return true;
     }

     bLastMan = ( Reason ~= "LastMan" );

     if ( !bLastMan && (GameRulesModifiers != None) && !GameRulesModifiers.CheckEndGame(Winner, Reason) )
          return false;

     if ( Winner == None )
     {
          for ( P=Level.ControllerList; P!=None; P=P.nextController )
          {
               if ( P.bIsPlayer && P.PlayerReplicationInfo != None && !P.PlayerReplicationInfo.bOutOfLives )
               {
                    if ( VictoryCondition == 0 )  //GunLevel
                    {
                         if ( (Winner == None) || (GunGamePRI(P.PlayerReplicationInfo).GunLevel > GunGamePRI(Winner).GunLevel) )
                              Winner = P.PlayerReplicationInfo;
                    }
                    else if ( VictoryCondition == 1 ) //GoalScore
                    {
                         if ( (Winner == None) || (P.PlayerReplicationInfo.Score > Winner.Score) )
                              Winner = P.PlayerReplicationInfo;
                    }
                    else  //Lives
                    {
                         if ( (Winner == None) || (P.PlayerReplicationInfo.NumLives < Winner.NumLives) )
                             Winner = P.PlayerReplicationInfo;
                    }
               }
          }
     }

     //Check for Overtime
     if ( !bLastMan )
     {
          for ( P=Level.ControllerList; P!=None; P=P.nextController )
          {
               if ( VictoryCondition == 0 )  //GunLevel overtime
               {
                    if ( P.bIsPlayer && (P.PlayerReplicationInfo != None) && (Winner != P.PlayerReplicationInfo) && !P.PlayerReplicationInfo.bOutOfLives && (GunGamePRI(P.PlayerReplicationInfo).GunLevel == GunGamePRI(Winner).GunLevel) )
                    {
                         if ( !bOverTimeBroadcast )
                         {
                              StartupStage = 7;
                              PlayStartupMessage();
                              bOverTimeBroadcast = true;
                         }
                         return false;
                    }
               }
               else if ( VictoryCondition == 1 )  //GoalScore overtime
               {
                    if ( P.bIsPlayer && (P.PlayerReplicationInfo != None) && (Winner != P.PlayerReplicationInfo) && !P.PlayerReplicationInfo.bOutOfLives && (P.PlayerReplicationInfo.Score == Winner.Score) )
                    {
                         if ( !bOverTimeBroadcast )
                         {
                              StartupStage = 7;
                              PlayStartupMessage();
                              bOverTimeBroadcast = true;
                         }
                         return false;
                    }
               }
          }
     }

     EndTime = Level.TimeSeconds + EndTimeDelay;
     GameReplicationInfo.Winner = Winner;
     if ( CurrentGameProfile != None )
          CurrentGameProfile.bWonMatch = (PlayerController(Winner.Owner) != None);

     EndGameFocus = Controller(Winner.Owner).Pawn;
     if ( EndGameFocus != None )
          EndGameFocus.bAlwaysRelevant = true;

     for ( P=Level.ControllerList; P!=None; P=NextController )
     {
          Player = PlayerController(P);
          if ( Player != None )
          {
               if ( !Player.PlayerReplicationInfo.bOnlySpectator )
                    PlayWinMessage(Player, (Player.PlayerReplicationInfo == Winner));
               Player.ClientSetBehindView(true);
               if ( EndGameFocus != None )
               {
                    Player.ClientSetViewTarget(EndGameFocus);
                    Player.SetViewTarget(EndGameFocus);
               }
               Player.ClientGameEnded();
          }
          NextController = P.NextController;
          P.GameHasEnded();
     }

     return true;
}

function Logout( Controller Exiting )
{
     local byte i;

     for ( i=0; i<Registry.Length; i++ )
     {
          if ( Registry[i] != None )
               Registry[i].NotifyLogout(Exiting);
     }

     Super.Logout(Exiting);
     CheckMaxLives(None);
}

//Support for Simple Death Messages detecting whether a kill was from sights or not
function BroadcastDeathMessage(Controller Killer, Controller Other, class<DamageType> damageType)
{
    if ( (Killer == Other) || (Killer == None) )
        BroadcastLocalized(self,DeathMessageClass, 1, None, Other.PlayerReplicationInfo, damageType);
	else if (Killer.Pawn != None && BallisticWeapon(Killer.Pawn.Weapon) != None && BallisticWeapon(Killer.Pawn.Weapon).bHasPenetrated)
		BroadcastLocalized(self,DeathMessageClass, 3, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);	
    else if (Killer.Pawn != None && BallisticWeapon(Killer.Pawn.Weapon) != None && BallisticWeapon(Killer.Pawn.Weapon).bScopeView)
		BroadcastLocalized(self,DeathMessageClass, 2, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);
    else BroadcastLocalized(self,DeathMessageClass, 0, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);
}

defaultproperties
{
	 LvlUpSound=Sound'GameSounds.Fanfares.UT2K3Fanfare08'
	 InventoryMut="BallisticProV55.Mut_BallisticDM"
	 HUDFixMut="HUDFix.MutHUDFix"
     StartHealth=100
     StartShield=100
	 MaxHealth=199
     bAdrenalineOn=True
     CureAward=25
     IterationAward=1
     bNoAdrenaline=False
     bNoHealth=False
     bNoShield=False
     StdWeaponFactor=1
     KillAmount=1

     LoginMenuClass="GunGameBW.UT2K4GunGameLoginMenu"
     bWeaponStay=False
     bAllowWeaponThrowing=False
     DefaultPlayerClassName="BallisticProV55.BallisticPawn"
     ScoreBoardType="GunGameBW.GGScoreboard"
     HUDType="GunGameBW.GGHUD"
     DeathMessageClass=Class'BallisticProV55.Ballistic_DeathMessage'
     MutatorClass="GunGameBW.GunGameMut"
     PlayerControllerClassName="BallisticProV55.BallisticPlayer"
     GameReplicationInfoClass=Class'GunGameBW.GunGameGRI'
     GameName="Ballistic GunGame"
     Description="Level up and achieve new Ballistic weapons by killing opponents."
     Acronym="GG"
}
