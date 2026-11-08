//=============================================================================
// ConfigTab_Loadout. (Evolution)
//
// The Evolution Loadout mutator's weapons: one list per loadout slot (Melee,
// Sidearm, Primary, Secondary, Grenade) in the shared weapon chooser, picked
// with slot tabs, and what a player must have done before each weapon can be
// chosen, in the boxes under the lists for the weapon last picked.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_Loadout extends ConfigTabBase
	DependsOn(Mut_Loadout)
	config(BallisticProV55);

var config bool						bUseAllWeapons;

var automated GUIImage				Box_WeapIcon, Pic_Weapon;
var automated GUILabel				l_WeapTitle;
var automated BC_WeaponListEditor	Editor;
var automated moCheckbox			ch_AllWeaps;
var automated moFloatEdit			fl_RequiredTime, fl_RequiredFrags, fl_RequiredEfficiency, fl_RequiredDmgRate, fl_RequiredSnprEff, fl_RequiredStgnEff, fl_RequiredHzrdEff;
var BC_TabRow						SlotRow;

struct LoadOutBox
{
	var array<string>		WeaponNames;
};
var LoadoutBox				Boxes[5];
var localized string		BoxNames[5];
var int						SelectedBox;
var int						CurrentWeapon;		// WeaponInfo index of the weapon whose requirements the boxes show, -1 none
var bool					bLoading;

var() localized string 		Headings[12];
var() localized string		ChosenCaptionFormat;

struct LOWeapInfo
{
	var string		ClassName;
	var string		Description;
	var Material	Icon;
	var IntBox		IconCoords;
	var bool		bIsBW;

	var float		ReqTime;
	var float		ReqFrags;
	var float		ReqEff;
	var float		ReqDmgRate;
	var float		ReqSnprEff;
	var float		ReqStgnEff;
	var float		ReqHzrdEff;
};
var   array<LOWeapInfo> WeaponInfo;

function InitializeConfigTab()
{
	local array<string> Captions;
	local int i;

	CurrentWeapon = -1;
	ch_AllWeaps.Checked(bUseAllWeapons);

	for (i = 0; i < 5; i++)
		Captions[i] = BoxNames[i];
	SlotRow = class'BC_TabRow'.static.Create(self, Editor, 0.020000, 0.015000, 0.960000, 0.050000, Captions);
	SlotRow.OnSwitch = SlotSwitched;

	Editor.OnChosenChanged = ChosenChanged;
	Editor.OnWeaponSelected = WeaponSelected;

	LoadList();
	LoadBoxesFromMutator();

	// back on the slot last edited
	SelectedBox = Clamp(class'BC_MenuMemory'.default.EvolutionSlot, 0, 4);
	SlotRow.Select(SelectedBox);
	ShowBox();
}

//===========================================================================
// LoadList
//
// The weapons that can go in a slot, by weapon kind, from the weapon cache
// (no classes loaded), with their requirements. Ballistic weapons only,
// unless Use All Weapons.
//===========================================================================
function LoadList()
{
	local int i, j, h;
	local array<CacheManager.WeaponRecord> Recs;
	local array<int> Heading;
	local string s;
	local BC_WeaponInfoCache.WeaponInfo WI;

	WeaponInfo.length = 0;
	CurrentWeapon = -1;

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
			else
				Heading[i] = 10;
		}
		else
		{
			WeaponInfo[j].Icon = WI.SmallIconMaterial;
			WeaponInfo[j].IconCoords = WI.SmallIconCoords;
			Heading[i] = 11;
		}
		WeaponInfo[j].bIsBW = WI.bIsBW;
		LoadRequirements(j);
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

