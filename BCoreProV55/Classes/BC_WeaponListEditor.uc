//=============================================================================
// BC_WeaponListEditor
//
// The weapon chooser of the Ballistic settings menus: spare weapons on the
// left (with a search row), the chosen ones on the right, buttons between.
// ADD > / < REMOVE move the selected weapon, ALL > adds every weapon the
// search shows, < EMPTY empties the chosen list; double click and drag move
// weapons too. In an ordered list (bOrdered) UP / DOWN move the selected
// weapon and ADD puts a weapon after the selected one.
//
// The owner fills the catalogue (AddSection / AddWeapon, in the order shown),
// sets the chosen class names, and reads them back with GetChosen.
// OnChosenChanged tells it the choice changed, OnWeaponSelected which weapon
// was picked in either list (for an icon, a description, edit boxes).
//=============================================================================
class BC_WeaponListEditor extends GUIPanel;

struct CatalogueEntry
{
	var string	Name;
	var string	ClassName;
	var bool	bSection;
	var Object	Data;
};

var array<CatalogueEntry>	Catalogue;		// every weapon that can be chosen, in the order shown, with headings
var array<string>			Chosen;			// class names of the chosen weapons, in their order
var() bool					bOrdered;		// the order matters: UP / DOWN, ADD after the selected weapon
var() bool					bNumbered;		// the chosen list shows numbers (1. Name)
var() int					MaxChosen;		// 0: no limit
var() localized string		ChosenCaption;	// shown with the count: "In Play (16)"

var automated GUIImage		i_Spare, i_Chosen;		// the frames behind the lists
var automated GUILabel		l_Spare, l_Chosen;
var automated GUIListBox	lb_Spare, lb_Chosen;
var automated GUIButton		b_Add, b_Remove, b_All, b_None, b_Up, b_Down;

var BC_ListSearch			Search;
var bool					bRebuilding;

delegate OnChosenChanged(BC_WeaponListEditor Sender);
delegate OnWeaponSelected(BC_WeaponListEditor Sender, string ClassName);

//=============================================================================
// Setup
//=============================================================================
function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

	lb_Spare.List.bSorted = false;
	lb_Chosen.List.bSorted = false;
	lb_Spare.List.OnDblClick = ListDblClick;
	lb_Chosen.List.OnDblClick = ListDblClick;
	lb_Spare.List.OnChange = ListChange;
	lb_Chosen.List.OnChange = ListChange;

	lb_Spare.List.bDropSource = true;
	lb_Spare.List.bDropTarget = true;
	lb_Spare.List.OnDragDrop = ListDragDrop;
	lb_Spare.List.OnBeginDrag = lb_Spare.List.InternalOnBeginDrag;
	lb_Spare.List.OnEndDrag = ListEndDrag;
	lb_Chosen.List.bDropSource = true;
	lb_Chosen.List.bDropTarget = true;
	lb_Chosen.List.OnDragDrop = ListDragDrop;
	lb_Chosen.List.OnBeginDrag = lb_Chosen.List.InternalOnBeginDrag;
	lb_Chosen.List.OnEndDrag = ListEndDrag;

	if (!bOrdered)
	{
		b_Up.SetVisibility(false);
		b_Down.SetVisibility(false);
	}

	Search = class'BC_ListSearch'.static.Create(self, lb_Spare, lb_Spare.List, 0.065);

	// the first rows of both lists side by side
	lb_Chosen.WinTop = lb_Spare.WinTop;
	lb_Chosen.WinHeight = lb_Spare.WinHeight;
}

// Showing the tab this is on shows every control on it: UP and DOWN only for an ordered list
event SetVisibility(bool bIsVisible)
{
	Super.SetVisibility(bIsVisible);
	if (bIsVisible && !bOrdered)
	{
		b_Up.SetVisibility(false);
		b_Down.SetVisibility(false);
	}
}

function SetOrdered(bool bNewOrdered, optional bool bNewNumbered)
{
	bOrdered = bNewOrdered;
	bNumbered = bNewNumbered;
	if (bOrdered)
	{
		b_Up.SetVisibility(true);
		b_Down.SetVisibility(true);
	}
	else
	{
		b_Up.SetVisibility(false);
		b_Down.SetVisibility(false);
	}
	Rebuild();
}

//=============================================================================
// Catalogue and choice
//=============================================================================
function ClearCatalogue()
{
	Catalogue.Length = 0;
}

