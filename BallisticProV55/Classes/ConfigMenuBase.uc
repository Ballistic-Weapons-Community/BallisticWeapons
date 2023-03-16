//=============================================================================
// ConfigMenuBase
//
// Base class of configuration menus for BW.
//
// by DarkCarnivour and Azarael
//=============================================================================
class ConfigMenuBase extends UT2K4GUIPage;

var class<BC_GameStyle>		ConfiguredStyle;

var automated GUIImage		MyBack;
var automated GUIButton		BDone, BCancel, BReset, BDefault, BPurge;
var automated GUIHeader		MyHeader;
var automated GUITabControl	c_Tabs;

var() localized string		HeaderCaption;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

	MyHeader.DockedTabs = c_Tabs;

	AddTabs();
}

function AddTabs();

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
	local int i;

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
		ConfigTabBase(c_Tabs.ActiveTab.MyPanel).LoadSettings();
	}
	
	else if (Sender==BDefault) // DEFAULTS
	{
		ConfigTabBase(c_Tabs.ActiveTab.MyPanel).DefaultSettings();
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

function class<BC_GameStyle> GetGameStyle()
{
	return ConfiguredStyle;
}

function class<BC_GameStyle_Config> GetConfigStyle()
{
	return class<BC_GameStyle_Config>(ConfiguredStyle);
}

function LoadSettings()
{
	local int i;

	for (i = 0; i < c_Tabs.TabStack.Length; ++i)
	{
		ConfigTabBase(c_Tabs.TabStack[i].MyPanel).LoadSettings();
	}
}

function SaveSettings()
{
	local int i;

	for (i = 0; i < c_Tabs.TabStack.Length; ++i)
	{
		ConfigTabBase(c_Tabs.TabStack[i].MyPanel).SaveSettings();
	}
}

function DefaultSettings()
{
	local int i;

	for (i = 0; i < c_Tabs.TabStack.Length; ++i)
	{
		ConfigTabBase(c_Tabs.TabStack[i].MyPanel).DefaultSettings();
	}
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
     MyBack=GUIImage'BallisticProV55.ConfigMenuBase.BackImage'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="OK"
         Hint="Save settings and exit menu."
         WinTop=0.900000
         WinLeft=0.200000
         WinWidth=0.100000
         TabOrder=0
         OnClick=ConfigMenuBase.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.ConfigMenuBase.DoneButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         Hint="Exit menu without saving."
         WinTop=0.900000
         WinLeft=0.700000
         WinWidth=0.100000
         TabOrder=1
         OnClick=ConfigMenuBase.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bCancel=GUIButton'BallisticProV55.ConfigMenuBase.CancelButton'

     Begin Object Class=GUIButton Name=BResetButton
         Caption="RESET"
         Hint="Undo all changes."
         WinTop=0.900000
         WinLeft=0.375000
         WinWidth=0.100000
         TabOrder=1
         OnClick=ConfigMenuBase.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bReset=GUIButton'BallisticProV55.ConfigMenuBase.BResetButton'

     Begin Object Class=GUIButton Name=BDefaultButton
         Caption="DEFAULTS"
         Hint="Load default settings."
         WinTop=0.900000
         WinLeft=0.525000
         WinWidth=0.100000
         TabOrder=1
         OnClick=ConfigMenuBase.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bDefault=GUIButton'BallisticProV55.ConfigMenuBase.BDefaultButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Ballistic Settings"
         FontScale=FNS_Medium
         WinLeft=0.100000
         WinWidth=0.800000
         WinHeight=1.000000
     End Object
     MyHeader=GUIHeader'BallisticProV55.ConfigMenuBase.DaBeegHeader'

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
         OnChange=ConfigMenuBase.InternalOnChange
     End Object
     c_Tabs=GUITabControl'BallisticProV55.ConfigMenuBase.PageTabs'

     //WIP
	 HeaderCaption="Ballistic Settings"

     bRenderWorld=True
     bAllowedAsLast=True
     OnKeyEvent=ConfigMenuBase.InternalOnKeyEvent
}