// Requirements of one listed weapon as the mutator has them, or what the weapon came with if the mutator doesn't list it
function LoadRequirements(int Index)
{
	local int k;

	for (k=0;k<class'Mut_Loadout'.default.Items.length;k++)
	{
		if (class'Mut_Loadout'.default.Items[k].ItemName ~= WeaponInfo[Index].ClassName)
		{
			WeaponInfo[Index].ReqTime = class'Mut_Loadout'.default.Items[k].Requirements.MatchTime;
			WeaponInfo[Index].ReqFrags = class'Mut_Loadout'.default.Items[k].Requirements.Frags;
			WeaponInfo[Index].ReqEff = class'Mut_Loadout'.default.Items[k].Requirements.Efficiency;
			WeaponInfo[Index].ReqDmgRate = class'Mut_Loadout'.default.Items[k].Requirements.DamageRate;
			WeaponInfo[Index].ReqSnprEff = class'Mut_Loadout'.default.Items[k].Requirements.SniperEff;
			WeaponInfo[Index].ReqStgnEff = class'Mut_Loadout'.default.Items[k].Requirements.ShotgunEff;
			WeaponInfo[Index].ReqHzrdEff = class'Mut_Loadout'.default.Items[k].Requirements.HazardEff;
			return;
		}
	}
	if (WeaponInfo[Index].bIsBW)
		SetDefaultRequirements(WeaponInfo[Index].ClassName, Index);
}

function bool SetDefaultRequirements(string ClassName, int Index)
{
	local class<BallisticWeapon> BW;
	local string s;
	local array<string> RS;

	BW = class<BallisticWeapon>( DynamicLoadObject(ClassName, class'class') );
	if (BW == None)
		return false;

	s = BW.static.StaticGetSpecialInfo('EvoDefs');
	if (s == "")
		return false;
	Split(s, ";", RS);
	switch (RS.Length-1)
	{
		case 6:	WeaponInfo[Index].ReqHzrdEff	= float(RS[6]);
		case 5:	WeaponInfo[Index].ReqStgnEff	= float(RS[5]);
		case 4:	WeaponInfo[Index].ReqSnprEff	= float(RS[4]);
		case 3:	WeaponInfo[Index].ReqDmgRate	= float(RS[3]);
		case 2:	WeaponInfo[Index].ReqEff		= float(RS[2]);
		case 1:	WeaponInfo[Index].ReqFrags		= float(RS[1]);
		case 0:	WeaponInfo[Index].ReqTime		= float(RS[0]);
	}
	return true;
}