function AddSection(string Heading)
{
	local int i;

	i = Catalogue.Length;
	Catalogue.Length = i + 1;
	Catalogue[i].Name = Heading;
	Catalogue[i].bSection = true;
}

function AddWeapon(string Name, string ClassName, optional Object Data)
{
	local int i;

	i = Catalogue.Length;
	Catalogue.Length = i + 1;
	Catalogue[i].Name = Name;
	Catalogue[i].ClassName = ClassName;
	Catalogue[i].Data = Data;
}

// Every weapon of the game, by name: Ballistic, then UT2004, then the rest
function AddAllGameWeapons(string BWHeading, string UTHeading, string OtherHeading)
{
	local array<CacheManager.WeaponRecord> Recs;
	local array<byte> Kind;
	local int i, k;

	class'CacheManager'.static.GetWeaponList(Recs);
	class'BC_WeaponInfoCache'.static.SortWeaponRecords(Recs);

	Kind.Length = Recs.Length;
	for (i = 0; i < Recs.Length; i++)
	{
		if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
			Kind[i] = 255;
		else if (class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			Kind[i] = 0;
		else if (Left(Recs[i].ClassName, 9) ~= "XWeapons." || Left(Recs[i].ClassName, 10) ~= "UTClassic." || Left(Recs[i].ClassName, 9) ~= "Onslaught")
			Kind[i] = 1;
		else
			Kind[i] = 2;
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	ClearCatalogue();
	for (k = 0; k < 3; k++)
	{
		if (k == 0)
			AddSection(BWHeading);
		else if (k == 1)
			AddSection(UTHeading);
		else
			AddSection(OtherHeading);
		for (i = 0; i < Recs.Length; i++)
			if (Kind[i] == k)
				AddWeapon(Recs[i].FriendlyName, Recs[i].ClassName);
	}
}

function int FindInCatalogue(string ClassName)
{
	local int i;

	for (i = 0; i < Catalogue.Length; i++)
		if (!Catalogue[i].bSection && Catalogue[i].ClassName ~= ClassName)
			return i;
	return -1;
}

function int FindChosen(string ClassName)
{
	local int i;

	for (i = 0; i < Chosen.Length; i++)
		if (Chosen[i] ~= ClassName)
			return i;
	return -1;
}

function bool IsChosen(string ClassName)
{
	return FindChosen(ClassName) != -1;
}

// The chosen weapons, in order. A weapon the catalogue doesn't have stays chosen (another mod may be missing)
function SetChosen(array<string> Names)
{
	local int i;

	Chosen.Length = 0;
	for (i = 0; i < Names.Length; i++)
		if (Names[i] != "" && !IsChosen(Names[i]))
			Chosen[Chosen.Length] = Names[i];
	Rebuild();
}

function GetChosen(out array<string> Names)
{
	Names = Chosen;
}

function string NameOf(string ClassName)
{
	local int i;

	i = FindInCatalogue(ClassName);
	if (i != -1)
		return Catalogue[i].Name;
	return Mid(ClassName, InStr(ClassName, ".") + 1);
}

//=============================================================================
// The two lists, made from the catalogue and the choice
//=============================================================================
function Rebuild()
{
	local int i, j, Sel, SpareTop, ChosenTop;
	local string SelSpare, SelChosen, Pending;
	local bool bPending;
	local array<int> Order;

	if (lb_Spare == None || bRebuilding)
		return;
	bRebuilding = true;

	SelSpare = lb_Spare.List.GetExtra();
	SelChosen = lb_Chosen.List.GetExtra();
	SpareTop = lb_Spare.List.Top;
	ChosenTop = lb_Chosen.List.Top;

	// spare: the catalogue less the chosen, a heading only over weapons left under it
	Search.Reset();
	lb_Spare.List.bNotify = false;
	lb_Spare.List.Clear();
	for (i = 0; i < Catalogue.Length; i++)
	{
		if (Catalogue[i].bSection)
		{
			Pending = Catalogue[i].Name;
			bPending = true;
			continue;
		}
		if (IsChosen(Catalogue[i].ClassName))
			continue;
		if (bPending)
		{
			lb_Spare.List.Add(Pending,,, true);
			bPending = false;
		}
		lb_Spare.List.Add(Catalogue[i].Name, Catalogue[i].Data, Catalogue[i].ClassName);
	}

	// chosen: in their order, or in the catalogue's
	lb_Chosen.List.bNotify = false;
	lb_Chosen.List.Clear();
	if (bOrdered)
	{
		for (i = 0; i < Chosen.Length; i++)
			Order[i] = i;
	}
	else
	{
		for (i = 0; i < Catalogue.Length; i++)
			if (!Catalogue[i].bSection)
			{
				j = FindChosen(Catalogue[i].ClassName);
				if (j != -1)
					Order[Order.Length] = j;
			}
		for (i = 0; i < Chosen.Length; i++)
			if (FindInCatalogue(Chosen[i]) == -1)
				Order[Order.Length] = i;
	}
	for (i = 0; i < Order.Length; i++)
	{
		j = Order[i];
		if (bNumbered)
			lb_Chosen.List.Add((i + 1) $ ". " $ NameOf(Chosen[j]),, Chosen[j]);
		else
			lb_Chosen.List.Add(NameOf(Chosen[j]),, Chosen[j]);
	}

	// the same weapons selected, the lists where they were
	Sel = lb_Spare.List.FindExtra(SelSpare);
	lb_Spare.List.Index = Sel;
	lb_Spare.List.Top = Clamp(SpareTop, 0, Max(0, lb_Spare.List.ItemCount - lb_Spare.List.ItemsPerPage));
	Sel = lb_Chosen.List.FindExtra(SelChosen);
	lb_Chosen.List.Index = Sel;
	lb_Chosen.List.Top = Clamp(ChosenTop, 0, Max(0, lb_Chosen.List.ItemCount - lb_Chosen.List.ItemsPerPage));
	lb_Spare.List.bNotify = true;
	lb_Chosen.List.bNotify = true;

	Search.Refresh();

	l_Chosen.Caption = ChosenCaption @ "(" $ Chosen.Length $ ")";
	bRebuilding = false;
	UpdateButtons();
}

function UpdateButtons()
{
	local int i;

	i = lb_Chosen.List.Index;
	SetEnabled(b_Add, lb_Spare.List.IsValid() && !lb_Spare.List.IsSection() && !Full());
	SetEnabled(b_Remove, lb_Chosen.List.IsValid());
	SetEnabled(b_All, !Full());
	SetEnabled(b_None, Chosen.Length > 0);
	SetEnabled(b_Up, bOrdered && i > 0);
	SetEnabled(b_Down, bOrdered && i >= 0 && i < lb_Chosen.List.ItemCount - 1);
}

function SetEnabled(GUIComponent C, bool bEnable)
{
	if (bEnable)
		C.EnableMe();
	else
		C.DisableMe();
}

function bool Full()
{
	return MaxChosen > 0 && Chosen.Length >= MaxChosen;
}

//=============================================================================
// Changes
//=============================================================================
function AddWeapons(array<string> Names)
{
	local int i, At;

	At = Chosen.Length;
	if (bOrdered && lb_Chosen.List.IsValid())
		At = FindChosen(lb_Chosen.List.GetExtra()) + 1;

	for (i = 0; i < Names.Length; i++)
	{
		if (Names[i] == "" || IsChosen(Names[i]) || Full())
			continue;
		Chosen.Insert(At, 1);
		Chosen[At] = Names[i];
		At++;
	}
	Changed();
	if (bOrdered && Names.Length == 1)
		SelectChosen(Names[0]);
}

function RemoveWeapons(array<string> Names)
{
	local int i, j;

	for (i = 0; i < Names.Length; i++)
	{
		j = FindChosen(Names[i]);
		if (j != -1)
			Chosen.Remove(j, 1);
	}
	Changed();
}

function Changed()
{
	Rebuild();
	OnChosenChanged(self);
}

function SelectChosen(string ClassName)
{
	local int i;

	i = lb_Chosen.List.FindExtra(ClassName);
	if (i != -1)
		lb_Chosen.List.SetIndex(i);
}

function AddSelected()
{
	local array<string> Names;
	local int i;

	if (!lb_Spare.List.IsValid() || lb_Spare.List.IsSection())
		return;
	// the next spare weapon is selected after, for adding several in a row
	i = lb_Spare.List.Index;
	Names[0] = lb_Spare.List.GetExtra();
	AddWeapons(Names);
	SelectRow(lb_Spare.List, i);
}

function RemoveSelected()
{
	local array<string> Names;
	local int i;

	if (!lb_Chosen.List.IsValid())
		return;
	i = lb_Chosen.List.Index;
	Names[0] = lb_Chosen.List.GetExtra();
	RemoveWeapons(Names);
	SelectRow(lb_Chosen.List, i);
}

// The row at this index, or the last one, skipping headings
function SelectRow(GUIList L, int i)
{
	i = Min(i, L.ItemCount - 1);
	while (i >= 0 && L.Elements[i].bSection)
		i++;
	if (i >= L.ItemCount)
		i = L.ItemCount - 1;
	if (i >= 0 && !L.Elements[i].bSection)
		L.SetIndex(i);
	UpdateButtons();
}

function AddAllShown()
{
	local array<string> Names;
	local int i;

	for (i = 0; i < lb_Spare.List.ItemCount; i++)
		if (!lb_Spare.List.Elements[i].bSection)
			Names[Names.Length] = lb_Spare.List.Elements[i].ExtraStrData;
	AddWeapons(Names);
}

function RemoveAll()
{
	Chosen.Length = 0;
	Changed();
}

function Move(int Dir)
{
	local int i;
	local string S;

	if (!bOrdered || !lb_Chosen.List.IsValid())
		return;
	S = lb_Chosen.List.GetExtra();
	i = FindChosen(S);
	if (i < 0 || i + Dir < 0 || i + Dir >= Chosen.Length)
		return;
	Chosen[i] = Chosen[i + Dir];
	Chosen[i + Dir] = S;
	Changed();
	SelectChosen(S);
}

//=============================================================================
// Input
//=============================================================================
function bool ButtonClick(GUIComponent Sender)
{
	if (Sender == b_Add)
		AddSelected();
	else if (Sender == b_Remove)
		RemoveSelected();
	else if (Sender == b_All)
		AddAllShown();
	else if (Sender == b_None)
		RemoveAll();
	else if (Sender == b_Up)
		Move(-1);
	else if (Sender == b_Down)
		Move(1);
	return true;
}

function bool ListDblClick(GUIComponent Sender)
{
	if (Sender == lb_Spare.List)
		AddSelected();
	else if (Sender == lb_Chosen.List)
		RemoveSelected();
	return true;
}

function ListChange(GUIComponent Sender)
{
	if (bRebuilding)
		return;
	UpdateButtons();
	if (GUIList(Sender) != None && GUIList(Sender).IsValid() && !GUIList(Sender).IsSection())
		OnWeaponSelected(self, GUIList(Sender).GetExtra());
}

// Dropped from one list on the other: added or taken out
function bool ListDragDrop(GUIComponent Sender)
{
	local array<GUIListElem> Dropped;
	local array<string> Names;
	local int i;

	if (Controller.DropTarget != Sender || GUIList(Controller.DropSource) == None || Controller.DropSource == Sender)
		return false;

	Dropped = GUIList(Controller.DropSource).GetPendingElements();
	for (i = 0; i < Dropped.Length; i++)
		if (!Dropped[i].bSection && Dropped[i].ExtraStrData != "")
			Names[Names.Length] = Dropped[i].ExtraStrData;

	if (Sender == lb_Chosen.List)
		AddWeapons(Names);
	else
		RemoveWeapons(Names);
	return true;
}

// The lists are made again after a drop: nothing to take out here
function ListEndDrag(GUIComponent Accepting, bool bAccepted)
{
	local GUIList L;

	L = GUIList(Controller.DropSource);
	if (L == None)
		return;
	L.bRepeatClick = Accepting == None;
	L.SetOutlineAlpha(255);
	L.ClearPendingElements();
}

defaultproperties
{
	ChosenCaption="Chosen"
	PropagateVisibility=True

	Begin Object Class=GUIImage Name=SpareBox
		Image=Texture'2K4Menus.NewControls.Display99'
		ImageStyle=ISTY_Stretched
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.065000
		WinLeft=0.000000
		WinWidth=0.420000
		WinHeight=0.935000
		RenderWeight=0.002000
	End Object
	i_Spare=GUIImage'BCoreProV55.BC_WeaponListEditor.SpareBox'

	Begin Object Class=GUIImage Name=ChosenBox
		Image=Texture'2K4Menus.NewControls.Display99'
		ImageStyle=ISTY_Stretched
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.065000
		WinLeft=0.580000
		WinWidth=0.420000
		WinHeight=0.935000
		RenderWeight=0.002000
	End Object
	i_Chosen=GUIImage'BCoreProV55.BC_WeaponListEditor.ChosenBox'

	Begin Object Class=GUILabel Name=SpareLabel
		Caption="Spare Weapons"
		TextAlign=TXTA_Center
		TextColor=(B=255,G=255,R=255)
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.000000
		WinLeft=0.000000
		WinWidth=0.420000
		WinHeight=0.060000
	End Object
	l_Spare=GUILabel'BCoreProV55.BC_WeaponListEditor.SpareLabel'

	Begin Object Class=GUILabel Name=ChosenLabel
		TextAlign=TXTA_Center
		TextColor=(B=255,G=255,R=255)
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.000000
		WinLeft=0.580000
		WinWidth=0.420000
		WinHeight=0.060000
	End Object
	l_Chosen=GUILabel'BCoreProV55.BC_WeaponListEditor.ChosenLabel'

	Begin Object Class=GUIListBox Name=SpareList
		bVisibleWhenEmpty=True
		OnCreateComponent=SpareList.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="Weapons not chosen. Double click, drag or ADD to choose one."
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.085000
		WinLeft=0.015000
		WinWidth=0.390000
		WinHeight=0.895000
		TabOrder=0
	End Object
	lb_Spare=GUIListBox'BCoreProV55.BC_WeaponListEditor.SpareList'

	Begin Object Class=GUIListBox Name=ChosenList
		bVisibleWhenEmpty=True
		OnCreateComponent=ChosenList.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="The chosen weapons. Double click, drag or REMOVE to take one out."
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.085000
		WinLeft=0.595000
		WinWidth=0.390000
		WinHeight=0.895000
		TabOrder=1
	End Object
	lb_Chosen=GUIListBox'BCoreProV55.BC_WeaponListEditor.ChosenList'

	Begin Object Class=GUIButton Name=AddButton
		Caption="ADD >"
		Hint="Choose the selected spare weapon."
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.150000
		WinLeft=0.435000
		WinWidth=0.130000
		WinHeight=0.070000
		TabOrder=2
		OnClick=BC_WeaponListEditor.ButtonClick
		OnKeyEvent=AddButton.InternalOnKeyEvent
	End Object
	b_Add=GUIButton'BCoreProV55.BC_WeaponListEditor.AddButton'

	Begin Object Class=GUIButton Name=RemoveButton
		Caption="< REMOVE"
		Hint="Take the selected weapon out."
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.240000
		WinLeft=0.435000
		WinWidth=0.130000
		WinHeight=0.070000
		TabOrder=3
		OnClick=BC_WeaponListEditor.ButtonClick
		OnKeyEvent=RemoveButton.InternalOnKeyEvent
	End Object
	b_Remove=GUIButton'BCoreProV55.BC_WeaponListEditor.RemoveButton'

	Begin Object Class=GUIButton Name=AllButton
		Caption="ALL >"
		Hint="Choose every spare weapon the search shows."
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.380000
		WinLeft=0.435000
		WinWidth=0.130000
		WinHeight=0.070000
		TabOrder=4
		OnClick=BC_WeaponListEditor.ButtonClick
		OnKeyEvent=AllButton.InternalOnKeyEvent
	End Object
	b_All=GUIButton'BCoreProV55.BC_WeaponListEditor.AllButton'

	Begin Object Class=GUIButton Name=NoneButton
		Caption="< EMPTY"
		Hint="Empty the chosen list: every weapon goes back to the spare list."
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.470000
		WinLeft=0.435000
		WinWidth=0.130000
		WinHeight=0.070000
		TabOrder=5
		OnClick=BC_WeaponListEditor.ButtonClick
		OnKeyEvent=NoneButton.InternalOnKeyEvent
	End Object
	b_None=GUIButton'BCoreProV55.BC_WeaponListEditor.NoneButton'

	Begin Object Class=GUIButton Name=UpButton
		Caption="UP"
		Hint="Move the selected weapon one earlier."
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.610000
		WinLeft=0.435000
		WinWidth=0.130000
		WinHeight=0.070000
		TabOrder=6
		OnClick=BC_WeaponListEditor.ButtonClick
		OnKeyEvent=UpButton.InternalOnKeyEvent
	End Object
	b_Up=GUIButton'BCoreProV55.BC_WeaponListEditor.UpButton'

	Begin Object Class=GUIButton Name=DownButton
		Caption="DOWN"
		Hint="Move the selected weapon one later."
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.700000
		WinLeft=0.435000
		WinWidth=0.130000
		WinHeight=0.070000
		TabOrder=7
		OnClick=BC_WeaponListEditor.ButtonClick
		OnKeyEvent=DownButton.InternalOnKeyEvent
	End Object
	b_Down=GUIButton'BCoreProV55.BC_WeaponListEditor.DownButton'
}
