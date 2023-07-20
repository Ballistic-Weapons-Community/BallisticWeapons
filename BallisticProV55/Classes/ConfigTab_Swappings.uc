//=============================================================================
// ConfigTab_Swappings.
//
// This page is used to configure the swapping lists for the Ballistic mutators
// Includes:
// A list of original weapons that can be replaced.
// CheckList of new weapons which replace each old weapon.
// Preset section to quickly load and save preset lists of replacements
// Edit box for switching time
// Checkbox for the random spawning of the replacements for each old weapon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_Swappings extends ConfigTabBase config(BallisticProV55);

var automated GUIListBox			lb_OldWeapons;
var automated BC_GUICheckListBox	lb_NewWeapons;
var Automated GUIImage				Box_Old, Box_New;
var Automated GUIButton				BAddAll, BRemoveAll, BSavePreset, BDeletePreset;
var automated moComboBox			cb_Presets;
var automated moCheckbox			ch_Independent;
var automated moNumericEdit			nu_SwitchTime;
var automated GUILabel   			l_OldList, l_NewList;

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

var() config array<Swap>		DefaultSwaps;			// The default replacements for the old items
var() config bool				bDefaultsWritten;		// The defaults have been written to the ini file. Don't do it again

function InitializeConfigTab()
{
	local int i, j;
	local array<CacheManager.WeaponRecord> Recs;
	local BC_WeaponInfoCache.WeaponInfo WI;
	local array<String> PresetNames;

	// Fill old items list
	for (i=0;i<class'Mut_BallisticSwap'.static.GetNumWeapons();i++)
		lb_OldWeapons.List.Add(class'Mut_BallisticSwap'.static.GetOldWeaponClass(i).default.ItemName, , string(class'Mut_BallisticSwap'.static.GetOldWeaponClass(i)));
	lb_OldWeapons.List.OnClick = InternalOnClick;

	// Fill replacement items list
	class'CacheManager'.static.GetWeaponList(Recs);
	for (i=0;i<Recs.Length;i++)
	{
		if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
			continue;
		// Tap into the BW weapon cache system to identify BallisticWeapons without loading them
		WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName, j);
		if (j == -1)
			continue;
		if (WI.ClassName != "")
		{
			if (WI.bIsBW)
				lb_NewWeapons.CheckList.AddCheck(WI.ItemName, , Recs[i].ClassName);
		}
	}
	class'BC_WeaponInfoCache'.static.EndSession();
	SaveConfig();
	lb_NewWeapons.CheckList.OnClick = InternalOnClick;

	PresetNames = GetPerObjectNames("BallisticProV55", "BallisticSwapPreset");
	for (i=0;i<PresetNames.Length;i++)
		cb_Presets.AddItem(PresetNames[i],new(None, PresetNames[i]) class'BallisticSwapPreset',);
	cb_Presets.SetIndex(0);
	cb_Presets.SetText("");

	ch_Independent.MyCheckBox.OnClick = InternalOnClick;
}