function LoadBoxesFromMutator ()
{
	local int i, j, k;

	// This runs again for RESET and DEFAULTS
	for (j=0;j<5;j++)
		Boxes[j].WeaponNames.length = 0;

	for (i=0;i<class'Mut_Loadout'.default.Items.length;i++)
		for (j=0;j<5;j++)
			if ((class'Mut_Loadout'.default.Items[i].Groups & (1<<j)) > 0)
				Boxes[j].WeaponNames[Boxes[j].WeaponNames.length] = class'Mut_Loadout'.default.Items[i].ItemName;

	// Get rid of things that are no longer around
	for(i=0;i<5;i++)
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

function SaveBoxesToMutator ()
{
	local int i, j, k, l, Groups;

	// An empty box must have at least one line otherwise the mutator defaults take over
	for(i=0;i<5;i++)
		if (Boxes[i].WeaponNames.length < 1)
			Boxes[i].WeaponNames.length = 1;

//	class'Mut_Loadout'.default.Items.length = 0;
	for (i=0;i<WeaponInfo.length;i++)
	{
		if (WeaponInfo[i].ClassName == "")
			continue;
		for (j=0;j<5;j++)
		{
			for (k=0;k<Boxes[j].WeaponNames.length;k++)
			{
				if (Boxes[j].WeaponNames[k] ~= WeaponInfo[i].ClassName)
				{
					Groups = Groups | (1<<j);
					break;
				}
			}
		}
		for (l=0;l<class'Mut_Loadout'.default.Items.length;l++)
			if (class'Mut_Loadout'.default.Items[l].ItemName ~= WeaponInfo[i].ClassName)
				break;
//		if (Groups > 0)
//		{
		if (l >= class'Mut_Loadout'.default.Items.length)
			class'Mut_Loadout'.default.Items.length = l + 1;
		class'Mut_Loadout'.default.Items[l].ItemName = WeaponInfo[i].ClassName;
		class'Mut_Loadout'.default.Items[l].Groups = Groups;
		class'Mut_Loadout'.default.Items[l].Requirements.MatchTime = WeaponInfo[i].ReqTime;
		class'Mut_Loadout'.default.Items[l].Requirements.Frags = WeaponInfo[i].ReqFrags;
		class'Mut_Loadout'.default.Items[l].Requirements.Efficiency = WeaponInfo[i].ReqEff;
		class'Mut_Loadout'.default.Items[l].Requirements.DamageRate = WeaponInfo[i].ReqDmgRate;
		class'Mut_Loadout'.default.Items[l].Requirements.SniperEff	= WeaponInfo[i].ReqSnprEff;
		class'Mut_Loadout'.default.Items[l].Requirements.ShotgunEff = WeaponInfo[i].ReqStgnEff;
		class'Mut_Loadout'.default.Items[l].Requirements.HazardEff 	= WeaponInfo[i].ReqHzrdEff;
//		}
		Groups = 0;
	}
	class'Mut_Loadout'.static.StaticSaveConfig();
}

//===========================================================================
// Slots
//===========================================================================
function ShowBox()
{
	local int i, j, n;

	bLoading = true;
	Editor.ChosenCaption = Repl(ChosenCaptionFormat, "%s", BoxNames[SelectedBox]);
	Editor.SetChosen(Boxes[SelectedBox].WeaponNames);
	bLoading = false;

	// "Primary (32)"
	for (i = 0; i < 5; i++)
	{
		n = 0;
		for (j = 0; j < Boxes[i].WeaponNames.Length; j++)
			if (Boxes[i].WeaponNames[j] != "")
				n++;
		SlotRow.SetCaption(i, BoxNames[i] @ "(" $ n $ ")");
	}
}

function ChosenChanged(BC_WeaponListEditor Sender)
{
	local array<string> Names;

	if (bLoading)
		return;
	Editor.GetChosen(Names);
	Boxes[SelectedBox].WeaponNames = Names;
	SlotRow.SetCaption(SelectedBox, BoxNames[SelectedBox] @ "(" $ Names.Length $ ")");
}

function SlotSwitched(BC_TabRow Sender, int Index)
{
	SelectedBox = Index;
	class'BC_MenuMemory'.static.SetEvolutionSlot(SelectedBox);
	ShowBox();
}

function InternalOnChange(GUIComponent Sender)
{
	if (Sender == ch_AllWeaps && !bLoading && SlotRow != None)
	{
		StoreRequirements();
		bUseAllWeapons = ch_AllWeaps.IsChecked();
		LoadList();
		ShowBox();
		DisplayWeapon();
	}
}

//===========================================================================
// Requirements of the weapon last picked
//===========================================================================
function int FindWeaponInfo(string ClassName)
{
	local int i;

	for (i = 0; i < WeaponInfo.Length; i++)
		if (WeaponInfo[i].ClassName ~= ClassName)
			return i;
	return -1;
}

// The boxes belong to the weapon shown: they are stored before another one is shown
function StoreRequirements()
{
	local int i;

	i = CurrentWeapon;
	if (i < 0 || i >= WeaponInfo.Length)
		return;

	WeaponInfo[i].ReqTime = fl_RequiredTime.GetValue();
	WeaponInfo[i].ReqFrags = fl_RequiredFrags.GetValue();
	WeaponInfo[i].ReqEff = fl_RequiredEfficiency.GetValue();
	WeaponInfo[i].ReqDmgRate = fl_RequiredDmgRate.GetValue();
	WeaponInfo[i].ReqSnprEff = fl_RequiredSnprEff.GetValue();
	WeaponInfo[i].ReqStgnEff = fl_RequiredStgnEff.GetValue();
	WeaponInfo[i].ReqHzrdEff = fl_RequiredHzrdEff.GetValue();
}

function WeaponSelected(BC_WeaponListEditor Sender, string ClassName)
{
	StoreRequirements();
	CurrentWeapon = FindWeaponInfo(ClassName);
	DisplayWeapon();
}

function DisplayWeapon()
{
	local int i;

	i = CurrentWeapon;
	if (i < 0 || i >= WeaponInfo.Length)
	{
		l_WeapTitle.Caption = "";
		Pic_Weapon.Image = None;
		return;
	}
	l_WeapTitle.Caption = Editor.NameOf(WeaponInfo[i].ClassName);
	Pic_Weapon.Image = WeaponInfo[i].Icon;
	Pic_Weapon.X1 	 = WeaponInfo[i].IconCoords.X1;
	Pic_Weapon.X2	 = WeaponInfo[i].IconCoords.X2;
	Pic_Weapon.Y1 	 = WeaponInfo[i].IconCoords.Y1;
	Pic_Weapon.Y2	 = WeaponInfo[i].IconCoords.Y2;

	fl_RequiredTime.SetValue(WeaponInfo[i].ReqTime);
	fl_RequiredFrags.SetValue(WeaponInfo[i].ReqFrags);
	fl_RequiredEfficiency.SetValue(WeaponInfo[i].ReqEff);
	fl_RequiredDmgRate.SetValue(WeaponInfo[i].ReqDmgRate);
	fl_RequiredSnprEff.SetValue(WeaponInfo[i].ReqSnprEff);
	fl_RequiredStgnEff.SetValue(WeaponInfo[i].ReqStgnEff);
	fl_RequiredHzrdEff.SetValue(WeaponInfo[i].ReqHzrdEff);
}

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	LoadBoxesFromMutator();
	ShowLoaded();
}

