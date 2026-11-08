//=============================================================================
// BC_ListSearch
//
// A search row over a weapon list: typing filters the list (any part of a
// name, case ignored), section headings show how many weapons they hold,
// sections with nothing in them are hidden while searching, Esc or X clears.
//
// Rows that don't match are taken out of the list and kept here, with the
// check boxes of BC_GUICheckList / BC_GUICheckListMulti rows, and put back in
// their places before the next search. Code that reads the whole list (saving
// check boxes, filling another list) calls ShowAll() first.
//
// Create() adds the row above the list box, which gives up that much height.
//=============================================================================
class BC_ListSearch extends GUI
	DependsOn(BC_GUICheckListMulti);

struct HiddenRow
{
	var int									At;		// index in the list when it was taken out
	var GUIListElem							Elem;
	var byte								Check;	// BC_GUICheckList
	var BC_GUICheckListMulti.CheckStruct	Multi;	// BC_GUICheckListMulti
};

var GUIList				List;
var GUIComponent		ListBox;
var GUIEditBox			Box;
var GUIButton			ClearButton;
var GUILabel			SearchLabel, CountLabel;

var array<HiddenRow>	Hidden;
var array<int>			Orig;		// for each row shown, its place in the whole list
var string				Filter;
var bool				bSetting;

var localized string	SearchCaption, BoxHint, ClearHint, OfText, WeaponsText;

// A search can hide the selected weapon: the first weapon found is selected instead. Owners that keep
// edit boxes for the selected weapon store them in OnBeforeSelect and show the new one in OnAfterSelect
delegate OnBeforeSelect();
delegate OnAfterSelect();

//=============================================================================
// Setup
//=============================================================================
static function BC_ListSearch Create(GUIMultiComponent Owner, GUIComponent TheBox, GUIList TheList, optional float RowHeight)
{
	local BC_ListSearch S;

	if (Owner == None || TheBox == None || TheList == None)
		return None;

	S = new class'BC_ListSearch';
	S.Init(Owner, TheBox, TheList, RowHeight);
	return S;
}

function Init(GUIMultiComponent Owner, GUIComponent TheBox, GUIList TheList, float RowHeight)
{
	local float X, Y, W, H;

	if (RowHeight <= 0)
		RowHeight = 0.045;

	List = TheList;
	ListBox = TheBox;

	X = ListBox.WinLeft;
	Y = ListBox.WinTop;
	W = ListBox.WinWidth;
	H = RowHeight * 0.85;

	SearchLabel = GUILabel(Owner.AddComponent("XInterface.GUILabel"));
	SearchLabel.Caption = SearchCaption;
	SearchLabel.TextColor = class'Canvas'.static.MakeColor(255, 255, 255, 255);
	SearchLabel.FontScale = FNS_Small;
	Place(SearchLabel, X, Y, W * 0.16, H);

	Box = GUIEditBox(Owner.AddComponent("XInterface.GUIEditBox"));
	Box.Hint = BoxHint;
	Box.OnChange = BoxChanged;
	Box.OnKeyEvent = BoxKeyEvent;
	Place(Box, X + W * 0.16, Y, W * 0.42, H);

	ClearButton = GUIButton(Owner.AddComponent("XInterface.GUIButton"));
	ClearButton.Caption = "X";
	ClearButton.Hint = ClearHint;
	ClearButton.OnClick = ClearClicked;
	Place(ClearButton, X + W * 0.59, Y, W * 0.07, H);

	CountLabel = GUILabel(Owner.AddComponent("XInterface.GUILabel"));
	CountLabel.TextAlign = TXTA_Right;
	CountLabel.TextColor = class'Canvas'.static.MakeColor(255, 255, 255, 255);
	CountLabel.FontScale = FNS_Small;
	Place(CountLabel, X + W * 0.67, Y, W * 0.33, H);

	ListBox.WinTop += RowHeight;
	ListBox.WinHeight -= RowHeight;

	Refresh();
}

