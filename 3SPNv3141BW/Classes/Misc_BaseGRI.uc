class Misc_BaseGRI extends GameReplicationInfo;

var string Version;

var int RoundTime;
var int RoundMinute;
var int CurrentRound;
var bool bEndOfRound;

var int MinsPerRound;
var int OTDamage;
var int OTInterval;

var int StartingHealth;
var int StartingArmor;
var float MaxHealth;

var float CampThreshold;
var bool bKickExcessiveCampers;

var bool bForceRUP;

var bool bDisableSpeed;
var bool bDisableBooster;
var bool bDisableInvis;
var bool bDisableBerserk;

var int  TimeOuts;

var bool bWeaponsLocked;
var bool bPracticeRound;

replication
{
    reliable if(bNetInitial && Role == ROLE_Authority)
        RoundTime, MinsPerRound, bDisableSpeed, bDisableBooster, bDisableInvis,
        bDisableBerserk, StartingHealth, StartingArmor, MaxHealth, OTDamage,
        OTInterval, CampThreshold, bKickExcessiveCampers, bForceRUP,
        TimeOuts;

    reliable if(!bNetInitial && bNetDirty && Role == ROLE_Authority)
        RoundMinute;

    reliable if(bNetDirty && Role == ROLE_Authority)
        CurrentRound, bEndOfRound, bWeaponsLocked, bPracticeRound;
}

simulated function Timer()
{
    Super.Timer();

    if(Level.NetMode == NM_Client)
    {
        if(RoundMinute > 0)
        {
            RoundTime = RoundMinute;
            RoundMinute = 0;
        }
        else if (RoundMinute == -1)
        {
            RoundTime = 0;
            RoundMinute = 0;
        }

        if(RoundTime > 0 && !bStopCountDown)
            RoundTime--;
    }
}

defaultproperties
{
     Version="3.14159265"
}