// Shows what LoadBoxesFromMutator has just fetched, dropping any edits
function ShowLoaded()
{
	local int i;

	for (i=0;i<WeaponInfo.length;i++)
		LoadRequirements(i);
	ShowBox();
	DisplayWeapon();
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	StoreRequirements();
	SaveBoxesToMutator();
	SaveConfig();
}

function DefaultSettings()
{
	local array<Mut_Loadout.LOItem> Saved;

	// ResetConfig is the only way to see the list the mutator came with, and it takes the saved one out of the ini at once.
	// Put the saved one back afterwards: nothing is final before OK.
	Saved = class'Mut_Loadout'.default.Items;
	class'Mut_Loadout'.static.ResetConfig("Items");

	LoadBoxesFromMutator();
	ShowLoaded();

	class'Mut_Loadout'.default.Items = Saved;
	class'Mut_Loadout'.static.StaticSaveConfig();
}

defaultproperties
{
	Begin Object Class=BC_WeaponListEditor Name=WeaponEditor
		WinTop=0.085000
		WinLeft=0.020000
		WinWidth=0.960000
		WinHeight=0.540000
		TabOrder=0
	End Object
	Editor=BC_WeaponListEditor'BallisticProV55.ConfigTab_Loadout.WeaponEditor'

	Begin Object Class=GUIImage Name=Box_WeapIconImg
		Image=Texture'2K4Menus.NewControls.Display99'
		ImageStyle=ISTY_Stretched
		WinTop=0.645000
		WinLeft=0.020000
		WinWidth=0.300000
		WinHeight=0.300000
		RenderWeight=0.002000
	End Object
	Box_WeapIcon=GUIImage'BallisticProV55.ConfigTab_Loadout.Box_WeapIconImg'

	Begin Object Class=GUIImage Name=Pic_WeaponImg
		ImageStyle=ISTY_Justified
		WinTop=0.660000
		WinLeft=0.030000
		WinWidth=0.280000
		WinHeight=0.210000
		RenderWeight=0.003000
	End Object
	Pic_Weapon=GUIImage'BallisticProV55.ConfigTab_Loadout.Pic_WeaponImg'

	Begin Object Class=GUILabel Name=l_WeapTitlelabel
		TextAlign=TXTA_Center
		TextColor=(B=255,G=255,R=255)
		WinTop=0.885000
		WinLeft=0.020000
		WinWidth=0.300000
		WinHeight=0.045000
	End Object
	l_WeapTitle=GUILabel'BallisticProV55.ConfigTab_Loadout.l_WeapTitlelabel'

     Begin Object Class=moCheckBox Name=ch_AllWeapsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use All Weapons"
         OnCreateComponent=ch_AllWeapsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable non BW weapons in the list."
         WinTop=0.885000
         WinLeft=0.340000
         WinWidth=0.300000
         WinHeight=0.040000
         OnChange=ConfigTab_Loadout.InternalOnChange
     End Object
     ch_AllWeaps=moCheckBox'BallisticProV55.ConfigTab_Loadout.ch_AllWeapsCheck'

     Begin Object Class=moFloatEdit Name=RequirementTimeEdit
         MinValue=0.000000
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Time"
         OnCreateComponent=RequirementTimeEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How much match time must have passed for this weapon to be available (simply delays availability)"
         WinTop=0.655000
         WinLeft=0.340000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     fl_RequiredTime=moFloatEdit'BallisticProV55.ConfigTab_Loadout.RequirementTimeEdit'

     Begin Object Class=moFloatEdit Name=RequirementFragsEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Frags"
         OnCreateComponent=RequirementFragsEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Mimimum frags required to choose this weapon (benefit by killing lots)"
         WinTop=0.705000
         WinLeft=0.340000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     fl_RequiredFrags=moFloatEdit'BallisticProV55.ConfigTab_Loadout.RequirementFragsEdit'

     Begin Object Class=moFloatEdit Name=RequirementEffEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Efficiency"
         OnCreateComponent=RequirementEffEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Frags divided by Deaths efficiency required to access this weapon (benefit by not wasting lives)"
         WinTop=0.755000
         WinLeft=0.340000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     fl_RequiredEfficiency=moFloatEdit'BallisticProV55.ConfigTab_Loadout.RequirementEffEdit'

     Begin Object Class=moFloatEdit Name=RequirementDmgRtEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="DamageRate"
         OnCreateComponent=RequirementDmgRtEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Damage Inflicted divided by Kills. How much the player has contibuted to kills (benfit by targeting strong players)"
         WinTop=0.805000
         WinLeft=0.340000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     fl_RequiredDmgRate=moFloatEdit'BallisticProV55.ConfigTab_Loadout.RequirementDmgRtEdit'

     Begin Object Class=moFloatEdit Name=fl_RequiredSnprEffEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Sniper Eff"
         OnCreateComponent=RequirementDmgRtEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Headshot kills divided by deaths. How efficient the player is at headshots (benfit by getting headshots and avoiding death)"
         WinTop=0.655000
         WinLeft=0.670000
         WinWidth=0.310000
         WinHeight=0.040000
     End Object
     fl_RequiredSnprEff=moFloatEdit'BallisticProV55.ConfigTab_Loadout.fl_RequiredSnprEffEdit'

     Begin Object Class=moFloatEdit Name=fl_RequiredStgnEffEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Shotgun Eff"
         OnCreateComponent=RequirementDmgRtEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Gun kills divided by range and deaths. How efficient the player is at close combat with guns (benefit by using guns close up and avoiding death)"
         WinTop=0.705000
         WinLeft=0.670000
         WinWidth=0.310000
         WinHeight=0.040000
     End Object
     fl_RequiredStgnEff=moFloatEdit'BallisticProV55.ConfigTab_Loadout.fl_RequiredStgnEffEdit'

     Begin Object Class=moFloatEdit Name=fl_RequiredHzrdEffEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Hazard Eff"
         OnCreateComponent=RequirementDmgRtEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Kills minus deaths with traps and hazardous weapons divided by deaths. (benfit by killing with hazardous weapons and avoiding death)"
         WinTop=0.755000
         WinLeft=0.670000
         WinWidth=0.310000
         WinHeight=0.040000
     End Object
     fl_RequiredHzrdEff=moFloatEdit'BallisticProV55.ConfigTab_Loadout.fl_RequiredHzrdEffEdit'

	BoxNames(0)="Melee"
	BoxNames(1)="Sidearm"
	BoxNames(2)="Primary"
	BoxNames(3)="Secondary"
	BoxNames(4)="Grenade"
	ChosenCaptionFormat="In %s"
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