function InternalOnChange(GUIComponent Sender)
{
	if (Sender == cb_Presets && cb_Presets.GetObject() != None)
	{
		Swaps = BallisticSwapPreset(cb_Presets.GetObject()).Swaps;
		UpdateReplacementsList(lb_OldWeapons.List.Index);
	}
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i;
	local String s;

	// Replacement weapons list
	if (Sender == lb_NewWeapons.CheckList)
	{
		lb_NewWeapons.CheckList.InternalOnClick(Sender);

		ChangeSwapListEntry(lb_OldWeapons.List.Index, lb_NewWeapons.List.GetExtraAtIndex(lb_NewWeapons.CheckList.LastCheckChanged), lb_NewWeapons.CheckList.Checks[lb_NewWeapons.CheckList.LastCheckChanged] > 0);
	}
	// Old weapons list
	else if (Sender == lb_OldWeapons.List)
	{
		lb_OldWeapons.List.InternalOnClick(Sender);
		UpdateReplacementsList(lb_OldWeapons.List.Index);
		ch_Independent.Checked(Swaps[lb_OldWeapons.List.Index].R);
	}
	// FILL
	else if (Sender == BAddAll)
	{
		Swaps[lb_OldWeapons.List.Index].NIs.length = 0;
		for (i=0;i<lb_NewWeapons.List.Elements.Length;i++)
		{
			Swaps[lb_OldWeapons.List.Index].NIs[i] = lb_NewWeapons.List.GetExtraAtIndex(i);
			lb_NewWeapons.CheckList.SetChecked(i, true);
		}
	}
	// EMPTY
	else if (Sender == BRemoveAll)
	{
		Swaps[lb_OldWeapons.List.Index].NIs.length = 0;
		for (i=0;i<lb_NewWeapons.List.Elements.Length;i++)
			lb_NewWeapons.CheckList.SetChecked(i, false);
	}
	// SAVE PRESET
	else if (Sender == BSavePreset)			
	{
		s = Repl(cb_Presets.GetText(), " ", Chr(27));
		if (s == "")
			return true;
		i = cb_Presets.FindIndex(s, True, False);
		
		if (i != -1)
			cb_Presets.SetIndex(i);
		else	
		{	
			cb_Presets.AddItem(s,new(None, s) class'BallisticSwapPreset',);
			cb_Presets.SetIndex(cb_Presets.ItemCount() - 1);
		}
		
		BallisticSwapPreset(cb_Presets.GetObject()).Swaps = Swaps;
		cb_Presets.GetObject().SaveConfig();
	}
	// DELETE PRESET
	else if (Sender == BDeletePreset)		
	{
		cb_Presets.GetObject().ClearConfig();
		cb_Presets.RemoveItem(cb_Presets.GetIndex(), 0);
	}
	// Independent Spawning CheckBox
	else if (Sender == ch_Independent.MyCheckBox)
	{
		ch_Independent.MyCheckBox.InternalOnClick(Sender);
		Swaps[lb_OldWeapons.List.Index].R = ch_Independent.IsChecked();
	}
	return true;
}

function ChangeSwapListEntry(int Index, string Item, bool bAdd)
{
	local int i;
	for (i=0;i<Swaps[Index].NIs.length;i++)
		if (Swaps[Index].NIs[i] == Item)	{
			if (bAdd)
				return;
			else	{
				Swaps[Index].NIs.Remove(i, 1);
				return;	}
		}
	Swaps[Index].NIs[Swaps[Index].NIs.length] = Item;
}

//Uncheck and recheck any in list.
function UpdateReplacementsList(int Index)
{
	local int i, j;
	for (i=0;i<lb_NewWeapons.List.Elements.Length;i++)	{
		lb_NewWeapons.CheckList.SetChecked(i, false);
		for (j=0;j<Swaps[Index].NIs.length;j++)
			if (Swaps[Index].NIs[j] ~= lb_NewWeapons.List.Elements[i].ExtraStrData)
				lb_NewWeapons.CheckList.SetChecked(i, true);
	}
}

//Load weapons from mutator.
function LoadSettings()
{
	local int i, j;
	local array<string> NewWeaps;
	local byte bRandom;

	cb_Presets.SetText("");
	Swaps.length = 0;
	for (i=0;i<class'Mut_BallisticSwap'.static.GetNumWeapons();i++)
	{
		Swaps.length = i+1;
		NewWeaps = class'Mut_BallisticSwap'.static.GetNewWeapons(i, bRandom);
		for (j=0;j<NewWeaps.length;j++)
			Swaps[i].NIs[j] = NewWeaps[j];
		Swaps[i].R = bRandom>0;
	}
	UpdateReplacementsList(lb_OldWeapons.List.Index);

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
		for (j=0;j<Swaps[i].NIs.length;j++)
			NewWeaps[j] = Swaps[i].NIs[j];
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
	UpdateReplacementsList(lb_OldWeapons.List.Index);

	nu_SwitchTime.SetValue(60);
}

