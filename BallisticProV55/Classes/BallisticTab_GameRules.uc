//=============================================================================
// BallisticTab_WeaponRules.
//
// Server side options like rules that change the behaviour of the game and
// affect all players. These are used when hosting an MP or SP game.
//
// Edit By OJMoody
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTab_GameRules extends UT2K4TabPanel;

var automated moComboBox	co_GameStyle;		//Choose Params
//Add Killsteaks Here
var automated moCheckbox	ch_ViewFlash;		//Damage Indication Flash Toggle
var automated moFloatEdit	fl_NadePct;			//Swap Ammo For Grenade Percentage
var automated moCheckbox	ch_BrightPickups;	//Bright Pickups Toggle
var automated moCheckbox	ch_PickupsChange;	//Toggle Pickups Change After Obtained
var automated moCheckbox	ch_SpawnUnique;		//Sawn Least Common Weapon Toggle
var automated moCheckbox	ch_LeaveSuper;		//Leave Non-BW Superweapons in Rotation
var automated moCheckbox	ch_KillRogueWPs;	//Kill All Non-BW Weapons that are forced into the map

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
	co_GameStyle.AddItem("Arena" ,,string(0));
	co_GameStyle.AddItem("Classic" ,,string(1));
	co_GameStyle.AddItem("Realism" ,,string(2));
    co_GameStyle.AddItem("Tactical" ,,string(3));
	co_GameStyle.ReadOnly(True);
	co_GameStyle.SetIndex(class'BallisticReplicationInfo'.default.GameStyle);
	
	ch_ViewFlash.Checked(class'BallisticPawn'.default.bNoViewFlash);
	fl_NadePct.SetValue(class'Mut_BallisticSwap'.default.NadeReplacePercent);
	ch_BrightPickups.Checked(class'Mut_Ballistic'.default.bBrightPickups);
	ch_PickupsChange.Checked(class'Mut_Ballistic'.default.bPickupsChange);
	ch_SpawnUnique.Checked(class'Mut_Ballistic'.default.bSpawnUniqueItems);
	ch_KillRogueWPs.Checked(class'Mut_Ballistic'.default.bKillRogueWeaponPickups);
	ch_LeaveSuper.Checked(class'Mut_Ballistic'.default.bLeaveSuper);
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'BallisticReplicationInfo'.default.GameStyle       = EGameStyle(co_GameStyle.GetIndex());
	class'BallisticPawn'.default.bNoViewFlash				= ch_ViewFlash.IsChecked();
	class'Mut_BallisticSwap'.default.NadeReplacePercent = fl_NadePct.GetValue();
	class'Mut_Ballistic'.default.bBrightPickups		 		= ch_BrightPickups.IsChecked();
	class'Mut_Ballistic'.default.bPickupsChange 			= ch_PickupsChange.IsChecked();
	class'Mut_Ballistic'.default.bSpawnUniqueItems 			= ch_SpawnUnique.IsChecked();
	class'Mut_Ballistic'.default.bKillRogueWeaponPickups	= ch_KillRogueWPs.IsChecked();
	class'Mut_Ballistic'.default.bLeaveSuper 				= ch_LeaveSuper.IsChecked();
	
	class'BallisticReplicationInfo'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'BallisticPawn'.static.StaticSaveConfig();
	class'Rules_Ballistic'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	co_GameStyle.SetIndex(0);
	ch_ViewFlash.Checked(true);
	fl_NadePct.SetValue(15);
	ch_BrightPickups.Checked(false);
	ch_PickupsChange.Checked(true);
	ch_SpawnUnique.Checked(true);
	ch_KillRogueWPs.Checked(false);
	ch_LeaveSuper.Checked(false);
}

defaultproperties
{
	 //To Add Inventory Mode Above "Game Style"
	 
	 Begin Object Class=moComboBox Name=co_GameStyleCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Game Style"
         OnCreateComponent=co_GameStyleCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Determines the general gameplay of Ballistic Weapons."
         WinTop=0.050000
         WinLeft=0.250000
		 WinHeight=0.040000
     End Object
     co_GameStyle=moComboBox'co_GameStyleCombo'
	 
	 Begin Object Class=moCheckBox Name=ch_ViewFlashCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Damage Screen Flashes"
         OnCreateComponent=ch_ViewFlashCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disable screen flashes when you get damaged."
         WinTop=0.10000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ViewFlash=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_ViewFlashCheck'

	 Begin Object Class=moFloatEdit Name=fl_NadePctFloat
         MinValue=1.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Ammo to Grenades Swap %"
         OnCreateComponent=fl_NadePctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Percentage chance of replacing an ammo pickup with a grenade."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_NadePct=moFloatEdit'BallisticProV55.BallisticTab_GameRules.fl_NadePctFloat'
	 
	 Begin Object Class=moCheckBox Name=ch_BrightPickupsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Bright Pickups"
         OnCreateComponent=ch_BrightPickupsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable to make pickups bright and easier to see. Does not affect multiplayer."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BrightPickups=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_BrightPickupsCheck'

	 Begin Object Class=moCheckBox Name=ch_PickupsChangeCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Pickups Change"
         OnCreateComponent=ch_PickupsChangeCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Pickups randomly change after they have been picked up."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_PickupsChange=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_PickupsChangeCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_SpawnUniqueCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Prefer Unique Pickups"
         OnCreateComponent=ch_SpawnUniqueCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Game will prefer to spawn pickups that are the least common at the time."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_SpawnUnique=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_SpawnUniqueCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_KillRogueWPsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Rogue Weapon Pickups"
         OnCreateComponent=ch_KillRogueWPsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="BW mutators will remove/replace unlisted weapon pickups. (e.g. In-map Instagib rifles)"
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_KillRogueWPs=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_KillRogueWPsCheck'

	 Begin Object Class=moCheckBox Name=ch_LeaveSuperCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Keep Super Weapons"
         OnCreateComponent=ch_LeaveSuperCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable to leave super weapons in."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_LeaveSuper=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_LeaveSuperCheck'

}