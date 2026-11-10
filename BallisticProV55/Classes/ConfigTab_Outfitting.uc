//=============================================================================
// ConfigTab_Outfitting.
//
// The Loadout mutator's weapons: one list per loadout slot (Melee, Sidearm,
// Primary, Secondary, Grenade, the two killstreak rewards), for free-for-all
// games and for each team of team games (Team Loadout), in the shared weapon
// chooser. Slot tabs pick the slot, a switch picks the team; 'Teams use the
// free-for-all weapons' edits one set of lists for everyone.
//
// Azarael edits:
// This tab also sets up Team Outfitting.
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_Outfitting extends ConfigTabBase config(BallisticProV55);

const NUM_BOXES=7;
const STREAK_BOX=5;		// first of the two killstreak boxes
const NUM_BOXES_TOTAL=21;

var config bool							bUseAllWeapons;

var automated GUIImage					Box_WeapIcon, Pic_Weapon;
var automated GUILabel					l_WeapTitle, l_Team;
var automated BC_WeaponListEditor		Editor;
var automated GUIScrollTextBox			lb_Desc;
var automated moCheckbox				ch_AllWeaps, ch_SameTeams;
var automated moFloatEdit				fl_ChangeInterval;
var BC_TabRow							SlotRow, TeamRow;

struct LoadOutBox
{
	var array<string>	WeaponNames;
};

var LoadoutBox				Boxes[NUM_BOXES_TOTAL]; //DM, and the two teams
var localized string		BoxNames[NUM_BOXES];
var int						SelectedBox;		// the slot shown
var int						SelectedTeam;		// 0 free-for-all, 1 red, 2 blue
var bool					bLoading;
var() localized string 		Headings[12];
var() localized string		TeamCaptions[3], ChosenCaptionFormat, ChosenCaptionTeamFormat;

struct LOWeapInfo
{
	var string		ClassName;
	var string		Description;
	var Material	Icon;
	var IntBox		IconCoords;
};
var   array<LOWeapInfo> 	WeaponInfo;

function InitializeConfigTab()
{
	local array<string> Captions;
	local int i;

	ch_AllWeaps.Checked(bUseAllWeapons);
	fl_ChangeInterval.SetValue(class'ClientOutfittingInterface'.default.ChangeInterval);

	for (i = 0; i < NUM_BOXES; i++)
		Captions[i] = BoxNames[i];
	SlotRow = class'BC_TabRow'.static.Create(self, Editor, 0.020000, 0.015000, 0.960000, 0.050000, Captions);
	SlotRow.OnSwitch = SlotSwitched;

	Captions.Length = 3;
	for (i = 0; i < 3; i++)
		Captions[i] = TeamCaptions[i];
	TeamRow = class'BC_TabRow'.static.Create(self, Editor, 0.170000, 0.080000, 0.420000, 0.045000, Captions);
	TeamRow.OnSwitch = TeamSwitched;

	Editor.OnChosenChanged = ChosenChanged;
	Editor.OnWeaponSelected = WeaponSelected;

	LoadList();
	LoadBoxesFromMutator();
	SetSameTeamsFromBoxes();

	// back on the slot and team last edited
	SelectedBox = Clamp(class'BC_MenuMemory'.default.LoadoutSlot, 0, NUM_BOXES - 1);
	SelectedTeam = Clamp(class'BC_MenuMemory'.default.LoadoutTeam, 0, 2);
	SlotRow.Select(SelectedBox);
	ShowBox();
}