// Placed the way the list box is: inside a tab, relative to the tab
function Place(GUIComponent C, float X, float Y, float W, float H)
{
	C.bBoundToParent = ListBox.bBoundToParent;
	C.bScaleToParent = ListBox.bScaleToParent;
	C.WinLeft = X;
	C.WinTop = Y;
	C.WinWidth = W;
	C.WinHeight = H;
	C.RenderWeight = 0.6;
}

//=============================================================================
// Input
//=============================================================================
function BoxChanged(GUIComponent Sender)
{
	if (bSetting)
		return;
	Filter = Box.GetText();
	Refresh();
}

function bool BoxKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x1B && Filter != "")	// Esc clears a search before it closes anything
	{
		if (State == 3)
			Clear();
		return true;
	}
	return Box.InternalOnKeyEvent(Key, State, delta);
}

function bool ClearClicked(GUIComponent Sender)
{
	Clear();
	return true;
}

function Clear()
{
	bSetting = true;
	Box.SetText("");
	bSetting = false;
	Filter = "";
	Refresh();
}

//=============================================================================
// Filtering
//=============================================================================

// Every row back in the list, the search kept (the list can be read and changed as a whole)
function ShowAll()
{
	local GUIListElem SelElem;
	local bool bSel;

	if (List == None)
		return;
	bSel = List.IsValidIndex(List.Index);
	if (bSel)
		SelElem = List.Elements[List.Index];

	RestoreRows();
	CountRows(false);

	// the same weapon stays selected, wherever it is now
	ResetView(FindElem(SelElem, bSel));
}

function int FindElem(GUIListElem E, bool bFind)
{
	local int i;

	if (bFind)
		for (i = 0; i < List.Elements.Length; i++)
			if (List.Elements[i].bSection == E.bSection && HeadingName(List.Elements[i].Item) == HeadingName(E.Item)
				&& List.Elements[i].ExtraStrData == E.ExtraStrData && List.Elements[i].ExtraData == E.ExtraData)
				return i;
	return -1;
}

// The search applied again: after the list was filled, or rows were added or taken out
function Refresh()
{
	local int i, Sel;
	local GUIListElem SelElem;
	local bool bSel, bLosesSel;
	local string Want;

	if (List == None)
		return;

	Want = Caps(Filter);
	bSel = List.IsValidIndex(List.Index);
	if (bSel)
	{
		SelElem = List.Elements[List.Index];
		// the search hides the selected weapon: its owner stores what it shows for it while it is still selected
		bLosesSel = !SelElem.bSection && Want != "" && InStr(Caps(SelElem.Item), Want) == -1;
		if (bLosesSel)
			OnBeforeSelect();
	}

	RestoreRows();

	if (Want != "")
		for (i = List.Elements.Length - 1; i >= 0; i--)
			if (!List.Elements[i].bSection && InStr(Caps(List.Elements[i].Item), Want) == -1)
				HideRow(i);

	CountRows(Want != "");

	// the selected row stays selected when it is shown, without telling the list's owner
	Sel = FindElem(SelElem, bSel);
	if (!bLosesSel)
	{
		ResetView(Sel);
		return;
	}

	// else the first weapon found is selected, as a click would
	ResetView(-1);
	for (i = 0; i < List.Elements.Length; i++)
		if (!List.Elements[i].bSection)
		{
			List.SetIndex(i);
			break;
		}
	OnAfterSelect();
}

// Headings get their counts; while searching, empty sections are taken out too
function CountRows(bool bHideEmpty)
{
	local int i, n, Shown, Total;

	for (i = List.Elements.Length - 1; i >= 0; i--)
	{
		if (List.Elements[i].bSection)
		{
			if (n == 0 && bHideEmpty)
				HideRow(i);
			else
				List.Elements[i].Item = HeadingName(List.Elements[i].Item) $ " (" $ n $ ")";
			n = 0;
		}
		else
		{
			n++;
			Shown++;
		}
	}

	Total = Shown;
	for (i = 0; i < Hidden.Length; i++)
		if (!Hidden[i].Elem.bSection)
			Total++;

	if (CountLabel != None)
	{
		if (Filter == "")
			CountLabel.Caption = Total @ WeaponsText;
		else
			CountLabel.Caption = Shown @ OfText @ Total;
	}
}

