//=============================================================================
// BallisticTeamOutfittingMenu.
//
// Menu for selecting weapon loadout. Consists of several categories, user can
// pick what weapon they want for each category (e.g. melee, sidearm, grenade)
//
// by Nolan "Dark Carnivour" Richert.
// Modified by Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTeamOutfittingMenu extends UT2K4GUIPage config(BallisticProV55);

var Automated GUIImage MyBack;
var Automated GUIButton BDone, BCancel;
var automated GUIHeader MyHeader;
var automated GUITabControl c_Tabs;

var() editconst noexport BallisticTeamOutfittingWeaponsTab p_Weapons;
var() editconst noexport BallisticTeamOutfittingKillstreaksTab p_Killstreaks;

var() localized string HeaderCaption;
var() localized string WeaponsTabLabel, WeaponsTabHint, KillstreaksTabLabel, KillstreaksTabHint;

var ClientTeamOutfittingInterface COI;	// The ClientOutfittingInterface actor we can use to communicate with the mutator

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.Initcomponent(MyController, MyOwner);

	MyHeader.DockedTabs = c_Tabs;
	p_Weapons = BallisticTeamOutfittingWeaponsTab(c_Tabs.AddTab(WeaponsTabLabel, "BallisticProV55.BallisticTeamOutfittingWeaponsTab",,WeaponsTabHint));
	p_Killstreaks = BallisticTeamOutfittingKillstreaksTab(c_Tabs.AddTab(KillstreaksTabLabel, "BallisticProV55.BallisticTeamOutfittingKillstreaksTab",,KillstreaksTabHint));
}

function SetupCOI(ClientTeamOutfittingInterface newCOI)
{
	COI = newCOI;
	p_Weapons.COI = COI;
	p_Killstreaks.COI = COI;
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
	else if (Sender==BDone) // DONE
	{
		SaveSettings();
		COI.LoadoutChanged(class'Mut_TeamOutfitting'.default.LoadOut, class'Mut_TeamOutfitting'.default.Killstreaks);
		Controller.CloseMenu();
	}
	return true;
}

function SaveSettings()
{
	p_Weapons.SaveWeapons();
	p_Killstreaks.SaveStreaks();
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinTop=0.200000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.600000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.BackImage'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.700000
         WinLeft=0.200000
         WinWidth=0.200000
         TabOrder=0
         OnClick=BallisticTeamOutfittingMenu.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.BallisticTeamOutfittingMenu.DoneButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         WinTop=0.700000
         WinLeft=0.600000
         WinWidth=0.200000
         TabOrder=1
         OnClick=BallisticTeamOutfittingMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bCancel=GUIButton'BallisticProV55.BallisticTeamOutfittingMenu.CancelButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Select your equipment"
         WinTop=0.200000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.700000
     End Object
     MyHeader=GUIHeader'BallisticProV55.BallisticTeamOutfittingMenu.DaBeegHeader'

     Begin Object Class=GUITabControl Name=PageTabs
         bDockPanels=True
         TabHeight=0.040000
         BackgroundStyleName="TabBackground"
         WinTop=0.200000
         WinLeft=0.110000
         WinWidth=0.780000
         WinHeight=0.040000
         RenderWeight=0.490000
         TabOrder=3
         bAcceptsInput=True
         OnActivate=PageTabs.InternalOnActivate
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
     End Object
     c_Tabs=GUITabControl'BallisticProV55.BallisticTeamOutfittingMenu.PageTabs'

     HeaderCaption="Loadout"
     WeaponsTabLabel="Weapons"
     WeaponsTabHint="Select your default weapons."
     KillstreaksTabLabel="Killstreaks"
     KillstreaksTabHint="Select your killstreak weapons."
     bRenderWorld=True
     bAllowedAsLast=True
     OnKeyEvent=BallisticTeamOutfittingMenu.InternalOnKeyEvent
}