//===========================================================================
// LoadList
//
// The weapons that can go in a slot, by weapon kind, from the weapon cache
// (no classes loaded). Ballistic weapons only, unless Use All Weapons.
//===========================================================================
function LoadList()
{
	local int i, j, h;
	local array<CacheManager.WeaponRecord> Recs;
	local array<int> Heading;
	local string s;
	local BC_WeaponInfoCache.WeaponInfo WI;

	WeaponInfo.length = 0;

	class'CacheManager'.static.GetWeaponList(Recs);
	class'BC_WeaponInfoCache'.static.SortWeaponRecords(Recs);
	Heading.Length = Recs.Length;
	for (i=0;i<Recs.Length;i++)
	{
		Heading[i] = -1;
		j = InStr(Recs[i].ClassName, ".");

		if (j != -1)
		{
			s = Left(Recs[i].ClassName, j);

			if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
				continue;

			if (!bUseAllWeapons)
			{
				if (InStr(s,"Ballistic")==-1 && InStr(s,"BWBP")==-1 && InStr(s,"JunkWar")==-1 && InStr(s,"JWBP")==-1)
					continue;
			}
		}

		// Use the BW weapon cache system to get the info needed without loading the classes (huge optimization)
		WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName, j);
		if (j == -1 || WI.ClassName == "")
			continue;

		j = WeaponInfo.length;
		WeaponInfo.length = j+1;
		WeaponInfo[j].Description = Recs[i].Description;
		WeaponInfo[j].ClassName = Recs[i].ClassName;
		if (WI.bIsBW)
		{
			WeaponInfo[j].Icon = WI.BigIconMaterial;
			WeaponInfo[j].IconCoords.X1 = -1;
			WeaponInfo[j].IconCoords.X2 = -1;
			WeaponInfo[j].IconCoords.Y1 = -1;
			WeaponInfo[j].IconCoords.Y2 = -1;

			if (WI.InventoryGroup > 0 && WI.InventoryGroup < 10)
				Heading[i] = WI.InventoryGroup - 1;
			else if (WI.InventoryGroup == 0)
				Heading[i] = 9;
			else
				Heading[i] = 10;
		}
		else
		{
			WeaponInfo[j].Icon = WI.SmallIconMaterial;
			WeaponInfo[j].IconCoords = WI.SmallIconCoords;
			if (bUseAllWeapons)
				Heading[i] = 11;
		}
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	Editor.ClearCatalogue();
	for (h = 0; h < 12; h++)
	{
		Editor.AddSection(Headings[h]);
		for (i = 0; i < Recs.Length; i++)
			if (Heading[i] == h)
				Editor.AddWeapon(Recs[i].FriendlyName, Recs[i].ClassName);
	}
}

//===========================================================================
// LoadBoxesFromMutator
//
// Copies over the loadout groups from the Loadout muts and purges anything from them which isn't
// in the WeaponInfo list (couldn't be loaded in cache.)
//===========================================================================
function LoadBoxesFromMutator ()
{
	local int i, j, k;
	local class<BC_GameStyle> game_style;
	local WeaponList_Killstreak KillstreakList;

	game_style = BaseMenu.GetGameStyle();

	if (game_style == None)
	{
		Log("ConfigTab_Outfitting: Couldn't load - No compatible style found");
		return;
	}

	KillstreakList = new(None, game_style.default.StyleName) class'WeaponList_Killstreak';
	
	//DM
	Boxes[0].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup0;
	Boxes[1].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup1;
	Boxes[2].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup2;
	Boxes[3].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup3;
	Boxes[4].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup4;
	Boxes[5].WeaponNames = KillstreakList.Streak1s;
	Boxes[6].WeaponNames = KillstreakList.Streak2s;
	//Red
	Boxes[7].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup0;
	Boxes[8].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup1;
	Boxes[9].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup2;
	Boxes[10].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup3;
	Boxes[11].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup4;
	Boxes[12].WeaponNames = KillstreakList.Streak1s;
	Boxes[13].WeaponNames = KillstreakList.Streak2s;
	//Blue
	Boxes[14].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup0;
	Boxes[15].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup1;
	Boxes[16].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup2;
	Boxes[17].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup3;
	Boxes[18].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup4;
	Boxes[19].WeaponNames = KillstreakList.Streak1s;
	Boxes[20].WeaponNames = KillstreakList.Streak2s;
	
	// Get rid of things that are no longer around
	for(i=0;i<NUM_BOXES_TOTAL;i++)
		for (j=0;j<Boxes[i].WeaponNames.length;j++)
		{
			for (k=0;k<WeaponInfo.length;k++)
				if (Boxes[i].WeaponNames[j] ~= WeaponInfo[k].ClassName)
					break;
			if (k >= WeaponInfo.length)
			{
				Boxes[i].WeaponNames.Remove(j, 1);
				j--;
			}
		}

}

