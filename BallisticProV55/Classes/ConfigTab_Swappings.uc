//=============================================================================
// ConfigTab_Swappings.
//
// The Pickups mode's replacements: for each original weapon (picked in the
// 'Replaces' box) the Ballistic weapons that take its place, in the shared
// weapon chooser. Presets save and load whole sets of replacements.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_Swappings extends ConfigTabBase config(BallisticProV55);

var automated BC_WeaponListEditor	Editor;
var automated GUILabel				l_Old;
var automated GUIComboBox			co_Old;				// the original weapon whose replacements are shown
var Automated GUIButton				BSavePreset, BDeletePreset;
var automated moComboBox			cb_Presets;
var automated moCheckbox			ch_Independent;
var automated moNumericEdit			nu_SwitchTime;

struct Swap					// Holds info about the replacments for an old item
{
	var() config array<string> NIs;				// The new items
	var() config bool		 R;					//
};
var() array<Swap>	Swaps;							// The replacement info for all old items

struct SwapPreset			// A single preset
{
	var() config string			PresetName;		// Name of this preset
	var() config array<Swap>	Swaps;			// Big block of swap info(a swap for each old weapon)
};

var() array<Swap>				DefaultSwaps;			// The default replacements for the old items (same as Mut_BallisticSwap's)
var() config bool				bDefaultsWritten;		// The defaults have been written to the ini file. Don't do it again

var int							OldIndex;
var bool						bLoading;

var() localized string 		Headings[12];
var() localized string		ChosenCaptionFormat;

function InitializeConfigTab()
{
	local int i, j, h;
	local array<CacheManager.WeaponRecord> Recs;
	local array<int> Heading;
	local BC_WeaponInfoCache.WeaponInfo WI;
	local array<String> PresetNames;

	// the original weapons
	for (i = 0; i < class'Mut_BallisticSwap'.static.GetNumWeapons(); i++)
		co_Old.AddItem(class'Mut_BallisticSwap'.static.GetOldWeaponClass(i).default.ItemName,, string(class'Mut_BallisticSwap'.static.GetOldWeaponClass(i)));
	co_Old.ReadOnly(true);
	co_Old.SetIndex(0);

	// the Ballistic weapons that can replace them, by weapon kind, by name
	class'CacheManager'.static.GetWeaponList(Recs);
	class'BC_WeaponInfoCache'.static.SortWeaponRecords(Recs);
	Heading.Length = Recs.Length;
	for (i = 0; i < Recs.Length; i++)
	{
		Heading[i] = -1;
		if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
			continue;
		// Tap into the BW weapon cache system to identify BallisticWeapons without loading them
		WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName, j);
		if (j == -1 || WI.ClassName == "" || !WI.bIsBW)
			continue;
		if (WI.InventoryGroup > 0 && WI.InventoryGroup < 10)
			Heading[i] = WI.InventoryGroup - 1;
		else if (WI.InventoryGroup == 0)
			Heading[i] = 9;
		else
			Heading[i] = 10;
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	Editor.ClearCatalogue();
	for (h = 0; h < 11; h++)
	{
		Editor.AddSection(Headings[h]);
		for (i = 0; i < Recs.Length; i++)
			if (Heading[i] == h)
				Editor.AddWeapon(Recs[i].FriendlyName, Recs[i].ClassName);
	}
	Editor.OnChosenChanged = ChosenChanged;

	SaveConfig();

	PresetNames = GetPerObjectNames("BallisticProV55", "BallisticSwapPreset");
	for (i = 0; i < PresetNames.Length; i++)
		cb_Presets.AddItem(Repl(PresetNames[i], Chr(27), " "), new(None, PresetNames[i]) class'BallisticSwapPreset',);
	cb_Presets.SetIndex(0);
	cb_Presets.SetText("");
}

//===========================================================================
// The original weapon shown
//===========================================================================
function ShowSwap()
{
	local array<string> Names;
	local int i;

	if (OldIndex < 0 || OldIndex >= Swaps.Length)
		return;

	// section headings that older versions saved into the lists are no weapons
	for (i = 0; i < Swaps[OldIndex].NIs.Length; i++)
		if (InStr(Swaps[OldIndex].NIs[i], ".") != -1)
			Names[Names.Length] = Swaps[OldIndex].NIs[i];

	bLoading = true;
	Editor.ChosenCaption = Repl(ChosenCaptionFormat, "%s", co_Old.GetText());
	Editor.SetChosen(Names);
	ch_Independent.Checked(Swaps[OldIndex].R);
	bLoading = false;
}

