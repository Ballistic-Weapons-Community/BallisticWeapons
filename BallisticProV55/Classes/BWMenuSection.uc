//=============================================================================
// BWMenuSection
//
// A titled box round a group of menu rows. The rows are handed to it with
// ManageComponent and it lines them up inside itself; showing or hiding it
// shows or hides them too.
//
// The game's blue menus draw it as UT2004's own section box. The dark menu
// theme draws it in script: a dark panel with its title on a bar across the
// top (see BWMenuTheme).
//=============================================================================
class BWMenuSection extends GUISectionBackground;

var Color	PanelColour, TitleBarColour, BorderColour, TitleColour;
var float	TitleBarHeight;	// pixels at 720 lines, scaled to the screen

function SetDark(bool bDark)
{
	if (bDark)
		OnDraw = DarkDraw;
	else
		OnDraw = None;
}

function bool DarkDraw(Canvas C)
{
	local float L, T, W, H, TH, XL, YL;
	local Texture White;

	if (!bVisible)
		return true;

	White = Texture'Engine.WhiteTexture';
	L = ActualLeft();
	T = ActualTop();
	W = ActualWidth();
	H = ActualHeight();
	TH = TitleBarHeight * C.ClipY / 720;

	C.Style = 5;	// alpha

	// border, then the panel inside it
	C.DrawColor = BorderColour;
	C.SetPos(L, T);
	C.DrawTileStretched(White, W, H);
	C.DrawColor = PanelColour;
	C.SetPos(L + 1, T + 1);
	C.DrawTileStretched(White, W - 2, H - 2);

	// title bar with a line of the title colour under it
	C.DrawColor = TitleBarColour;
	C.SetPos(L + 1, T + 1);
	C.DrawTileStretched(White, W - 2, TH);
	C.DrawColor = TitleColour;
	C.SetPos(L + 1, T + 1 + TH);
	C.DrawTileStretched(White, W - 2, 2);

	if (Caption != "")
	{
		C.Font = Controller.GetMenuFont("UT2SmallFont").GetFont(C.ClipX);
		C.TextSize(Caption, XL, YL);
		C.SetPos(L + 10, T + 1 + (TH - YL) / 2);
		C.DrawText(Caption);
	}
	return true;
}

defaultproperties
{
	PanelColour=(R=27,G=31,B=41,A=255)
	TitleBarColour=(R=37,G=43,B=57,A=255)
	BorderColour=(R=55,G=63,B=82,A=255)
	TitleColour=(R=255,G=180,B=40,A=255)
	TitleBarHeight=26
}