//===========================================================================
// Saves the weapon assignments to the mutator.
//===========================================================================
function SaveBoxesToMutator ()
{
	local int i;
	local class<BC_GameStyle> game_style;
	local WeaponList_Killstreak KillstreakList;
	
	game_style = BaseMenu.GetGameStyle();

	if (game_style == None)
	{
		Log("ConfigTab_Outfitting: Couldn't load - No compatible style found");
		return;
	}

	KillstreakList = new(None, game_style.default.StyleName) class'WeaponList_Killstreak';
	
	// An empty box must have at least one line otherwise the mutator defaults take over
	for(i=0;i<NUM_BOXES_TOTAL;i++)
		if (Boxes[i].WeaponNames.length < 1)
			Boxes[i].WeaponNames.length = 1;
	class'Mut_Outfitting'.default.LoadoutGroup0 = Boxes[0].WeaponNames;
	class'Mut_Outfitting'.default.LoadoutGroup1 = Boxes[1].WeaponNames;
	class'Mut_Outfitting'.default.LoadoutGroup2 = Boxes[2].WeaponNames;
	class'Mut_Outfitting'.default.LoadoutGroup3 = Boxes[3].WeaponNames;
	class'Mut_Outfitting'.default.LoadoutGroup4 = Boxes[4].WeaponNames;
	KillstreakList.Streak1s = Boxes[5].WeaponNames;
	KillstreakList.Streak2s = Boxes[6].WeaponNames;
	
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup0 = Boxes[7].WeaponNames;
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup1 = Boxes[8].WeaponNames;
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup2 = Boxes[9].WeaponNames;
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup3 = Boxes[10].WeaponNames;
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup4 = Boxes[11].WeaponNames;
	//class'Mut_TeamOutfitting'.default.RedLoadoutGroup5 = Boxes[12].WeaponNames;
	//class'Mut_TeamOutfitting'.default.RedLoadoutGroup6 = Boxes[13].WeaponNames;
	
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup0 = Boxes[14].WeaponNames;
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup1 = Boxes[15].WeaponNames;
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup2 = Boxes[16].WeaponNames;
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup3 = Boxes[17].WeaponNames;
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup4 = Boxes[18].WeaponNames;
	//class'Mut_TeamOutfitting'.default.BlueLoadoutGroup5 = Boxes[19].WeaponNames;
	//class'Mut_TeamOutfitting'.default.BlueLoadoutGroup6 = Boxes[20].WeaponNames;
	
	class'Mut_Outfitting'.static.StaticSaveConfig();
	class'Mut_TeamOutfitting'.static.StaticSaveConfig();
	class'Mut_Killstreak'.static.StaticSaveConfig();
	KillstreakList.SaveConfig();
}

//===========================================================================
// Slots and teams
//===========================================================================
function bool IsStreakSlot(int Slot)
{
	return Slot >= STREAK_BOX;
}

// The box shown: the killstreak slots have one list for everyone, and the teams use the free-for-all box when ticked
function int ShownBox()
{
	if (IsStreakSlot(SelectedBox) || ch_SameTeams.IsChecked())
		return SelectedBox;
	return SelectedBox + SelectedTeam * NUM_BOXES;
}

