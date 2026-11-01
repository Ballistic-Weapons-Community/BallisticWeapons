class Misc_PRI extends xPlayerReplicationInfo;

// NR = not automatically replicated

var bool    bWarned;                // has been warned for camping (next time will receive penalty) - NR
var bool    bWaterWarned;           // has received warning for being in water - NR
var int     CampCount;              // the number of times penalized for camping - NR
var int     WaterCampCount;	        // the number of times anticamp has detected the player in a fog-dense water volume - NR
var int     ConsecutiveCampCount;   // the number of times penalized for camping consecutively - NR

var int     EnemyDamage;            // damage done to enemies - NR
var int     AllyDamage;             // damage done to allies and self - NR
var int     ReceivedDamage;         // damage received - NR
var float   ReverseFF;              // percentage of friendly fire that is returned - NR

var int     FlawlessCount;          // number of flawless victories - NR
var int     OverkillCount;          // number of overkills - NR
var int     DarkHorseCount;         // number of darkhorses - NR

var float   DarkSoulPower; 	        // Dark Star soul power - NR
var float   NovaSoulPower; 	        // Nova Staff soul power - NR
var float   XOXOLewdness;           // XOXO Lewdness - NR

var int     JoinRound;              // the round the player joined on

/* camping related */
var vector LocationHistory[10];
var int	   NextLocHistSlot;
var bool   bWarmedUp;
var int	   ReWarnTime;
var int    WaterReWarnTime;
/* camping related */

var class<Misc_PawnReplicationInfo> PawnInfoClass;
var Misc_PawnReplicationInfo PawnReplicationInfo;

replication
{
    reliable if(bNetInitial && Role == ROLE_Authority)
        JoinRound;

    reliable if(bNetDirty && Role == ROLE_Authority)
        PawnReplicationInfo;
}

event PostBeginPlay()
{
  Super.PostBeginPlay();

  if(!bDeleteMe && Level.NetMode != NM_Client)
  {
		PawnReplicationInfo = Spawn(PawnInfoClass, self,, vect(0,0,0), rot(0,0,0));
		if (TeamArenaMaster(Level.Game) != None && TeamArenaMaster(Level.Game).bPureRFF)
			ReverseFF = 1.0;
	}
}

simulated function string GetLocationName()
{
    if(bOutOfLives && !bOnlySpectator)
        return default.StringDead;

    return Super.GetLocationName();
}

function float CalcKillEfficiency()
{
    return float(Kills) / FMax(1f, Deaths);
}

function float CalcDamageEfficiency()
{
    return float(EnemyDamage) / FMax(1f, float(ReceivedDamage));
}

defaultproperties
{
     PawnInfoClass=Class'3SPNv3141BW.Misc_PawnReplicationInfo'
}
