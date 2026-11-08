//=============================================================================
// GunGameWeaponMenu
//
// The Weapon List button of GunGame's game options. Spare weapons on the left,
// GunGame's level order on the right: the first weapon is the standard weapon,
// the last one wins. Saves GunGameConfig.WeaponList (GunGameBW.ini); a list the
// same as the stock one is saved as no list, so the stock list keeps up with
// new versions.
//=============================================================================
class GunGameWeaponMenu extends UT2K4GUIPage;

var automated GUIImage		MyBack, Box_Spare, Box_Levels;
var automated GUIHeader		MyHeader;
var automated GUILabel		l_Spare, l_Levels, l_Status;
var automated GUIListBox	lb_Spare, lb_Levels;
var automated GUIButton		b_Add, b_Remove, b_Up, b_Down, b_Reset, b_Done, b_Cancel;

var() localized string		Headings[3];
var() localized string		LevelsCaption, TooFewText;

var BC_ListSearch			Search;		// the search row over the spare list

//=============================================================================
// Spare list order: Ballistic weapons, then UT2004, then the rest (as the Arena menu)
//=============================================================================
function int WeaponRank(string PackageName, optional GUIListElem El)
{
	if (PackageName == "BW")
		return 0;
	if (InStr(PackageName, "Ballistic") != -1 || InStr(PackageName, "BWBP") != -1)
		return 1;
	if (PackageName == "UT")
		return 50;
	if (PackageName ~= "XWeapons" || PackageName ~= "UTClassic" || InStr(PackageName, "Onslaught") != -1)
		return 51;
	if (PackageName == "O")
		return 100;
	if (El.ExtraData == self)
		return 10;
	return 110;
}

function int CompareSpare(GUIListElem ElemA, GUIListElem ElemB)
{
	local int AR, BR;

	AR = ElemRank(ElemA);
	BR = ElemRank(ElemB);

	if (AR == BR)
		return StrCmp(ElemA.Item, ElemB.Item);
	return AR - BR;
}

function int ElemRank(GUIListElem E)
{
	local int i;

	if (E.bSection)
		return WeaponRank(E.ExtraStrData);

	i = InStr(E.ExtraStrData, ".");
	if (i > 0)
		return WeaponRank(Left(E.ExtraStrData, i), E);
	return 110;
}

//=============================================================================
// Setup
//=============================================================================
function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

	lb_Spare.List.CompareItem = CompareSpare;
	lb_Spare.List.OnDblClick = InternalOnDblClick;
	lb_Levels.List.OnDblClick = InternalOnDblClick;
	lb_Levels.List.OnChange = InternalOnChange;

	if (class'GunGameConfig'.default.WeaponList.Length > 0)
		FillLists(class'GunGameConfig'.default.WeaponList);
	else
		FillLists(class'GunGameConfig'.default.StockWeaponList);

	Search = class'BC_ListSearch'.static.Create(self, lb_Spare, lb_Spare.List);
}

