//=============================================================================
// BallisticConfigMenuPro.
//
// This menu is like an options menu for the Ballistic Weapons mod.
// It has settings for the mutator and game like rules and so on which are kept
// server side and preference type options that are kept client side.
// OK: saves and exits, Cancel: exits without save, Reset: undoes all changes
// Defaults: resets everything to default
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticConfigMenuPro extends UT2K4GUIPage;

var Automated GUIImage		MyBack;
var Automated GUIButton		BDone, BCancel, BReset, BDefault, BPurge;
var automated GUIHeader		MyHeader;
var automated GUITabControl	c_Tabs;

var() editconst noexport BallisticTab_RulesPro			p_Rules;
var() editconst noexport BallisticTab_PreferencesPro	p_Options;
var() editconst noexport BallisticTab_BloodPro			p_Blood;
var() editconst noexport BallisticTab_SwappingsPro		p_Swap;
var() editconst noexport BallisticTab_OutfittingPro		p_Loadout;
var() editconst noexport BallisticTab_Crosshairs		p_Cross;
var() editconst noexport BallisticTab_LoadoutPro		p_LoadoutNew;
var() editconst noexport BallisticTab_ProSettings 		p_ProSettings;


var() localized string 	HeaderCaption;
var() localized string	RulesTabLabel,RulesTabHint, OptionsTabLabel,OptionsTabHint, BloodTabLabel,BloodTabHint, SwapTabLabel,SwapTabHint,LoadoutTabLabel,LoadoutTabHint,CrossTabLabel,CrossTabHint,LoadoutNewTabLabel,LoadoutNewTabHint,ProSettingsTabLabel,ProSettingsTabHint;
var()		  string	DetailSettings[9];

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.Initcomponent(MyController, MyOwner);

	MyHeader.DockedTabs = c_Tabs;
	p_Rules		 = BallisticTab_RulesPro(c_Tabs.AddTab(RulesTabLabel,"BallisticProV55.BallisticTab_RulesPro",,RulesTabHint));
	p_ProSettings	= BallisticTab_ProSettings(c_Tabs.AddTab(ProSettingsTabLabel,"BallisticProV55.BallisticTab_ProSettings",,ProSettingsTabHint));
	p_Options	 = BallisticTab_PreferencesPro(c_Tabs.AddTab(OptionsTabLabel,"BallisticProV55.BallisticTab_PreferencesPro",,OptionsTabHint));
	p_Blood		 = BallisticTab_BloodPro(c_Tabs.AddTab(BloodTabLabel,"BallisticProV55.BallisticTab_BloodPro",,BloodTabHint));
	p_Swap		 = BallisticTab_SwappingsPro(c_Tabs.AddTab(SwapTabLabel,"BallisticProV55.BallisticTab_SwappingsPro",,SwapTabHint));
	p_Loadout	 = BallisticTab_OutfittingPro(c_Tabs.AddTab(LoadoutTabLabel,"BallisticProV55.BallisticTab_OutfittingPro",,LoadoutTabHint));
	p_Cross		 = BallisticTab_Crosshairs(c_Tabs.AddTab(CrossTabLabel,"BallisticProV55.BallisticTab_Crosshairs",,CrossTabHint));
	p_LoadoutNew = BallisticTab_LoadoutPro(c_Tabs.AddTab(LoadoutNewTabLabel,"BallisticProV55.BallisticTab_LoadoutPro",,LoadoutNewTabHint));
}