function ChosenChanged(BC_WeaponListEditor Sender)
{
	local array<string> Names;

	if (bLoading || OldIndex < 0 || OldIndex >= Swaps.Length)
		return;
	Editor.GetChosen(Names);
	Swaps[OldIndex].NIs = Names;
}

function InternalOnChange(GUIComponent Sender)
{
	if (bLoading)
		return;

	// A preset that holds nothing (one that is just being made) must not wipe the lists
	if (Sender == cb_Presets && cb_Presets.GetObject() != None && BallisticSwapPreset(cb_Presets.GetObject()).Swaps.length > 0)
	{
		Swaps = BallisticSwapPreset(cb_Presets.GetObject()).Swaps;
		// presets saved by older versions can be shorter than the list of old weapons
		Swaps.length = class'Mut_BallisticSwap'.static.GetNumWeapons();
		ShowSwap();
	}
	else if (Sender == co_Old)
	{
		OldIndex = co_Old.GetIndex();
		ShowSwap();
	}
	else if (Sender == ch_Independent && OldIndex >= 0 && OldIndex < Swaps.Length)
		Swaps[OldIndex].R = ch_Independent.IsChecked();
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i;
	local String s;
	local array<Swap> SavedSwaps;

	// SAVE PRESET
	if (Sender == BSavePreset)
	{
		s = cb_Presets.GetText();
		if (s == "")
			return true;
		// Selecting the preset in the box loads it. Keep what is being saved.
		SavedSwaps = Swaps;
		i = cb_Presets.FindIndex(s, True, False);

		bLoading = true;
		if (i != -1)
			cb_Presets.SetIndex(i);
		else
		{
			// Object names can't hold spaces
			cb_Presets.AddItem(s,new(None, Repl(s, " ", Chr(27))) class'BallisticSwapPreset',);
			cb_Presets.SetIndex(cb_Presets.ItemCount() - 1);
		}
		bLoading = false;
		Swaps = SavedSwaps;
		ShowSwap();

		if (cb_Presets.GetObject() != None)
		{
			BallisticSwapPreset(cb_Presets.GetObject()).Swaps = Swaps;
			cb_Presets.GetObject().SaveConfig();
		}
	}
	// DELETE PRESET
	else if (Sender == BDeletePreset)
	{
		// GetObject is None when the box holds a name that is not a preset
		if (cb_Presets.GetObject() != None)
		{
			cb_Presets.GetObject().ClearConfig();
			cb_Presets.RemoveItem(cb_Presets.GetIndex(), 0);
			cb_Presets.SetText("");
		}
	}
	return true;
}

//==================================================================
// Settings & Defaults
//==================================================================

//Load weapons from mutator.
function LoadSettings()
{
	local int i, j;
	local byte bRandom;
	local array<string> NewWeaps; // Array to hold new weapons for each old weapon

	cb_Presets.SetText("");
	Swaps.Length = class'Mut_BallisticSwap'.static.GetNumWeapons(); // Resize Swaps array

	for (i = 0; i < Swaps.Length; i++)
	{
		Swaps[i].R = false; // Default random spawning flag

		NewWeaps = class'Mut_BallisticSwap'.static.GetNewWeapons(i, bRandom);
		Swaps[i].NIs.Length = NewWeaps.Length;
		for (j = 0; j < NewWeaps.Length; j++)
			Swaps[i].NIs[j] = NewWeaps[j]; // Copy full package.classname to Swaps

		Swaps[i].R = bRandom > 0; // Set random spawning flag
	}

	OldIndex = co_Old.GetIndex();
	ShowSwap();

	nu_SwitchTime.SetValue(class'Mut_BallisticSwap'.default.PickupChangeTime);
}

//Send settings to mutator.
function SaveSettings()
{
	local int i, j;
	local Array<string> NewWeaps;

	if (!bInitialized)
		return;
	for (i=0;i<class'Mut_BallisticSwap'.static.GetNumWeapons();i++)
	{
		NewWeaps.length = 0;
		// Section headings that older versions saved into the list (or a preset) are dropped here
		for (j=0;j<Swaps[i].NIs.length;j++)
			if (InStr(Swaps[i].NIs[j], ".") != -1)
				NewWeaps[NewWeaps.length] = Swaps[i].NIs[j];
		class'Mut_BallisticSwap'.static.SetNewWeapons(i, NewWeaps, Swaps[i].R);
		class'Mut_BallisticSwap'.static.StaticSaveConfig();
	}

	class'Mut_BallisticSwap'.default.PickupChangeTime	= nu_SwitchTime.GetValue();
	class'Mut_BallisticSwap'.static.StaticSaveConfig();

	if (!bDefaultsWritten)
	{
		bDefaultsWritten=true;
		SaveConfig();
	}
}