// Puts every known weapon in the spare list except those in Order, which go in the level list in its order
function FillLists(array< class<Weapon> > Order)
{
	local array<CacheManager.WeaponRecord> Recs;
	local array<string> Names, Friendly;
	local int i, j;
	local bool bBW;

	if (Search != None)
		Search.ShowAll();
	lb_Spare.List.Clear();
	lb_Levels.List.Clear();

	lb_Spare.List.Add(Headings[0],, "BW", true);
	lb_Spare.List.Add(Headings[1],, "UT", true);
	lb_Spare.List.Add(Headings[2],, "O", true);

	Names.Length = Order.Length;
	Friendly.Length = Order.Length;
	for (i = 0; i < Order.Length; i++)
		if (Order[i] != None)
			Names[i] = string(Order[i]);

	class'CacheManager'.static.GetWeaponList(Recs);

	for (i = 0; i < Recs.Length; i++)
	{
		if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
			continue;

		bBW = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW;

		for (j = 0; j < Names.Length; j++)
			if (Names[j] ~= Recs[i].ClassName)
				break;

		if (j < Names.Length)
			Friendly[j] = Recs[i].FriendlyName;
		else if (bBW)
			lb_Spare.List.Add(Recs[i].FriendlyName, self, Recs[i].ClassName);
		else
			lb_Spare.List.Add(Recs[i].FriendlyName,, Recs[i].ClassName);
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	lb_Spare.List.Sort();

	for (i = 0; i < Names.Length; i++)
	{
		if (Names[i] == "")
			continue;
		if (Friendly[i] == "")	// not in the weapon cache: show the class name
			Friendly[i] = Mid(Names[i], InStr(Names[i], ".") + 1);
		lb_Levels.List.Add("0. " $ Friendly[i],, Names[i]);
	}

	Renumber();
	lb_Levels.List.SetIndex(0);

	if (Search != None)
		Search.Refresh();
}

//=============================================================================
// Level list text: "12. Name". Every level item has a number in front, so the
// name is what follows the first ". "
//=============================================================================
function string WeaponName(string ItemText)
{
	return Mid(ItemText, InStr(ItemText, ". ") + 2);
}

function Renumber()
{
	local int i;

	for (i = 0; i < lb_Levels.List.ItemCount; i++)
		lb_Levels.List.SetItemAtIndex(i, (i + 1) $ ". " $ WeaponName(lb_Levels.List.GetItemAtIndex(i)));

	l_Levels.Caption = LevelsCaption @ "(" $ lb_Levels.List.ItemCount $ ")";
	l_Status.Caption = "";
	UpdateButtons();
}

function UpdateButtons()
{
	local int i;

	i = lb_Levels.List.Index;
	if (i > 0)
		b_Up.EnableMe();
	else
		b_Up.DisableMe();

	if (i >= 0 && i < lb_Levels.List.ItemCount - 1)
		b_Down.EnableMe();
	else
		b_Down.DisableMe();

	if (lb_Levels.List.ItemCount >= class'GunGameConfig'.static.MaxWeapons())
		b_Add.DisableMe();
	else
		b_Add.EnableMe();
}

function InternalOnChange(GUIComponent Sender)
{
	UpdateButtons();
}

//=============================================================================
// Buttons
//=============================================================================
function AddSelected()
{
	local int At;
	local string ClassName, WeapName;
	local GUIList L;

	L = lb_Spare.List;
	if (L.Index < 0 || L.IsSection() || lb_Levels.List.ItemCount >= class'GunGameConfig'.static.MaxWeapons())
		return;

	WeapName = L.Get();
	ClassName = L.GetExtra();
	L.Remove(L.Index);

	// after the selected level, or at the end
	At = lb_Levels.List.Index + 1;
	if (At <= 0 || At > lb_Levels.List.ItemCount)
		At = lb_Levels.List.ItemCount;

	lb_Levels.List.Insert(At, "0. " $ WeapName,, ClassName, true);
	Renumber();
	lb_Levels.List.SetIndex(At);
	Search.Refresh();
}

function RemoveSelected()
{
	local int i;
	local string ClassName;

	i = lb_Levels.List.Index;
	if (i < 0)
		return;

	ClassName = lb_Levels.List.GetExtra();
	if (class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ClassName).bIsBW)
		lb_Spare.List.Add(WeaponName(lb_Levels.List.Get()), self, ClassName);
	else
		lb_Spare.List.Add(WeaponName(lb_Levels.List.Get()),, ClassName);
	class'BC_WeaponInfoCache'.static.EndSession();
	lb_Spare.List.Sort();

	lb_Levels.List.Remove(i);
	Renumber();
	lb_Levels.List.SetIndex(Min(i, lb_Levels.List.ItemCount - 1));
	Search.Refresh();
}

function Move(int Dir)
{
	local int i;

	i = lb_Levels.List.Index;
	if (i < 0 || i + Dir < 0 || i + Dir >= lb_Levels.List.ItemCount)
		return;

	lb_Levels.List.Swap(i, i + Dir);
	Renumber();
	lb_Levels.List.SetIndex(i + Dir);
}

function bool SameAsStock(array< class<Weapon> > List)
{
	local int i;

	if (List.Length != class'GunGameConfig'.default.StockWeaponList.Length)
		return false;
	for (i = 0; i < List.Length; i++)
		if (List[i] != class'GunGameConfig'.default.StockWeaponList[i])
			return false;
	return true;
}