function InternalOnChange(GUIComponent Sender)
{
    if (GUITabButton(Sender)==none)
        return;

    MyHeader.SetCaption(HeaderCaption@"|"@GUITabButton(Sender).Caption);
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(BDone);
	else if (Key == 0x1B && State == 3)	// Escape
		return InternalOnClick(BCancel);

	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==BCancel) // CANCEL
		Controller.CloseMenu();
	else if (Sender==BPurge) // ???
	{
		PurgeSettings();
		LoadSettings();
	}
	else if (Sender==BDone) // DONE
	{
		SaveSettings();
		Controller.CloseMenu();
	}
	else if (Sender==BReset) // RESET
	{
		switch (c_Tabs.ActiveTab.MyPanel)
		{
			 case p_Rules:		p_Rules.LoadSettings(); break;
			 case p_Options:	p_Options.LoadSettings(); break;
			 case p_Blood:		p_Blood.LoadSettings(); break;
			 case p_Swap:		p_Swap.LoadSettings(); break;
			 case p_Loadout:	p_Loadout.LoadSettings(); break;
			 case p_LoadoutNew:	p_LoadoutNew.LoadSettings(); break;
			 case p_Cross:		p_Cross.LoadSettings(); break;
			 case p_ProSettings:   p_ProSettings.LoadSettings(); break;
		}

	}
	else if (Sender==BDefault) // DEFAULTS
	{
		switch (c_Tabs.ActiveTab.MyPanel)
		{
			 case p_Rules:		p_Rules.DefaultSettings(); break;
			 case p_Options:	p_Options.DefaultSettings(); break;
			 case p_Blood:		p_Blood.DefaultSettings(); break;
			 case p_Swap:		p_Swap.DefaultSettings(); break;
			 case p_Loadout:	p_Loadout.DefaultSettings(); break;
			 case p_LoadoutNew:	p_LoadoutNew.DefaultSettings(); break;
			 case p_Cross:		p_Cross.DefaultSettings(); break;
			 case p_ProSettings:   p_ProSettings.DefaultSettings(); break;
		}
	}
	return true;
}

function PurgeSettings()
{
	local int i;
	local array<CacheManager.WeaponRecord> Recs;
	local class<BallisticWeapon> Weap;

	class'CacheManager'.static.GetWeaponList(Recs);
	for (i=0;i<Recs.Length;i++)
	{
		Weap = class<BallisticWeapon>(DynamicLoadObject(Recs[i].ClassName, class'Class'));
		if (Weap != None)
			Weap.static.StaticClearConfig();
	}
	class'BallisticWeapon'.static.StaticClearConfig();
	class'BWBloodControl'.static.StaticClearConfig();
	class'BloodManager'.static.StaticClearConfig();
	class'AD_BloodDecal'.static.StaticClearConfig();
	class'Mut_Ballistic'.static.StaticClearConfig();
	class'BallisticMod'.static.StaticClearConfig();
	class'AD_ImpactDecal'.static.StaticClearConfig();
	class'BallisticPawn'.static.StaticClearConfig();
	class'Rules_Ballistic'.static.StaticClearConfig();
}
function LoadSettings()
{
	p_Rules.LoadSettings();
	p_Options.LoadSettings();
	p_Blood.LoadSettings();
	p_Swap.LoadSettings();
	p_Loadout.LoadSettings();
	p_Cross.LoadSettings();
	p_LoadoutNew.LoadSettings();
	p_ProSettings.LoadSettings();
}

function SaveSettings()
{
	p_Rules.SaveSettings();
	p_Options.SaveSettings();
	p_Blood.SaveSettings();
	p_Swap.SaveSettings();
	p_Loadout.SaveSettings();
	p_Cross.SaveSettings();
	p_LoadoutNew.SaveSettings();
	p_ProSettings.SaveSettings();
}

function DefaultSettings()
{
	p_Rules.DefaultSettings();
	p_Options.DefaultSettings();
	p_Blood.DefaultSettings();
	p_Swap.DefaultSettings();
	p_Loadout.DefaultSettings();
	p_Cross.DefaultSettings();
	p_LoadoutNew.DefaultSettings();
	p_ProSettings.DefaultSettings();
}

final function string GetDisplayString(string ConfigString)
{
	local int i;
	for(i=0;i<9;i++)
		if (DetailSettings[i] ~= ConfigString)
			return class'UT2K4Tab_DetailSettings'.default.DetailLevels[i];
	return "";
}