function DefaultSettings()
{
	local int i, j;

	cb_Presets.SetText("");
	Swaps.length = 0;
	for (i=0;i<DefaultSwaps.length;i++)
	{
		Swaps.length = i+1;
		Swaps[i].R = DefaultSwaps[i].R;
		for (j=0;j<DefaultSwaps[i].NIs.length;j++)
			Swaps[i].NIs[j] = DefaultSwaps[i].NIs[j];
	}
	Swaps.length = class'Mut_BallisticSwap'.static.GetNumWeapons();
	ShowSwap();

	nu_SwitchTime.SetValue(60);
}

defaultproperties
{
	Begin Object Class=GUILabel Name=l_OldLabel
		Caption="Replaces:"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.035000
		WinLeft=0.050000
		WinWidth=0.120000
		WinHeight=0.045000
	End Object
	l_Old=GUILabel'BallisticProV55.ConfigTab_Swappings.l_OldLabel'

	Begin Object Class=GUIComboBox Name=co_OldCB
		Hint="The original weapon: the list on the right holds what replaces it."
		WinTop=0.040000
		WinLeft=0.170000
		WinWidth=0.300000
		WinHeight=0.040000
		TabOrder=0
		OnChange=ConfigTab_Swappings.InternalOnChange
		OnKeyEvent=co_OldCB.InternalOnKeyEvent
	End Object
	co_Old=GUIComboBox'BallisticProV55.ConfigTab_Swappings.co_OldCB'

	Begin Object Class=BC_WeaponListEditor Name=WeaponEditor
		WinTop=0.100000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.620000
		TabOrder=1
	End Object
	Editor=BC_WeaponListEditor'BallisticProV55.ConfigTab_Swappings.WeaponEditor'

     Begin Object Class=moCheckBox Name=ch_IndependentCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Independent Spawning"
         OnCreateComponent=ch_IndependentCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="When several weapons replace one original, this prevents ammo and same-type weapon pickups from being forced to match each other."
         WinTop=0.042000
         WinLeft=0.520000
         WinWidth=0.430000
         WinHeight=0.040000
         OnChange=ConfigTab_Swappings.InternalOnChange
     End Object
     ch_Independent=moCheckBox'BallisticProV55.ConfigTab_Swappings.ch_IndependentCheck'

     Begin Object Class=moComboBox Name=co_PresetsCB
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Presets"
         OnCreateComponent=co_PresetsCB.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Choose a preset replacements configuration, or type a new preset name here and click 'Save' to make the current configuration a new preset."
         WinTop=0.750000
         WinLeft=0.050000
         WinWidth=0.450000
         OnChange=ConfigTab_Swappings.InternalOnChange
         WinHeight=0.040000
     End Object
     cb_Presets=moComboBox'BallisticProV55.ConfigTab_Swappings.co_PresetsCB'

     Begin Object Class=GUIButton Name=BSavePresetButton
         Caption="Save"
         Hint="Saves the current configuration as a new preset Type the name of your new preset in the preset box."
         WinTop=0.750000
         WinLeft=0.520000
         WinWidth=0.120000
         TabOrder=0
         OnClick=ConfigTab_Swappings.InternalOnClick
         OnKeyEvent=BSavePresetButton.InternalOnKeyEvent
         WinHeight=0.040000
     End Object
     BSavePreset=GUIButton'BallisticProV55.ConfigTab_Swappings.BSavePresetButton'

     Begin Object Class=GUIButton Name=BDeletePresetButton
         Caption="Delete"
         Hint="Deletes the currently selected preset."
         WinTop=0.750000
         WinLeft=0.660000
         WinWidth=0.120000
         TabOrder=0
         OnClick=ConfigTab_Swappings.InternalOnClick
         OnKeyEvent=BDeletePresetButton.InternalOnKeyEvent
         WinHeight=0.040000
     End Object
     BDeletePreset=GUIButton'BallisticProV55.ConfigTab_Swappings.BDeletePresetButton'

     Begin Object Class=moNumericEdit Name=nu_SwitchTimeEdit
         MinValue=5
         MaxValue=600
         Step=5
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Pickup Change Time"
         OnCreateComponent=nu_SwitchTimeEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Specify time interval(in seconds) between weapon pickup changes. Affects situations where multiple items are set to replace one original pickup."
         WinTop=0.830000
         WinLeft=0.050000
         WinHeight=0.040000
         WinWidth=0.450000
     End Object
     nu_SwitchTime=moNumericEdit'BallisticProV55.ConfigTab_Swappings.nu_SwitchTimeEdit'

	ChosenCaptionFormat="Replacing %s"
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