function bool Save()
{
	local array< class<Weapon> > List;
	local class<Weapon> W;
	local int i;

	for (i = 0; i < lb_Levels.List.ItemCount; i++)
	{
		W = class<Weapon>(DynamicLoadObject(lb_Levels.List.GetExtraAtIndex(i), class'Class', true));
		if (W != None)
			List[List.Length] = W;
	}

	if (List.Length < class'GunGameConfig'.static.MinWeapons())
	{
		l_Status.Caption = TooFewText;
		return false;
	}

	if (SameAsStock(List))
	{
		class'GunGameConfig'.default.WeaponList.Length = 0;
		class'GunGameConfig'.static.StaticClearConfig("WeaponList");
	}
	else
	{
		class'GunGameConfig'.default.WeaponList = List;
		class'GunGameConfig'.static.StaticSaveConfig();
	}
	return true;
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender == b_Add)
		AddSelected();
	else if (Sender == b_Remove)
		RemoveSelected();
	else if (Sender == b_Up)
		Move(-1);
	else if (Sender == b_Down)
		Move(1);
	else if (Sender == b_Reset)
		FillLists(class'GunGameConfig'.default.StockWeaponList);
	else if (Sender == b_Cancel)
		Controller.CloseMenu(true);
	else if (Sender == b_Done && Save())
		Controller.CloseMenu(false);
	return true;
}

function bool InternalOnDblClick(GUIComponent Sender)
{
	if (Sender == lb_Spare.List)
		AddSelected();
	else if (Sender == lb_Levels.List)
		RemoveSelected();
	return true;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(b_Done);
	return false;
}

