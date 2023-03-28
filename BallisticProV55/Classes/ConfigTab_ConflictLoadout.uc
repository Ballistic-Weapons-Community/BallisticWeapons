//=============================================================================
// ConfigTab_ConflictLoadout
//
// Server side options like rules that change the behaviour of the game and
// affect all players. These are used when hosting an MP or SP game.
//
// Edit By OJMoody
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_ConflictLoadout extends ConfigTabBase;

var Automated GUIImage		Box_Unused;				//All Unused Weapons
var Automated GUIImage		Box_UsedRed;			//Red Team
var Automated GUIImage		Box_UsedBlue;			//Blue Team
var Automated GUIButton		BAddBlue;				//Add to Blue
var Automated GUIButton		BRemoveBlue;			//Remove From Blue
var Automated GUIButton		BAddAllBlue;			//Fill Blue
var Automated GUIButton		BRemoveAllBlue;			//Empty Blue
var Automated GUIButton		BAddRed;				//Add to Red
var Automated GUIButton		BRemoveRed;				//Remove From Red
var Automated GUIButton		BAddAllRed;				//Fill Red
var Automated GUIButton		BRemoveAllRed;			//Empty Red
var automated GUIListBox	lb_UsedRedWeapons;		//Red Team List
var automated GUIListBox	lb_UsedBlueWeapons;		//Blue Team List
var automated GUIListBox	lb_UnusedWeapons;		//Unused List
var automated GUILabel		l_Red;					//Label Red
var automated GUILabel		l_Blue;					//Label Blue
var automated GUILabel		l_Unused;				//Label Unused
var automated moComboBox	co_LoadOpt;				//Loadout Options

var() localized string Headings[4];

//==================================================================
// General Menu Code
//==================================================================

