//=============================================================================
// GUILoadOutItem.
//
// A handy little component for cycling through things. It is comprized of a
// list of images each with a Caption and some extra text. clicking on the
// component will change the image to the next in the list and call the
// OnItemChange() delegate. Right clicking goes back the other way. AddItem()
// can be used to add an item and SetItem() will set which item in the list is
// the current one.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class GUILoadOutItem extends GUIImage;

struct LoadOutItem		// Info for a single item in the list
{
	var() string	Text;		// Extra text string
	var() string	Caption;	// Caption to display
	var() Material	Image;		// Image to display
	var() int		X1,Y1,X2,Y2;// Coords for sub-images
};
var() int					Index;		// current position in list
var() Array<LoadOutItem>	Items;		// List of items
var() Material				NAImage;	// Image to use if current item don't got one
var() string				Caption;	// Title to display above this component

// Add item to the lsit
function AddItem(string ItemCaption, Material ItemImage, string ItemString, optional IntBox ItemCoords)
{
	Items.Length = Items.Length + 1;
	Items[Items.Length-1].Caption = ItemCaption;
	Items[Items.Length-1].Image = ItemImage;
	Items[Items.Length-1].Text = ItemString;
	if (ItemCoords.X1 + ItemCoords.X2 + ItemCoords.Y1 + ItemCoords.Y2 == 0)
	{
		Items[Items.Length-1].X1 = -1;
		Items[Items.Length-1].X2 = -1;
		Items[Items.Length-1].Y1 = -1;
		Items[Items.Length-1].Y2 = -1;
	}
	else
	{
		Items[Items.Length-1].X1 = ItemCoords.X1;
		Items[Items.Length-1].X2 = ItemCoords.X2;
		Items[Items.Length-1].Y1 = ItemCoords.Y1;
		Items[Items.Length-1].Y2 = ItemCoords.Y2;
	}
}

// Set current items
function SetItem (string ItemString)
{
	local int i;
	for (i=0;i<Items.Length;i++)
		if (Items[i].Text == ItemString)
			Index = i;

	UpdateImage();
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

	UpdateImage();
}

// Called when cycling through list
Delegate OnItemChange(GUIComponent Sender);

function UpdateImage ()
{
	if (Items.length > Index && Items[Index].Image != None)
	{
		Image = Items[Index].Image;
		X1 = Items[Index].X1;
		X2 = Items[Index].X2;
		Y1 = Items[Index].Y1;
		Y2 = Items[Index].Y2;
	}
	else
	{
		Image = NAImage;
		X1 = -1;
		X2 = -1;
		Y1 = -1;
		Y2 = -1;
	}
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Index >= Items.length-1)
		Index=0;
	else
		Index++;
	UpdateImage();
	OnItemChange(self);
	return true;
}

function bool InternalOnRightClick(GUIComponent Sender)
{
	if (Index <= 0)
		Index=Items.length-1;
	else
		Index--;
	UpdateImage();
	OnItemChange(self);
	return true;
}

// Draw the caption
function InternalOnDraw(Canvas C)
{
	local float XL, YL;

	if (Index >= Items.Length)
		return;
	C.Style=5;
	C.Font = Controller.GetMenuFont("UT2SmallFont").GetFont(C.ClipX);

	C.SetDrawColor(255,255,0,255);
	C.Strlen(Items[Index].Caption, XL, YL);
	C.SetPos (ActualLeft(), ActualTop() + ActualHeight() - YL);
	C.DrawText(Items[Index].Caption);

	if (Caption != "")
	{
		C.SetDrawColor(255,255,255,255);
		C.Strlen(Caption, XL, YL);
		C.SetPos (ActualLeft() + ActualWidth() / 2 - XL / 2, ActualTop() - YL);
		C.DrawText(Caption);
	}
}

defaultproperties
{
     ImageStyle=ISTY_Scaled
     ImageRenderStyle=MSTY_Normal
     bAcceptsInput=True
     OnRendered=GUILoadOutItem.InternalOnDraw
     OnClick=GUILoadOutItem.InternalOnClick
     OnRightClick=GUILoadOutItem.InternalOnRightClick
}
