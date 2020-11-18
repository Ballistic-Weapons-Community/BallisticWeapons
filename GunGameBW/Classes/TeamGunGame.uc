//////////////////////////////////////////
// TeamGunGame GameType - (c) by Mutant //
// Version 1.0 Final                    //
//////////////////////////////////////////
class TeamGunGame extends xTeamGame
	config(GunGameBW);

//Settings-related
var config int StartHealth;
var config int StartShield;
var config int MaxHealth;
var bool bAdrenalineOn;         //Disables adrenaline -> no combos
var config byte CureAward;             //Health for kills, heals player max. up to 'StartHealth'. Then Shield, max. up to 'StartShield'
var config byte IterationAward;        //Award amount for cycling through WeaponList (only valid for GoalScore/Lives mode)
var bool bNoAdrenaline;        		   //Remove Adrenaline-Pickups
var bool bNoHealth;            		   //Remove Health-Pickups
var bool bNoShield;            		   //Remove Shield-Pickups
var bool bNoDoubleDamage;     		   //Remove DoubleDamage-Pickups
var config byte VictoryCondition;      //0 = Reaching highest GunLevel ends the match; 1 = Reaching GoalScore ends the match; 2 = Last Man wins the match
var config byte AmmoHandling;          //Rule how to handle the ammo issue: 0 = unlimited ammo, 1 = limited ammo, so if out of ammo --> downgrade GunLevel
var config byte StdWeaponFeature;      //Defines how to handle standard weapon kills
var config byte StdWeaponFactor;       //Defines the value of the effect a standard weapon kill will cause
var config byte KillAmount;            //Defines how many kills are needed to level up
var config bool bUseCustomWeapons;     //Set to true if you want a customized WeaponList
var config string CustomWeapons;       //Customized weapon set

//Game-related
var config array< class<Weapon> > DefaultWeapons;         //Default weapon set

var array< class<Weapon> > WeaponList; //Load DefaultWeapons or Custom weapons in here, this is the actual weapon set GunGame works with
var array<GGRegistry> Registry;        //Registry class, used to handle ammonition issues, and some other GG specific things (similar to a Controller class)
var int HighestLevel;                 //Highest GunLevel
var array<PlayerStart> PlayerStarts;   //Includes all playerstarts, used to find out the two PlayerStarts with the greatest distance in between

var globalconfig string	InventoryMut, HUDFixMut;

var GunGamePRI timerKillerPRI;	//moving variables to Timer to execute weapon switching on a delay
var Controller timerKiller;

var Sound LvlUpSound;	//sounds to play upon killing & reaching the final weapon

//TeamGunGame-related
var config byte Mode;                        //Define how the game works: 0->Teams spawn nearby, everyone has one life each round; 1->Like TeamDeathmatch
var array<NavigationPoint> ValidRedStarts;   //Valid other startpoints besides the SpawnBases.
var array<NavigationPoint> ValidBlueStarts;  //The same for the vlue team
var array<NavigationPoint> SwapBases;        //Used to swap the spawn bases (Check SetUpNewRound())
var array<Rotator> BestRotations;            //Define new rotations (first red starts then blue's) for NavPoints (except PlayerStarts) so you won't start somewhere facing a wall.
var bool bNewRound;                          //Introduce new round
var byte Counter;                            //Used to wait some seconds until RestartPlayer() for Turn-Based mode


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
     PlayInfo.AddSetting("TeamGunGame", "Mode", "Mode", 0, 20, "Select", "0;Turn-Based;1;Tournament");
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
          case "Mode":			return "Turn-Based: All Teammates start nearby each other, everyone has one life per round. Eradicating the enemy's team initiates a new round. Tournament: Everyone can start at every playerstart, you restart when you died.";
     }

     return Super.GetDescriptionText(PropName);
}

static function PrecacheGameTextures(LevelInfo myLevel)
{
     local byte i;

     Super.PrecacheGameTextures(myLevel);

     //Precache Pickups
     for ( i=0; i<Default.WeaponList.Length; i++ )
     {
          if ( Default.WeaponList[i] != None )
               if ( Default.WeaponList[i].Default.PickupClass != None )
                    Default.WeaponList[i].Default.PickupClass.static.StaticPrecache(myLevel);  //Kinda tricky but it works if weapon has been scripted properly
     }
}

static function PrecacheGameAnnouncements(AnnouncerVoice V, bool bRewardSounds)
{
     Super.PrecacheGameAnnouncements(V,bRewardSounds);
     if ( !bRewardSounds )
     {
          V.PrecacheSound('NewRoundIn');
          V.PrecacheSound('Red_team_round');
          V.PrecacheSound('Blue_team_round');
     }
}