function int WeaponRank(string PackageName, optional string ClassName, optional GUIListElem El)
{
//	local class<Weapon> W;

	if (PackageName == "I")
		return 50;
	if (El.ExtraData == lb_UsedRedWeapons)
		return 51;
	if (PackageName == "BW")
		return 0;
	if (InStr(PackageName, "Ballistic") != -1 || InStr(PackageName, "BWBP") != -1)
		return 1;
	if (InStr(PackageName, "JunkWar") != -1 || InStr(PackageName, "JWBP") != -1)
		return 2;
	if (PackageName == "UT")
		return 100;
	if (PackageName ~= "XWeapons" || PackageName ~= "UTClassic")
		return 101;
	if (InStr(PackageName, "Onslaught") != -1)
		return 150;
	if (PackageName == "O")
		return 200;
	if (El.ExtraData == self)
		return 10;
	return 210;
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
	local int i, j;
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
				else
				{
					for (j=0;j<L.Elements.length;j++)
						if (L.GetExtraAtIndex(j) ~= NewItem[i].ExtraStrData)
						{
							NewItem.Remove(i, 1);
							break;
						}
				}

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
	local GUIList L;

	L = lb_UnusedWeapons.List;

	if (bAccepted && Accepting != None)
	{
		L.GetPendingElements();
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
	local array<string> ItemNameList;
	local class<ConflictItem> CI;

	local class<BC_GameStyle> game_style;
	local WeaponList_ConflictLoadout ConfigList;
	
	Super.InitComponent(MyController, MyOwner);
	
	lb_UnusedWeapons.List.CompareItem = MyCompareItem;

	lb_UnusedWeapons.List.Add(Headings[0],,"BW",true);
	lb_UnusedWeapons.List.Add(Headings[1],,"I",true);
	lb_UnusedWeapons.List.Add(Headings[2],,"UT",true);
	lb_UnusedWeapons.List.Add(Headings[3],,"O",true);

	game_style = BaseMenu.GetGameStyle();

	if (game_style == None)
	{
		Log("ConfigTab_ConflictLoadout: Couldn't load: No compatible style found");
		return;
	}

	ConfigList = new(None, game_style.default.StyleName) class'WeaponList_ConflictLoadout';

	class'CacheManager'.static.GetWeaponList(Recs);

	for (i=0;i<Recs.Length;i++)
	{
		if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
			continue;
		
		for (j=0;j<ConfigList.ConflictWeapons.length;j++)
		{
			if (ConfigList.ConflictWeapons[j].ClassName ~= Recs[i].ClassName)
			{
				if (ConfigList.ConflictWeapons[j].bRed)
				{
					if (Recs[i].ClassName != "" && class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
						lb_UsedRedWeapons.List.Add(Recs[i].FriendlyName, self, Recs[i].ClassName);
					else
						lb_UsedRedWeapons.List.Add(Recs[i].FriendlyName, , Recs[i].ClassName);
				}
				if (ConfigList.ConflictWeapons[j].bBlue)
				{
					if (Recs[i].ClassName != "" && class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
						lb_UsedBlueWeapons.List.Add(Recs[i].FriendlyName, self, Recs[i].ClassName);
					else
						lb_UsedBlueWeapons.List.Add(Recs[i].FriendlyName, , Recs[i].ClassName);
				}
				break;
			}
		}
		
		if (Recs[i].ClassName != "" && class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			lb_UnusedWeapons.List.Add(Recs[i].FriendlyName, self, Recs[i].ClassName);
		else
			lb_UnusedWeapons.List.Add(Recs[i].FriendlyName, , Recs[i].ClassName);
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	PlayerOwner().GetAllInt("ConflictItem", ItemNameList);
	for(i=0;i<ItemNameList.length;i++)
	{
		CI = class<ConflictItem>(DynamicLoadObject(ItemNameList[i], class'Class'));
		if (CI != None)
		{
			for (j=0;j<ConfigList.ConflictWeapons.length;j++)
				if (ConfigList.ConflictWeapons[j].ClassName ~= ItemNameList[i])
				{
					if (ConfigList.ConflictWeapons[j].bRed)
						lb_UsedRedWeapons.List.Add(CI.default.ItemName, lb_UsedRedWeapons, ItemNameList[i]);
					if (ConfigList.ConflictWeapons[j].bBlue)
						lb_UsedBlueWeapons.List.Add(CI.default.ItemName, lb_UsedRedWeapons, ItemNameList[i]);
					break;
				}
			lb_UnusedWeapons.List.Add(CI.default.ItemName, lb_UsedRedWeapons, ItemNameList[i]);
		}
	}

    lb_UnusedWeapons.List.bDropSource = True;
    lb_UnusedWeapons.List.bDropTarget = True;
    lb_UnusedWeapons.List.OnDragDrop = InternalOnDragDrop;
	
    lb_UnusedWeapons.List.OnBeginDrag = lb_UnusedWeapons.List.InternalOnBeginDrag;
    lb_UnusedWeapons.List.OnEndDrag = InternalOnEndDrag;

	lb_UnusedWeapons.List.OnDblClick = InternalOnDblClick;

    lb_UsedRedWeapons.List.bDropSource = True;
    lb_UsedRedWeapons.List.bDropTarget = True;
    lb_UsedRedWeapons.List.OnDragDrop = InternalOnDragDrop;

    lb_UsedRedWeapons.List.OnBeginDrag = lb_UsedRedWeapons.List.InternalOnBeginDrag;
    lb_UsedRedWeapons.List.OnEndDrag = lb_UsedRedWeapons.List.InternalOnEndDrag;
	lb_UsedRedWeapons.List.OnDblClick = InternalOnDblClick;

    lb_UsedBlueWeapons.List.bDropSource = True;
    lb_UsedBlueWeapons.List.bDropTarget = True;
    lb_UsedBlueWeapons.List.OnDragDrop = InternalOnDragDrop;

    lb_UsedBlueWeapons.List.OnBeginDrag = lb_UsedBlueWeapons.List.InternalOnBeginDrag;
    lb_UsedBlueWeapons.List.OnEndDrag = lb_UsedBlueWeapons.List.InternalOnEndDrag;
	lb_UsedBlueWeapons.List.OnDblClick = InternalOnDblClick;
	
	for(i=0;i<class'Mut_ConflictLoadout'.default.LoadoutOptionText.Length;i++)
		co_LoadOpt.AddItem(class'Mut_ConflictLoadout'.default.LoadoutOptionText[i] ,,string(i));
	co_LoadOpt.ReadOnly(True);
	co_LoadOpt.SetIndex(int(ConfigList.LoadoutOption));
}

function bool InternalOnDblClick(GUIComponent Sender)
{
	if (Sender==lb_UnusedWeapons.List)
	{
		InternalOnClick(BAddRed);
		InternalOnClick(BAddBlue);
	}
	else if (Sender==lb_UsedRedWeapons.List)
		InternalOnClick(BRemoveRed);
	else if (Sender==lb_UsedBlueWeapons.List)
		InternalOnClick(BRemoveBlue);
	return true;
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i;

	if (Sender==BAddAllBlue) // ADD ALL
	{
		lb_UsedBlueWeapons.List.Clear();
		for (i=lb_UnusedWeapons.List.Elements.Length-1;i>-1;i--)
			if (!lb_UnusedWeapons.List.Elements[i].bSection)
				lb_UsedBlueWeapons.List.Add(lb_UnusedWeapons.List.GetItemAtIndex(i), , lb_UnusedWeapons.List.GetExtraAtIndex(i));
	}
	else if (Sender==BRemoveAllBlue) // REMOVE ALL
	{
		while(lb_UsedBlueWeapons.List.Elements.Length > 0)
			lb_UsedBlueWeapons.List.Remove(0);
	}
	else if (Sender==BAddBlue) // ADD
	{
		if (!lb_UnusedWeapons.List.IsSection())
		{
			for (i=0;i<lb_UsedBlueWeapons.List.Elements.length;i++)
				if (lb_UsedBlueWeapons.List.GetExtraAtIndex(i) == lb_UnusedWeapons.List.GetExtra())
					break;
			if (i>=lb_UsedBlueWeapons.List.Elements.length)
				lb_UsedBlueWeapons.List.Add(lb_UnusedWeapons.List.Get(), , lb_UnusedWeapons.List.GetExtra());
		}
	}
	else if (Sender==BRemoveBlue) // REMOVE
	{
		lb_UsedBlueWeapons.List.Remove(lb_UsedBlueWeapons.List.Index);
	}
	else if (Sender==BAddAllRed) // ADD ALL
	{
		lb_UsedRedWeapons.List.Clear();
		for (i=lb_UnusedWeapons.List.Elements.Length-1;i>-1;i--)
			if (!lb_UnusedWeapons.List.Elements[i].bSection)
				lb_UsedRedWeapons.List.Add(lb_UnusedWeapons.List.GetItemAtIndex(i), , lb_UnusedWeapons.List.GetExtraAtIndex(i));
	}
	else if (Sender==BRemoveAllRed) // REMOVE ALL
	{
		while(lb_UsedRedWeapons.List.Elements.Length > 0)
			lb_UsedRedWeapons.List.Remove(0);
	}
	else if (Sender==BAddRed) // ADD
	{
		if (!lb_UnusedWeapons.List.IsSection())
		{
			for (i=0;i<lb_UsedRedWeapons.List.Elements.length;i++)
				if (lb_UsedRedWeapons.List.GetExtraAtIndex(i) == lb_UnusedWeapons.List.GetExtra())
					break;
			if (i>=lb_UsedRedWeapons.List.Elements.length)
				lb_UsedRedWeapons.List.Add(lb_UnusedWeapons.List.Get(), , lb_UnusedWeapons.List.GetExtra());
		}
	}
	else if (Sender==BRemoveRed) // REMOVE
	{
		lb_UsedRedWeapons.List.Remove(lb_UsedRedWeapons.List.Index);
	}
	return true;
}

//==================================================================
// Settings & Defaults
//==================================================================

function SaveSettings()
{
	local int i, j, k;
	local class<BC_GameStyle> game_style;
	local WeaponList_ConflictLoadout ConfigList;

	game_style = BaseMenu.GetGameStyle();

	if (game_style == None)
	{
		Log("ConfigTab_ConflictLoadout: Couldn't save: No compatible style found");
		return;
	}

	ConfigList = new(None, game_style.default.StyleName) class'WeaponList_ConflictLoadout';
	
	ConfigList.LoadoutOption = co_LoadOpt.GetIndex();
	ConfigList.ConflictWeapons.length = 0;

	for (i=0;i<lb_UnusedWeapons.List.Elements.length;i++)
	{
		if (lb_UnusedWeapons.List.Elements[i].bSection)
			continue;
		k = ConfigList.ConflictWeapons.length;
		ConfigList.ConflictWeapons.length = k+1;
		ConfigList.ConflictWeapons[k].ClassName = lb_UnusedWeapons.List.GetExtraAtIndex(i);
		for (j=0;j<lb_UsedRedWeapons.List.Elements.length;j++)
			if (lb_UsedRedWeapons.List.GetExtraAtIndex(j) ~= lb_UnusedWeapons.List.GetExtraAtIndex(i))
			{
				ConfigList.ConflictWeapons[k].bRed = true;
				break;
			}
		for (j=0;j<lb_UsedBlueWeapons.List.Elements.length;j++)
			if (lb_UsedBlueWeapons.List.GetExtraAtIndex(j) ~= lb_UnusedWeapons.List.GetExtraAtIndex(i))
			{
				ConfigList.ConflictWeapons[k].bBlue = true;
				break;
			}
	}

	ConfigList.SaveConfig();

	SaveConfig();
}

function LoadSettings()
{
}

function DefaultSettings()
{
}

defaultproperties
{
     Begin Object Class=GUIImage Name=ImageBoxUnused
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.150000
         WinLeft=0.375000
         WinWidth=0.250000
         WinHeight=0.600000
         RenderWeight=0.002000
     End Object
     Box_Unused=ImageBoxUnused

     Begin Object Class=GUIImage Name=ImageBoxUsedRed
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.150000
         WinLeft=0.675000
         WinWidth=0.250000
         WinHeight=0.600000
         RenderWeight=0.002000
     End Object
     Box_UsedRed=ImageBoxUsedRed

     Begin Object Class=GUIImage Name=ImageBoxUsedBlue
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.150000
         WinLeft=0.075000
         WinWidth=0.250000
         WinHeight=0.600000
         RenderWeight=0.002000
     End Object
     Box_UsedBlue=ImageBoxUsedBlue

     Begin Object Class=GUIButton Name=AddButtonBlue
         Caption="< < <"
         WinTop=0.750000
         WinLeft=0.375000
         WinWidth=0.100000
         TabOrder=0
         OnClick=ConfigTab_ConflictLoadout.InternalOnClick
         OnKeyEvent=AddButton.InternalOnKeyEvent
     End Object
     bAddBlue=AddButtonBlue

     Begin Object Class=GUIButton Name=RemoveButtonBlue
         Caption="> > >"
         WinTop=0.750000
         WinLeft=0.225000
         WinWidth=0.100000
         TabOrder=0
         OnClick=ConfigTab_ConflictLoadout.InternalOnClick
         OnKeyEvent=RemoveButton.InternalOnKeyEvent
     End Object
     BRemoveBlue=RemoveButtonBlue

     Begin Object Class=GUIButton Name=AddAllButtonBlue
         Caption="FILL"
         WinTop=0.750000
         WinLeft=0.075000
         WinWidth=0.075000
         TabOrder=0
         OnClick=ConfigTab_ConflictLoadout.InternalOnClick
         OnKeyEvent=AddAllButton.InternalOnKeyEvent
     End Object
     BAddAllBlue=AddAllButtonBlue

     Begin Object Class=GUIButton Name=RemoveAllButtonBlue
         Caption="EMPTY"
         WinTop=0.750000
         WinLeft=0.150000
         WinWidth=0.075000
         TabOrder=0
         OnClick=ConfigTab_ConflictLoadout.InternalOnClick
         OnKeyEvent=RemoveAllButton.InternalOnKeyEvent
     End Object
     BRemoveAllBlue=RemoveAllButtonBlue

     Begin Object Class=GUIButton Name=AddButtonRed
         Caption="> > >"
         WinTop=0.750000
         WinLeft=0.525000
         WinWidth=0.100000
         TabOrder=0
         OnClick=ConfigTab_ConflictLoadout.InternalOnClick
         OnKeyEvent=AddButton.InternalOnKeyEvent
     End Object
     bAddRed=AddButtonRed

     Begin Object Class=GUIButton Name=RemoveButtonRed
         Caption="< < <"
         WinTop=0.750000
         WinLeft=0.675000
         WinWidth=0.100000
         TabOrder=0
         OnClick=ConfigTab_ConflictLoadout.InternalOnClick
         OnKeyEvent=RemoveButton.InternalOnKeyEvent
     End Object
     BRemoveRed=RemoveButtonRed

     Begin Object Class=GUIButton Name=AddAllButtonRed
         Caption="FILL"
         WinTop=0.750000
         WinLeft=0.850000
         WinWidth=0.075000
         TabOrder=0
         OnClick=ConfigTab_ConflictLoadout.InternalOnClick
         OnKeyEvent=AddAllButton.InternalOnKeyEvent
     End Object
     BAddAllRed=AddAllButtonRed

     Begin Object Class=GUIButton Name=RemoveAllButtonRed
         Caption="EMPTY"
         WinTop=0.750000
         WinLeft=0.775000
         WinWidth=0.075000
         TabOrder=0
         OnClick=ConfigTab_ConflictLoadout.InternalOnClick
         OnKeyEvent=RemoveAllButton.InternalOnKeyEvent
     End Object
     BRemoveAllRed=RemoveAllButtonRed

     Begin Object Class=GUIListBox Name=UsedRedWeaponList
         bVisibleWhenEmpty=True
         OnCreateComponent=UsedWeaponList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="List of the weapons for red team. Be careful to make sure there are always some available weapons when using evolution mode."
         WinTop=0.190000
         WinLeft=0.685000
         WinWidth=0.230000
         WinHeight=0.550000
         RenderWeight=0.510000
         TabOrder=1
     End Object
     lb_UsedRedWeapons=UsedRedWeaponList

     Begin Object Class=GUIListBox Name=UsedBlueWeaponList
         bVisibleWhenEmpty=True
         OnCreateComponent=UsedWeaponList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="List of the weapons for blue team. Be careful to make sure there are always some available weapons when using evolution mode."
         WinTop=0.190000
         WinLeft=0.085000
         WinWidth=0.230000
         WinHeight=0.550000
         RenderWeight=0.510000
         TabOrder=1
     End Object
     lb_UsedBlueWeapons=UsedBlueWeaponList

     Begin Object Class=GUIListBox Name=UnusedWeaponList
         bVisibleWhenEmpty=True
         bSorted=True
         OnCreateComponent=UnusedWeaponList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="List of weapons that you can give to the teams."
         WinTop=0.190000
         WinLeft=0.386000
         WinWidth=0.230000
         WinHeight=0.550000
         RenderWeight=0.510000
         TabOrder=1
     End Object
     lb_UnusedWeapons=UnusedWeaponList

     Begin Object Class=GUILabel Name=RedLabel
         Caption="Red"
         TextAlign=TXTA_Center
         TextColor=(B=0,R=255)
         FontScale=FNS_Small
         WinTop=0.150000
         WinLeft=0.700000
         WinWidth=0.200000
         WinHeight=0.040000
     End Object
     l_Red=RedLabel

     Begin Object Class=GUILabel Name=BlueLabel
         Caption="Blue"
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255)
         FontScale=FNS_Small
         WinTop=0.150000
         WinLeft=0.100000
         WinWidth=0.200000
         WinHeight=0.040000
     End Object
     l_Blue=BlueLabel

     Begin Object Class=GUILabel Name=UnusedLabel
         Caption="Potentials"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Small
         WinTop=0.150000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.040000
     End Object
     l_Unused=UnusedLabel

     Begin Object Class=moComboBox Name=LoadOptCombo
         OnCreateComponent=LoadOptCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Choose the type of loadout."
         WinTop=0.825000
         WinLeft=0.275000
         WinWidth=0.300000
     End Object
     co_LoadOpt=LoadOptCombo

     Headings(0)="Ballistic Weapons"
     Headings(1)="Items"
     Headings(2)="UT2004 Standard"
     Headings(3)="Other"
}