function ShowBox()
{
	local int i;

	bLoading = true;
	if (IsStreakSlot(SelectedBox) || ch_SameTeams.IsChecked())
	{
		TeamRow.Select(0);
		TeamRow.SetEnabled(false);
		Editor.ChosenCaption = Repl(ChosenCaptionFormat, "%s", BoxNames[SelectedBox]);
	}
	else
	{
		TeamRow.Select(SelectedTeam);
		TeamRow.SetEnabled(true);
		Editor.ChosenCaption = Repl(Repl(ChosenCaptionTeamFormat, "%s", BoxNames[SelectedBox]), "%t", TeamCaptions[SelectedTeam]);
	}
	if (IsStreakSlot(SelectedBox))
		ch_SameTeams.DisableMe();
	else
		ch_SameTeams.EnableMe();
	Editor.SetChosen(Boxes[ShownBox()].WeaponNames);
	bLoading = false;

	for (i = 0; i < NUM_BOXES; i++)
		UpdateSlotCaption(i);
}

// "Primary (32)": the weapons in the slot for the team shown
function UpdateSlotCaption(int Slot)
{
	local int b, i, n;

	b = Slot;
	if (!IsStreakSlot(Slot) && !ch_SameTeams.IsChecked())
		b += SelectedTeam * NUM_BOXES;
	for (i = 0; i < Boxes[b].WeaponNames.Length; i++)
		if (Boxes[b].WeaponNames[i] != "")
			n++;
	SlotRow.SetCaption(Slot, BoxNames[Slot] @ "(" $ n $ ")");
}

function ChosenChanged(BC_WeaponListEditor Sender)
{
	local array<string> Names;

	if (bLoading)
		return;
	Editor.GetChosen(Names);
	Boxes[ShownBox()].WeaponNames = Names;
	UpdateSlotCaption(SelectedBox);
}

function SlotSwitched(BC_TabRow Sender, int Index)
{
	SelectedBox = Index;
	class'BC_MenuMemory'.static.SetLoadout(SelectedBox, SelectedTeam);
	ShowBox();
}

function TeamSwitched(BC_TabRow Sender, int Index)
{
	SelectedTeam = Index;
	class'BC_MenuMemory'.static.SetLoadout(SelectedBox, SelectedTeam);
	ShowBox();
}

// Ticked when every slot's team lists are the free-for-all ones
function SetSameTeamsFromBoxes()
{
	local int i;
	local bool bSame;

	bSame = true;
	for (i = 0; i < STREAK_BOX && bSame; i++)
		bSame = class'ConfigTab_ConflictLoadout'.static.SameNames(Boxes[i].WeaponNames, Boxes[i + NUM_BOXES].WeaponNames)
			&& class'ConfigTab_ConflictLoadout'.static.SameNames(Boxes[i].WeaponNames, Boxes[i + 2 * NUM_BOXES].WeaponNames);
	bLoading = true;
	ch_SameTeams.Checked(bSame);
	bLoading = false;
}

// The teams' lists follow the free-for-all ones while ticked
function CopyFreeForAllToTeams()
{
	local int i;

	for (i = 0; i < STREAK_BOX; i++)
	{
		Boxes[i + NUM_BOXES].WeaponNames = Boxes[i].WeaponNames;
		Boxes[i + 2 * NUM_BOXES].WeaponNames = Boxes[i].WeaponNames;
	}
}

function InternalOnChange(GUIComponent Sender)
{
	if (bLoading || SlotRow == None)
		return;

	if (Sender == ch_SameTeams)
	{
		// both ways the teams start from the free-for-all lists
		CopyFreeForAllToTeams();
		if (ch_SameTeams.IsChecked())
			SelectedTeam = 0;
		ShowBox();
	}
	else if (Sender == ch_AllWeaps)
	{
		bUseAllWeapons = ch_AllWeaps.IsChecked();
		LoadList();
		ShowBox();
	}
}