//Get rid of useless settings/activate wished settings
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

     InOpt = ParseOption(Options, "bUseCustomWeapons");
     if(InOpt != "")
          bUseCustomWeapons = bool(InOpt);

     InOpt = ParseOption(Options, "CustomWeapons");
     if(InOpt != "")
          CustomWeapons = InOpt;

     InOpt = ParseOption(Options, "Mode");
     if(InOpt != "")
          Mode = byte(InOpt);

     WeaponList.Remove(0, WeaponList.Length);  //Remove old WeaponList (for singleplayer games)
     Registry.Remove(0, Registry.Length);      //Remove old Registry (for singleplayer games)
     BestRotations.Remove(0, BestRotations.Length);

     //Assign customized WeaponList
     if ( bUseCustomWeapons && CustomWeapons != "" )
     {
          Split(CustomWeapons, ";", WeaponClasses);

          for ( i=0; i<WeaponClasses.Length; i++ )
          {
               W = Class<Weapon>(DynamicLoadObject(WeaponClasses[i], Class'Class', true));

               if ( W != None ) //Check that user weapon actually exists
               {
                    WeaponList.Insert(WeaponList.Length, 1);
                    WeaponList[WeaponList.Length-1] = W;
                    Default.WeaponList[WeaponList.Length-1] = WeaponList[WeaponList.Length-1];
               }
               else if ( i == 0 )  //No standard weapon wished, if zeroth element does not exist or is invalid
               {
                    WeaponList.Insert(0, 1);
                    WeaponList[0] = None;
                    Default.WeaponList[0] = None;
               }
               else
                    log("TeamGunGameBW: Error - Cannot load weapon:"@WeaponClasses[i]);
          }
     }

     //Check if WeaponList is valid, if not assign basic weapon
     if ( WeaponList.Length == 0 || (WeaponList[0] == None && WeaponList.Length == 1) )
     {
          if ( bUseCustomWeapons )
          {
               bUseCustomWeapons = false;
               log("GunGameBW: Error - invalid customized weapon set, use default set.");
          }

          for ( i=0; i<DefaultWeapons.Length; i++ )
          {
               WeaponList.Insert(WeaponList.Length, 1);
               WeaponList[i] = DefaultWeapons[i];
               Default.WeaponList[i] = WeaponList[i];
          }
     }

     HighestLevel = WeaponList.Length;

     //Check validity of user inputs
     if ( VictoryCondition != 2 && MaxLives > 0 && Mode != 0 )
          MaxLives = 0;
     else if ( VictoryCondition == 2 && MaxLives == 0 )
          MaxLives = 3;
     else if ( Mode == 0 && MaxLives != 1 && VictoryCondition != 2 )
          MaxLives = 1;

     if ( IterationAward > 0 && VictoryCondition == 0 )  //When GunLevel is VC there is no sense in keeping an IterationAward as whe you cannot iterate through WeaponList several times
          IterationAward = 0;

     //As Mode 0 uses one life make sure that LateEntryLives is not grater than zero to avoid later comers join the match
     if ( Mode == 0 && VictoryCondition != 2 && LateEntryLives > 0 )
          LateEntryLives = 0;

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

     if ( TeamGunGame(Level.Game) != None )
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
          case 0:  AddServerDetail( ServerState, "TGG-VictoryCondition", "GunLevel" );
                   break;
          case 1:  AddServerDetail( ServerState, "TGG-VictoryCondition", "GoalScore" );
                   break;
          case 2:  AddServerDetail( ServerState, "TGG-VictoryCondition", "Lives" );
     }
     AddServerDetail( ServerState, "TGG-AmmoHandling", Eval(AmmoHandling == 0, "Unlimited", "Downgrading") );
     AddServerDetail( ServerState, "TGG-Mode", Eval(Mode == 0, "Turn-Based", "Tournament") );
     AddServerDetail( ServerState, "TGG-CustomWeapons", bUseCustomWeapons );
     AddServerDetail( ServerState, "TGG-KillAmount", KillAmount );
}

function PostBeginPlay()
{
     local NavigationPoint np;
     local float dist, maxDist;
     local int i, j;

     //Get all playerstarts
     for (np = Level.NavigationPointList; np != None; np = np.NextNavigationPoint)
     {
          if ( PlayerStart(np) != None ) //Store all PlayerStarts in a list
          {
               PlayerStarts.Insert(PlayerStarts.Length, 1);
               PlayerStarts[PlayerStarts.Length-1] = PlayerStart(np);
          }
     }

     if ( Mode == 0 )  //Initialize spawn bases and relating spawn points
     {
          ValidRedStarts.Insert(0, 1);
          ValidBlueStarts.Insert(0, 1);

          //Connect all playerstarts with one another and find out the two playerstart with the greatest distance in between
          for ( i=0; i<PlayerStarts.Length; i++ )
          {
               for ( j=0; j<PlayerStarts.Length; j++ )
               {
                    if ( i != j )
                    {
                        dist = VSize( PlayerStarts[i].Location - PlayerStarts[j].Location );

                         if ( dist > maxDist )
                         {
                              maxDist = dist;

                              if ( FRand() > 0.5 ) //Assign spawn bases randomly
                              {
                                   ValidRedStarts[0] = PlayerStarts[i];
                                   ValidBlueStarts[0] = PlayerStarts[j];
                              }
                              else
                              {
                                   ValidRedStarts[0] = PlayerStarts[j];
                                   ValidBlueStarts[0] = PlayerStarts[i];
                              }
                         }
                    }
               }
          }

          SetBestRotationFor(ValidRedStarts[0]);

          //Now lets find other useful playerstarts around these bases
          foreach RadiusActors( class'NavigationPoint', np, maxDist/4, ValidRedStarts[0].Location ) //Assign further startpoints for red
          {
               //Use Navs which are connected with more than one other Nav, Playerstarts and valid PathNodes
               if ( ((PathNode(np) != None && FlyingPathNode(np) == None) || PlayerStart(np) != None) && np != ValidRedStarts[0] && np.PathList.Length > 1 )
               {
                    ValidRedStarts.Insert(ValidRedStarts.Length, 1);
                    ValidRedStarts[ValidRedStarts.Length-1] = np;
                    SetBestRotationFor(np);
               }
          }

          SetBestRotationFor(ValidBlueStarts[0]);

          foreach RadiusActors( class'NavigationPoint', np, maxDist/4, ValidBlueStarts[0].Location ) //Assign further startpoints for blue
          {
               if ( ((PathNode(np) != None && FlyingPathNode(np) == None) || PlayerStart(np) != None) && np != ValidBlueStarts[0] && np.PathList.Length > 1 )
               {
                    ValidBlueStarts.Insert(ValidBlueStarts.Length, 1);
                    ValidBlueStarts[ValidBlueStarts.Length-1] = np;
                    SetBestRotationFor(np);
               }
          }
     }

     Super.PostBeginPlay();
}

