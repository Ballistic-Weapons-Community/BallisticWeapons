// ====================================================================
//  Class: GunGame.GunGamePRI
// ====================================================================

class GunGamePRI extends xPlayerReplicationInfo;

var int GunLevel;              //Index to player's current weapon in GunGame's WeaponList
var int OldGunLevel;           //The previous GunLevel the owning Player had before, used to find the old weapon in order to delete it then
var int RegistryID;             //Index to player's Registry object, so I can find the corresponding object fast, without an iteration
var int HighestLevel;          //Grabbed from Level.Game (TGG/GG)
var int PlayerStartIndex;       //Used to find the corresponding Rotation in TeamGunGame (RestartPlayer())
var bool bStdWeaponKill;        //Used by Level.Game to avoid StdWeapons influence the normal scoring system in ScoreKill() as they use its own
var byte KillAmount;            //The same as in GunGame
var byte ValidKills;            //Counts up to KillAmount -> player is able level up
var float DelayedLevellingTime; //Time for delayed level up/down
var bool bInDelayedProcess;     //Player is currently involved in a massive kill process -> don't level up instantly wait until the killstreaks end

replication
{
     reliable if ( Role == ROLE_Authority && bNetDirty )
          GunLevel;
}

simulated function PostBeginPlay()
{
     Super.PostBeginPlay();

     if ( Role < ROLE_Authority )
          return;

     if ( GunGame(Level.Game) != None )
     {
          HighestLevel = GunGame(Level.Game).HighestLevel;
          KillAmount = GunGame(Level.Game).KillAmount;
     }
     else if ( TeamGunGame(Level.Game) != None )
     {
          HighestLevel = TeamGunGame(Level.Game).HighestLevel;
          KillAmount = TeamGunGame(Level.Game).KillAmount;
     }

     Disable('Tick');
}

event Tick( float DeltaTime )
{
     if ( Level.TimeSeconds >= DelayedLevellingTime )
     {
          if ( Controller(Owner) != None && GunLevel < HighestLevel )
          {
               if ( GunGame(Level.Game) != None )
                    GunGame(Level.Game).SetEquipment(Self, Controller(Owner).Pawn);
               else if ( TeamGunGame(Level.Game) != None )
                    TeamGunGame(Level.Game).SetEquipment(Self, Controller(Owner).Pawn);
          }

          bInDelayedProcess = false;
          DelayedLevellingTime = 0.0;

          Disable('Tick');
     }
}

//Handle massive level ups/downs at the same time caused by std. weapon (Redeemer)
function DelayedAdjustLevel( int value )
{
     AdjustLevel( value );
     if ( !bInDelayedProcess )
     {
          bInDelayedProcess = true;
          DelayedLevellingTime = Level.TimeSeconds + 2.0;
          Enable('Tick');
     }
}

function AdjustLevel( int value )
{
     if ( GunLevel < HighestLevel && !bInDelayedProcess )  //Do not overwrite the old gunlevel during delayed process
          OldGunLevel = GunLevel;

     GunLevel = Clamp(Gunlevel+value, 1, HighestLevel); //GunLevel must always stay between 1 and HighestLevel
     NetUpdateTime = Level.TimeSeconds - 1;
     ValidKills = 0;
}

//True -> Player is able to level up
//False -> Player has to achieve more kills to level up
function bool ValidKill()
{
     ValidKills = Min(ValidKills+1, KillAmount);
     return ( ValidKills >= KillAmount );
}

defaultproperties
{
     GunLevel=1
     RegistryID=-1
     PlayerStartIndex=-1
}