//===========================================================================
// The weapon picked in either list
//===========================================================================
function WeaponSelected(BC_WeaponListEditor Sender, string ClassName)
{
	local int i;

	for (i = 0; i < WeaponInfo.Length; i++)
		if (WeaponInfo[i].ClassName ~= ClassName)
			break;
	l_WeapTitle.Caption = Editor.NameOf(ClassName);
	if (i >= WeaponInfo.Length)
	{
		Pic_Weapon.Image = None;
		lb_Desc.SetContent("");
		return;
	}
	Pic_Weapon.Image = WeaponInfo[i].Icon;
	Pic_Weapon.X1 	 = WeaponInfo[i].IconCoords.X1;
	Pic_Weapon.X2	 = WeaponInfo[i].IconCoords.X2;
	Pic_Weapon.Y1 	 = WeaponInfo[i].IconCoords.Y1;
	Pic_Weapon.Y2	 = WeaponInfo[i].IconCoords.Y2;
	lb_Desc.SetContent(WeaponInfo[i].Description);
}

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	fl_ChangeInterval.SetValue(class'ClientOutfittingInterface'.default.ChangeInterval);
	LoadBoxesFromMutator();
	SetSameTeamsFromBoxes();
	ShowBox();
}

function SaveSettings()
{
	if (!bInitialized)
		return;

	if (ch_SameTeams.IsChecked())
		CopyFreeForAllToTeams();

	class'ClientOutfittingInterface'.default.ChangeInterval = fl_ChangeInterval.GetValue();
	class'ClientOutfittingInterface'.static.StaticSaveConfig();
	// Team Outfitting is set up on this tab as well and keeps its own copy
	class'ClientTeamOutfittingInterface'.default.ChangeInterval = fl_ChangeInterval.GetValue();
	class'ClientTeamOutfittingInterface'.static.StaticSaveConfig();
	SaveBoxesToMutator();
	SaveConfig();
}

// DEFAULTS: the lists the mod comes with (LoadoutStockLists: ResetConfig would empty these globalconfig lists)
function DefaultSettings()
{
	local int i, t, j, k;

	for (t = 0; t < 3; t++)
		for (i = 0; i < STREAK_BOX; i++)
		{
			Boxes[i + t * NUM_BOXES].WeaponNames = class'LoadoutStockLists'.static.GetList(t, i);
			// what isn't there (a weapon pack that is missing) is left out, as when loading
			for (j = 0; j < Boxes[i + t * NUM_BOXES].WeaponNames.Length; j++)
			{
				for (k = 0; k < WeaponInfo.Length; k++)
					if (Boxes[i + t * NUM_BOXES].WeaponNames[j] ~= WeaponInfo[k].ClassName)
						break;
				if (k >= WeaponInfo.Length)
				{
					Boxes[i + t * NUM_BOXES].WeaponNames.Remove(j, 1);
					j--;
				}
			}
		}
	// The killstreak lists are kept per style; the class holds what they came with
	for (i=0;i<3;i++)
	{
		Boxes[STREAK_BOX + i*NUM_BOXES].WeaponNames = class'WeaponList_Killstreak'.default.Streak1s;
		Boxes[STREAK_BOX + 1 + i*NUM_BOXES].WeaponNames = class'WeaponList_Killstreak'.default.Streak2s;
	}
	SetSameTeamsFromBoxes();
	ShowBox();
	fl_ChangeInterval.SetValue(60);
}