// A heading without the count this adds
static function string HeadingName(string S)
{
	local int i;
	local string Num;

	if (Right(S, 1) != ")")
		return S;
	for (i = Len(S) - 2; i > 0; i--)
		if (Mid(S, i, 2) == " (")
			break;
	if (i <= 0)
		return S;
	Num = Mid(S, i + 2, Len(S) - i - 3);
	if (Num == "" || string(int(Num)) != Num)
		return S;
	return Left(S, i);
}

// The place in the whole list of a row shown at this index: for arrays kept beside the list. -1 for none
function int FullIndex(int Shown)
{
	if (Shown < 0 || Shown >= List.Elements.Length)
		return -1;
	if (Shown >= Orig.Length)
		return Shown;
	return Orig[Shown];
}

// Where a row of the whole list is shown, -1 when it is hidden
function int ShownIndex(int Full)
{
	local int i;

	if (Orig.Length != List.Elements.Length)
		return Full;
	for (i = 0; i < Orig.Length; i++)
		if (Orig[i] == Full)
			return i;
	return -1;
}

function HideRow(int i)
{
	local int n;

	n = Hidden.Length;
	Hidden.Length = n + 1;
	Hidden[n].At = i;
	Hidden[n].Elem = List.Elements[i];

	if (BC_GUICheckList(List) != None && i < BC_GUICheckList(List).Checks.Length)
	{
		Hidden[n].Check = BC_GUICheckList(List).Checks[i];
		BC_GUICheckList(List).Checks.Remove(i, 1);
	}
	else if (BC_GUICheckListMulti(List) != None && i < BC_GUICheckListMulti(List).CheckStore.Length)
	{
		Hidden[n].Multi = BC_GUICheckListMulti(List).CheckStore[i];
		BC_GUICheckListMulti(List).CheckStore.Remove(i, 1);
	}

	List.Elements.Remove(i, 1);
	List.ItemCount = List.Elements.Length;
	if (i < Orig.Length)
		Orig.Remove(i, 1);
}

// Last taken out, first put back: each row goes back where it was
function RestoreRows()
{
	local int i;

	if (Hidden.Length > 0)
		PutBack();

	Orig.Length = List.Elements.Length;
	for (i = 0; i < Orig.Length; i++)
		Orig[i] = i;
}

function PutBack()
{
	local int i, At;

	for (i = Hidden.Length - 1; i >= 0; i--)
	{
		At = Min(Hidden[i].At, List.Elements.Length);
		List.Elements.Insert(At, 1);
		List.Elements[At] = Hidden[i].Elem;

		if (BC_GUICheckList(List) != None)
		{
			BC_GUICheckList(List).Checks.Insert(At, 1);
			BC_GUICheckList(List).Checks[At] = Hidden[i].Check;
		}
		else if (BC_GUICheckListMulti(List) != None)
		{
			BC_GUICheckListMulti(List).CheckStore.Insert(At, 1);
			BC_GUICheckListMulti(List).CheckStore[At] = Hidden[i].Multi;
		}
	}
	Hidden.Length = 0;
	List.ItemCount = List.Elements.Length;

	// rows added while searching can have moved the places: a sorted list sorts itself again
	// (not the check lists, whose check boxes are kept beside the rows)
	if (List.bSorted && BC_GUICheckList(List) == None && BC_GUICheckListMulti(List) == None)
		List.Sort();
}

function ResetView(int Sel)
{
	List.Index = Sel;
	List.SelectedItems.Length = 0;

	if (Sel >= 0 && (Sel < List.Top || Sel >= List.Top + List.ItemsPerPage))
		List.Top = Max(0, Sel - List.ItemsPerPage / 2);
	List.Top = Clamp(List.Top, 0, Max(0, List.ItemCount - List.ItemsPerPage));

	if (List.MyScrollBar != None)
		List.MyScrollBar.AlignThumb();
}

defaultproperties
{
	SearchCaption="Search"
	BoxHint="Type part of a weapon's name. Esc or X clears it."
	ClearHint="Clear the search."
	OfText="of"
	WeaponsText="weapons"
}
