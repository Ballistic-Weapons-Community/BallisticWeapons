//=============================================================================
// ConfigTab_ConflictLoadout
//
// The weapons each team can buy in Conflict (the Inventory mode), in the
// shared weapon chooser. A switch picks the team shown; 'Both teams use the
// same weapons' edits one list for both.
//
// Edit By OJMoody
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_ConflictLoadout extends ConfigTabBase;

var automated BC_WeaponListEditor	Editor;			// every weapon and item, and the shown team's
var automated GUILabel				l_Team;			// "Weapons for:"
var automated moCheckBox			ch_SameTeams;	// both teams use the same weapons
var automated moComboBox			co_LoadOpt;		// Loadout Options
var BC_TabRow						TeamRow;		// Red team / Blue team

var array<string>					RedNames, BlueNames;
var int								ShownTeam;		// 0 red, 1 blue
var bool							bLoading;

var() localized string Headings[2];
var() localized string TeamCaptions[2], TeamListCaptions[2], BothListCaption;

// The lists are filled when the tab is first shown. Going through every weapon of the game is too much for opening the menu.
function InitializeConfigTab()
{
	local array<CacheManager.WeaponRecord> Recs;
	local array<string> ItemNameList, Captions;
	local class<ConflictItem> CI;
	local class<BC_GameStyle> game_style;
	local WeaponList_ConflictLoadout ConfigList;
	local int i;

	game_style = BaseMenu.GetGameStyle();
	if (game_style == None)
	{
		Log("ConfigTab_ConflictLoadout: Couldn't load: No compatible style found");
		return;
	}
	ConfigList = new(None, game_style.default.StyleName) class'WeaponList_ConflictLoadout';

	// Ballistic weapons, then the Conflict items
	Editor.ClearCatalogue();
	Editor.AddSection(Headings[0]);
	class'CacheManager'.static.GetWeaponList(Recs);
	class'BC_WeaponInfoCache'.static.SortWeaponRecords(Recs);
	for (i = 0; i < Recs.Length; i++)
		if (Recs[i].ClassName != "" && class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName)
			&& class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			Editor.AddWeapon(Recs[i].FriendlyName, Recs[i].ClassName);
	class'BC_WeaponInfoCache'.static.EndSession();

	Editor.AddSection(Headings[1]);
	PlayerOwner().GetAllInt("ConflictItem", ItemNameList);
	for (i = 0; i < ItemNameList.length; i++)
	{
		CI = class<ConflictItem>(DynamicLoadObject(ItemNameList[i], class'Class'));
		if (CI != None)
			Editor.AddWeapon(CI.default.ItemName, ItemNameList[i]);
	}
	Editor.OnChosenChanged = ChosenChanged;

	Captions[0] = TeamCaptions[0];
	Captions[1] = TeamCaptions[1];
	TeamRow = class'BC_TabRow'.static.Create(self, Editor, 0.200000, 0.035000, 0.300000, 0.050000, Captions);
	TeamRow.OnSwitch = TeamSwitched;

	for (i = 0; i < class'Mut_ConflictLoadout'.default.LoadoutOptionText.Length; i++)
		co_LoadOpt.AddItem(class'Mut_ConflictLoadout'.default.LoadoutOptionText[i],, string(i));
	co_LoadOpt.ReadOnly(True);

	UseList(ConfigList.ConflictWeapons, ConfigList.LoadoutOption);
}

//==================================================================
// Teams
//==================================================================
static function bool SameNames(array<string> A, array<string> B)
{
	local int i, j;

	if (A.Length != B.Length)
		return false;
	for (i = 0; i < A.Length; i++)
	{
		for (j = 0; j < B.Length; j++)
			if (A[i] ~= B[j])
				break;
		if (j >= B.Length)
			return false;
	}
	return true;
}

function ShowTeam()
{
	if (ch_SameTeams.IsChecked())
	{
		Editor.ChosenCaption = BothListCaption;
		Editor.SetChosen(RedNames);
	}
	else
	{
		Editor.ChosenCaption = TeamListCaptions[ShownTeam];
		if (ShownTeam == 0)
			Editor.SetChosen(RedNames);
		else
			Editor.SetChosen(BlueNames);
	}
	TeamRow.SetEnabled(!ch_SameTeams.IsChecked());
}

function ChosenChanged(BC_WeaponListEditor Sender)
{
	local array<string> Names;

	Editor.GetChosen(Names);
	if (ch_SameTeams.IsChecked())
	{
		RedNames = Names;
		BlueNames = Names;
	}
	else if (ShownTeam == 0)
		RedNames = Names;
	else
		BlueNames = Names;
}

function TeamSwitched(BC_TabRow Sender, int Index)
{
	ShownTeam = Index;
	ShowTeam();
}

// Ticked: both teams get the list shown now
function InternalOnChange(GUIComponent Sender)
{
	if (Sender != ch_SameTeams || bLoading || TeamRow == None)
		return;
	if (ch_SameTeams.IsChecked())
	{
		if (ShownTeam == 0)
			BlueNames = RedNames;
		else
			RedNames = BlueNames;
	}
	ShowTeam();
}

//==================================================================
// Settings & Defaults
//==================================================================