defaultproperties
{
     Begin Object Class=GUIListBox Name=lb_OldWeaponsList
         bVisibleWhenEmpty=True
         OnCreateComponent=lb_OldWeaponsList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="The original weapons. Select one to choose what replaces it"
         WinTop=0.100000
         WinLeft=0.100000
         WinWidth=0.350000
         WinHeight=0.600000
         RenderWeight=0.520000
         TabOrder=1
     End Object
     lb_OldWeapons=GUIListBox'BallisticProV55.ConfigTab_Swappings.lb_OldWeaponsList'

     Begin Object Class=BC_GUICheckListBox Name=lb_NewWeaponsList
         bVisibleWhenEmpty=True
         OnCreateComponent=lb_NewWeaponsList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Tick the weapons that you want to replace the orignal one selected on the left."
         WinTop=0.100000
         WinLeft=0.550000
         WinWidth=0.350000
         WinHeight=0.600000
         RenderWeight=0.520000
         TabOrder=1
     End Object
     lb_NewWeapons=BC_GUICheckListBox'BallisticProV55.ConfigTab_Swappings.lb_NewWeaponsList'

     Begin Object Class=GUIImage Name=Box_OldImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.075000
         WinWidth=0.400000
         WinHeight=0.675000
         RenderWeight=0.002000
     End Object
     Box_Old=GUIImage'BallisticProV55.ConfigTab_Swappings.Box_OldImg'

     Begin Object Class=GUIImage Name=Box_NewImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.525000
         WinWidth=0.400000
         WinHeight=0.675000
         RenderWeight=0.002000
     End Object
     Box_New=GUIImage'BallisticProV55.ConfigTab_Swappings.Box_NewImg'

     Begin Object Class=GUIButton Name=AddAllButton
         Caption="FILL"
         Hint="Checks all to replace the original weapon currently selected"
         WinTop=0.800000
         WinLeft=0.550000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Swappings.InternalOnClick
         OnKeyEvent=AddAllButton.InternalOnKeyEvent
     End Object
     BAddAll=GUIButton'BallisticProV55.ConfigTab_Swappings.AddAllButton'

     Begin Object Class=GUIButton Name=RemoveAllButton
         Caption="EMPTY"
         Hint="Unchecks all to replace the original weapon currently selected"
         WinTop=0.800000
         WinLeft=0.750000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Swappings.InternalOnClick
         OnKeyEvent=RemoveAllButton.InternalOnKeyEvent
     End Object
     BRemoveAll=GUIButton'BallisticProV55.ConfigTab_Swappings.RemoveAllButton'

     Begin Object Class=GUIButton Name=BSavePresetButton
         Caption="Save"
         Hint="Saves the current configuration as a new preset Type the name of your new preset in the preset box."
         WinTop=0.800000
         WinLeft=0.100000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Swappings.InternalOnClick
         OnKeyEvent=BSavePresetButton.InternalOnKeyEvent
     End Object
     BSavePreset=GUIButton'BallisticProV55.ConfigTab_Swappings.BSavePresetButton'

     Begin Object Class=GUIButton Name=BDeletePresetButton
         Caption="Delete"
         Hint="Deletes the currently selected preset."
         WinTop=0.800000
         WinLeft=0.300000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Swappings.InternalOnClick
         OnKeyEvent=BDeletePresetButton.InternalOnKeyEvent
     End Object
     BDeletePreset=GUIButton'BallisticProV55.ConfigTab_Swappings.BDeletePresetButton'

     Begin Object Class=moComboBox Name=co_PresetsCB
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Presets"
         OnCreateComponent=co_PresetsCB.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Choose a preset replacements configuration, or type a new preset name here and click 'Save' to make the current configuration a new preset."
         WinTop=0.750000
         WinLeft=0.100000
         WinWidth=0.350000
         OnChange=ConfigTab_Swappings.InternalOnChange
     End Object
     cb_Presets=moComboBox'BallisticProV55.ConfigTab_Swappings.co_PresetsCB'

     Begin Object Class=moCheckBox Name=ch_IndependentCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Independent Spawning"
         OnCreateComponent=ch_IndependentCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="When several weapons replace one original, this prevents ammo and same-type weapon pickups from being forced to match each other."
         WinTop=0.750000
         WinLeft=0.550000
         WinWidth=0.350000
         WinHeight=0.040000
     End Object
     ch_Independent=moCheckBox'BallisticProV55.ConfigTab_Swappings.ch_IndependentCheck'

     Begin Object Class=moNumericEdit Name=nu_SwitchTimeEdit
         MinValue=1
         MaxValue=600
         Step=5
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Pickup Change Time"
         OnCreateComponent=nu_SwitchTimeEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Specify time interval(in seconds) between weapon pickup changes. Affects situations where multiple items are set to replace one original pickup."
         WinTop=0.900000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     nu_SwitchTime=moNumericEdit'BallisticProV55.ConfigTab_Swappings.nu_SwitchTimeEdit'

     Begin Object Class=GUILabel Name=l_OldListlabel
         Caption="Original Weapons"
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.050000
         WinLeft=0.075000
         WinWidth=0.400000
         WinHeight=0.050000
     End Object
     l_OldList=GUILabel'BallisticProV55.ConfigTab_Swappings.l_OldListlabel'

     Begin Object Class=GUILabel Name=l_NewListlabel
         Caption="Replace with..."
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.050000
         WinLeft=0.525000
         WinWidth=0.400000
         WinHeight=0.050000
     End Object
     l_NewList=GUILabel'BallisticProV55.ConfigTab_Swappings.l_NewListlabel'

     DefaultSwaps(0)=(NIs=("BallisticProV55.X3Knife","BallisticProV55.A909SkrithBlades","BallisticProV55.EKS43katana"))
     DefaultSwaps(1)=(NIs=("BallisticProV55.M806Pistol","BallisticProV55.MRT6Shotgun","BallisticProV55.A42SkrithPistol","BallisticProV55.D49Revolver","BallisticProV55.AM67Pistol","BallisticProV55.Fifty9MachinePistol","BallisticProV55.XK2SubMachinegun","BallisticProV55.RS8Pistol","BallisticProV55.XRS10Submachinegun"))
     DefaultSwaps(2)=(NIs=("BallisticProV55.NRP57Grenade","BallisticProV55.FP7Grenade","BallisticProV55.FP9Explosive","BallisticProV55.BX5Mine","BallisticProV55.T10Grenade"),R=True)
     DefaultSwaps(3)=(NIs=("BallisticProV55.M50AssaultRifle","BallisticProV55.SRS900Rifle","BallisticProV55.SARAssaultRifle"))
     DefaultSwaps(4)=(NIs=("BallisticProV55.A73SkrithRifle","BallisticProV55.HVCMk9LightningGun"))
     DefaultSwaps(5)=(NIs=("BallisticProV55.M353Machinegun","BallisticProV55.M925Machinegun","BallisticProV55.XMV850Minigun"))
     DefaultSwaps(6)=(NIs=("BallisticProV55.M763Shotgun","BallisticProV55.M290Shotgun","BallisticProV55.MRS138Shotgun"))
     DefaultSwaps(7)=(NIs=("BallisticProV55.G5Bazooka","BallisticProV55.RX22AFlamer"))
     DefaultSwaps(8)=(NIs=("BallisticProV55.R78Rifle","BallisticProV55.M75Railgun","BallisticProV55.R9RangerRifle"))
     DefaultSwaps(9)=(NIs=("BallisticProV55.M75Railgun","BallisticProV55.RX22AFlamer"))
     DefaultSwaps(10)=(NIs=("BallisticProV55.XMV850Minigun","BallisticProV55.RX22AFlamer"))
     DefaultSwaps(11)=(NIs=("BallisticProV55.M75Railgun","BallisticProV55.R78Rifle","BallisticProV55.R9RangerRifle"))
     DefaultSwaps(12)=(NIs=("BallisticProV55.G5Bazooka"))
     DefaultSwaps(13)=(NIs=("BallisticProV55.NRP57Grenade"))
     DefaultSwaps(14)=(NIs=("BallisticProV55.BX5Mine"))
     DefaultSwaps(15)=(NIs=("BallisticProV55.R78Rifle"))
}
