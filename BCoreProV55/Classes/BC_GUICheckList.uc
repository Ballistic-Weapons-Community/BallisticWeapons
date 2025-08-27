//=============================================================================
// BC_GUICheckList.
//
// A special kind of list that includes a column of checboxes, one for each
// list item...
// FIXME: Lacks some functionality(sorting) for the moment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BC_GUICheckList extends GUIList;

var() Material		CheckMat;
var() Material		CheckBackMat;

var() array<byte> Checks;
var   int		  LastCheckChanged;
var   bool		  LastClickWasCheck;

function InternalOnDrawItem(Canvas Canvas, int i, float X, float Y, float W, float H, bool bSelected, bool bPending)
{
	local int NewIndex;

	Canvas.Style=5;
	if (IsInClientBounds() && ItemsPerPage > 0)
	{
		NewIndex = CalculateIndex();
		if (NewIndex == i)
		{
			Canvas.SetPos(X, Y);
			Canvas.SetDrawColor(0,0,128,255);
			Canvas.DrawTile(Controller.DefaultPens[0], W, H,0,0,32,32);
		}
	}

	if (Elements[i].bSection)
	{
		Canvas.SetPos(X, Y);
		Canvas.SetDrawColor(0,0,0,255);
		Canvas.DrawTile(Controller.DefaultPens[0], W, H,0,0,32,32);
	}

	Canvas.SetPos(X, Y);
	Canvas.SetDrawColor(255,255,255,255);
	Canvas.DrawTile(CheckBackMat, H, H,0,0,32,32);

	if (Checks[i] > 0)
	{
		Canvas.SetPos(X, Y);
		Canvas.SetDrawColor(255,255,255,255);
		Canvas.DrawTile(CheckMat, H, H,0,0,32,32);
	}
	if (Elements[i].bSection)
	    SectionStyle.DrawText( Canvas, MenuState, X+H, Y, W-H, H, TextAlign, GetItemAtIndex(i), FontScale );
	else
	    Style.DrawText( Canvas, MenuState, X+H, Y, W-H, H, TextAlign, GetItemAtIndex(i), FontScale );
}

function AddCheck(string NewItem, optional Object obj, optional string Str, optional bool bSection, optional bool bChecked)
{
	local int NewIndex;
	local GUIListElem E;

	if ( !bAllowEmptyItems && NewItem == "" && Obj == None && Str == "" )
		return;

	E.Item = NewItem;
	E.ExtraData = Obj;
	E.ExtraStrData = Str;
	E.bSection = bSection;

	if (bSorted && Elements.Length > 0)
	{
		while (NewIndex < Elements.Length && CompareItem(Elements[NewIndex], E) < 0)
			NewIndex++;
	}
	else NewIndex = Elements.Length;

	Elements.Insert(NewIndex, 1);
	Elements[NewIndex] = E;

	Checks.Insert(NewIndex, 1);
	Checks[NewIndex] = byte(bChecked);

	ItemCount = Elements.Length;

	if (Elements.Length == 1 && bInitializeList)
		SetIndex(0);
	else if ( bNotify )
		CheckLinkedObjects(Self);

	if (MyScrollBar != None)
		MyScrollBar.AlignThumb();
}

function SetChecked (int i, bool bChecked)
{
	Checks[i] = byte(bChecked);
}
function ToggleChecked (int i)
{
	Checks[i] = byte(!bool(Checks[i]));
	LastCheckChanged = i;
}

function bool CursorOverCheck()
{
	if (Controller.MouseX <= ClientBounds[0] + ItemHeight)
		return true;
	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int NewIndex;

	if ( !IsInClientBounds() || ItemsPerPage==0 )
		return false;

	// Get the Row..
	NewIndex = CalculateIndex();

	if (CursorOverCheck())
	{
		LastClickWasCheck=true;
		ToggleChecked(NewIndex);
	}
	else
	{
		LastClickWasCheck=false;
		SetIndex(NewIndex);
	}
	return true;
}

defaultproperties
{
     CheckMat=Texture'2K4Menus.NewControls.CloseBoxBallWatched'
     CheckBackMat=Texture'2K4Menus.NewControls.GradientButtonBlurry'
     TextAlign=TXTA_Left
     OnDrawItem=BC_GUICheckList.InternalOnDrawItem
}