defaultproperties
{
	Begin Object Class=GUIImage Name=BackImage
		Image=Texture'2K4Menus.NewControls.Display95'
		ImageStyle=ISTY_Stretched
		WinTop=0.150000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.750000
		RenderWeight=0.001000
	End Object
	MyBack=GUIImage'GunGameBW.GunGameWeaponMenu.BackImage'

	Begin Object Class=GUIHeader Name=DaBeegHeader
		bUseTextHeight=True
		Caption="GunGame Weapon List"
		WinTop=0.150000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.750000
	End Object
	MyHeader=GUIHeader'GunGameBW.GunGameWeaponMenu.DaBeegHeader'

	Begin Object Class=GUIImage Name=ImageBoxSpare
		Image=Texture'2K4Menus.NewControls.Display99'
		ImageStyle=ISTY_Stretched
		WinTop=0.225000
		WinLeft=0.087500
		WinWidth=0.375000
		WinHeight=0.560000
		RenderWeight=0.002000
	End Object
	Box_Spare=GUIImage'GunGameBW.GunGameWeaponMenu.ImageBoxSpare'

	Begin Object Class=GUIImage Name=ImageBoxLevels
		Image=Texture'2K4Menus.NewControls.Display99'
		ImageStyle=ISTY_Stretched
		WinTop=0.225000
		WinLeft=0.537500
		WinWidth=0.375000
		WinHeight=0.560000
		RenderWeight=0.002000
	End Object
	Box_Levels=GUIImage'GunGameBW.GunGameWeaponMenu.ImageBoxLevels'

	Begin Object Class=GUILabel Name=SpareLabel
		Caption="Spare Weapons"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.232000
		WinLeft=0.100000
		WinWidth=0.350000
		WinHeight=0.035000
	End Object
	l_Spare=GUILabel'GunGameBW.GunGameWeaponMenu.SpareLabel'

	Begin Object Class=GUILabel Name=LevelsLabel
		Caption="Level Order"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.232000
		WinLeft=0.550000
		WinWidth=0.350000
		WinHeight=0.035000
	End Object
	l_Levels=GUILabel'GunGameBW.GunGameWeaponMenu.LevelsLabel'

	Begin Object Class=GUIListBox Name=SpareList
		bVisibleWhenEmpty=True
		bSorted=True
		OnCreateComponent=SpareList.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="Weapons not in GunGame. Double click or ADD to put one after the selected level."
		WinTop=0.270000
		WinLeft=0.100000
		WinWidth=0.350000
		WinHeight=0.500000
		RenderWeight=0.510000
		TabOrder=0
	End Object
	lb_Spare=GUIListBox'GunGameBW.GunGameWeaponMenu.SpareList'

	Begin Object Class=GUIListBox Name=LevelList
		bVisibleWhenEmpty=True
		OnCreateComponent=LevelList.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="The order weapons are given in. Level 1 is the standard weapon, the last level wins. Double click or REMOVE to take one out."
		WinTop=0.270000
		WinLeft=0.550000
		WinWidth=0.350000
		WinHeight=0.500000
		RenderWeight=0.510000
		TabOrder=1
	End Object
	lb_Levels=GUIListBox'GunGameBW.GunGameWeaponMenu.LevelList'

	Begin Object Class=GUIButton Name=AddButton
		Caption="ADD"
		Hint="Put the selected spare weapon after the selected level."
		WinTop=0.300000
		WinLeft=0.450000
		WinWidth=0.100000
		TabOrder=2
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=AddButton.InternalOnKeyEvent
	End Object
	b_Add=GUIButton'GunGameBW.GunGameWeaponMenu.AddButton'

	Begin Object Class=GUIButton Name=RemoveButton
		Caption="REMOVE"
		Hint="Take the selected level out."
		WinTop=0.350000
		WinLeft=0.450000
		WinWidth=0.100000
		TabOrder=3
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=RemoveButton.InternalOnKeyEvent
	End Object
	b_Remove=GUIButton'GunGameBW.GunGameWeaponMenu.RemoveButton'

	Begin Object Class=GUIButton Name=UpButton
		Caption="UP"
		Hint="Move the selected level one earlier."
		WinTop=0.430000
		WinLeft=0.450000
		WinWidth=0.100000
		TabOrder=4
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=UpButton.InternalOnKeyEvent
	End Object
	b_Up=GUIButton'GunGameBW.GunGameWeaponMenu.UpButton'

	Begin Object Class=GUIButton Name=DownButton
		Caption="DOWN"
		Hint="Move the selected level one later."
		WinTop=0.480000
		WinLeft=0.450000
		WinWidth=0.100000
		TabOrder=5
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=DownButton.InternalOnKeyEvent
	End Object
	b_Down=GUIButton'GunGameBW.GunGameWeaponMenu.DownButton'

	Begin Object Class=GUIButton Name=DoneButton
		Caption="DONE"
		WinTop=0.580000
		WinLeft=0.450000
		WinWidth=0.100000
		TabOrder=6
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=DoneButton.InternalOnKeyEvent
	End Object
	b_Done=GUIButton'GunGameBW.GunGameWeaponMenu.DoneButton'

	Begin Object Class=GUIButton Name=CancelButton
		Caption="CANCEL"
		WinTop=0.630000
		WinLeft=0.450000
		WinWidth=0.100000
		TabOrder=7
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=CancelButton.InternalOnKeyEvent
	End Object
	b_Cancel=GUIButton'GunGameBW.GunGameWeaponMenu.CancelButton'

	Begin Object Class=GUIButton Name=ResetButton
		Caption="RESET TO DEFAULT"
		Hint="Put back the list GunGame comes with."
		WinTop=0.800000
		WinLeft=0.100000
		WinWidth=0.220000
		TabOrder=8
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=ResetButton.InternalOnKeyEvent
	End Object
	b_Reset=GUIButton'GunGameBW.GunGameWeaponMenu.ResetButton'

	Begin Object Class=GUILabel Name=StatusLabel
		TextAlign=TXTA_Right
		TextColor=(B=80,G=80,R=255)
		WinTop=0.800000
		WinLeft=0.550000
		WinWidth=0.350000
		WinHeight=0.035000
	End Object
	l_Status=GUILabel'GunGameBW.GunGameWeaponMenu.StatusLabel'

	Headings(0)="Ballistic Weapons"
	Headings(1)="UT2004 Standard"
	Headings(2)="Other"
	LevelsCaption="Level Order"
	TooFewText="GunGame needs at least 2 weapons"
	bRenderWorld=True
	bAllowedAsLast=True
	OnKeyEvent=GunGameWeaponMenu.InternalOnKeyEvent
}
