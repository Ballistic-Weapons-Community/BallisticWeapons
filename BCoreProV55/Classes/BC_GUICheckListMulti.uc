//=============================================================================
// BC_GUICheckListMulti.
//
// Modification of BC_GUIListCheck for more checkboxes.
// FIXME make generic!
//=============================================================================
class BC_GUICheckListMulti extends GUIList;

#exec TEXTURE IMPORT NAME=CloseBoxBallDesat FILE=Textures\CloseBoxBallDesat.dds GROUP=Textures MIPS=Off ALPHA=1 DXT=3 LODSET=5

var() Material		CheckMat;
var() Material		CheckBackMat;
var	byte			MaxChecks;

struct CheckStruct
{
	var byte Checks[3];
};

var	array<Object.Color>		CheckColors;
var 	array<CheckStruct>	CheckStore;

var   int					LastCheckChanged, LastColumnChanged;
var   bool				LastClickWasCheck;

function InternalOnDrawItem(Canvas Canvas, int i, float X, float Y, float W, float H, bool bSelected, bool bPending)
{
	local int NewIndex;
	local byte j;

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

	for (j=0; j<MaxChecks;j++)
	{
		Canvas.SetPos(X + (H * j), Y);
		Canvas.SetDrawColor(255,255,255,255);
		Canvas.DrawTile(CheckBackMat, H, H,0,0,32,32);
	}

	for (j=0; j<MaxChecks;j++)
	{
		if (CheckStore[i].Checks[j] > 0)
		{
			Canvas.SetPos(X + (H * j), Y);
			Canvas.DrawColor = CheckColors[j];
			Canvas.DrawTile(CheckMat, H, H,0,0,32,32);
		}
	}
	
	Canvas.DrawColor = Canvas.default.DrawColor;
	
	if (Elements[i].bSection)
	    SectionStyle.DrawText( Canvas, MenuState, X+(H * MaxChecks), Y, W-H, H, TextAlign, GetItemAtIndex(i), FontScale );
	else
	    Style.DrawText( Canvas, MenuState, X+(H * MaxChecks), Y, W-H, H, TextAlign, GetItemAtIndex(i), FontScale );
}

//Set the NumCheck checkbox at Index.
function SetChecked (int Index, int CheckNum, bool bChecked)
{
	CheckStore[Index].Checks[CheckNum] = byte(bChecked);
}

//Toggle the NumCheck checkbox at Index.
function ToggleChecked (int Index, int CheckNum)
{
	CheckStore[Index].Checks[CheckNum] = byte(!bool(CheckStore[Index].Checks[CheckNum]));
	LastCheckChanged = Index;
	LastColumnChanged = CheckNum;
}

//Returns the checkbox position, starting from 0, which the player's mouse is over.
function int CursorOverCheck()
{
	local byte i;
	for (i=0;i<MaxChecks;i++)
	{
		if (Controller.MouseX <= ClientBounds[0] + ItemHeight * (i+1))
			return i;
	}
		return -1;
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int NewIndex, CheckNum;

	if ( !IsInClientBounds() || ItemsPerPage==0 )
		return false;

	// Get the Row.
	NewIndex = CalculateIndex();
	// Which checkbox are we over?
	CheckNum = CursorOverCheck();

	if (CheckNum != -1)
	{
		LastClickWasCheck=true;
		ToggleChecked(NewIndex, CheckNum);
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
     CheckMat=Texture'BCoreProV55.textures.CloseBoxBallDesat'
     CheckBackMat=Texture'2K4Menus.NewControls.GradientButtonBlurry'
     MaxChecks=3
     CheckColors(0)=(B=150,G=255,R=255,A=255)
     CheckColors(1)=(B=100,G=100,R=255,A=255)
     CheckColors(2)=(B=255,G=200,A=255)
     TextAlign=TXTA_Left
     OnDrawItem=BC_GUICheckListMulti.InternalOnDrawItem
}