function SetBestRotationFor(NavigationPoint np)
{
        local vector HitNormal, HitLocation, EndTrace;
        local float dist, bestDist;
        local rotator bestRot;
        local byte i;

        BestRotations.Insert(BestRotations.Length, 1);

        if ( PlayerStart(np) != None )
        {
             BestRotations[BestRotations.Length-1] = np.Rotation;
             return;
        }
        
        for ( i=0; i<8; i++ )
        {
             switch(i)
             {
                  case 0:  EndTrace = np.Location + vect(10000,0,0);
                           break;
                  case 1:  EndTrace = np.Location + vect(7100,7100,0);
                           break;
                  case 2:  EndTrace = np.Location + vect(0,10000,0);
                           break;
                  case 3:  EndTrace = np.Location + vect(-7100,7100,0);
                           break;
                  case 4:  EndTrace = np.Location + vect(-10000,0,0);
                           break;
                  case 5:  EndTrace = np.Location + vect(-7100,-7100,0);
                           break;
                  case 6:  EndTrace = np.Location + vect(0,-10000,0);
                           break;
                  case 7:  EndTrace = np.Location + vect(7100,-7100,0);
             }

             if ( Trace(HitLocation, HitNormal, EndTrace, np.Location, false) != None )
                  dist = VSize( np.Location - HitLocation );
             else
                  dist = VSize( np.Location - EndTrace );

             if ( dist > bestDist )
             {
                  bestDist = dist;
                  bestRot = rotator(EndTrace - np.Location);
             }
        }

        bestRot.Roll = 0;
	bestRot.Pitch = 0;
        BestRotations[BestRotations.Length-1] = bestRot;
}

function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string incomingName)
{
     local NavigationPoint np, other;
     local byte Team;
     local Teleporter Tel;
     local float NewRating, BestRating;
     local int i, index;

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

     index = -1; //Used to find the corresponding rotation (in BestRotations) when starting a player at a nav point

     if ( Mode == 0 ) //Turn-Based
     {
          if ( Team == 0 )
          {
               for( i=0; i<ValidRedStarts.Length; i++ )
               {
                    np = ValidRedStarts[i];

                    NewRating = RatePlayerStart(np, Team, Player);
                    if ( NewRating > BestRating )
                    {
                         BestRating = NewRating;
                         other = np;
                         index = i;
                    }
               }
          }
          else if ( Team == 1 )
          {
               for( i=0; i<ValidBlueStarts.Length; i++ )
               {
                    np = ValidBlueStarts[i];

                    NewRating = RatePlayerStart(np, Team, Player);
                    if ( NewRating > BestRating )
                    {
                         BestRating = NewRating;
                         other = np;
                         index = i + ValidRedStarts.Length-1;   //As red start rotations and blue's are stored in one array (BestRotations)
                    }
               }
          }
     }
     else //Tournament
     {
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
          if ( Player != None )
               GunGamePRI(Player.PlayerReplicationInfo).PlayerStartIndex = index;

          LastStartSpot = other;
     }

     return other;
}