// Fills the red and blue lists from a weapon list
function UseList(array<WeaponList_ConflictLoadout.Entry> Weapons, byte Option)
{
	local int i;

	RedNames.Length = 0;
	BlueNames.Length = 0;
	for (i = 0; i < Weapons.Length; i++)
	{
		if (Weapons[i].bRed)
			RedNames[RedNames.Length] = Weapons[i].ClassName;
		if (Weapons[i].bBlue)
			BlueNames[BlueNames.Length] = Weapons[i].ClassName;
	}

	bLoading = true;
	ch_SameTeams.Checked(SameNames(RedNames, BlueNames));
	bLoading = false;
	ShownTeam = 0;
	TeamRow.Select(0);
	ShowTeam();
	co_LoadOpt.SetIndex(Option);
}

// RESET: back to the saved list. The first time through, InitializeConfigTab has just filled the lists.
function LoadSettings()
{
	local class<BC_GameStyle> game_style;
	local WeaponList_ConflictLoadout ConfigList;

	if (!bInitialized)
		return;
	game_style = BaseMenu.GetGameStyle();
	if (game_style == None)
		return;
	ConfigList = new(None, game_style.default.StyleName) class'WeaponList_ConflictLoadout';
	UseList(ConfigList.ConflictWeapons, ConfigList.LoadoutOption);
}

// DEFAULTS: the list the mod came with
function DefaultSettings()
{
	if (BaseMenu.GetGameStyle() == None || TeamRow == None)
		return;
	UseList(class'WeaponList_ConflictLoadout'.default.ConflictWeapons, class'WeaponList_ConflictLoadout'.default.LoadoutOption);
}

function SaveSettings()
{
	local int i, k;
	local class<BC_GameStyle> game_style;
	local WeaponList_ConflictLoadout ConfigList;
	local string S;

	// A tab that was never shown has empty lists, and saving those would empty the weapon list
	if (!bInitialized)
		return;

	game_style = BaseMenu.GetGameStyle();
	if (game_style == None)
	{
		Log("ConfigTab_ConflictLoadout: Couldn't save: No compatible style found");
		return;
	}

	ConfigList = new(None, game_style.default.StyleName) class'WeaponList_ConflictLoadout';
	ConfigList.LoadoutOption = co_LoadOpt.GetIndex();
	ConfigList.ConflictWeapons.length = 0;

	// every weapon and item, with the teams that have it
	for (i = 0; i < Editor.Catalogue.Length; i++)
	{
		if (Editor.Catalogue[i].bSection)
			continue;
		S = Editor.Catalogue[i].ClassName;
		k = ConfigList.ConflictWeapons.length;
		ConfigList.ConflictWeapons.length = k + 1;
		ConfigList.ConflictWeapons[k].ClassName = S;
		ConfigList.ConflictWeapons[k].bRed = HasName(RedNames, S);
		ConfigList.ConflictWeapons[k].bBlue = HasName(BlueNames, S);
	}

	ConfigList.SaveConfig();
	SaveConfig();
}

static function bool HasName(array<string> Names, string S)
{
	local int i;

	for (i = 0; i < Names.Length; i++)
		if (Names[i] ~= S)
			return true;
	return false;
}

defaultproperties
{
	Begin Object Class=GUILabel Name=TeamLabel
		Caption="Weapons for:"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.035000
		WinLeft=0.050000
		WinWidth=0.150000
		WinHeight=0.050000
	End Object
	l_Team=GUILabel'BallisticProV55.ConfigTab_ConflictLoadout.TeamLabel'

	Begin Object Class=moCheckBox Name=SameTeamsCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Both teams use the same weapons"
		OnCreateComponent=SameTeamsCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="One list for both teams. Untick to give the teams different weapons."
		WinTop=0.040000
		WinLeft=0.540000
		WinWidth=0.410000
		WinHeight=0.040000
		OnChange=ConfigTab_ConflictLoadout.InternalOnChange
	End Object
	ch_SameTeams=moCheckBox'BallisticProV55.ConfigTab_ConflictLoadout.SameTeamsCheck'

	Begin Object Class=BC_WeaponListEditor Name=WeaponEditor
		WinTop=0.110000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.693563
		TabOrder=0
	End Object
	Editor=BC_WeaponListEditor'BallisticProV55.ConfigTab_ConflictLoadout.WeaponEditor'

	Begin Object Class=moComboBox Name=LoadOptCombo
		Caption="Loadout Option"
		OnCreateComponent=LoadOptCombo.InternalOnCreateComponent
		IniOption="@Internal"
		IniDefault="High"
		Hint="Choose the type of loadout."
		WinTop=0.825000
		WinLeft=0.275000
		WinWidth=0.450000
		WinHeight=0.040000
	End Object
	co_LoadOpt=moComboBox'BallisticProV55.ConfigTab_ConflictLoadout.LoadOptCombo'

	Headings(0)="Ballistic Weapons"
	Headings(1)="Items"
	TeamCaptions(0)="Red team"
	TeamCaptions(1)="Blue team"
	TeamListCaptions(0)="Red team's weapons"
	TeamListCaptions(1)="Blue team's weapons"
	BothListCaption="Both teams' weapons"
}
