//=============================================================================
// BC_TabRow
//
// A row of tab buttons that pick one of several things without panels of
// their own: the loadout slot being edited, the team whose weapons are shown.
// Plain buttons in the tab style (a GUITabButton needs a GUITabControl and its
// panel to draw); the active one is kept drawn as focused. OnSwitch tells the owner.
//=============================================================================
class BC_TabRow extends GUI;

var array<GUIButton>		Buttons;
var int					Active;
var GUIComponent		Like;		// placed the way this component is (inside a tab: relative to the tab)

delegate OnSwitch(BC_TabRow Sender, int Index);

static function BC_TabRow Create(GUIMultiComponent Owner, GUIComponent PlaceLike, float X, float Y, float W, float H, array<string> Captions)
{
	local BC_TabRow R;

	if (Owner == None || Captions.Length == 0)
		return None;
	R = new class'BC_TabRow';
	R.Init(Owner, PlaceLike, X, Y, W, H, Captions);
	return R;
}

function Init(GUIMultiComponent Owner, GUIComponent PlaceLike, float X, float Y, float W, float H, array<string> Captions)
{
	local int i;
	local GUIButton B;
	local float BW;

	Like = PlaceLike;
	BW = W / Captions.Length;
	for (i = 0; i < Captions.Length; i++)
	{
		B = GUIButton(Owner.AddComponent("XInterface.GUIButton"));
		B.StyleName = "TabButton";
		B.FontScale = FNS_Small;
		B.Style = Owner.Controller.GetStyle(B.StyleName, B.FontScale);
		B.Caption = Captions[i];
		B.OnClick = Clicked;
		if (Like != None)
		{
			B.bBoundToParent = Like.bBoundToParent;
			B.bScaleToParent = Like.bScaleToParent;
		}
		B.WinLeft = X + BW * i;
		B.WinTop = Y;
		B.WinWidth = BW;
		B.WinHeight = H;
		B.RenderWeight = 0.6;
		Buttons[i] = B;
	}
	Buttons[0].OnPreDraw = KeepActiveDrawn;
	Select(0);
}

function SetCaption(int i, string S)
{
	if (i >= 0 && i < Buttons.Length)
		Buttons[i].Caption = S;
}

function SetHint(int i, string S)
{
	if (i >= 0 && i < Buttons.Length)
		Buttons[i].Hint = S;
}

function Select(int i, optional bool bNotify)
{
	local int j;

	if (i < 0 || i >= Buttons.Length)
		return;
	Active = i;
	for (j = 0; j < Buttons.Length; j++)
		if (j != i && Buttons[j].MenuState == MSAT_Focused)
			Buttons[j].MenuState = MSAT_Blurry;
	if (bNotify)
		OnSwitch(self, i);
}

function SetEnabled(bool bEnable)
{
	local int i;

	for (i = 0; i < Buttons.Length; i++)
	{
		if (bEnable)
			Buttons[i].EnableMe();
		else
			Buttons[i].DisableMe();
	}
}

// Drawn before the row each frame: the active button looks selected whatever the mouse did
function bool KeepActiveDrawn(Canvas C)
{
	if (Active >= 0 && Active < Buttons.Length && Buttons[Active].MenuState != MSAT_Disabled)
		Buttons[Active].MenuState = MSAT_Focused;
	return false;
}

function bool Clicked(GUIComponent Sender)
{
	local int i;

	for (i = 0; i < Buttons.Length; i++)
		if (Buttons[i] == Sender)
		{
			if (i != Active)
				Select(i, true);
			break;
		}
	return true;
}
