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
	local class<BC_GameStyle_Config> style;

	style = class'BallisticGameStyles'.static.GetClientLocalConfigStyle();

	if (style != None)
	{
    	ne_killRewardHealthpoints.SetValue(style.default.class.default.killRewardHealthpoints);
    	ne_killRewardHealthcap.SetValue(style.default.class.default.killRewardHealthcap);
    	ne_killrewardArmor.SetValue(style.default.class.default.killrewardArmor);
    	ne_killrewardArmorCap.SetValue(style.default.class.default.killrewardArmorCap);
	}
}

function DefaultSettings()
{
    ne_killRewardHealthpoints.SetValue(0);
    ne_killRewardHealthcap.SetValue(0);
    ne_killrewardArmor.SetValue(0);
    ne_killrewardArmorCap.SetValue(0);
}

function SaveSettings()
{
    if (!bInitialized)
        return;

	style = class'BallisticGameStyles'.static.GetClientLocalConfigStyle();

	if (style != None)
	{
		style.default.killRewardHealthpoints  = ne_killRewardHealthpoints.GetValue();
		style.default.killRewardHealthcap = ne_killRewardHealthcap.GetValue();
		style.default.killrewardArmor = ne_killrewardArmor.GetValue();
		style.default.killrewardArmorCap = ne_killrewardArmorCap.GetValue();
		style.static.StaticSaveConfig();
	}
}

defaultproperties
{
     Begin Object Class=moNumericEdit Name=ne_killRewardHealthpointsE
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Health Kill Reward"
         OnCreateComponent=ne_killRewardHealthpointsE.InternalOnCreateComponent
         Hint="Health received for killing an enemy."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killRewardHealthpoints=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_killRewardHealthpointsE'

     Begin Object Class=moNumericEdit Name=ne_killRewardHealthcapE
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Health Kill Reward Cap"
         OnCreateComponent=ne_killRewardHealthcapE.InternalOnCreateComponent
         Hint="The maximum health value that can be reached through health kill rewards. 0 uses the player's maximum health value."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killRewardHealthcap=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_killRewardHealthcapE'

     Begin Object Class=moNumericEdit Name=ne_killrewardArmorC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Shield Kill Reward"
         OnCreateComponent=ne_killrewardArmorC.InternalOnCreateComponent
         Hint="Shields received for killing an enemy."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killrewardArmor=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_killrewardArmorC'

     Begin Object Class=moNumericEdit Name=ne_killrewardArmorCapC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Shield Kill Reward Cap"
         OnCreateComponent=ne_killrewardArmorCapC.InternalOnCreateComponent
         Hint="The maximum shield value that can be reached through shield kill rewards. 0 uses the player's maximum shield value."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_killrewardArmorCap=moNumericEdit'BallisticProV55.BallisticTab_KillRewards.ne_killrewardArmorCapC'

}