defaultproperties
{
	Begin Object Class=GUILabel Name=TeamLabel
		Caption="Weapons for:"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.080000
		WinLeft=0.020000
		WinWidth=0.150000
		WinHeight=0.045000
	End Object
	l_Team=GUILabel'BallisticProV55.ConfigTab_Outfitting.TeamLabel'

	Begin Object Class=moCheckBox Name=SameTeamsCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Teams use the free-for-all weapons"
		OnCreateComponent=SameTeamsCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="One set of lists for every game. Untick to give the red and blue teams their own weapons in team games."
		WinTop=0.083000
		WinLeft=0.620000
		WinWidth=0.360000
		WinHeight=0.040000
		OnChange=ConfigTab_Outfitting.InternalOnChange
	End Object
	ch_SameTeams=moCheckBox'BallisticProV55.ConfigTab_Outfitting.SameTeamsCheck'

	Begin Object Class=BC_WeaponListEditor Name=WeaponEditor
		WinTop=0.140000
		WinLeft=0.020000
		WinWidth=0.960000
		WinHeight=0.540000
		TabOrder=0
	End Object
	Editor=BC_WeaponListEditor'BallisticProV55.ConfigTab_Outfitting.WeaponEditor'

	Begin Object Class=GUIImage Name=Box_WeapIconImg
		Image=Texture'2K4Menus.NewControls.Display99'
		ImageStyle=ISTY_Stretched
		WinTop=0.700000
		WinLeft=0.020000
		WinWidth=0.300000
		WinHeight=0.230000
		RenderWeight=0.002000
	End Object
	Box_WeapIcon=GUIImage'BallisticProV55.ConfigTab_Outfitting.Box_WeapIconImg'

	Begin Object Class=GUIImage Name=Pic_WeaponImg
		ImageStyle=ISTY_Justified
		WinTop=0.705000
		WinLeft=0.030000
		WinWidth=0.280000
		WinHeight=0.170000
		RenderWeight=0.003000
	End Object
	Pic_Weapon=GUIImage'BallisticProV55.ConfigTab_Outfitting.Pic_WeaponImg'

	Begin Object Class=GUILabel Name=l_WeapTitlelabel
		TextAlign=TXTA_Center
		TextColor=(B=255,G=255,R=255)
		WinTop=0.880000
		WinLeft=0.020000
		WinWidth=0.300000
		WinHeight=0.045000
	End Object
	l_WeapTitle=GUILabel'BallisticProV55.ConfigTab_Outfitting.l_WeapTitlelabel'

	Begin Object Class=GUIScrollTextBox Name=WeaponDescription
		CharDelay=0.001500
		EOLDelay=0.250000
		OnCreateComponent=WeaponDescription.InternalOnCreateComponent
		WinTop=0.700000
		WinLeft=0.340000
		WinWidth=0.640000
		WinHeight=0.180000
		bNoTeletype=True
	End Object
	lb_Desc=GUIScrollTextBox'BallisticProV55.ConfigTab_Outfitting.WeaponDescription'

	Begin Object Class=moCheckBox Name=ch_AllWeapsCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Use All Weapons"
		OnCreateComponent=ch_AllWeapsCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="List non Ballistic weapons too."
		WinTop=0.893000
		WinLeft=0.340000
		WinWidth=0.280000
		WinHeight=0.040000
		OnChange=ConfigTab_Outfitting.InternalOnChange
	End Object
	ch_AllWeaps=moCheckBox'BallisticProV55.ConfigTab_Outfitting.ch_AllWeapsCheck'


     Begin Object Class=moFloatEdit Name=fl_ChangeIntervalFloat
         MinValue=0.000000
         MaxValue=600.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Loadout Change Interval"
         OnCreateComponent=fl_ChangeIntervalFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Time which must pass before you can change your weapons with Loadout while still alive."
         WinTop=0.893000
         WinLeft=0.640000
         WinWidth=0.340000
         WinHeight=0.040000
     End Object
     fl_ChangeInterval=moFloatEdit'BallisticProV55.ConfigTab_Outfitting.fl_ChangeIntervalFloat'

	BoxNames(0)="Melee"
	BoxNames(1)="Sidearm"
	BoxNames(2)="Primary"
	BoxNames(3)="Secondary"
	BoxNames(4)="Grenade"
	BoxNames(5)="Streak 1"
	BoxNames(6)="Streak 2"
	TeamCaptions(0)="Free-for-all"
	TeamCaptions(1)="Red team"
	TeamCaptions(2)="Blue team"
	ChosenCaptionFormat="In %s"
	ChosenCaptionTeamFormat="In %s, %t"
	Headings(0)="Melee"
	Headings(1)="Sidearms"
	Headings(2)="Sub Machineguns"
	Headings(3)="Assault Rifles"
	Headings(4)="Energy Weapons"
	Headings(5)="Heavy Machineguns"
	Headings(6)="Shotguns"
	Headings(7)="Ordnance"
	Headings(8)="Sniper Rifles"
	Headings(9)="Grenades"
	Headings(10)="Miscellaneous"
	Headings(11)="Non-BW"
}
