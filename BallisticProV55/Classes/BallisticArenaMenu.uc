//=============================================================================
// BallisticArenaMenu.
//
// Menu for Ballistic arena Mutator. This includes a list of spare weapons, a
// list of weapons to go into play and some buttons to Add, Remove, Ok, Cancel,
// empty, Fill. Weapons can also be dragged from list to list.
// A Preset system is included to quick load, save and delete sets of weapons.
//
// ** v2.0 Update **
// -Added sections to unused list
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticArenaMenu extends UT2K4GUIPage;

var Automated GUIImage		MyBack, Box_Unused, Box_Used;
var Automated GUIButton		BDone, BCancel, BAdd, BRemove, BSave, BDelete, BAddAll, BRemoveAll, BBWOps;
var automated GUIHeader		MyHeader;
var automated GUIListBox	lb_UsedWeapons, lb_UnusedWeapons;
var automated moCheckbox	ch_Random, ch_PerSpawn;
var automated GUIComboBox	cb_Presets;
var automated GUILabel   	l_PresetLabel;

struct ArenaPreset
{
	var() config string			PresetName;
	var() config array<string>	WeaponClassNames;
};
var() config Array<ArenaPreset>		Presets;

var() localized string Headings[3];

function int WeaponRank(string PackageName, optional string ClassName, optional GUIListElem El)
{
//	local class<Weapon> W;

	if (PackageName == "BW")
		return 0;
	if (InStr(PackageName, "Ballistic") != -1 || InStr(PackageName, "BWBP") != -1 || InStr(PackageName, "RedGunPack") != -1)
		return 1;
	if (InStr(PackageName, "JunkWar") != -1 || InStr(PackageName, "JWBP") != -1)
		return 2;
	if (PackageName == "UT")
		return 50;
	if (PackageName ~= "XWeapons" || PackageName ~= "UTClassic")
		return 51;
	if (InStr(PackageName, "Onslaught") != -1)
		return 55;
	if (PackageName == "O")
		return 100;
	if (El.ExtraData == self)
		return 10;
	// Tap into the BW weapon cache system to identify BallisticWeapons without loading them
//	if (ClassName != "" && class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ClassName).bIsBW)
//		return 10;
	return 110;
}

// Used by SortList.
function int MyCompareItem(GUIListElem ElemA, GUIListElem ElemB)
{
	local int i, AR, BR;

	if (ElemA.bSection)
		AR = WeaponRank(ElemA.ExtraStrData);
	else
	{
		i = InStr(ElemA.ExtraStrData, ".");
		if (i > 0)
			AR = WeaponRank(left(ElemA.ExtraStrData, i), ElemA.ExtraStrData, ElemA);
	}

	if (ElemB.bSection)
		BR = WeaponRank(ElemB.ExtraStrData);
	else
	{
		i = InStr(ElemB.ExtraStrData, ".");
		if (i > 0)
			BR = WeaponRank(left(ElemB.ExtraStrData, i), ElemB.ExtraStrData, ElemB);
	}

	if (AR == BR)
		return StrCmp(ElemA.Item, ElemB.Item);
	else
		return AR-BR;
}

function bool InternalOnDragDrop(GUIComponent Sender)
{
	local array<GUIListElem> NewItem;
	local int i;
	local GUIList L;

	L = GUIList(Sender);
	if (L != None && Sender.Controller.DropTarget == Sender)
	{
		if (Sender.Controller.DropSource == L)
			return false;

		if (Sender.Controller.DropSource != None && GUIList(Sender.Controller.DropSource) != None)
		{
			NewItem = GUIList(Sender.Controller.DropSource).GetPendingElements();
			for (i=NewItem.Length;i>-1;i--)
				if (NewItem[i].bSection)
					NewItem.Remove(i, 1);

			if ( !L.IsValidIndex(L.DropIndex) )
				L.DropIndex = L.ItemCount;

			for (i = NewItem.Length - 1; i >= 0; i--)
				L.Insert(L.DropIndex, NewItem[i].Item, NewItem[i].ExtraData, NewItem[i].ExtraStrData);

			L.SetIndex(L.DropIndex);
			return true;
		}
	}
	return false;
}