final function string GetConfigString(string DisplayString)
{
	local int i;
	for(i=0;i<9;i++)
		if (class'UT2K4Tab_DetailSettings'.default.DetailLevels[i] ~= DisplayString)
			return DetailSettings[i];
	return "";
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinLeft=0.100000
         WinWidth=0.800000
         WinHeight=1.000000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.BallisticConfigMenuPro.BackImage'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="OK"
         Hint="Save settings and exit menu."
         WinTop=0.900000
         WinLeft=0.200000
         WinWidth=0.100000
         TabOrder=0
         OnClick=BallisticConfigMenuPro.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.BallisticConfigMenuPro.DoneButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         Hint="Exit menu without saving."
         WinTop=0.900000
         WinLeft=0.700000
         WinWidth=0.100000
         TabOrder=1
         OnClick=BallisticConfigMenuPro.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bCancel=GUIButton'BallisticProV55.BallisticConfigMenuPro.CancelButton'

     Begin Object Class=GUIButton Name=BResetButton
         Caption="RESET"
         Hint="Undo all changes."
         WinTop=0.900000
         WinLeft=0.375000
         WinWidth=0.100000
         TabOrder=1
         OnClick=BallisticConfigMenuPro.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bReset=GUIButton'BallisticProV55.BallisticConfigMenuPro.BResetButton'

     Begin Object Class=GUIButton Name=BDefaultButton
         Caption="DEFAULTS"
         Hint="Load default settings."
         WinTop=0.900000
         WinLeft=0.525000
         WinWidth=0.100000
         TabOrder=1
         OnClick=BallisticConfigMenuPro.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bDefault=GUIButton'BallisticProV55.BallisticConfigMenuPro.BDefaultButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Ballistic Settings"
         FontScale=FNS_Medium
         WinLeft=0.100000
         WinWidth=0.800000
         WinHeight=1.000000
     End Object
     MyHeader=GUIHeader'BallisticProV55.BallisticConfigMenuPro.DaBeegHeader'

     Begin Object Class=GUITabControl Name=PageTabs
         bDockPanels=True
         TabHeight=0.040000
         BackgroundStyleName="TabBackground"
         WinLeft=0.110000
         WinWidth=0.780000
         WinHeight=0.040000
         RenderWeight=0.490000
         TabOrder=3
         bAcceptsInput=True
         OnActivate=PageTabs.InternalOnActivate
         OnChange=BallisticConfigMenuPro.InternalOnChange
     End Object
     c_Tabs=GUITabControl'BallisticProV55.BallisticConfigMenuPro.PageTabs'

     HeaderCaption="Ballistic Settings"
     RulesTabLabel="Game Rules"
     RulesTabHint="Adjust rules and settings that affect the behaviour of the game."
     OptionsTabLabel="Preferences"
     OptionsTabHint="Configure your own personal preferences."
     BloodTabLabel="Blood"
     BloodTabHint="Configure Ballistic blood and gore settings."
     SwapTabLabel="Swapping"
     SwapTabHint="Adjust how and which weapons are spawned by the 'Ballistic Weapons' mutator."
     CrossTabLabel="Crosshairs"
     CrossTabHint="Configure the Ballistic crosshair styles, colours, sizes, etc"
	 LoadoutTabLabel="Loadout"
     LoadoutTabHint="Change how and which weapons are used by the 'Ballistic Loadout' mutator."
     LoadoutNewTabLabel="Evolution Loadout"
     LoadoutNewTabHint="Adjust the loadout and requirement settings for the 'Ballistic Evolution Loadout' mutator."
     ProSettingsTabLabel="Additional Game Rules"
     ProSettingsTabHint="BallisticPro specific game settings, affecting walk and crouch speed."
	 DetailSettings(0)="UltraLow"
     DetailSettings(1)="VeryLow"
     DetailSettings(2)="Low"
     DetailSettings(3)="Lower"
     DetailSettings(4)="Normal"
     DetailSettings(5)="Higher"
     DetailSettings(6)="High"
     DetailSettings(7)="VeryHigh"
     DetailSettings(8)="UltraHigh"
     bRenderWorld=True
     bAllowedAsLast=True
     OnKeyEvent=BallisticConfigMenuPro.InternalOnKeyEvent
}
