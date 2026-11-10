//=============================================================================
// ConfigTab_WeaponLists
//
// One tab for the weapon lists of the inventory modes: Inventory (Conflict),
// Loadout, Evolution Loadout, Pickup Swaps and Arena, as tabs of their own
// inside it. It opens on the list of the inventory mode the Game tab has set,
// marked "(in use)". OK saves every list; RESET and DEFAULTS act on the list
// shown.
//=============================================================================
class ConfigTab_WeaponLists extends ConfigTabBase;

var automated GUITabControl		c_Lists;

var() localized string			ListLabels[5], ListHints[5], InUseText;
var() string					ListClasses[5];
var bool						bOpened;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;

	Super.InitComponent(MyController, MyOwner);

	// hidden until this tab is shown: AddTab would show (and load) the first list at once
	c_Lists.SetVisibility(false);
	for (i = 0; i < 5; i++)
		c_Lists.AddTab(ListLabels[i], ListClasses[i],, ListHints[i]);
}

// The mode the Game tab has set (not saved yet maybe), -1 for one without a list (Melee)
function int InUseIndex()
{
	local int i;
	local ConfigTab_GameRules GameTab;

	if (BaseMenu == None)
		return -1;
	for (i = 0; i < BaseMenu.c_Tabs.TabStack.Length; i++)
	{
		GameTab = ConfigTab_GameRules(BaseMenu.c_Tabs.TabStack[i].MyPanel);
		if (GameTab != None && GameTab.co_InventoryMode.ItemCount() > 0)
			return ListOfMode(GameTab.co_InventoryMode.GetIndex());
	}
	if (BaseMenu.GetGameStyle() != None)
		return ListOfMode(BaseMenu.GetGameStyle().default.InventoryModeIndex);
	return -1;
}

// Inventory modes: 0 Inventory (Conflict), 1 Loadout, 2 Evolution, 3 Pickups, 4 Arena, 5 Melee
function int ListOfMode(int Mode)
{
	if (Mode >= 0 && Mode < 5)
		return Mode;
	return -1;
}

function ShowPanel(bool bShow)
{
	local int i, InUse;

	Super.ShowPanel(bShow);
	if (!bShow)
		return;

	InUse = InUseIndex();
	for (i = 0; i < c_Lists.TabStack.Length && i < 5; i++)
	{
		if (i == InUse)
			c_Lists.TabStack[i].Caption = ListLabels[i] @ InUseText;
		else
			c_Lists.TabStack[i].Caption = ListLabels[i];
	}

	// first shown: the list in use (the first one for a mode without a list)
	if (!bOpened)
	{
		bOpened = true;
		c_Lists.SetVisibility(true);
		if (InUse < 0 || InUse >= c_Lists.TabStack.Length)
			InUse = 0;
		if (c_Lists.TabStack.Length > 0)
			c_Lists.ActivateTab(c_Lists.TabStack[InUse], true);
	}
}

function ConfigTabBase ListTab(int i)
{
	if (i < 0 || i >= c_Lists.TabStack.Length)
		return None;
	return ConfigTabBase(c_Lists.TabStack[i].MyPanel);
}

function ConfigTabBase ShownList()
{
	if (c_Lists.ActiveTab == None)
		return None;
	return ConfigTabBase(c_Lists.ActiveTab.MyPanel);
}

//==================================================================
// Settings & Defaults
//==================================================================

// RESET: the list shown (a list is loaded by itself when first shown)
function LoadSettings()
{
	if (bInitialized && ShownList() != None)
		ShownList().LoadSettings();
}

function DefaultSettings()
{
	if (ShownList() != None)
		ShownList().DefaultSettings();
}

// OK: every list (one never shown saves nothing)
function SaveSettings()
{
	local int i;

	for (i = 0; i < c_Lists.TabStack.Length; i++)
		if (ListTab(i) != None)
			ListTab(i).SaveSettings();
}

defaultproperties
{
	Begin Object Class=GUITabControl Name=ListTabs
		bDockPanels=True
		TabHeight=0.045000
		BackgroundStyleName="TabBackground"
		WinTop=0.005000
		WinLeft=0.020000
		WinWidth=0.960000
		WinHeight=0.055024
		RenderWeight=0.490000
		bAcceptsInput=True
		OnActivate=ListTabs.InternalOnActivate
	End Object
	c_Lists=GUITabControl'BallisticProV55.ConfigTab_WeaponLists.ListTabs'

	ListLabels(0)="Inventory"
	ListLabels(1)="Loadout"
	ListLabels(2)="Evolution"
	ListLabels(3)="Pickup Swaps"
	ListLabels(4)="Arena"
	ListHints(0)="The weapons each team can buy in the Inventory (Conflict) mode."
	ListHints(1)="The weapons of each slot of the Loadout mode."
	ListHints(2)="The weapons of each slot of the Evolution Loadout mode, and what unlocks them."
	ListHints(3)="The Ballistic weapons that replace the original pickups in the Pickups mode."
	ListHints(4)="The weapons of the Arena mode."
	ListClasses(0)="BallisticProV55.ConfigTab_ConflictLoadout"
	ListClasses(1)="BallisticProV55.ConfigTab_Outfitting"
	ListClasses(2)="BallisticProV55.ConfigTab_Loadout"
	ListClasses(3)="BallisticProV55.ConfigTab_Swappings"
	ListClasses(4)="BallisticProV55.ConfigTab_Arena"
	InUseText="(in use)"
}