function float RatePlayerStart(NavigationPoint N, byte Team, Controller Player)
{
     local float Score, NextDist;
     local Controller OtherPlayer;

     if ( N.PhysicsVolume.bWaterVolume )  //Don't exclude them but make it rather unlikely (if there are too many players for example these startpoints could be used)
          Score = -100000.0;
     else
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
                    if ( OtherPlayer.PlayerReplicationInfo.Team.TeamIndex == Team && bTeamGame )
                    {
                         //Randomize here. This spreads the choice of playerstarts a bit, but still prefers playerstarts with teammates nearby.
                         if ( FRand() > 0.5 )
                              Score += (3000.0 - NextDist);
                    }
                    else
                    {
                         if ( FastTrace(N.Location, OtherPlayer.Pawn.Location) )
                              Score -= (5000.0 - NextDist);
                         else
                              Score -= (3000.0 - NextDist);
                    }
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

//Removed some things from here, added custom spawn rotation system
function RestartPlayer( Controller aPlayer )
{    
     local NavigationPoint startSpot;
     local int TeamNum;
     local class<Pawn> DefaultPlayerClass;
     local rotator bestRotation;
     local TeamInfo BotTeam, OtherTeam;

     if ( (!bPlayersVsBots || (Level.NetMode == NM_Standalone)) && bBalanceTeams && (Bot(aPlayer) != None) && (!bCustomBots || (Level.NetMode != NM_Standalone)) )
     {
          BotTeam = aPlayer.PlayerReplicationInfo.Team;
          if ( BotTeam == Teams[0] )
               OtherTeam = Teams[1];
          else
               OtherTeam = Teams[0];

          if ( OtherTeam.Size < BotTeam.Size - 1 )
          {
               aPlayer.Destroy();
               return;
          }
     }

     if ( bMustJoinBeforeStart && (UnrealPlayer(aPlayer) != None) && UnrealPlayer(aPlayer).bLatecomer )
          return;

     if ( aPlayer.PlayerReplicationInfo.bOutOfLives || (bNewRound && Mode == 0) )  //Bots can join when round has ended and a spectator is fixed to him -> (bNewRound && Mode == 0)
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

     if ( GunGamePRI(aPlayer.PlayerReplicationInfo).PlayerStartIndex != -1 )
          bestRotation = BestRotations[GunGamePRI(aPlayer.PlayerReplicationInfo).PlayerStartIndex];
     else
          bestRotation = startspot.Rotation;

     if (aPlayer.PreviousPawnClass != None && aPlayer.PawnClass != aPlayer.PreviousPawnClass)
          BaseMutator.PlayerChangedClass(aPlayer);

     if ( aPlayer.PawnClass != None )
          aPlayer.Pawn = Spawn(aPlayer.PawnClass,,, startSpot.Location, bestRotation);

     if( aPlayer.Pawn == None )
     {
          DefaultPlayerClass = GetDefaultPlayerClass(aPlayer);
          aPlayer.Pawn = Spawn(DefaultPlayerClass,,, startSpot.Location, bestRotation);
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

//Used to handle the 'Turn-Based' spawn system
State MatchInProgress
{
     function Timer()
     {
          if (!bGameEnded && bNewRound && Mode == 0)
               SetUpNewRound();  //Get rid of all player pawns, add new round sound/message, restart all player pawns, reset battlefield

          Super.Timer();
     }
}

function SetUpNewRound()
{
     local Controller C;
     local Actor A;
     local float AdrenalineBckp;
     local int i;
     local Inventory inv;

     switch(Counter)
     {
          case 0:  //EndRound for bots -> so they don't pick up essential pickups during end round time
                   for ( C=Level.ControllerList; C!=None; C=C.NextController )
                   {
                        if ( Bot(C) != None )
                             C.GameHasEnded();
                   }

                   //Clear all enemies
                   Teams[0].AI.ClearEnemies();
                   Teams[1].AI.ClearEnemies();

                   break;

          case 2:  //Destroy all pawns left
                   for ( C=Level.ControllerList; C!=None; C=C.NextController ) //Destroy all pawns
                   {
                        if ( (PlayerController(C) != None || Bot(C) != None) && !C.PlayerReplicationInfo.bOnlySpectator && !C.PlayerReplicationInfo.bOutOfLives )
                        {
                             C.PlayerReplicationInfo.bOutOfLives = true;

                             if ( C.Pawn != None )
                             {
                                  if ( xPawn(C.Pawn) != None )  //Disable Combos, remove Powerups
                                  {
                                       if (xPawn(C.Pawn).CurrentCombo != None)
                                       {
                                            xPawn(C.Pawn).CurrentCombo.Destroy();
                                       }
                                       if ( xPawn(C.Pawn).UDamageTimer != None )
                                       {
                                            xPawn(C.Pawn).UDamageTimer.Destroy();
                                            xPawn(C.Pawn).DisableUDamage();
                                       }
                                       C.Pawn.RemovePowerups();
                                  }                                  

                                  for ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory )
                                  {
                                       if ( TransLauncher(Inv) != None )
                                            Weapon(Inv).GiveAmmo(0, None, false);
                                  }

                                  C.Pawn.Destroy();
                             }

                             AdrenalineBckp = C.Adrenaline;  //Backup current adrenaline amount, as it will be reset
                             C.Reset();

                             if ( PlayerController(C) != None )
                             {
                                  PlayerController(C).ClientReset();
                                  PlayerController(C).GotoState('Spectating');
                             }

                             C.AwardAdrenaline(AdrenalineBckp);  //Restore Adrenaline
                        }
                   }

                   //Set up clean battlefield
                   foreach AllActors(class'Actor', A)
                   {
                        if ( Projectile(A) != None || xPawn(A) != None )
                             A.Destroy();
                        else if ( Mover(A) != None || Decoration(A) != None || Emitter(A) != None)
                             A.Reset();
                   }

                   //Swap Spawn-Bases, to avert disadvantages caused by them
                   for ( i=0; i<ValidRedStarts.Length; i++ )  //Swap rotations to keep consistency with team starts. Cut out the red start rotations and add them to the end of the array
                   {
                        BestRotations.Insert(BestRotations.Length, 1);
                        BestRotations[BestRotations.Length-1] = BestRotations[i];
                   }
                   BestRotations.Remove(0, ValidRedStarts.Length);
                   for ( i=0; i<ValidRedStarts.Length; i++ )  //Backup red starts
                   {
                        SwapBases.Insert(i, 1);
                        SwapBases[i] = ValidRedStarts[i];
                   }
                   ValidRedStarts.Remove(0, ValidRedStarts.Length);
                   for ( i=0; i<ValidBlueStarts.Length; i++ )  //Swap blue starts
                   {
                        ValidRedStarts.Insert(i, 1);
                        ValidRedStarts[i] = ValidBlueStarts[i];
                   }
                   ValidBlueStarts.Remove(0, ValidBlueStarts.Length);
                   for ( i=0; i<SwapBases.Length; i++ )  //Swap backuped red starts
                   {
                        ValidBlueStarts.Insert(i, 1);
                        ValidBlueStarts[i] = SwapBases[i];
                   }
                   SwapBases.Remove(0, SwapBases.Length);

                   break;

          case 3:  BroadcastLocalizedMessage( class'GunGameBW.GGMessages', 2 );
                   break;

          case 5:  BroadcastLocalizedMessage( class'TimerMessage', 3 );
                   break;

          case 6:  BroadcastLocalizedMessage( class'TimerMessage', 2 );
                   break;

          case 7:  BroadcastLocalizedMessage( class'TimerMessage', 1 );
                   break;

          case 8:  bNewRound = false;

                   for ( C=Level.ControllerList; C!=None; C=C.NextController )
                   {
                        if( (PlayerController(C) != None || Bot(C) != None) && C.Pawn == None && C.PlayerReplicationInfo != None && !C.PlayerReplicationInfo.bOnlySpectator )
                        {
                             if ( VictoryCondition == 2 && C.PlayerReplicationInfo.NumLives < MaxLives )
                                  C.PlayerReplicationInfo.bOutOfLives = false;
                             else if ( VictoryCondition != 2 )
                             {
                                  C.PlayerReplicationInfo.NumLives = 0;
                                  C.PlayerReplicationInfo.bOutOfLives = false;
                             }

                             if ( Bot(C) != None )  //Set bots free
                                  C.GotoState('');

                             RestartPlayer(C);
                        }
                   }

                   Counter = 0;
                   return;
     }

     Counter++;
}

function int ReduceDamage( int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
     if ( instigatedBy != None && injured != None && injured != instigatedBy && class<WeaponDamageType>(DamageType) != None )
     {
          if ( instigatedBy.PlayerReplicationInfo != None && instigatedBy.PlayerReplicationInfo.Team != injured.PlayerReplicationInfo.Team )
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
                         Killer.Pawn.AddShieldStrength( Min(StartShield, Killer.Pawn.ShieldStrength + Overflow) - Killer.Pawn.ShieldStrength );
               }
          }
     }

     Super.NotifyKilled(Killer, Other, OtherPawn);
}

