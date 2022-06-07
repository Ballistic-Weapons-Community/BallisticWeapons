//=============================================================================
// CFTab_Rules.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class BallisticTab_KillRewards extends UT2K4TabPanel;

var automated moNumericEdit	ne_killRewardHealthpoints;		//HP Reward
var automated moNumericEdit	ne_killRewardHealthcap;			//HP Reward Cap

var automated moNumericEdit ne_ADRKill;						//Adrenaline Kill Reward
var automated moNumericEdit ne_ADRMajorKill;				//Adrenaline Overkill Reward
var automated moNumericEdit ne_ADRMinorBonus;				//Adrenaline Damage Reward
var automated moNumericEdit ne_ADRKillTeamMate;				//Adrenaline Teamkill Reward
var automated moNumericEdit ne_ADRMinorError;				//Adrenaline Team Damage Reward

var automated moNumericEdit ne_killrewardArmor;				//Armour Reward
var automated moNumericEdit ne_killrewardArmorCap;			//Armour Reward Cap

var BallisticConfigMenuPro	p_Anchor;
var bool					bInitialized;

//==================================================================
// General Menu Code
//==================================================================

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);
    if (BallisticConfigMenuPro(Controller.ActivePage) != None)
        p_Anchor = BallisticConfigMenuPro(Controller.ActivePage);
}

function ShowPanel(bool bShow)
{
    super.ShowPanel(bShow);
    if (bInitialized)
        return;
    LoadSettings();
    bInitialized = true;
}

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
    ne_killRewardHealthpoints.SetValue(class'BallisticReplicationInfo'.default.killRewardHealthpoints);
    ne_killRewardHealthcap.SetValue(class'BallisticReplicationInfo'.default.killRewardHealthcap);
    ne_ADRKill.SetValue(class'BallisticReplicationInfo'.default.ADRKill);
    ne_ADRMajorKill.SetValue(class'BallisticReplicationInfo'.default.ADRMajorKill);
    ne_ADRMinorBonus.SetValue(class'BallisticReplicationInfo'.default.ADRMinorBonus);
    ne_ADRKillTeamMate.SetValue(class'BallisticReplicationInfo'.default.ADRKillTeamMate);
    ne_ADRMinorError.SetValue(class'BallisticReplicationInfo'.default.ADRMinorError);
    ne_killrewardArmor.SetValue(class'BallisticReplicationInfo'.default.killrewardArmor);
    ne_killrewardArmorCap.SetValue(class'BallisticReplicationInfo'.default.killrewardArmorCap);
}

function DefaultSettings()
{
    ne_killRewardHealthpoints.SetValue(20);
    ne_killRewardHealthcap.SetValue(0);
    ne_ADRKill.SetValue(10);
    ne_ADRMajorKill.SetValue(15);
    ne_ADRMinorBonus.SetValue(5);
    ne_ADRKillTeamMate.SetValue(-10);
    ne_ADRMinorError.SetValue(-5);
    ne_killrewardArmor.SetValue(10);
    ne_killrewardArmorCap.SetValue(0);
}

function SaveSettings()
{
    if (!bInitialized)
        return;

    class'BallisticReplicationInfo'.default.killRewardHealthpoints  = ne_killRewardHealthpoints.GetValue();
    class'BallisticReplicationInfo'.default.killRewardHealthcap = ne_killRewardHealthcap.GetValue();
    class'BallisticReplicationInfo'.default.ADRKill = ne_ADRKill.GetValue();
    class'BallisticReplicationInfo'.default.ADRMajorKill = ne_ADRMajorKill.GetValue();
    class'BallisticReplicationInfo'.default.ADRMinorBonus = ne_ADRMinorBonus.GetValue();
    class'BallisticReplicationInfo'.default.ADRKillTeamMate = ne_ADRKillTeamMate.GetValue();
    class'BallisticReplicationInfo'.default.ADRMinorError = ne_ADRMinorError.GetValue();
    class'BallisticReplicationInfo'.default.killrewardArmor = ne_killrewardArmor.GetValue();
    class'BallisticReplicationInfo'.default.killrewardArmorCap = ne_killrewardArmorCap.GetValue();

    class'BallisticReplicationInfo'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moNumericEdit Name=ne_killRewardHealthpointsE
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Kill reward in health points:"
         OnCreateComponent=ne_killRewardHealthpointsE.InternalOnCreateComponent
         Hint="The kill reward in health points given to the dominator."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killRewardHealthpoints=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_killRewardHealthpointsE'

     Begin Object Class=moNumericEdit Name=ne_killRewardHealthcapE
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Kill reward health cap:"
         OnCreateComponent=ne_killRewardHealthcapE.InternalOnCreateComponent
         Hint="The kill reward health cap for the dominator. 0 = player super health cap."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killRewardHealthcap=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_killRewardHealthcapE'

     Begin Object Class=moNumericEdit Name=ne_ADRKillC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Adrenaline for kill:"
         OnCreateComponent=ne_ADRKillC.InternalOnCreateComponent
         Hint="The given adrenaline for a kill."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRKill=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_ADRKillC'

     Begin Object Class=moNumericEdit Name=ne_ADRMajorKillC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Adrenaline for major kill:"
         OnCreateComponent=ne_ADRMajorKillC.InternalOnCreateComponent
         Hint="The given adrenaline for a major kill."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRMajorKill=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_ADRMajorKillC'

     Begin Object Class=moNumericEdit Name=ne_ADRMinorBonusC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Adrenaline for minor bonus:"
         OnCreateComponent=ne_ADRMinorBonusC.InternalOnCreateComponent
         Hint="The given adrenaline for a minor bonus."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRMinorBonus=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_ADRMinorBonusC'

     Begin Object Class=moNumericEdit Name=ne_ADRKillTeamMateC
         MinValue=-999
         MaxValue=0
         ComponentWidth=0.175000
         Caption="Adrenaline deduction for team kill:"
         OnCreateComponent=ne_ADRKillTeamMateC.InternalOnCreateComponent
         Hint="The adrenaline deduction for a team kill."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRKillTeamMate=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_ADRKillTeamMateC'

     Begin Object Class=moNumericEdit Name=ne_ADRMinorErrorC
         MinValue=-999
         MaxValue=0
         ComponentWidth=0.175000
         Caption="Adrenaline deduction for minor error:"
         OnCreateComponent=ne_ADRMinorErrorC.InternalOnCreateComponent
         Hint="The adrenaline deduction for a minor error."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ADRMinorError=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_ADRMinorErrorC'

     Begin Object Class=moNumericEdit Name=ne_killrewardArmorC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Kill reward in armor points:"
         OnCreateComponent=ne_killrewardArmorC.InternalOnCreateComponent
         Hint="The kill reward in armor points given to the dominator."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killrewardArmor=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_killrewardArmorC'

     Begin Object Class=moNumericEdit Name=ne_killrewardArmorCapC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Kill reward armor cap:"
         OnCreateComponent=ne_killrewardArmorCapC.InternalOnCreateComponent
         Hint="The kill reward armor cap for the dominator. 0 = player armor cap."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killrewardArmorCap=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_killrewardArmorCapC'

}