function InternalOnEndDrag(GUIComponent Accepting, bool bAccepted)
{
	local int i;
	local GUIList L;

	L = lb_UnusedWeapons.List;

	if (bAccepted && Accepting != None)
	{
		L.GetPendingElements();
		if ( Accepting != Self )
		{
			for ( i = 0; i < L.SelectedElements.Length; i++ )
				if (!L.SelectedElements[i].bSection)
					L.RemoveElement(L.SelectedElements[i]);
		}

		L.bRepeatClick = False;
	}

	// Simulate repeat click if the operation was a failure to prevent InternalOnMouseRelease from clearing
	// the SelectedItems array
	// This way we don't lose the items we clicked on
	if (Accepting == None)
		L.bRepeatClick = True;

	L.SetOutlineAlpha(255);
	if ( L.bNotify )
		L.CheckLinkedObjects(L);
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local array<CacheManager.WeaponRecord> Recs;
	local int i, j;

	Super.InitComponent(MyController, MyOwner);

	for(i=0;i<Presets.length;i++)
	    cb_Presets.AddItem(Presets[i].PresetName,,string(i));
	cb_Presets.SetText("");

	lb_UnusedWeapons.List.CompareItem = MyCompareItem;

	lb_UnusedWeapons.List.Add(Headings[0],,"BW",true);
	lb_UnusedWeapons.List.Add(Headings[1],,"UT",true);
	lb_UnusedWeapons.List.Add(Headings[2],,"O",true);

	class'CacheManager'.static.GetWeaponList(Recs);
	
	for (i=0;i<Recs.Length;i++)
	{
		if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
			continue;
		
		for (j=0;j<class'Mut_BallisticArena'.default.WeaponClassNames.length;j++)
			if (class'Mut_BallisticArena'.default.WeaponClassNames[j] ~= Recs[i].ClassName)
			{
				if (Recs[i].ClassName != "" && class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
					lb_UsedWeapons.List.Add(Recs[i].FriendlyName, self, Recs[i].ClassName);
				else
					lb_UsedWeapons.List.Add(Recs[i].FriendlyName, , Recs[i].ClassName);
				break;
			}
		if (j >= class'Mut_BallisticArena'.default.WeaponClassNames.length)
		{
			if (Recs[i].ClassName != "" && class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
				lb_UnusedWeapons.List.Add(Recs[i].FriendlyName, self, Recs[i].ClassName);
			else
				lb_UnusedWeapons.List.Add(Recs[i].FriendlyName, , Recs[i].ClassName);
		}
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	ch_Random.Checked(class'Mut_BallisticArena'.default.bRandomPickOne);
	ch_PerSpawn.Checked(class'Mut_BallisticArena'.default.bRandomPerSpawn);

    lb_UnusedWeapons.List.bDropSource = True;
    lb_UnusedWeapons.List.bDropTarget = True;
    lb_UnusedWeapons.List.OnDragDrop = InternalOnDragDrop;
//    lb_UnusedWeapons.List.OnDragDrop = lb_UnusedWeapons.List.InternalOnDragDrop;
//    lb_UnusedWeapons.List.OnBeginDrag = InternalOnBeginDrag;
    lb_UnusedWeapons.List.OnBeginDrag = lb_UnusedWeapons.List.InternalOnBeginDrag;
    lb_UnusedWeapons.List.OnEndDrag = InternalOnEndDrag;
//    lb_UnusedWeapons.List.OnEndDrag = lb_UnusedWeapons.List.InternalOnEndDrag;
	lb_UnusedWeapons.List.OnDblClick = InternalOnDblClick;

    lb_UsedWeapons.List.bDropSource = True;
    lb_UsedWeapons.List.bDropTarget = True;
    lb_UsedWeapons.List.OnDragDrop = InternalOnDragDrop;
//    lb_UsedWeapons.List.OnDragDrop = lb_UsedWeapons.List.InternalOnDragDrop;
    lb_UsedWeapons.List.OnBeginDrag = lb_UsedWeapons.List.InternalOnBeginDrag;
    lb_UsedWeapons.List.OnEndDrag = lb_UsedWeapons.List.InternalOnEndDrag;
	lb_UsedWeapons.List.OnDblClick = InternalOnDblClick;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(BDone);

	return false;
}

function InternalOnClose(optional Bool bCanceled)
{
	Super.OnClose(bCanceled);
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i;
	local ArenaPreset NewPreset;

	if (Sender==BCancel) // CANCEL
		Controller.CloseMenu();
	else if (Sender==BSave) // Save Preset
	{
		for(i=0;i<lb_UsedWeapons.List.Elements.length;i++)
			NewPreset.WeaponClassNames[i] = lb_UsedWeapons.List.GetExtraAtIndex(i);
		NewPreset.PresetName = cb_Presets.GetText();
		for (i=0;i<Presets.Length;i++)
			if (Presets[i].PresetName ~= NewPreset.PresetName)
				NewPreset.PresetName $= "2";
		Presets[Presets.Length] = NewPreset;
	    cb_Presets.AddItem(NewPreset.PresetName,,string(Presets.Length-1));
		SaveConfig();
	}
	else if (Sender==BDelete) // Delete Preset
	{
		for(i=0;i<Presets.length;i++)
		{
			if (Presets[i].PresetName ~= cb_Presets.GetText())
			{
				Presets.Remove(i,1);
				cb_Presets.RemoveItem(cb_Presets.Index);
				SaveConfig();
				break;
			}
		}
	}
	else if (Sender==BAddAll) // ADD ALL
	{
		for (i=lb_UnusedWeapons.List.Elements.Length-1;i>-1;i--)
			if (!lb_UnusedWeapons.List.Elements[i].bSection)
			{
				lb_UsedWeapons.List.Add(lb_UnusedWeapons.List.GetItemAtIndex(i), , lb_UnusedWeapons.List.GetExtraAtIndex(i));
				lb_UnusedWeapons.List.Remove(i);
			}
	}
	else if (Sender==BRemoveAll) // REMOVE ALL
	{
		while(lb_UsedWeapons.List.Elements.Length > 0)
		{
			lb_UnusedWeapons.List.Add(lb_UsedWeapons.List.GetItemAtIndex(0), , lb_UsedWeapons.List.GetExtraAtIndex(0));
			lb_UsedWeapons.List.Remove(0);
		}
	}
	else if (Sender==BAdd) // ADD
	{
		if (!lb_UnusedWeapons.List.IsSection())
		{
			lb_UsedWeapons.List.Add(lb_UnusedWeapons.List.Get(), , lb_UnusedWeapons.List.GetExtra());
			lb_UnusedWeapons.List.Remove(lb_UnusedWeapons.List.Index);
		}
	}
	else if (Sender==BRemove) // REMOVE
	{

		lb_UnusedWeapons.List.Add(lb_UsedWeapons.List.Get(), , lb_UsedWeapons.List.GetExtra());
		lb_UsedWeapons.List.Remove(lb_UsedWeapons.List.Index);
	}
	else if (Sender==BDone) // DONE
	{
		if (lb_UsedWeapons.List.Elements.length < 1)
			class'Mut_BallisticArena'.default.WeaponClassNames.length = 1;
		else
		{
			class'Mut_BallisticArena'.default.WeaponClassNames.length = 0;
			for (i=0;i<lb_UsedWeapons.List.Elements.length;i++)
				class'Mut_BallisticArena'.default.WeaponClassNames[i] = lb_UsedWeapons.List.GetExtraAtIndex(i);

		}
		class'Mut_BallisticArena'.default.bRandomPickOne = ch_Random.IsChecked();
		class'Mut_BallisticArena'.default.bRandomPerSpawn = ch_PerSpawn.IsChecked();
		class'Mut_BallisticArena'.static.StaticSaveConfig();
		Controller.CloseMenu();
	}
	else if (Sender==BBWOps) // Options
		Controller.OpenMenu("BallisticProV55.ConfigMenu_Inventory");

	return true;
}

function bool InternalOnDblClick(GUIComponent Sender)
{
	if (Sender==lb_UnusedWeapons.List)
		InternalOnClick(BAdd);
	else if (Sender==lb_UsedWeapons.List)
		InternalOnClick(BRemove);
	return true;
}

function InternalOnChange(GUIComponent Sender)
{
	local int i, j;

	if (Sender == cb_Presets && cb_Presets.GetExtra() != "")
	{
		while(lb_UsedWeapons.List.Elements.Length > 0)
		{
			lb_UnusedWeapons.List.Add(lb_UsedWeapons.List.GetItemAtIndex(0), , lb_UsedWeapons.List.GetExtraAtIndex(0));
			lb_UsedWeapons.List.Remove(0);
		}
		for (i=0;i<Presets[int(cb_Presets.GetExtra())].WeaponClassNames.Length;i++)
		{
			for (j=0;j<lb_UnusedWeapons.List.Elements.length;j++)
			{
				if (lb_UnusedWeapons.List.GetExtraAtIndex(j) ~= Presets[int(cb_Presets.GetExtra())].WeaponClassNames[i])
				{
					lb_UsedWeapons.List.Add(lb_UnusedWeapons.List.GetItemAtIndex(j),, lb_UnusedWeapons.List.GetExtraAtIndex(j));
					lb_UnusedWeapons.List.Remove(j);
					break;
				}
			}
		}
	}
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinTop=0.200000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.700000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.BallisticArenaMenu.BackImage'

     Begin Object Class=GUIImage Name=ImageBoxUnused
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.225000
         WinLeft=0.087500
         WinWidth=0.375000
         WinHeight=0.500000
         RenderWeight=0.002000
     End Object
     Box_Unused=GUIImage'BallisticProV55.BallisticArenaMenu.ImageBoxUnused'

     Begin Object Class=GUIImage Name=ImageBoxUsed
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.225000
         WinLeft=0.537500
         WinWidth=0.375000
         WinHeight=0.500000
         RenderWeight=0.002000
     End Object
     Box_Used=GUIImage'BallisticProV55.BallisticArenaMenu.ImageBoxUsed'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.525000
         WinLeft=0.450000
         WinWidth=0.100000
         TabOrder=0
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.BallisticArenaMenu.DoneButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         WinTop=0.575000
         WinLeft=0.450000
         WinWidth=0.100000
         TabOrder=1
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bCancel=GUIButton'BallisticProV55.BallisticArenaMenu.CancelButton'

     Begin Object Class=GUIButton Name=AddButton
         Caption="ADD"
         WinTop=0.375000
         WinLeft=0.450000
         WinWidth=0.100000
         TabOrder=0
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=AddButton.InternalOnKeyEvent
     End Object
     bAdd=GUIButton'BallisticProV55.BallisticArenaMenu.AddButton'

     Begin Object Class=GUIButton Name=RemoveButton
         Caption="REMOVE"
         WinTop=0.425000
         WinLeft=0.450000
         WinWidth=0.100000
         TabOrder=0
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=RemoveButton.InternalOnKeyEvent
     End Object
     bRemove=GUIButton'BallisticProV55.BallisticArenaMenu.RemoveButton'

     Begin Object Class=GUIButton Name=SaveButton
         Caption="SAVE"
         WinTop=0.740000
         WinLeft=0.725000
         WinWidth=0.100000
         TabOrder=0
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=SaveButton.InternalOnKeyEvent
     End Object
     bSave=GUIButton'BallisticProV55.BallisticArenaMenu.SaveButton'

     Begin Object Class=GUIButton Name=DeleteButton
         Caption="DELETE"
         WinTop=0.740000
         WinLeft=0.825000
         WinWidth=0.100000
         TabOrder=0
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=DeleteButton.InternalOnKeyEvent
     End Object
     BDelete=GUIButton'BallisticProV55.BallisticArenaMenu.DeleteButton'

     Begin Object Class=GUIButton Name=AddAllButton
         Caption="FILL"
         WinTop=0.250000
         WinLeft=0.450000
         WinWidth=0.100000
         TabOrder=0
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=AddAllButton.InternalOnKeyEvent
     End Object
     BAddAll=GUIButton'BallisticProV55.BallisticArenaMenu.AddAllButton'

     Begin Object Class=GUIButton Name=RemoveAllButton
         Caption="EMPTY"
         WinTop=0.300000
         WinLeft=0.450000
         WinWidth=0.100000
         TabOrder=0
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=RemoveAllButton.InternalOnKeyEvent
     End Object
     BRemoveAll=GUIButton'BallisticProV55.BallisticArenaMenu.RemoveAllButton'

     Begin Object Class=GUIButton Name=BBWOpsButton
         Caption="Options"
         WinTop=0.650000
         WinLeft=0.450000
         WinWidth=0.100000
         TabOrder=1
         OnClick=BallisticArenaMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     BBWOps=GUIButton'BallisticProV55.BallisticArenaMenu.BBWOpsButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Ballistic Arena Options"
         WinTop=0.200000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.700000
     End Object
     MyHeader=GUIHeader'BallisticProV55.BallisticArenaMenu.DaBeegHeader'

     Begin Object Class=GUIListBox Name=UsedWeaponList
         bVisibleWhenEmpty=True
         OnCreateComponent=UsedWeaponList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Used Weapons. Drag, Double click or use Remove button to take them out the match."
         WinTop=0.270000
         WinLeft=0.550000
         WinWidth=0.350000
         WinHeight=0.425000
         RenderWeight=0.510000
         TabOrder=1
     End Object
     lb_UsedWeapons=GUIListBox'BallisticProV55.BallisticArenaMenu.UsedWeaponList'

     Begin Object Class=GUIListBox Name=UnusedWeaponList
         bVisibleWhenEmpty=True
         bSorted=True
         OnCreateComponent=UnusedWeaponList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Spare Weapons. Drag, Double click or use Add button to put them in the match."
         WinTop=0.270000
         WinLeft=0.100000
         WinWidth=0.350000
         WinHeight=0.425000
         RenderWeight=0.510000
         TabOrder=1
     End Object
     lb_UnusedWeapons=GUIListBox'BallisticProV55.BallisticArenaMenu.UnusedWeaponList'

     Begin Object Class=moCheckBox Name=RandomCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="One Random Weapon"
         OnCreateComponent=RandomCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Gives players one random weapon from the list of weapons you have chosen."
         WinTop=0.800000
         WinLeft=0.550000
         WinWidth=0.350000
         WinHeight=0.040000
     End Object
     ch_Random=moCheckBox'BallisticProV55.BallisticArenaMenu.RandomCheck'

     Begin Object Class=moCheckBox Name=PerSpawnCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Random Per Spawn"
         OnCreateComponent=PerSpawnCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Players get a different random weapon from the chosen list each time they spawn."
         WinTop=0.800000
         WinLeft=0.100000
         WinWidth=0.350000
         WinHeight=0.040000
     End Object
     ch_PerSpawn=moCheckBox'BallisticProV55.BallisticArenaMenu.PerSpawnCheck'

     Begin Object Class=GUIComboBox Name=PresetsComboBox
         Hint="Pick a preset list of weapons."
         WinTop=0.740000
         WinLeft=0.400000
         WinWidth=0.300000
         WinHeight=0.030000
         TabOrder=0
         OnChange=BallisticArenaMenu.InternalOnChange
         OnKeyEvent=PresetsComboBox.InternalOnKeyEvent
     End Object
     cb_Presets=GUIComboBox'BallisticProV55.BallisticArenaMenu.PresetsComboBox'

     Begin Object Class=GUILabel Name=PresetLabel
         Caption="Presets"
         TextAlign=TXTA_Right
         TextColor=(B=255,G=255,R=255)
         bMultiLine=True
         FontScale=FNS_Large
         WinTop=0.740000
         WinLeft=0.100000
         WinWidth=0.275000
         WinHeight=0.030000
     End Object
     l_PresetLabel=GUILabel'BallisticProV55.BallisticArenaMenu.PresetLabel'

     Presets(0)=(PresetName="Sidearm Shootout",WeaponClassNames=("BallisticProV55.M806Pistol","BallisticProV55.A42SkrithPistol","BallisticProV55.XK2SubMachinegun","BallisticProV55.MRT6Shotgun","BallisticProV55.AM67Pistol","BallisticProV55.D49Revolver","BallisticProV55.Fifty9MachinePistol","BallisticProV55.RS8Pistol","BallisticProV55.XRS10SubMachinegun"))
     Presets(1)=(PresetName="Monster Weapons",WeaponClassNames=("BallisticProV55.G5Bazooka","BallisticProV55.HVCMk9LightningGun","BallisticProV55.M75Railgun","BallisticProV55.RX22AFlamer","BallisticProV55.XMV850Minigun"))
     Presets(2)=(PresetName="Shotgun Arena",WeaponClassNames=("BallisticProV55.MRT6Shotgun","BallisticProV55.M763Shotgun","BallisticProV55.M290Shotgun","BallisticProV55.MRS138Shotgun"))
     Presets(3)=(PresetName="Sniper Arena",WeaponClassNames=("BallisticProV55.M75Railgun","BallisticProV55.R78Rifle","BallisticProV55.SRS900Rifle"))
     Presets(4)=(PresetName="Tricks n Traps",WeaponClassNames=("BallisticProV55.NRP57Grenade","BallisticProV55.FP7Grenade","BallisticProV55.FP9Explosive","BallisticProV55.BX5Mine","BallisticProV55.T10Grenade"))
     Presets(5)=(PresetName="Assault Weapons",WeaponClassNames=("BallisticProV55.MRS138Shotgun","BallisticProV55.RS8Pistol","BallisticProV55.SRS900Rifle","BallisticProV55.AM67Pistol","BallisticProV55.M290Shotgun","BallisticProV55.M353Machinegun","BallisticProV55.M50AssaultRifle","BallisticProV55.M763Shotgun","BallisticProV55.M806Pistol","BallisticProV55.M925Machinegun","BallisticProV55.NRP57Grenade","BallisticProV55.X3Knife","BallisticProV55.XK2SubMachinegun"))
     Presets(6)=(PresetName="Machinegun Battle",WeaponClassNames=("BallisticProV55.M353Machinegun","BallisticProV55.M925Machinegun","BallisticProV55.XMV850Minigun"))
     Presets(7)=(PresetName="Blade Match",WeaponClassNames=("BallisticProV55.X3Knife","BallisticProV55.A909SkrithBlades","BallisticProV55.EKS43Katana"))
     Presets(8)=(PresetName="UT2004 Stuff",WeaponClassNames=("XWeapons.AssaultRifle","XWeapons.BioRifle","XWeapons.FlakCannon","XWeapons.Painter","XWeapons.SniperRifle","XWeapons.LinkGun","XWeapons.Minigun","XWeapons.Redeemer","XWeapons.RocketLauncher","XWeapons.ShieldGun","XWeapons.ShockRifle","UTClassic.ClassicSniperRifle","XWeapons.Translauncher","Onslaught.ONSAVRiL","Onslaught.ONSGrenadeLauncher","Onslaught.ONSMineLayer","OnslaughtFull.ONSPainter"))
     Headings(0)="Ballistic Weapons"
     Headings(1)="UT2004 Standard"
     Headings(2)="Other"
     bRenderWorld=True
     bAllowedAsLast=True
     OnClose=BallisticArenaMenu.InternalOnClose
     OnKeyEvent=BallisticArenaMenu.InternalOnKeyEvent
}