//Used for GunGame functions: Increasse/Decrease GunLevels, decide if kills are valid and initialize new weapons.
//Moved function definitions from 'GameInfo' and 'Deathmatch' to optimize them for GunGame usage.
function Killed( Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType )
{
     local GunGamePRI KillerPRI, KilledPRI;
     local class<WeaponDamageType> WDT;
     local bool bNoUpgrade;
     local bool bEnemyKill;
     local float Overflow;

     bEnemyKill = ( !bTeamGame || ((Killer != None) && (Killer != Killed) && (Killed != None) && (Killer.PlayerReplicationInfo != None) && (Killed.PlayerReplicationInfo != None) && (Killer.PlayerReplicationInfo.Team != Killed.PlayerReplicationInfo.Team)) );

     if ( KilledPawn != None && KilledPawn.GetSpree() > 4 )
     {
          if ( bEnemyKill && (Killer != None) )
               Killer.AwardAdrenaline(ADR_MajorKill);
          EndSpree(Killer, Killed);
     }

     if ( Killed != None && Killed.bIsPlayer )
     {
          KilledPRI = GunGamePRI(Killed.PlayerReplicationInfo);

          if ( Killer != None && Killer.bIsPlayer )
          {
               KillerPRI = GunGamePRI(Killer.PlayerReplicationInfo);

               if ( UnrealPlayer(Killer) != None )
                    UnrealPlayer(Killer).LogMultiKills(ADR_MajorKill, bEnemyKill);

               if ( bEnemyKill )
                    DamageType.static.ScoreKill(Killer, Killed);

               if ( !bFirstBlood && (Killer != Killed) && bEnemyKill )
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
               else if ( !bEnemyKill )
                    Killer.AwardAdrenaline(ADR_KillTeamMate);
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
          {
               if ( !bEnemyKill )
                    KillEvent("TK", Killer.PlayerReplicationInfo, Killed.PlayerReplicationInfo, DamageType);	//"Teamkill"
               else
                    KillEvent("K", Killer.PlayerReplicationInfo, Killed.PlayerReplicationInfo, DamageType);	//"Kill"
          }
     }

     //Here are GunGame's mechanics implemented
     if ( KillerPRI != None )
          KillerPRI.bStdWeaponKill = false;  //Reset StdWeaponKill

     //If bNoUpgrade is true right here, then a self kill happened, downgrade and skip the rest of the GunGame code
     if ( bNoUpgrade )
          KilledPRI.AdjustLevel( -1 );
     else
     {
          if ( bEnemyKill )  //Skip if it was a teamkill, as we don't need to check the validity of the kill here
          {
               //Here I get the very last weapondamage actively done to Killed. So I know when Killed has been pushed out, which weapon caused that
               if ( class<WeaponDamageType>(damageType) != None )
                    WDT = class<WeaponDamageType>(damageType);
               else if ( damageType.Default.bCausedByWorld )
                    WDT = Registry[KillerPRI.RegistryID].LastWeaponsDamageDoneTo(Killed);

               if ( WDT != None )
               {
                    //If Damagetype belongs to std weapon and std weapon is not the current weapon in list, go on with punishing victim, otherwise skip this code
                    //Standard weapon kill scoring system
                    if ( ClassIsChildOf(WeaponList[0], WDT.Default.WeaponClass) && WeaponList[KillerPRI.GunLevel] != WeaponList[0] )
                    {
                         bNoUpgrade = true;   //Do not upgrade std weapon kills by default
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

                                                     if ( (KilledPri.Score - StdWeaponFactor) >= 0.0 )
                                                     {
                                                          Overflow = StdWeaponFactor;
                                                          KilledPRI.Score -= StdWeaponFactor;
                                                     }
                                                     else
                                                     {
                                                          Overflow = KilledPRI.Score;
                                                          KilledPRI.Score = 0.0;
                                                     }

                                                     KilledPRI.Team.Score -= Overflow;
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

                                                     KilledPRI.Team.Score -= Overflow;
                                                     KillerPRI.Score += Overflow;
                                                     KillerPRI.Team.Score += Overflow;
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
                                                     break;

                                            case 1:  KillerPRI.Score += StdWeaponFactor;
                                                     KillerPRI.Team.Score += StdWeaponFactor;
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
                         KillerPRI.Team.NetUpdateTime = Level.TimeSeconds - 1;
                         KilledPRI.Team.NetUpdateTime = Level.TimeSeconds - 1;
                    }
                    else  //Normal weapon kills
                    {
                         if ( !ClassIsChildOf(WeaponList[KillerPRI.GunLevel], WDT.Default.WeaponClass) )
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
          }

          if ( !bEnemyKill )
          {
               KillerPRI.DelayedAdjustLevel( -1 );
          }
          else if ( !bNoUpgrade && !Registry[KillerPRI.RegistryID].bBlockMultiKills ) //Skip the rest of the code for one second when this player has already levelled.
          {
               //Now we know that it was a valid kill. Check if player is able to be updated
               if ( KillerPRI.ValidKill() )  //Whether player is able to level up
               {
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
                              {
                                   KillerPRI.Score += IterationAward;
                                   KillerPRI.Team.Score += IterationAward;
                              }
                              else if ( VictoryCondition == 2 )
                                   KillerPRI.NumLives = Max((KillerPRI.NumLives - IterationAward), 0); //MaxLives = limit, one won't get further lives
                         }

                         KillerPRI.AdjustLevel( -HighestLevel );
                    }
					//If the player has killed with a guided akeron rocket, set a timer to handle equipment after the player no longer posesses the rocket
					if (AkeronWarhead(Killer.Pawn) != None)
					{
						timerKillerPRI = KillerPRI;
						timerKiller = Killer;
						SetTimer(1.5, false);
					}
					else if ( KillerPRI.GunLevel < HighestLevel && !KillerPRI.bInDelayedProcess )
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

function Timer()
{
	//If the player is still possessing a guided akeron rocket, just try again until they aren't (assuming they can't be an akeron rocket forever. never give up!)
	if (AkeronWarhead(timerKiller.Pawn) != None)
		SetTimer(1.5, false);
	else if ( timerKillerPRI.GunLevel < HighestLevel && !timerKillerPRI.bInDelayedProcess )
		SetEquipment(timerKillerPRI, timerKiller.Pawn);
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
               W = FindCorrespondingWeapon(KillerPawn, KillerPRI.GunLevel);

               if ( W != None )
                    W.bCanThrow = false;
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
     KillerPRI = GunGamePRI(Killer.PlayerReplicationInfO);

     if ( Mode == 0 && OtherPRI != None )
          OtherPRI.bOutOfLives = true;

     if ( !Other.bIsPlayer || ((Killer != None) && !Killer.bIsPlayer) )  //Non-Players (monsters), removed original code here as GunGame can only be played with players
          return;

     if ( (Killer == None) || (Killer == Other) || (Killer.PlayerReplicationInfo.Team != Other.PlayerReplicationInfo.Team) )
     {
          //Removed bonuses: critical players and scorevictimstargets -> check TeamGame for more information

          //DeathMatch
          if ( OtherPRI != None )  //Std weapon kills does not influence the normal scoring system, they use its own by default -> check Killed() for details
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

          if ( (Killer == None) || (Other == None) )
               return;

          if ( bAdjustSkill && (PlayerController(Killer) != None || PlayerController(Other) != None) )
          {
               if ( AIController(Killer) != None )
                    AdjustSkill(AIController(Killer), PlayerController(Other),true);
               if ( AIController(Other) != None )
                    AdjustSkill(AIController(Other), PlayerController(Killer),false);
          }
          //End DeathMatch

     }
     else if ( GameRulesModifiers != None )
          GameRulesModifiers.ScoreKill(Killer, Other);

     if ( !bScoreTeamKills )
     {
          if ( Other.bIsPlayer && (Killer != None) && Killer.bIsPlayer && (Killer != Other) && (Killer.PlayerReplicationInfo.Team == Other.PlayerReplicationInfo.Team) )
          {
               Killer.PlayerReplicationInfo.Score -= 1;
               Killer.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
               ScoreEvent(Killer.PlayerReplicationInfo, -1, "team_frag");
          }
          if ( MaxLives > 0 )
          {
               if ( Killer != None )
                    CheckScore(Killer.PlayerReplicationInfo);
               else
                    CheckScore(None);
          }

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
               if ( !KillerPRI.bStdWeaponKill )  //Keep being consistent with players' scores
               {
                    Killer.PlayerReplicationInfo.Team.Score += 1;
                    Killer.PlayerReplicationInfo.Team.NetUpdateTime = Level.TimeSeconds - 1;
               }

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

     if ( (Killer != None) && bScoreTeamKills )
          CheckScore(Killer.PlayerReplicationInfo);
}

function CheckScore(PlayerReplicationInfo Scorer)
{
     local Controller C;
     local PlayerReplicationInfo PRI;
     local bool bInitNewRound;

     if ( (GameRulesModifiers != None) && GameRulesModifiers.CheckScore(Scorer) )
          return;

     //CheckScore will be called 2 times every kill, so check that this condition will only be executed once, when bNewRound has already been initialized to avoid overlapping announcer sounds
     //Scorer can be None here, e.g. world kills cause that, but this also reduces lives, so check that if Mode==0
     if ( Mode == 0 && !bNewRound )
     {
          if ( Scorer != None && !Scorer.bOutOfLives )
               PRI = Scorer;

          bInitNewRound = true;
          for ( C=Level.ControllerList; C!=None; C=C.NextController )
          {
               if ( (C.PlayerReplicationInfo != None) && C.bIsPlayer )
               {
                    if ( !C.PlayerReplicationInfo.bOutOfLives && !C.PlayerReplicationInfo.bOnlySpectator )
                    {
                         if ( PRI == None )
                              PRI  = C.PlayerReplicationInfo;
                         else if ( PRI.Team != C.PlayerReplicationInfo.Team )
                         {
                              bInitNewRound = false;
                              break;
                         }
                    }
               }
          }

          if ( bInitNewRound )
          {
               if ( PRI != None )
                    BroadcastLocalizedMessage( class'GunGameBW.GGMessages', PRI.Team.TeamIndex );
               else if ( Scorer != None )
                    BroadcastLocalizedMessage( class'GunGameBW.GGMessages', Scorer.Team.TeamIndex );

               bNewRound = true;
          }
     }

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
                                      PRI = C.PlayerReplicationInfo;
                                      if ( GunGamePRI(PRI) != None && C.bIsPlayer )
                                           if ( GunGamePRI(Scorer).GunLevel < GunGamePRI(PRI).GunLevel )
                                                return;
                                 }
                            }

                            EndGame(Scorer,"GunLevel");
                       }
                  }
                  break;

         case 1:  if ( Scorer != None )
                  {
                       if (  !bOverTime && (GoalScore == 0) ) //Goalscore
		            return;

                       if ( (Scorer != None) && (Scorer.Team != None) && (Scorer.Team.Score >= GoalScore) )
		            EndGame(Scorer,"TeamScoreLimit");

                       if ( (Scorer != None) && bOverTime )
		            EndGame(Scorer,"TimeLimit");
                  }
                  break;

         case 2:  CheckMaxLives(Scorer);  //Lives
     }
}

function bool CheckMaxLives(PlayerReplicationInfo Scorer)
{
     local Controller C;
     local PlayerReplicationInfo Living, PRI;
     local bool bNoneLeft;

     if ( MaxLives > 0 && VictoryCondition == 2 )
     {
          if ( Scorer != None )
          {
               PRI = Scorer;

               if ( !Scorer.bOutOfLives )
                    Living = Scorer;
          }

          bNoneLeft = true;
          for ( C=Level.ControllerList; C!=None; C=C.NextController )
          {
               if ( C.PlayerReplicationInfo != None && C.bIsPlayer )
               {
                    if ( !C.PlayerReplicationInfo.bOutOfLives && !C.PlayerReplicationInfo.bOnlySpectator )
                    {
                         if ( Living == None )
                              Living = C.PlayerReplicationInfo;
                         else if ( (Living.Team != C.PlayerReplicationInfo.Team) )
                         {
                              bNoneLeft = false;
                              break;
                         }
                    }

                    if ( Mode == 0 )  //Check if game should really end, when the other team is out
                    {
                         if ( PRI == None )
                              PRI  = C.PlayerReplicationInfo;
                         else if ( PRI.Team != C.PlayerReplicationInfo.Team )
                         {
                              if ( C.PlayerReplicationInfo.NumLives < MaxLives ) //Check if members are really out of lives
                              {
                                   bNoneLeft = false;
                                   break;
                              }
                         }
                    }
               }
          }
          if ( bNoneLeft )
          {
               if ( Living != None )
                    EndGame(Living,"LastTeam");
               else
                    EndGame(Scorer,"LastTeam");

               return true;
          }
     }
     return false;
}

//"GunLevel" and "LastTeam" reasons added
function EndGame(PlayerReplicationInfo Winner, string Reason )
{
     if ( (Reason ~= "triggered") ||
          (Reason ~= "LastMan")   ||
          (Reason ~= "TimeLimit") ||
          (Reason ~= "FragLimit") ||
          (Reason ~= "TeamScoreLimit") ||
          (Reason ~= "GunLevel") ||
          (Reason ~= "LastTeam") )
     {
          Super(GameInfo).EndGame(Winner,Reason);
          if ( bGameEnded )
               GotoState('MatchOver');
     }
}

//Adjust Overtime, make announcer announce the right winning team and some other small changes
function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason)
{
     local Controller P;
     local bool bLastMan;

     if ( bOverTime )
     {
          if ( Numbots + NumPlayers == 0 )
               return true;

          bLastMan = true;
          for ( P=Level.ControllerList; P!=None; P=P.nextController )
          {
               if ( (P.PlayerReplicationInfo != None) && !P.PlayerReplicationInfo.bOutOfLives )
               {
                    bLastMan = false;
                    break;
               }
          }
          if ( bLastMan )
               return true;
     }

     bLastMan = ( Reason ~= "LastMan" || Reason ~= "LastTeam" );

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
                         if ( (Winner == None) || (P.PlayerReplicationInfo.Score > Winner.Score) && ( (P.PlayerReplicationInfo.Team == Teams[0] && Teams[0].Score > Teams[1].Score) || (P.PlayerReplicationInfo.Team == Teams[1] && Teams[1].Score > Teams[0].Score) ) )
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

     if ( bTeamScoreRounds )
     {
          if ( Winner != None )
          {
               Winner.Team.Score += 1;
               Winner.Team.NetUpdateTime = Level.TimeSeconds - 1;
          }
     }
     else if ( !bLastMan && VictoryCondition == 0 )  //GunLevel overtime
     {
          for ( P=Level.ControllerList; P!=None; P=P.nextController )
          {
               if ( P.bIsPlayer && (P.PlayerReplicationInfo != None) && (Winner.Team != P.PlayerReplicationInfo.Team) && !P.PlayerReplicationInfo.bOutOfLives && (GunGamePRI(P.PlayerReplicationInfo).GunLevel == GunGamePRI(Winner).GunLevel) )
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
     else if ( !bLastMan && (Teams[1].Score == Teams[0].Score) && VictoryCondition == 1 )  //GoalScore overtime
     {
          if ( !bOverTimeBroadcast )
          {
               StartupStage = 7;
               PlayStartupMessage();
               bOverTimeBroadcast = true;
          }
          return false;
     }

     GameReplicationInfo.Winner = Winner.Team;

     EndTime = Level.TimeSeconds + EndTimeDelay;

     SetEndGameFocus(Winner);
     return true;
}

//Adjust winning sound: 'flawless_victory' and 'humiliating_defeat' removed due to unnecessary complexity
function PlayEndOfMatchMessage()
{
     local Controller C;

     for ( C = Level.ControllerList; C != None; C = C.NextController )
     {
          if ( PlayerController(C) != None && C.PlayerReplicationInfo != None )
          {
               if ( C.PlayerReplicationInfo.Team == GameReplicationInfo.Winner )
                    PlayerController(C).PlayStatusAnnouncement(EndGameSoundName[0],1,true);
               else
                    PlayerController(C).PlayStatusAnnouncement(EndGameSoundName[1],1,true);
          }
     }
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

defaultproperties
{
	 LvlUpSound=Sound'GameSounds.Fanfares.UT2K3Fanfare08'
	 InventoryMut="BallisticProV55.Mut_BallisticDM"
	 HUDFixMut="HUDFix.MutHUDFix"
     StartHealth=175
     StartShield=0
	 MaxHealth=218
     bAdrenalineOn=True
     CureAward=25
     IterationAward=1
     bNoAdrenaline=False
     bNoHealth=False
     bNoShield=False
     StdWeaponFactor=1
	 KillAmount=1
	 AmmoHandling=0

     DefaultWeapons(0)=Class'BallisticProV55.X3Knife'	//standard weapon

     DefaultWeapons(1)=Class'BallisticProV55.HVCMk9LightningGun'
     DefaultWeapons(2)=Class'BWBPRecolorsPro.LAWLauncher'
     DefaultWeapons(3)=Class'BallisticProV55.MACWeapon'
     DefaultWeapons(4)=Class'BWBPRecolorsPro.MGLauncher'	//ks2
     DefaultWeapons(5)=Class'BWBPRecolorsPro.FLASHLauncher'
     DefaultWeapons(6)=Class'BallisticProV55.RX22AFlamer'
     DefaultWeapons(7)=Class'BallisticProV55.M290Shotgun'

     DefaultWeapons(8)=Class'BallisticProV55.MRocketLauncher'
     DefaultWeapons(9)=Class'BallisticProV55.G5Bazooka'
     DefaultWeapons(10)=Class'BWBPRecolorsPro.SKASShotgun'	//ks1
     DefaultWeapons(11)=Class'BWBPRecolorsPro.AH208Pistol'
	 DefaultWeapons(12)=Class'BallisticProV55.SRS600Rifle'

	 DefaultWeapons(13)=Class'BallisticProV55.M50AssaultRifle'
	 DefaultWeapons(14)=Class'BallisticProV55.M46AssaultRifle'
	 DefaultWeapons(15)=Class'BallisticProV55.M46AssaultRifleQS'
     DefaultWeapons(16)=Class'BWBPRecolorsPro.MARSAssaultRifle'
     DefaultWeapons(17)=Class'BWBPRecolorsPro.F2000AssaultRifle'
     DefaultWeapons(18)=Class'BWBPRecolorsPro.CYLOAssaultWeapon'	//ar
     DefaultWeapons(19)=Class'BWBPRecolorsPro.CYLOUAW'
	 DefaultWeapons(20)=Class'BWBPRecolorsPro.LK05Carbine'
	 DefaultWeapons(21)=Class'BallisticProV55.SARAssaultRifle'
	 DefaultWeapons(22)=Class'BWBPRecolorsPro.AK47AssaultRifle'
     DefaultWeapons(23)=Class'BWBPOtherPackPro.CX61AssaultRifle'
	 
     DefaultWeapons(24)=Class'BallisticProV55.Fifty9MachinePistol'
     DefaultWeapons(25)=Class'BallisticProV55.XK2SubMachinegun'
	 DefaultWeapons(26)=Class'BallisticProV55.XMK5SubMachinegun'	//smg
     DefaultWeapons(27)=Class'BallisticProV55.XRS10SubMachinegun'

	 DefaultWeapons(28)=Class'BallisticProV55.RSNovaStaff'
     DefaultWeapons(29)=Class'BallisticProV55.RSDarkStar'
     DefaultWeapons(30)=Class'BWBPOtherPackPro.XOXOStaff'
     DefaultWeapons(31)=Class'BallisticProV55.E23PlasmaRifle'
     DefaultWeapons(32)=Class'BallisticProV55.A73SkrithRifle'	//energy
	 DefaultWeapons(33)=Class'BWBPRecolorsPro.A49SkrithBlaster'
     DefaultWeapons(34)=Class'BWBPOtherPackPro.XM20AutoLas'
     DefaultWeapons(35)=Class'BWBPOtherPackPro.Raygun'
     DefaultWeapons(36)=Class'BWBPOtherPackPro.ProtonStreamer'

	 DefaultWeapons(37)=Class'BallisticProV55.A500Reptile'
     DefaultWeapons(38)=Class'BWBPRecolorsPro.CoachGun'
     DefaultWeapons(39)=Class'BWBPOtherPackPro.ARShotgun'
     DefaultWeapons(40)=Class'BWBPRecolorsPro.MK781Shotgun'
     DefaultWeapons(41)=Class'BallisticProV55.MRS138Shotgun'	//shotgun
     DefaultWeapons(42)=Class'BWBPOtherPackPro.TrenchGun'
     DefaultWeapons(43)=Class'BallisticProV55.M763Shotgun'
	 DefaultWeapons(44)=Class'BWBPRecolorsPro.SK410Shotgun'

	 DefaultWeapons(45)=Class'BallisticProV55.M353Machinegun'
	 DefaultWeapons(46)=Class'BallisticProV55.M925Machinegun'
	 DefaultWeapons(47)=Class'BWBPOtherPackPro.Z250Minigun'	//mg
     DefaultWeapons(48)=Class'BallisticProV55.XMV850Minigun'
     DefaultWeapons(49)=Class'BWBPRecolorsPro.FG50MachineGun'

     DefaultWeapons(50)=Class'BWBPRecolorsPro.BulldogAssaultCannon'
	 DefaultWeapons(51)=Class'BWBPOtherPackPro.AkeronLauncher'	//ordnance
	 DefaultWeapons(52)=Class'BWBPRecolorsPro.LonghornLauncher'

	 DefaultWeapons(53)=Class'BallisticProV55.R78Rifle'
	 DefaultWeapons(54)=Class'BallisticProV55.SRS900Rifle'
	 DefaultWeapons(55)=Class'BWBPOtherPackPro.R9A1RangerRifle'
	 DefaultWeapons(56)=Class'BallisticProV55.MarlinRifle'
	 DefaultWeapons(57)=Class'BWBPOtherPackPro.CX85AssaultWeapon'
	 DefaultWeapons(58)=Class'BWBPRecolorsPro.LS14Carbine'	//sniper
     DefaultWeapons(59)=Class'BWBPRecolorsPro.M2020GaussDMR'
     DefaultWeapons(60)=Class'BWBPRecolorsPro.AS50Rifle'
	 DefaultWeapons(61)=Class'BWBPOtherPackPro.BX85Crossbow'
	 DefaultWeapons(62)=Class'BWBPRecolorsPro.X82Rifle'
     DefaultWeapons(63)=Class'BallisticProV55.M75Railgun'

	 DefaultWeapons(64)=Class'BallisticProV55.AM67Pistol'
     DefaultWeapons(65)=Class'BWBPRecolorsPro.AH250Pistol'
     DefaultWeapons(66)=Class'BallisticProV55.D49Revolver'
     DefaultWeapons(67)=Class'BallisticProV55.leMatRevolver'
     DefaultWeapons(68)=Class'BallisticProV55.GRS9Pistol'
	 DefaultWeapons(69)=Class'BallisticProV55.MRT6Shotgun'
     DefaultWeapons(70)=Class'BallisticProV55.RS8Pistol'	//pistol
     DefaultWeapons(71)=Class'BWBPRecolorsPro.PS9mPistol'
	 DefaultWeapons(72)=Class'BWBPRecolorsPro.MRDRMachinePistol'
     DefaultWeapons(73)=Class'BallisticProV55.A42SkrithPistol'
	 DefaultWeapons(74)=Class'BallisticProV55.MD24Pistol'
	 DefaultWeapons(75)=Class'BallisticProV55.BOGPPistol'
     DefaultWeapons(76)=Class'BWBPOtherPackPro.PD97Bloodhound'

     DefaultWeapons(77)=Class'BWBPRecolorsPro.DragonsToothSword'
	 DefaultWeapons(78)=Class'BWBPOtherPackPro.DefibFists'
     DefaultWeapons(79)=Class'BWBPOtherPackPro.FlameSword'
     DefaultWeapons(80)=Class'BWBPOtherPackPro.MAG78Longsword'	//melee
     DefaultWeapons(81)=Class'BallisticProV55.A909SkrithBlades'
     DefaultWeapons(82)=Class'BallisticProV55.EKS43Katana'
     DefaultWeapons(83)=Class'BallisticProV55.X4Knife'
     DefaultWeapons(84)=Class'BWBPRecolorsPro.X8Knife'

     LoginMenuClass="GunGameBW.UT2K4GunGameLoginMenu"
     bWeaponStay=False
     bAllowWeaponThrowing=False
     ScoreBoardType="GunGameBW.TGGScoreboard"
     //HUDType="GunGameBW.GGHUD"
     MutatorClass="GunGameBW.GunGameMut"
     BroadcastHandlerClass="GunGameBW.GGBroadcastHandler"
     GameReplicationInfoClass=Class'GunGameBW.GunGameGRI'
     GameName="Ballistic Team GunGame"
     Description="Level up and achieve new weapons by killing opponents as team."
     Acronym="TGG"
}
